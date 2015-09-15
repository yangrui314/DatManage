unit DatManage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, dbisamtb, cxControls, cxContainer, cxEdit,
  cxTextEdit, cxMaskEdit, cxButtonEdit, cxStyles, cxCustomData, cxGraphics,
  cxFilter, cxData, cxDataStorage, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid, cxCheckBox, ExtCtrls, cxMemo, cxVGrid,
  cxDBVGrid, cxInplaceContainer,unitEnvironment,frameShowResult, dxLayoutControl,
  cxDropDownEdit, cxRadioGroup,unitTable, Menus,
  cxLookAndFeelPainters, cxButtons,cxGridExportLink,unitConfigFile,unitConfigDat,formParent;

type
  TfmMain = class(TParentForm)
    dMainGroup_Root: TdxLayoutGroup;
    dMain: TdxLayoutControl;
    dMainItem2: TdxLayoutItem;
    btnResult: TButton;
    dMainItem5: TdxLayoutItem;
    edtSQL: TcxMemo;
    dMainItem9: TdxLayoutItem;
    btnLoadTableName: TButton;
    dlgOpen: TOpenDialog;
    dMainGroup1: TdxLayoutGroup;
    dMainGroup2: TdxLayoutGroup;
    edtTable: TcxComboBox;
    dMainItem7: TdxLayoutItem;
    cbTable: TcxRadioButton;
    dMainItem3: TdxLayoutItem;
    dMainItem6: TdxLayoutItem;
    cbSQL: TcxRadioButton;
    dMainGroup3: TdxLayoutGroup;
    dMainGroup4: TdxLayoutGroup;
    pnlResult: TPanel;
    dMainItem1: TdxLayoutItem;
    btnProperty: TButton;
    dMainItem8: TdxLayoutItem;
    btnAdd: TButton;
    dMainItem11: TdxLayoutItem;
    btnImportExcel: TButton;
    dMainGroup9: TdxLayoutGroup;
    dMainGroup8: TdxLayoutGroup;
    dMainItem13: TdxLayoutItem;
    btnExport: TButton;
    dlgSave: TSaveDialog;
    dMainItem12: TdxLayoutItem;
    btnRefresh: TButton;
    MainMenu: TMainMenu;
    MenuAbout: TMenuItem;
    dMainGroup5: TdxLayoutGroup;
    btnSelectPath: TcxButton;
    dMainItem10: TdxLayoutItem;
    dMainGroup6: TdxLayoutGroup;
    edtCreatePath: TcxComboBox;
    dMainItem14: TdxLayoutItem;
    dMainItem4: TdxLayoutItem;
    edtPathName: TcxComboBox;
    dMainItem15: TdxLayoutItem;
    btnSavePath: TcxButton;
    dMainGroup7: TdxLayoutGroup;
    procedure btnResultClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnLoadTableNameClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cbTablePropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure cbTableClick(Sender: TObject);
    procedure cbSQLClick(Sender: TObject);
    procedure btnPropertyClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnImportExcelClick(Sender: TObject);
    procedure btnExportClick(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure MenuAboutClick(Sender: TObject);
    procedure btnSelectPathClick(Sender: TObject);
    procedure edtCreatePathPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure edtPathNamePropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure btnSavePathClick(Sender: TObject);
  private
    FRootPath : String;
    FTableName : String;
    FEnvironment : TEnvironment;
    FResult : TShowResultFrame;
    FTable : TTable;
    FGetTable : Boolean;
    FConfigFile : TConfigFile;
    procedure LoadTableName(const sPath : String);
    procedure AddTable(const aTableName: String);
    procedure LoadField(aSQL : String);
    procedure WorkRun;
    function GetSQL : String;
    function SelectFile(aExt : String) : String;
    function SaveFile: String;    
    procedure CheckState;
    procedure ShowResult(bShow : Boolean);overload;
    procedure ShowResult;overload;
    procedure LoadConfig;
  public
    { Public declarations }
  end;

var
  fmMain: TfmMain;

implementation

{$R *.dfm}

uses
   FileCtrl,StrUtils,unitStandardHandle,formTableProperty,unitExcelHandle,formExport,
   formAbout,formImport,unitConfig,unitHistory,formSavePath;



procedure TfmMain.btnResultClick(Sender: TObject);
begin
  WorkRun;
end;


function TfmMain.GetSQL : String;
begin
  if cbTable.Checked then
  begin
    if FTableName = '' then
    begin
      Result := '';
    end
    else
    begin
      Result := 'select * from ' + FTableName;
    end;
  end
  else
  begin
    FTableName := '';
    if edtSQL.SelText = ''
    then Result  := edtSQL.Text
    else Result := edtSQL.SelText;
  end;
end;

procedure TfmMain.WorkRun;
var
  aSQL : String;
begin
  try
    aSQL := GetSQL;
    if aSQL = '' then Exit;
    LoadField(aSQL);
    ShowResult;
  except
  on E: Exception do
    showmessage('异常类名称:' + E.ClassName
      + #13#10 + '异常信息:' + E.Message);
  end;
end;



procedure TfmMain.LoadField(aSQL : String);
begin
  FTable := TTable.Create(FEnvironment,aSQL,FTableName);
  FGetTable := True;
  FResult.Update(FTable);
end;



procedure TfmMain.LoadTableName(const sPath : String);
var
  SearchRec:TSearchRec;
  Found:Integer;
  NewName : String;
  TablePath : String;
begin

  if RightStr(sPath, 1) = '\'
  then TablePath := sPath
  else TablePath := sPath  + '\';

  Found:=FindFirst(TablePath+'*.*',faAnyFile,SearchRec);
  while Found = 0 do
  begin
    if (SearchRec.Name <>'.')  and (SearchRec.Name<>'..')
         and    (SearchRec.Attr <> faDirectory) and ( (ExtractFileExt(SearchRec.Name) = '.dat')) then
    begin
     AddTable(ChangeFileExt(SearchRec.Name,''));
    end;
    found:=FindNext(SearchRec);
  end;
  FindClose(SearchRec);
end;

procedure TfmMain.AddTable(const aTableName: String);
begin
  edtTable.Properties.Items.Add(aTableName);
//  if edtTable.Text = '' then edtTable.Text := aTableName;
end;


procedure TfmMain.FormShow(Sender: TObject);
begin
  inherited;
  LoadConfig;
  edtCreatePath.Text := FRootPath;
  LoadTableName(FRootPath);
  FEnvironment := TEnvironment.Create(Self,FRootPath);
  FTable := TTable.Create(FEnvironment,'','');
  FResult := TShowResultFrame.Create(Self);
  FResult.Parent := pnlResult;
  FResult.Align := alClient;
  CheckState;
  FGetTable := False;
  dMain.Height := 266;
  ShowResult;
end;


procedure TfmMain.LoadConfig;
var
  I : Integer;
  aTest : String;
begin
  FConfigFile := TConfigDat.Create;
  edtPathName.Properties.Items.Add('最后一条记录');
  edtCreatePath.Properties.Items.Add(Config.LastFolderPath);
  edtPathName.EditValue := '最后一条记录';

  FRootPath := Config.LastFolderPath;
  if FRootPath = '' then FRootPath := Config.InitFolderPath;

  for I := 0 to Config.Historys.Count - 1 do
  begin
    edtPathName.Properties.Items.Add(THistory(Config.Historys[I]).Name);
    edtCreatePath.Properties.Items.Add(THistory(Config.Historys[I]).Path);
  end;
end;


procedure TfmMain.btnLoadTableNameClick(Sender: TObject);
begin
  FRootPath := edtCreatePath.Text;
  LoadTableName(FRootPath);
end;



function TfmMain.SelectFile(aExt : String) : String;
var
  I : Integer;
begin
  Result := '';
  dlgOpen.Filter := '相关文档('+aExt +')|'+'*.' + aExt;
  if dlgOpen.Execute then
  begin
    for I := 0 to dlgOpen.Files.Count-1 do
    begin
      Result := dlgOpen.Files.Strings[I];
    end;
  end;
end;

function TfmMain.SaveFile: String;
var
  I : Integer;
begin
  Result := '';
  if dlgSave.Execute then
  begin
    for I := 0 to dlgSave.Files.Count-1 do
    begin
      Result := dlgSave.Files.Strings[I];
    end;
  end;
end;


procedure TfmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Config.LastFolderPath := FRootPath;
  FConfigFile.Destroy;
  FTable.Destroy;
  FEnvironment.Destroy;
  inherited;
end;

procedure TfmMain.cbTablePropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  FTableName := DisplayValue;
  WorkRun;
end;

procedure TfmMain.CheckState;
begin
  if cbTable.Checked then
  begin
    edtTable.Enabled := True;
    btnLoadTableName.Enabled := True;
    edtSQL.Enabled := False;
    btnResult.Enabled := False;
  end
  else
  begin
    edtTable.Enabled := False;
    btnLoadTableName.Enabled := False;
    edtSQL.Enabled := True;
    btnResult.Enabled := True;
  end;
end;


procedure TfmMain.cbTableClick(Sender: TObject);
begin
  CheckState;
end;

procedure TfmMain.cbSQLClick(Sender: TObject);
begin
  CheckState;
end;

procedure TfmMain.ShowResult;
begin
  ShowResult(FGetTable);
end;


procedure TfmMain.ShowResult(bShow : Boolean);
var
  aScrHeight : Integer;
  aResultHeight : Integer;
  aDefaultHeight : Integer;
begin
  if pnlResult.Visible = bShow then
    Exit;
  pnlResult.Visible := bShow;
  aDefaultHeight := 286;
  if bShow then
  begin
    fmMain.Height := fmMain.Height + aDefaultHeight;
  end
  else
  begin
    fmMain.Height := fmMain.Height - aDefaultHeight;
  end;
  pnlResult.Height := aDefaultHeight;
end;

procedure TfmMain.btnPropertyClick(Sender: TObject);
var
  fmTableProperty : TfmTableProperty;
begin
  if not FGetTable then
  begin
    ShowMessage('未选择对应表。无属性。');
    Exit;
  end;

  fmTableProperty := TfmTableProperty.Create(Self,FTable);
  with fmTableProperty do
  try
    ShowModal;
  finally
    Free;
  end;
end;


procedure TfmMain.btnAddClick(Sender: TObject);
begin
  if not FGetTable then
  begin
    ShowMessage('未选择对应表。无属性。');
    Exit;
  end;
  FTable.Add(Self);
end;

procedure TfmMain.btnImportExcelClick(Sender: TObject);
var
  fmImport : TfmImport;
begin
  if not FGetTable then
  begin
    ShowMessage('未选择对应表。无法导入Excel。');
    Exit;
  end;

  fmImport := TfmImport.Create(self,FTable);
  try
    fmImport.ShowModal;
  finally
    fmImport.Free;
  end;
end;

procedure TfmMain.btnExportClick(Sender: TObject);
var
  fmExport : TfmExport;
begin
  if not FGetTable then
  begin
    ShowMessage('未选择对应表。无法导入Excel。');
    Exit;
  end;

  fmExport := TfmExport.Create(self,FTable);
  try
    fmExport.ShowModal;
  finally
    fmExport.Free;
  end;
end;

procedure TfmMain.btnRefreshClick(Sender: TObject);
begin
  FResult.Update(FTable);
end;

procedure TfmMain.MenuAboutClick(Sender: TObject);
var
  aAbout : TfmAbout;
begin
  aAbout := TfmAbout.Create(Self);
  try
    aAbout.ShowModal;
  finally
    aAbout.Free;
  end;
end;

procedure TfmMain.btnSelectPathClick(Sender: TObject);
var
  DirectoryPath : String;
begin
if SelectDirectory('请指定文件夹','',DirectoryPath) then
begin
  if RightStr(DirectoryPath, 1) = '\'
  then edtCreatePath.Text := DirectoryPath
  else edtCreatePath.Text := DirectoryPath  + '\';

  FRootPath := edtCreatePath.Text;
  LoadTableName(FRootPath);
  FEnvironment.SetRootPath(FRootPath);
end;
end;

procedure TfmMain.edtCreatePathPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  inherited;
  edtPathName.EditValue := Config.GetHistoryName(DisplayValue);
  FRootPath := DisplayValue;
  LoadTableName(FRootPath);
  FEnvironment.SetRootPath(FRootPath);
end;

procedure TfmMain.edtPathNamePropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  inherited;
  edtCreatePath.EditValue := Config.GetHistoryPath(DisplayValue);
  FRootPath := edtCreatePath.EditValue;
  LoadTableName(FRootPath);
  FEnvironment.SetRootPath(FRootPath);  
end;

procedure TfmMain.btnSavePathClick(Sender: TObject);
var
  fmSavePath : TfmSavePath;
  aName : String;
  aPath : String;
begin
  aName := edtPathName.EditValue;
  aPath := edtCreatePath.EditValue;
  fmSavePath := TfmSavePath.Create(Self,aName,aPath);
  try
    if fmSavePath.ShowModal = mrOk then
       FConfigFile.SaveHistory(fmSavePath.PathName,fmSavePath.Path);
  finally
    fmSavePath.Free;
  end;
end;
end.
