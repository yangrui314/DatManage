unit DatManage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, dbisamtb, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxMaskEdit, cxButtonEdit, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, cxCheckBox,
  ExtCtrls, cxMemo, cxVGrid, cxDBVGrid, cxInplaceContainer, unitEnvironment,
  frameShowResult, dxLayoutControl, cxDropDownEdit, cxRadioGroup, unitTable,
  Menus, cxLookAndFeelPainters, cxButtons, cxGridExportLink, unitConfigFile,
  unitConfigDat, formParent, cxPC, ShellAPI, WinSkinData, dxBar,formSVN;

type
  TfmMain = class(TParentForm)
    dlgOpen: TOpenDialog;
    pnlResult: TPanel;
    dlgSave: TSaveDialog;
    MainMenu: TMainMenu;
    MenuAbout: TMenuItem;
    MenuSet: TMenuItem;
    MenuSupply: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    BarManager: TdxBarManager;
    BarManagerBar1: TdxBar;
    btnResult: TdxBarButton;
    N3: TMenuItem;
    N4: TMenuItem;
    MenuSVN: TMenuItem;
    N6: TMenuItem;
    btnImportExcel: TdxBarButton;
    btnExport: TdxBarButton;
    btnAdd: TdxBarButton;
    btnProperty: TdxBarButton;
    MenuDiff: TMenuItem;
    MenuSelectAll: TMenuItem;
    pnlCondition: TPanel;
    dMain: TdxLayoutControl;
    cbTable: TcxRadioButton;
    cbSQL: TcxRadioButton;
    btnSelectPath: TcxButton;
    edtCreatePath: TcxComboBox;
    edtPathName: TcxComboBox;
    btnSavePath: TcxButton;
    PageSelect: TcxPageControl;
    SheetTable: TcxTabSheet;
    lcTable: TdxLayoutControl;
    edtTable: TcxComboBox;
    edtCondition: TcxMemo;
    dxLayoutGroup1: TdxLayoutGroup;
    dxLayoutItem1: TdxLayoutItem;
    lcTableItem2: TdxLayoutItem;
    SheetSQL: TcxTabSheet;
    edtSQL: TcxMemo;
    dockChange: TdxBarDockControl;
    dxLayoutGroup2: TdxLayoutGroup;
    dMainItem4: TdxLayoutItem;
    dMainItem15: TdxLayoutItem;
    dMainGroup3: TdxLayoutGroup;
    dMainItem14: TdxLayoutItem;
    dMainItem10: TdxLayoutItem;
    dMainGroup2: TdxLayoutGroup;
    dMainItem3: TdxLayoutItem;
    dMainItem6: TdxLayoutItem;
    dMainItem8: TdxLayoutItem;
    dMainItem5: TdxLayoutItem;
    dMainGroup1: TdxLayoutGroup;
    dMainGroup4: TdxLayoutGroup;
    btnImport: TdxBarButton;
    lcTableItem1: TdxLayoutItem;
    edtFieldName: TcxComboBox;
    lcTableItem3: TdxLayoutItem;
    edtKeyword: TcxComboBox;
    lcTableGroup1: TdxLayoutGroup;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cbTableClick(Sender: TObject);
    procedure cbSQLClick(Sender: TObject);
    procedure MenuAboutClick(Sender: TObject);
    procedure btnSelectPathClick(Sender: TObject);
    procedure edtCreatePathPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure edtPathNamePropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure btnSavePathClick(Sender: TObject);
    procedure MenuSetClick(Sender: TObject);
    procedure btnResultClick(Sender: TObject);
    procedure btnConditionClick(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure btnResult1Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure MenuSVNClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure btnImportExcelClick(Sender: TObject);
    procedure btnExportClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnPropertyClick(Sender: TObject);
    procedure MenuSelectAllClick(Sender: TObject);
    procedure edtTablePropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
  private

    FRootPath: string;
    FTableName: string;
    FEnvironment: TEnvironment;
    FResult: TShowResultFrame;
    FTable: TTable;
    FGetTable: Boolean;
    FConfigFile: TConfigFile;
    FSVN : TfmSVN;
    procedure LoadTableName(const sPath: string);
    procedure AddTable(const aTableName: string);
    procedure LoadField(aSQL: string);
    procedure WorkRun;
    function GetSQL: string;
    function SelectFile(aExt: string): string;
    function SaveFile: string;
    procedure CheckState;
    procedure ShowResult(bShow: Boolean); overload;
    procedure ShowResult; overload;
    procedure LoadConfig;
  public

  end;

var
  fmMain: TfmMain;

implementation

{$R *.dfm}

uses
  FileCtrl, StrUtils, unitStandardHandle, formTableProperty, unitExcelHandle,
  formExport, formAbout, formImport, unitConfig, unitHistory, formSavePath,
  formSet,formSelectAll;

function TfmMain.GetSQL: string;
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
      if  (edtFieldName.Text <> '') and  (edtKeyword.Text <> '') and (edtCondition.Text <> '') then
      begin
        if edtKeyword.Text = '包含' then
        begin
          Result := Result + ' where ' + edtFieldName.Text + ' like ' + '''%'+  edtCondition.Text + '%''';
        end
        else if edtKeyword.Text = '等于' then
        begin
          Result := Result + ' where ' + edtFieldName.Text + ' = ' +  edtCondition.Text ;
        end
        else if edtKeyword.Text = '不等于' then
        begin
          Result := Result + ' where ' + edtFieldName.Text + ' <> ' +  edtCondition.Text ;        
        end;
      end;
      if  (edtFieldName.Text = '') and  (edtKeyword.Text = '') and (edtCondition.Text <> '') then
      begin
        Result := Result + ' where ' + edtCondition.Text ;     
      end;
    end;
  end
  else
  begin
    FTableName := '';
    if edtSQL.SelText = '' then
      Result := edtSQL.Text
    else
      Result := edtSQL.SelText;
  end;
end;

procedure TfmMain.WorkRun;
var
  aSQL: string;
begin
  try
    aSQL := GetSQL;
    if aSQL = '' then
      Exit;
    LoadField(aSQL);
    ShowResult;
  except
    on E: Exception do
      showmessage('异常类名称:' + E.ClassName + #13#10 + '异常信息:' + E.Message);
  end;
end;

procedure TfmMain.LoadField(aSQL: string);
var
  I : Integer;
begin
  FTable := TTable.Create(FEnvironment, aSQL, FTableName);

  edtFieldName.Properties.Items.Clear;
  for I := 0 to   FTable.TableFieldCount - 1 do
  begin
    edtFieldName.Properties.Items.Add(FTable.TableFieldNameArray[I]);
  end;

  FGetTable := True;
  FResult.Update(FTable, Config.SelectShowWay);
end;

procedure TfmMain.LoadTableName(const sPath: string);
var
  SearchRec: TSearchRec;
  Found: Integer;
  NewName: string;
  TablePath: string;
begin

  if RightStr(sPath, 1) = '\' then
    TablePath := sPath
  else
    TablePath := sPath + '\';

  Found := FindFirst(TablePath + '*.*', faAnyFile, SearchRec);
  while Found = 0 do
  begin
    if (SearchRec.Name <> '.') and (SearchRec.Name <> '..') and (SearchRec.Attr <> faDirectory) and ((ExtractFileExt(SearchRec.Name) = '.dat')) then
    begin
      AddTable(ChangeFileExt(SearchRec.Name, ''));
    end;
    found := FindNext(SearchRec);
  end;
  FindClose(SearchRec);
end;

procedure TfmMain.AddTable(const aTableName: string);
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
  FEnvironment := TEnvironment.Create(Self, FRootPath);
  FTable := TTable.Create(FEnvironment, '', '');
  FResult := TShowResultFrame.Create(Self);
  FResult.Parent := pnlResult;
  FResult.Align := alClient;
  CheckState;
  FGetTable := False;
  dMain.Height := 248;
  ShowResult;

  edtKeyword.Properties.Items.Clear;
  edtKeyword.Properties.Items.Add('包含');
  edtKeyword.Properties.Items.Add('等于');
  edtKeyword.Properties.Items.Add('不等于');  
end;

procedure TfmMain.LoadConfig;
var
  I: Integer;
  aTest: string;
begin
  FConfigFile := TConfigDat.Create;
//  edtPathName.Properties.Items.Add('最后一条记录');
//  edtCreatePath.Properties.Items.Add(Config.LastFolderPath);
//  edtPathName.EditValue := '最后一条记录';
  FRootPath := Config.LastFolderPath;
  if FRootPath = '' then
    FRootPath := Config.InitFolderPath;

  for I := 0 to Config.Historys.Count - 1 do
  begin
    edtPathName.Properties.Items.Add(THistory(Config.Historys[I]).Name);
    edtCreatePath.Properties.Items.Add(THistory(Config.Historys[I]).Path);
  end;

  edtPathName.EditValue := Config.GetHistoryName(FRootPath);

  dMainItem4.Visible := Config.ShowName;
  dMainItem15.Visible := Config.ShowName;

  dMainItem14.Visible := Config.ShowPath;
  dMainItem10.Visible := Config.ShowPath;
end;

function TfmMain.SelectFile(aExt: string): string;
var
  I: Integer;
begin
  Result := '';
  dlgOpen.Filter := '相关文档(' + aExt + ')|' + '*.' + aExt;
  if dlgOpen.Execute then
  begin
    for I := 0 to dlgOpen.Files.Count - 1 do
    begin
      Result := dlgOpen.Files.Strings[I];
    end;
  end;
end;

function TfmMain.SaveFile: string;
var
  I: Integer;
begin
  Result := '';
  if dlgSave.Execute then
  begin
    for I := 0 to dlgSave.Files.Count - 1 do
    begin
      Result := dlgSave.Files.Strings[I];
    end;
  end;
end;

procedure TfmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FSVN.Free;
  Config.LastFolderPath := FRootPath;
  FConfigFile.Destroy;
  FTable.Destroy;
  FEnvironment.Destroy;
  inherited;
end;

procedure TfmMain.CheckState;
begin
  if cbTable.Checked then
  begin
    PageSelect.ActivePageIndex := 0;
//    edtTable.Enabled := True;
//    edtSQL.Enabled := False;
//    btnResult.Enabled := False;
  end
  else
  begin
    PageSelect.ActivePageIndex := 1;
//    edtTable.Enabled := False;
//    edtSQL.Enabled := True;
//    btnResult.Enabled := True;
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

procedure TfmMain.ShowResult(bShow: Boolean);
var
  aScrHeight: Integer;
  aResultHeight: Integer;
  aDefaultHeight: Integer;
begin
  if pnlResult.Visible = bShow then
    Exit;
  pnlResult.Visible := bShow;
  aDefaultHeight := 256;
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

procedure TfmMain.MenuAboutClick(Sender: TObject);
var
  aAbout: TfmAbout;
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
  DirectoryPath: string;
begin
  if SelectDirectory('请指定文件夹', '', DirectoryPath) then
  begin
    if RightStr(DirectoryPath, 1) = '\' then
      edtCreatePath.Text := DirectoryPath
    else
      edtCreatePath.Text := DirectoryPath + '\';

    edtPathName.EditValue := '';

    FRootPath := edtCreatePath.Text;
    LoadTableName(FRootPath);
    FEnvironment.SetRootPath(FRootPath);
  end;
end;

procedure TfmMain.edtCreatePathPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  inherited;
  edtPathName.EditValue := Config.GetHistoryName(DisplayValue);
  FRootPath := DisplayValue;
  LoadTableName(FRootPath);
  FEnvironment.SetRootPath(FRootPath);
end;

procedure TfmMain.edtPathNamePropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  inherited;
  edtCreatePath.EditValue := Config.GetHistoryPath(DisplayValue);
  FRootPath := edtCreatePath.EditValue;
  LoadTableName(FRootPath);
  FEnvironment.SetRootPath(FRootPath);
end;

procedure TfmMain.btnSavePathClick(Sender: TObject);
var
  fmSavePath: TfmSavePath;
  aName: string;
  aPath: string;
begin
  aName := edtPathName.EditValue;
  aPath := edtCreatePath.EditValue;
  fmSavePath := TfmSavePath.Create(Self, aName, aPath);
  try
    if fmSavePath.ShowModal = mrOk then
      FConfigFile.SaveHistory(fmSavePath.PathName, fmSavePath.Path);
  finally
    fmSavePath.Free;
  end;
end;

procedure TfmMain.MenuSetClick(Sender: TObject);
var
  aSet: TfmSet;
begin
  aSet := TfmSet.Create(Self);
  try
    aSet.ShowModal;
  finally
    aSet.Free;
  end;
end;

procedure TfmMain.btnResultClick(Sender: TObject);
begin
  inherited;
  WorkRun;
end;

procedure TfmMain.btnConditionClick(Sender: TObject);
begin
  inherited;
  WorkRun;
end;

procedure TfmMain.N1Click(Sender: TObject);
var
  aDatPath: string;
begin
  inherited;
  if (cbSQL.Checked) or (edtTable.Text = '') then
  begin
    //打开目录
    ShellExecute(Handle, 'open', 'Explorer.exe', PChar(FRootPath), nil, 1);
  end
  else
  begin
    //打开目录并定位。
    if RightStr(FRootPath, 1) = '\' then
      aDatPath := FRootPath
    else
      aDatPath := FRootPath + '\';
    aDatPath := aDatPath + edtTable.EditValue + '.dat';
    ShellExecute(0, nil, PChar('explorer.exe'), PChar('/e, ' + '/select,' + aDatPath), nil, SW_NORMAL);
  end;
end;

procedure TfmMain.N2Click(Sender: TObject);
var
  aDatPath: string;
begin
  inherited;
  //打开表
  if (cbSQL.Checked) or (edtTable.Text = '') then
  begin
    ShowMessage('未选择表或SQL查询模式。');
    Exit;
  end;
  if RightStr(FRootPath, 1) = '\' then
    aDatPath := FRootPath
  else
    aDatPath := FRootPath + '\';
  aDatPath := aDatPath + edtTable.EditValue + '.dat';
  ShellExecute(Handle, 'open', 'Explorer.exe', PChar(aDatPath), nil, 1);
end;

procedure TfmMain.btnResult1Click(Sender: TObject);
begin
  inherited;
  WorkRun;
end;

procedure TfmMain.N4Click(Sender: TObject);
begin
  inherited;
  ShellExecute(Handle, 'open', 'Explorer.exe', PChar(ExtractFileDir(ParamStr(0)) + '\Config'), nil, 1);
end;

procedure TfmMain.MenuSVNClick(Sender: TObject);
var
  aSVN: TfmSVN;
begin
  aSvn := TfmSVN.Create(Self);
  try
    if not aSVN.CheckSvnIsExist then
    begin
      ShowMessage('未安装SVN,无法使用该功能。');
      Exit;
    end;
    aSvn.ShowModal;
  finally
    aSvn.Free;
  end;
end;

procedure TfmMain.FormCreate(Sender: TObject);
begin
  inherited;
  FSVN := TfmSVN.Create(Self);
end;

procedure TfmMain.N3Click(Sender: TObject);
var
  aDatPath : string;
begin
  inherited;
  if RightStr(FRootPath, 1) = '\' then
    aDatPath := FRootPath
  else
    aDatPath := FRootPath + '\';  
  FSVN.WorkRun(aDatPath,'update');
end;

procedure TfmMain.N6Click(Sender: TObject);
var
  aDatPath : string;
begin
  inherited;
  if RightStr(FRootPath, 1) = '\' then
    aDatPath := FRootPath
  else
    aDatPath := FRootPath + '\';    
  FSVN.WorkRun(aDatPath,'commit');
end;

procedure TfmMain.btnImportExcelClick(Sender: TObject);
var
  fmImport: TfmImport;
begin
  if not FGetTable then
  begin
    ShowMessage('未选择对应表。无法导入Excel。');
    Exit;
  end;

  fmImport := TfmImport.Create(self, FTable);
  try
    fmImport.ShowModal;
  finally
    fmImport.Free;
  end;
end;

procedure TfmMain.btnExportClick(Sender: TObject);
var
  fmExport: TfmExport;
begin
  if not FGetTable then
  begin
    ShowMessage('未选择对应表。无法导入Excel。');
    Exit;
  end;

  fmExport := TfmExport.Create(self, FTable);
  try
    fmExport.ShowModal;
  finally
    fmExport.Free;
  end;
end;

procedure TfmMain.btnAddClick(Sender: TObject);
begin
  inherited;
  if not FGetTable then
  begin
    ShowMessage('未选择对应表。无属性。');
    Exit;
  end;
  FTable.Add(Self);
end;

procedure TfmMain.btnPropertyClick(Sender: TObject);
var
  fmTableProperty: TfmTableProperty;
begin
  if not FGetTable then
  begin
    ShowMessage('未选择对应表。无属性。');
    Exit;
  end;

  fmTableProperty := TfmTableProperty.Create(Self, FTable);
  with fmTableProperty do
  try
    ShowModal;
  finally
    Free;
  end;
end;

procedure TfmMain.MenuSelectAllClick(Sender: TObject);
var
  aSelect: TfmSelectAll;
begin
  aSelect := TfmSelectAll.Create(Self,FRootPath);
  try
    aSelect.ShowModal;
  finally
    aSelect.Free;
  end;
end;

procedure TfmMain.edtTablePropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  inherited;
  FTableName := DisplayValue;
  WorkRun;
end;

end.

