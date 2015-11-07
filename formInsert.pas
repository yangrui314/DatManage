unit formInsert;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,unitTable, cxStyles, cxGraphics, cxEdit, cxCalc, cxVGrid,
  cxControls, cxInplaceContainer,cxTextEdit,DB, dbisamtb,cxCheckBox,cxCalendar,cxSpinEdit,
  Menus, cxLookAndFeelPainters, dxLayoutControl, StdCtrls, cxButtons,
  ExtCtrls,unitEnvironment,formParent;

type

  TEditMode = (emNone, emInsert, emUpdate,emDelete);


  TfmInsert = class(TParentForm)
    gridInsert: TcxVerticalGrid;
    pnlButton: TPanel;
    lcButtonGroup_Root: TdxLayoutGroup;
    lcButton: TdxLayoutControl;
    btnOk: TcxButton;
    lcButtonItem1: TdxLayoutItem;
    lcButtonItem2: TdxLayoutItem;
    btnCancel: TcxButton;
    procedure btnCancelClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    FTable : TTable;
    FEditMode : TEditMode;
    FRow : Integer;
    FUpdateField : TStringList;
    FUpdateValue : TStringList;
    FKeyValue : String;
    FKeyConditon : string;
    procedure InitData;
    function GetValue(aName : String;aType :TFieldType) : String; overload;
    function GetValue(aValue: Variant;aType :TFieldType) : String; overload;
    procedure Insert;
    procedure Update;
    procedure SaveUpdateValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean );

  public
    constructor Create(AOwner: TComponent;aTable : TTable; aEditMode: TEditMode = emInsert;aRow : Integer = 0 );
    procedure DeleteRow;
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
  FUpdateField := TStringList.Create;
  FUpdateValue := TStringList.Create;
  if FEditMode = emInsert then
  begin
    Self.Caption := '新增...';
  end
  else if FEditMode = emUpdate then
  begin
    Self.Caption := '编辑...';
  end
  else 
  begin
    Self.Caption := '查看';  
  end;
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
  FKeyConditon := '';
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
      if FTable.TableFieldCaptionArray[I] <> ''
      then row.Properties.Caption := FTable.TableFieldCaptionArray[I]
      else row.Properties.Caption := FTable.TableFieldNameArray[I];
      if aNotEmpty then  row.Properties.Caption := row.Properties.Caption+ '(*)';
      if aFieldName  = FTable.TableKeyField then row.Properties.Caption := row.Properties.Caption + '(Key)';

      row.Properties.Value := '';
      if FTable.TableFieldDataTypeArray[I] =  ftString then
      begin
        row.Properties.EditPropertiesClass := TcxTextEditProperties;
        TcxTextEditProperties(row.Properties.EditProperties).ImmediatePost := True;
        TcxTextEditProperties(row.Properties.EditProperties).OnValidate := SaveUpdateValidate;
        if (FEditMode = emUpdate) or  (FEditMode = emDelete) then row.Properties.Value := FTable.TableData.FieldByName(aFieldName).AsString;;
      end
      else if FTable.TableFieldDataTypeArray[I] =  ftAutoInc then
      begin
        row.Properties.EditPropertiesClass := TcxSpinEditProperties;
        TcxSpinEditProperties(row.Properties.EditProperties).ImmediatePost := True;
        TcxSpinEditProperties(row.Properties.EditProperties).OnValidate := SaveUpdateValidate;
        if (FEditMode = emUpdate) or  (FEditMode = emDelete) then row.Properties.Value := FTable.TableData.FieldByName(aFieldName).AsInteger;
      end
      else if FTable.TableFieldDataTypeArray[I] =  ftBoolean then
      begin
        row.Properties.EditPropertiesClass := TcxCheckBoxProperties;
        TcxCheckBoxProperties(row.Properties.EditProperties).ImmediatePost := True;
        TcxCheckBoxProperties(row.Properties.EditProperties).OnValidate := SaveUpdateValidate;
       if (FEditMode = emUpdate) or  (FEditMode = emDelete) then row.Properties.Value := FTable.TableData.FieldByName(aFieldName).AsBoolean;
      end
      else if FTable.TableFieldDataTypeArray[I] =  ftDateTime then
      begin
        row.Properties.EditPropertiesClass := TcxDateEditProperties;
        TcxDateEditProperties(row.Properties.EditProperties).ImmediatePost := True;
        TcxDateEditProperties(row.Properties.EditProperties).OnValidate := SaveUpdateValidate;

        if (FEditMode = emUpdate) or  (FEditMode = emDelete) then row.Properties.Value := FTable.TableData.FieldByName(aFieldName).AsDateTime;
      end
      else if FTable.TableFieldDataTypeArray[I] =  ftInteger then
      begin
        row.Properties.EditPropertiesClass := TcxSpinEditProperties;
        TcxSpinEditProperties(row.Properties.EditProperties).ImmediatePost := True;
        TcxSpinEditProperties(row.Properties.EditProperties).OnValidate := SaveUpdateValidate;

        if (FEditMode = emUpdate) or  (FEditMode = emDelete)  then row.Properties.Value := FTable.TableData.FieldByName(aFieldName).AsInteger;
      end
      else if FTable.TableFieldDataTypeArray[I] =  ftFloat then
      begin
        row.Properties.EditPropertiesClass := TcxCalcEditProperties;
        TcxCalcEditProperties(row.Properties.EditProperties).ImmediatePost := True;
        TcxCalcEditProperties(row.Properties.EditProperties).OnValidate := SaveUpdateValidate;

        if (FEditMode = emUpdate) or  (FEditMode = emDelete) then row.Properties.Value := FTable.TableData.FieldByName(aFieldName).AsFloat;

      end
      else
      begin
        row.Properties.EditPropertiesClass := TcxTextEditProperties;
        TcxTextEditProperties(row.Properties.EditProperties).ImmediatePost := True;
        TcxTextEditProperties(row.Properties.EditProperties).OnValidate := SaveUpdateValidate;

        if (FEditMode = emUpdate) or  (FEditMode = emDelete)  then row.Properties.Value := FTable.TableData.FieldByName(aFieldName).AsString;
      end;
      if ((FEditMode = emUpdate) or (FEditMode = emDelete)) and  FTable.IsKeyNameAccordValue(aFieldName) then
      begin
        row.Properties.EditProperties.ReadOnly := True;
        FKeyValue :=  GetValue(row.Properties.Value,FTable.TableFieldDataTypeArray[I]);
        if FKeyConditon = '' then
        begin
          if aFieldName = 'RecordID_1' then
          begin
            FKeyConditon :=  FTable.HandleSpecialStr('RecordID') + ' = ' + FKeyValue;
          end
          else
          begin
            FKeyConditon :=  FTable.HandleSpecialStr(aFieldName) + ' = ' + FKeyValue;          
          end;
        end
        else
        begin
          if aFieldName = 'RecordID_1' then
          begin
            FKeyConditon := FKeyConditon + ' and ' + FTable.HandleSpecialStr('RecordID') + ' = ' + FKeyValue;
          end
          else
          begin
            FKeyConditon := FKeyConditon + ' and ' + FTable.HandleSpecialStr(aFieldName) + ' = ' + FKeyValue;
          end;

        end;

      end;
    end;


  finally
    gridInsert.EndUpdate;
  end;
end;

procedure TfmInsert.Insert;
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
    then aField := aField + FTable.HandleSpecialStr(FTable.TableFieldNameArray[I])
    else aField := aField + ',' + FTable.HandleSpecialStr(FTable.TableFieldNameArray[I]);
    aType := FTable.TableFieldDataTypeArray[I];
    if aValue = ''
    then aValue := aValue + GetValue(FTable.TableFieldNameArray[I],aType)
    else aValue := aValue + ',' + GetValue(FTable.TableFieldNameArray[I],aType);
  end;

  aPrefixSQL := 'INSERT INTO ' + FTable.TableName + ' (' +aField + ' ) ';
  aPostfixSQL := ' VALUES ( ' + aValue + ')';

  aSQL := aPrefixSQL + aPostfixSQL;

  FTable.Environment.ExecSQL(aSQL);
  ShowMessage('执行成功！SQL执行脚本:'+ aSQL);    
end;


procedure TfmInsert.SaveUpdateValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption;
  var Error: Boolean );
var
  aName : String;
  aOrder : Integer;
  aField : TFieldType;
  aValue : String;
  Row: TcxEditorRow;
  I : Integer;  
begin
    aName := gridInsert.FocusedRow.Name;
    aOrder := FTable.GetOrderID(aName);
    aField := FTable.TableFieldDataTypeArray[aOrder];
    if aField = ftBoolean then
    begin
      if (Sender as TcxCheckBox).Checked then
      begin
        aValue := '1';
      end
      else
      begin
        aValue := '0';
      end;
    end
    else
    begin
      aValue := GetValue(DisplayValue,aField);
    end;


    for I := 0 to FUpdateField.Count - 1 do
    begin
      if aName = FUpdateField[I] then
      begin
        FUpdateField.Delete(I);
        FUpdateValue.Delete(I);
      end;
    end;

    FUpdateField.Add(aName);
    FUpdateValue.Add(aValue);
end;


procedure TfmInsert.Update;
var
  aSQL : String;
  aPrefixSQL : String;
  aPostfixSQL : String;
  aType : TFieldType;
  aValue : String;
  aField :String;
  aTotal : String;
  I : Integer;
begin
  if FUpdateField.Count = 0 then
  begin
    ShowMessage('该数据未有任何更改。');
    Exit;
  end;

  for I:=0 to  FUpdateField.Count - 1 do
  begin
    if aTotal =''
    then aTotal := aTotal + FTable.HandleSpecialStr(FUpdateField[I]) + ' = '  + FUpdateValue[I]
    else aTotal := aTotal + ',' + FTable.HandleSpecialStr(FUpdateField[I])  + ' = '  + FUpdateValue[I];;
  end;

  aPrefixSQL := 'update ' + FTable.TableName + ' set ' + aTotal;
  aPostfixSQL := ' where  ' + FKeyConditon + ';';



  aSQL := aPrefixSQL + aPostfixSQL;

  FTable.Environment.ExecSQL(aSQL);
  ShowMessage('执行成功！SQL执行脚本:'+ aSQL);
  Close;
end;

procedure TfmInsert.DeleteRow;
var
  aSQL : String;
  aPrefixSQL : String;
  aPostfixSQL : String;
begin
  aPrefixSQL := 'Delete from  ' + FTable.TableName ;
  aPostfixSQL := ' where  ' + FKeyConditon + ';';

  aSQL := aPrefixSQL + aPostfixSQL;
  FTable.Environment.ExecSQL(aSQL);
  ShowMessage('执行成功！SQL执行脚本:'+ aSQL)  
end;


function TfmInsert.GetValue(aName : String;aType :TFieldType) : String;
var
  Row: TcxEditorRow;
begin
  Row := TcxEditorRow(gridInsert.RowByName(aName));
  Result :=  GetValue(Row.Properties.Value,aType);
end;

function TfmInsert.GetValue(aValue: Variant;aType :TFieldType) : String;
var
  aDate : TDateTime;
begin
  if aValue = '' then
  begin
    Result := 'null';
    Exit;  
  end;

  if aType =  ftString then
  begin
    Result := '''' + aValue  + '''';
  end
  else if aType =  ftAutoInc then
  begin
    Result := IntToStr(aValue);
  end
  else if aType =  ftBoolean then
  begin
    if (VarToStr(aValue) = 'True') or (VarToStr(aValue) = '1') then
    begin
      Result :=  '1';
    end
    else
    begin
      Result :=  '0';
    end;
  end
  else if aType =  ftDateTime then
  begin
    TryStrToDateTime(aValue,aDate);
    Result := FormatDateTime('YYYY-MM-DD', aDate);
  end
  else if aType =  ftInteger then
  begin
    Result := IntToStr(aValue);
  end
  else if aType =  ftFloat then
  begin
    Result := '''' + FloatToStr(aValue) + '''';
  end
  else
  begin
    Result := aValue;
  end;    
end;


procedure TfmInsert.btnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfmInsert.btnOkClick(Sender: TObject);
begin
  if FEditMode = emInsert then
  begin
    Insert;
  end
  else if  FEditMode = emUpdate then
  begin
    Update;
  end
  else
  begin
    ShowMessage('不能提交！');
  end;
end;

procedure TfmInsert.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FUpdateField.Free;
  FUpdateValue.Free;
  inherited;
end;

end.
