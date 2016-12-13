unit formImport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxPC, cxControls, cxGraphics, dxLayoutControl, cxContainer,
  cxEdit, cxTextEdit, cxMaskEdit, cxDropDownEdit, cxImageComboBox, Menus,
  cxLookAndFeelPainters, StdCtrls, cxButtons, ExtCtrls,unitTable,frameTableProperty,frameShowResult,
  cxButtonEdit,unitExcelHandle, cxCheckBox,unitStandardHandle,formParent;

type
  TfmImport = class(TParentForm)
    dlgOpen: TOpenDialog;
    lcMain: TdxLayoutControl;
    cmbImportType: TcxImageComboBox;
    btnFilePath: TcxButtonEdit;
    cbSaveSQL: TcxCheckBox;
    cbContainDelSQL: TcxCheckBox;
    edtDelKeyField: TcxComboBox;
    dxLayoutGroup1: TdxLayoutGroup;
    lcMainItem2: TdxLayoutItem;
    dxLayoutItem1: TdxLayoutItem;
    lcMainItem3: TdxLayoutItem;
    dxLayoutGroup2: TdxLayoutGroup;
    lcMainItem4: TdxLayoutItem;
    lcMainItem5: TdxLayoutItem;
    lcMainItem7: TdxLayoutItem;
    btnFinish: TcxButton;
    procedure btnFinishClick(Sender: TObject);
    procedure btnFilePathPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure cmbImportTypePropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure btnFilePathPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure cbSaveSQLPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure cbContainDelSQLPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure FormShow(Sender: TObject);
  private
    FTable : TTable;
    FWay : Integer;
    FFilePath : String;
    FContainDelSQL : Boolean;
    FDelKeyField : String;
    procedure InitField;
    procedure ImportExcel;
    procedure LoadFile(aFilePath : String);
    procedure SetState;
  public
    constructor Create(AOwner: TComponent;aTable: TTable);
  end;

var
  fmImport: TfmImport;

implementation

{$R *.dfm}


constructor TfmImport.Create(AOwner: TComponent;aTable: TTable);
begin
  inherited Create(AOwner);
  FTable := aTable;
  InitField;
end;

procedure TfmImport.InitField;
var
  I : Integer;
begin
  edtDelKeyField.Properties.Items.Clear;
  for I:=0  to FTable.TableFieldCount - 1 do
  begin
    edtDelKeyField.Properties.Items.Add(FTable.TableFieldNameArray[I]);
  end;
end;


procedure TfmImport.btnFinishClick(Sender: TObject);
begin
  FContainDelSQL := cbContainDelSQL.Checked;
  FDelKeyField := edtDelKeyField.Text;

  if FWay = 0 then Exit;
  if FWay = 1 then
  begin
    ImportExcel;
    Close;
  end
  else if FWay = 2 then
  begin
//    LoadFile(FFilePath);
    ShowMessage('导入脚本功能暂未开放');
    Close;
  end;
end;

procedure TfmImport.LoadFile(aFilePath : String);
var
  aFile : TStandardHandle;
  I : Integer;
begin
//  aFile := TStandardHandle.Create;
//  try
//    edtSQL.Clear;
//    aFile.ReadFile(aFilePath);
//    for I := 0 to aFile.FileData.Count - 1 do
//    begin
//      edtSQL.Lines.Add(aFile.FileData[I]);
//    end;
//  finally
//    aFile.Destroy;
//  end;
end;

procedure TfmImport.ImportExcel;
var
  aExcel : TExcelHandle;
  I : Integer;
  aSQLSavePath : String;
begin
  if FTable.TableName = '' then
  begin
    ShowMessage('未选择对应表。无法导入Excel。');
    Exit;
  end;

  if FFilePath = '' then
  begin
    Exit;
  end;

  aSQLSavePath := ExtractFilePath(FFilePath) + ChangeFileExt(ExtractFileName(FFilePath), '') + '.sql';
  aExcel := TExcelHandle.Create(FTable);
  try
    aExcel.ReadFile(FFilePath,FContainDelSQL,FDelKeyField,aSQLSavePath);
  finally
    aExcel.Free;
  end;
end;


procedure TfmImport.btnFilePathPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
var
  I : Integer;
  aExt : String;
begin
  btnFilePath.Text := '';
//  dlgOpen.Filter := 'Excel文档(*.xls)|*.xls';
  aExt := cmbImportType.EditText;
  if aExt = '' then
  begin
    ShowMessage('请选择对应的导入类型。');
    Exit;
  end;
  dlgOpen.Filter := '相关文档('+aExt +')|'+'*' + aExt;
  if dlgOpen.Execute then
  begin
    for I := 0 to dlgOpen.Files.Count-1 do
    begin
      btnFilePath.Text := dlgOpen.Files.Strings[I] ;
      FFilePath := btnFilePath.Text;
    end;
  end;
end;

procedure TfmImport.cmbImportTypePropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  FWay := cmbImportType.ItemIndex + 1;
end;

procedure TfmImport.btnFilePathPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  FFilePath := DisplayValue;
end;

procedure TfmImport.SetState;
begin
  if  cbSaveSQL.Checked then
  begin
    cbContainDelSQL.Enabled := True;
  end
  else
  begin
    cbContainDelSQL.Checked := False;
    cbContainDelSQL.Enabled := False;
  end;

  if cbContainDelSQL.Checked then
  begin
    edtDelKeyField.Enabled := True;
  end
  else
  begin
    edtDelKeyField.Enabled := False;  
  end;
end;

procedure TfmImport.cbSaveSQLPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  SetState;
end;

procedure TfmImport.cbContainDelSQLPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  SetState;
end;

procedure TfmImport.FormShow(Sender: TObject);
begin
  inherited;
  cbSaveSQL.Checked := True;
  FWay := 1;
  FContainDelSQL := False;
  SetState;  
end;

end.
