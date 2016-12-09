unit frameShowResult;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGrid,DB, dbisamtb,unitTable,
  cxGridBandedTableView,cxGridExportLink,formInsert;

type
  TShowResultFrame = class(TFrame)
    gridField: TcxGrid;
    levelField: TcxGridLevel;
    dgField: TcxGridTableView;
    procedure dgFieldCellDblClick(Sender: TcxCustomGridTableView;
      ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
      AShift: TShiftState; var AHandled: Boolean);
  private
    { Private declarations }
    FTable : TTable;
    FFieldShowWay : String;
    procedure LoadData;
    procedure ClearColumn;
    procedure ClearData(const dgData : TcxGridTableView);
    procedure AddColumn(const Width: Integer; const Caption : String;const DataType : String);
    function GetColumnLength(aFieldType : TFieldType;aDataSize : Integer): Integer;
  public
    constructor Create(AOwner: TComponent);
    procedure Update(aTable : TTable; aFieldShowWay : String = '1');
    procedure ExportExcel(aFilePath : String);
    procedure DeleteRow;
    procedure ClearGridField;    
  end;

implementation

{$R *.dfm}

constructor TShowResultFrame.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

procedure TShowResultFrame.ClearGridField;
begin
  ClearData(dgField);
  ClearColumn;    
end;

procedure TShowResultFrame.ClearData(const dgData : TcxGridTableView);
var
  I : Integer;
  TotalCount : Integer;
begin
  TotalCount := dgData.DataController.RowCount;
  if  TotalCount = 0 then Exit;
  dgData.BeginUpdate;
  try
    for i:= 0  to  TotalCount - 1 do
    begin
      dgData.DataController.DeleteRecord(TotalCount - 1  - i);
    end;
  finally
    dgData.EndUpdate;
  end;
end;


procedure TShowResultFrame.ClearColumn;
begin
  dgField.BeginUpdate;
  try
    dgField.ClearItems;
  finally
    dgField.EndUpdate;
  end;
end;

function TShowResultFrame.GetColumnLength(aFieldType : TFieldType;aDataSize : Integer): Integer;
begin
  if (aFieldType = ftSmallint) or (aFieldType = ftInteger) or
    (aFieldType = ftFloat) or (aFieldType = ftAutoInc) then
  begin
    Result := 30;
  end
  else if aFieldType = ftDateTime then
  begin
    Result := 60;
  end
  else if aFieldType = ftMemo then
  begin
    Result := 255;
  end
  else if aDataSize <= 30 then
  begin
    Result := 75;
  end
  else if aDataSize >= 250 then
  begin
    Result := 250;
  end
  else
  begin
    Result := 2 * aDataSize;
  end;
    
end;

procedure TShowResultFrame.ExportExcel(aFilePath : String);
begin
  ExportGridToExcel(aFilePath, gridField, True, False, True); 
end;


procedure TShowResultFrame.LoadData;
var
  sTest : String;
  sField : String;
  i : Integer;
  aDataType : TFieldType;
  ANewRecId : Integer;
  j : Integer;
begin
  ClearGridField;

  dgField.BeginUpdate;
  try
    for i:=0 to  FTable.TableFieldCount - 1 do
    begin
      if FTable.TableFieldVisibleArray[I] then
      begin
        if FFieldShowWay = '1'  then
        begin
          AddColumn(GetColumnLength(FTable.TableFieldDataTypeArray[I],FTable.TableFieldSizeArray[I]),FTable.TableFieldNameArray[I],FTable.TableFieldSQLTypeArray[I]);
        end
        else
        begin
          AddColumn(GetColumnLength(FTable.TableFieldDataTypeArray[I],FTable.TableFieldSizeArray[I]),FTable.TableFieldCaptionArray[I],FTable.TableFieldSQLTypeArray[I]);
        end;
      end;
    end;


  if not FTable.ContainData then
  begin
//    ShowMessage('执行SQL语句完成，无结果显示。');
    Exit;
  end;

    FTable.TableData.First;
    while not FTable.TableData.Eof do
    begin
      ANewRecId := dgField.DataController.AppendRecord;
      j := 0;
      for i:=0 to  FTable.TableData.Fields.Count - 1 do
      begin
        if  not FTable.TableFieldVisibleArray[I] then Continue;
        sField := FTable.TableData.Fields.Fields[I].FieldName;
        aDataType := FTable.TableFieldDataTypeArray[I];

        if aDataType = ftString then
        begin
          dgField.DataController.Values[ANewRecId,j] := FTable.TableData.FieldByName(sField).AsString;
        end
        else if  aDataType = ftInteger then
        begin
          dgField.DataController.Values[ANewRecId,j] := FTable.TableData.FieldByName(sField).AsInteger;
        end
        else if  aDataType = ftFloat  then
        begin
          dgField.DataController.Values[ANewRecId,j] := FTable.TableData.FieldByName(sField).AsFloat;
        end
        else if  aDataType = ftBoolean      then
        begin
          dgField.DataController.Values[ANewRecId,j] := FTable.TableData.FieldByName(sField).AsBoolean;
        end
        else if  aDataType = ftDateTime      then
        begin
          dgField.DataController.Values[ANewRecId,j] := FTable.TableData.FieldByName(sField).AsDateTime;
        end
        else
        begin
          dgField.DataController.Values[ANewRecId,j] := FTable.TableData.FieldByName(sField).AsString;
        end;
        Inc(j);
      end;
      dgField.DataController.Post();
      FTable.TableData.Next;
    end;
  finally
    dgField.EndUpdate;
  end;
end;

procedure TShowResultFrame.Update(aTable : TTable ; aFieldShowWay : String = '1');
begin
  FTable := aTable;
  FFieldShowWay := aFieldShowWay;
  LoadData;
end;


procedure TShowResultFrame.AddColumn(const Width: Integer; const Caption : String;const DataType : String);
var
  col: TcxGridColumn;
begin
  col := dgField.CreateColumn;
  col.Caption := Caption;
  col.DataBinding.ValueType := 'String';
  col.PropertiesClassName :=  'TcxTextEditProperties';
  col.HeaderAlignmentHorz := taCenter;
  col.HeaderAlignmentVert := cxClasses.vaCenter;
  col.Options.Sorting := False;
  col.Options.CellMerging := False;
//  col.Options.Editing := False;
  col.Properties.ReadOnly := True;
  col.Width := width ;
end;

procedure TShowResultFrame.dgFieldCellDblClick(
  Sender: TcxCustomGridTableView;
  ACellViewInfo: TcxGridTableDataCellViewInfo; AButton: TMouseButton;
  AShift: TShiftState; var AHandled: Boolean);
var
  fmInsert : TfmInsert;
  aRow : Integer;
begin
  aRow := dgField.Controller.FocusedRowIndex;
  fmInsert := TfmInsert.Create(Self,FTable,emUpdate,aRow);
  with fmInsert do
  try
    ShowModal;
  finally
    Free;
  end;
end;


procedure TShowResultFrame.DeleteRow;
var
  fmInsert : TfmInsert;
  aRow : Integer;
begin
  aRow := dgField.Controller.FocusedRowIndex;
  if Application.MessageBox(Pchar('您确定删除这条数据吗？'), '警告', MB_ICONQUESTION or MB_OKCANCEL) <> IDOK then
  begin
    Exit;
  end;

  fmInsert := TfmInsert.Create(Self,FTable,emDelete,aRow);
  with fmInsert do
  try
    DeleteRow;
  finally
    Free;
  end;
end;

end.
