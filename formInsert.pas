unit formInsert;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,unitTable, cxStyles, cxGraphics, cxEdit, cxCalc, cxVGrid,
  cxControls, cxInplaceContainer,cxTextEdit,DB, dbisamtb,cxCheckBox,cxCalendar,cxSpinEdit,
  Menus, cxLookAndFeelPainters, dxLayoutControl, StdCtrls, cxButtons,
  ExtCtrls,unitConfig;

type

  TEditMode = (emNone, emInsert, emUpdate);


  TfmInsert = class(TForm)
    gridInsert: TcxVerticalGrid;
    pnlButton: TPanel;
    lcButtonGroup_Root: TdxLayoutGroup;
    lcButton: TdxLayoutControl;
    btnOk: TcxButton;
    lcButtonItem1: TdxLayoutItem;
    lcButtonItem2: TdxLayoutItem;
    btnCancel: TcxButton;
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
  private
    FTable : TTable;
    FEditMode : TEditMode;
    FRow : Integer;
    procedure InitData;
    function GetValue(aName : String;aType :TFieldType) : String;
  public
    constructor Create(AOwner: TComponent;aTable : TTable; aEditMode: TEditMode = emInsert;aRow : Integer = 0 );
  end;

var
  fmInsert: TfmInsert;

implementation

{$R *.dfm}

constructor TfmInsert.Create(AOwner: TComponent;aTable : TTable; aEditMode: TEditMode = emInsert;aRow : Integer= 0);
begin
  inherited Create(AOwner);
  FTable := aTable;
  FEditMode := aEditMode;
  FRow := aRow;
  InitData;
end;

procedure TfmInsert.InitData;
var
  rowNotEmpty,rowEmpty : TcxCategoryRow;
  row: TcxEditorRow;
  I : Integer;
  aNotEmpty : Boolean;
  aFieldName : String;
begin
  gridInsert.BeginUpdate;

  try
    gridInsert.ClearRows;

    rowNotEmpty := TcxCategoryRow(gridInsert.Add(TcxCategoryRow));
    rowNotEmpty.Properties.Caption := '必填(*)';

    rowEmpty := TcxCategoryRow(gridInsert.Add(TcxCategoryRow));
    rowEmpty.Properties.Caption := '可选';

    FTable.TableData.First;
//    FTable.TableData.RecordID := aRow;
    for I := 1 to FRow do
    begin
      FTable.TableData.Next;
    end;


    for I:=0 to  FTable.TableFieldCount - 1 do
    begin
      aNotEmpty := not FTable.TableFieldIsNullArray[I];
      if aNotEmpty then
      begin
        row := TcxEditorRow(gridInsert.AddChild(rowNotEmpty, TcxEditorRow));
      end
      else
      begin
        row := TcxEditorRow(gridInsert.AddChild(rowEmpty, TcxEditorRow));      
      end;
      aFieldName :=  FTable.TableFieldNameArray[I];
      row.Name := FTable.TableFieldNameArray[I];
      row.Properties.Caption := FTable.TableFieldNameArray[I];
      if aNotEmpty then  row.Properties.Caption := row.Properties.Caption+ '(*)';
      row.Properties.Value := '';
      if FTable.TableFieldDataTypeArray[I] =  ftString then
      begin
        row.Properties.EditPropertiesClass := TcxTextEditProperties;
        TcxTextEditProperties(row.Properties.EditProperties).ImmediatePost := True;
        if FEditMode = emUpdate  then row.Properties.Value := FTable.TableData.FieldByName(aFieldName).AsString;;
      end
      else if FTable.TableFieldDataTypeArray[I] =  ftAutoInc then
      begin
        row.Properties.EditPropertiesClass := TcxSpinEditProperties;
        TcxSpinEditProperties(row.Properties.EditProperties).ImmediatePost := True;
        if FEditMode = emUpdate  then row.Properties.Value := FTable.TableData.FieldByName(aFieldName).AsInteger;
      end
      else if FTable.TableFieldDataTypeArray[I] =  ftBoolean then
      begin
        row.Properties.EditPropertiesClass := TcxCheckBoxProperties;
        TcxCheckBoxProperties(row.Properties.EditProperties).ImmediatePost := True;
        if FEditMode = emUpdate  then row.Properties.Value := FTable.TableData.FieldByName(aFieldName).AsBoolean;
      end
      else if FTable.TableFieldDataTypeArray[I] =  ftDateTime then
      begin
        row.Properties.EditPropertiesClass := TcxDateEditProperties;
        TcxDateEditProperties(row.Properties.EditProperties).ImmediatePost := True;
        if FEditMode = emUpdate  then row.Properties.Value := FTable.TableData.FieldByName(aFieldName).AsDateTime;
      end
      else if FTable.TableFieldDataTypeArray[I] =  ftInteger then
      begin
        row.Properties.EditPropertiesClass := TcxSpinEditProperties;
        TcxSpinEditProperties(row.Properties.EditProperties).ImmediatePost := True;
        if FEditMode = emUpdate  then row.Properties.Value := FTable.TableData.FieldByName(aFieldName).AsInteger;
      end
      else if FTable.TableFieldDataTypeArray[I] =  ftFloat then
      begin
        row.Properties.EditPropertiesClass := TcxCalcEditProperties;
        TcxCalcEditProperties(row.Properties.EditProperties).ImmediatePost := True;
        if FEditMode = emUpdate  then row.Properties.Value := FTable.TableData.FieldByName(aFieldName).AsFloat;

      end
      else
      begin
        row.Properties.EditPropertiesClass := TcxTextEditProperties;
        TcxTextEditProperties(row.Properties.EditProperties).ImmediatePost := True;
        if FEditMode = emUpdate  then row.Properties.Value := FTable.TableData.FieldByName(aFieldName).AsString;
      end;
    end;  


  finally
    gridInsert.EndUpdate;
  end;
end;

procedure TfmInsert.btnOkClick(Sender: TObject);
var
  aSQL : String;
  aPrefixSQL : String;
  aPostfixSQL : String;
  aType : TFieldType;
  aValue : String;
  aField :String;
  I : Integer;
begin
  for I:=0 to  FTable.TableFieldCount - 1 do
  begin
    if aField = ''
    then aField := aField + FTable.TableFieldNameArray[I]
    else aField := aField + ',' + FTable.TableFieldNameArray[I];
    aType := FTable.TableFieldDataTypeArray[I];
    if aValue = ''
    then aValue := aValue + GetValue(FTable.TableFieldNameArray[I],aType)
    else aValue := aValue + ',' + GetValue(FTable.TableFieldNameArray[I],aType);
  end;

  aPrefixSQL := 'INSERT INTO ' + FTable.TableName + ' (' +aField + ' ) ';
  aPostfixSQL := ' VALUES ( ' + aValue + ')';
  aSQL := aPrefixSQL + aPostfixSQL;

  FTable.Config.ExecSQL(aSQL);
  ShowMessage('执行成功！SQL执行脚本:'+ aSQL)
end;

function TfmInsert.GetValue(aName : String;aType :TFieldType) : String;
var
  Row: TcxEditorRow;
  aDate : TDateTime;  
begin

  Row := TcxEditorRow(gridInsert.RowByName(aName));
  if Row.Properties.Value = '' then
  begin
    Result := 'null';
    Exit;  
  end;

  if aType =  ftString then
  begin
    Result := '''' + Row.Properties.Value  + '''';
  end
  else if aType =  ftAutoInc then
  begin
    Result := IntToStr(Row.Properties.Value);
  end
  else if aType =  ftBoolean then
  begin
    //todo
  end
  else if aType =  ftDateTime then
  begin
    TryStrToDateTime(Row.Properties.Value,aDate);
    Result := FormatDateTime('YYYY-MM-DD', aDate);
  end
  else if aType =  ftInteger then
  begin
    Result := IntToStr(Row.Properties.Value);
  end
  else if aType =  ftFloat then
  begin
    Result := '''' + FloatToStr(Row.Properties.Value) + '''';
  end
  else
  begin
    Result := Row.Properties.Value;
  end;
end;


procedure TfmInsert.btnCancelClick(Sender: TObject);
begin
  Close;
end;

end.
