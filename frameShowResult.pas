unit frameShowResult;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, 
  Dialogs, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxEdit, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGrid,DB, dbisamtb,unitTable,
  cxGridBandedTableView,cxGridExportLink;

type
  TShowResultFrame = class(TFrame)
    gridField: TcxGrid;
    levelField: TcxGridLevel;
    dgField: TcxGridTableView;
  private
    { Private declarations }
    FTable : TTable;
    procedure LoadData;
    procedure ClearGridField;
    procedure ClearColumn;
    procedure ClearData(const dgData : TcxGridTableView);
    procedure AddColumn(const Width: Integer; const Caption : String;const DataType : String);
    function GetColumnLength(DataSize : Integer): Integer;
  public
    constructor Create(AOwner: TComponent);
    procedure Update(aTable : TTable);
    procedure ExportExcel(aFilePath : String);
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

function TShowResultFrame.GetColumnLength(DataSize : Integer): Integer;
begin
  if DataSize <= 30 then
  begin
    Result := 75;
  end
  else
  begin
    Result := 2 * DataSize;
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

  if not FTable.ContainData then
  begin
    ShowMessage('执行SQL语句完成，无结果显示。');
    Exit;
  end;


  dgField.BeginUpdate;
  try
    for i:=0 to  FTable.TableFieldCount - 1 do
    begin
      if FTable.TableFieldVisibleArray[I] then
      begin
        if FTable.TableFieldCaptionArray[I] ='' then
        begin
          AddColumn(GetColumnLength(FTable.TableFieldSizeArray[I]),FTable.TableFieldNameArray[I],FTable.TableFieldSQLTypeArray[I]);
        end
        else
        begin
          AddColumn(GetColumnLength(FTable.TableFieldSizeArray[I]),FTable.TableFieldCaptionArray[I],FTable.TableFieldSQLTypeArray[I]);
        end;
      end;
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

procedure TShowResultFrame.Update(aTable : TTable);
begin
  FTable := aTable;
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

end.
