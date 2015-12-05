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
  unitConfigDat, formParent, cxPC, ShellAPI, WinSkinData, dxBar,formSVN,
  cxLookAndFeels, RzStatus,formUpgradeProgress,unitDownLoadFile, cxLabel,
  unitSQLEnvironment,unitDbisamEnvironment,formParentMenu;

type
  TfmMain = class(TParentForm)
    dlgOpen: TOpenDialog;
    pnlResult: TPanel;
    dlgSave: TSaveDialog;
    MainMenu: TMainMenu;
    BarManager: TdxBarManager;
    BarManagerBar1: TdxBar;
    btnResult: TdxBarButton;
    btnImportExcel: TdxBarButton;
    btnExport: TdxBarButton;
    btnAdd: TdxBarButton;
    btnProperty: TdxBarButton;
    pnlCondition: TPanel;
    dMain: TdxLayoutControl;
    btnSelectParameter: TcxButton;
    edtParameter: TcxComboBox;
    edtPathName: TcxComboBox;
    btnSaveParameter: TcxButton;
    PageSelect: TcxPageControl;
    SheetTable: TcxTabSheet;
    lcTable: TdxLayoutControl;
    edtTable: TcxComboBox;
    dxLayoutGroup1: TdxLayoutGroup;
    dxLayoutItem1: TdxLayoutItem;
    SheetSQL: TcxTabSheet;
    edtSQL: TcxMemo;
    dockChange: TdxBarDockControl;
    dxLayoutGroup2: TdxLayoutGroup;
    dMainItem4: TdxLayoutItem;
    dMainItem15: TdxLayoutItem;
    dMainItem14: TdxLayoutItem;
    dMainItem10: TdxLayoutItem;
    dMainItem8: TdxLayoutItem;
    dMainItem5: TdxLayoutItem;
    btnImport: TdxBarButton;
    lcTableItem1: TdxLayoutItem;
    edtFieldName: TcxComboBox;
    lcTableItem3: TdxLayoutItem;
    edtKeyword: TcxComboBox;
    lcTableGroup1: TdxLayoutGroup;
    RzVersionInfo: TRzVersionInfo;
    edtCondition: TcxTextEdit;
    lcTableItem4: TdxLayoutItem;
    lcTableGroup2: TdxLayoutGroup;
    dxBarSubItem1: TdxBarSubItem;
    btnDelete: TdxBarButton;
    dxBarButton1: TdxBarButton;
    dxBarButton2: TdxBarButton;
    GroupConnect: TdxLayoutGroup;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSelectParameterClick(Sender: TObject);
    procedure edtCreatePathPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure edtPathNamePropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure btnSaveParameterClick(Sender: TObject);
    procedure btnResultClick(Sender: TObject);
    procedure btnConditionClick(Sender: TObject);
    procedure btnResult1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnImportExcelClick(Sender: TObject);
    procedure btnExportClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnPropertyClick(Sender: TObject);
    procedure edtTablePropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure edtTablePropertiesChange(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
  private
    FParameter: string;
    FTableName: string;
    FEnvironment: TEnvironment;
    FResult: TShowResultFrame;
    FTable: TTable;
    FGetTable: Boolean;
    FConfigFile: TConfigFile;
    FSVN : TfmSVN;
    FPatchVersion : String;
    FNowVersion : string;
    FInitConnectWay : String;

    procedure MenuClick(Sender: TObject);
    procedure LoadTableName(aFilter : String = '');
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
    procedure LoadMenu(aMenuName : String;aHint : String = '';aShow : Boolean = True);
    procedure InitMenu;
    procedure ChangeConnect;
  public
    class function CreateInstance(var AForm: TfmParentMenu; AFormClassName: String = ''): TfmParentMenu;overload;
  end;

var
  fmMain: TfmMain;

implementation

uses
  FileCtrl, StrUtils, unitStandardHandle, formTableProperty, unitExcelHandle,
  formExport, formAbout, formImport, unitConfig, unitHistory, formSavePath,
  formSet,formSelectAll,frmMain;

const
  VERSION_URL = 'http://sz-btfs.yun.ftn.qq.com/ftn_handler/2b9f99e1565690cd424cf4a2cc2ff3ad4da93155f7ea9365baf46d09c876a3d1/?fname=Version.ini&from=30111&version=2.0.0.2&uin=190200649';
  UPGRADE_URL = 'http://sz-btfs.yun.ftn.qq.com/ftn_handler/3b301df756b88a0b720798d077c605b69eeda0113c9dc0cc8624625e70dd80d2/?fname=Upgrade.zip&from=30111&version=2.0.0.2&uin=190200649';


{$R *.dfm}


function TfmMain.GetSQL: string;
begin
  if PageSelect.ActivePageIndex = 0 then
  begin
    if FTableName = '' then FTableName := edtTable.EditValue;
    if FTableName = '' then
    begin
      Result := '';
    end
    else
    begin
      Result := FEnvironment.GetBaseTableSQL(FTableName);
      if  (edtFieldName.Text <> '') and  (edtKeyword.Text <> '') and (edtCondition.Text <> '') then
      begin
        if edtKeyword.Text = '包含' then
        begin
          Result := Result + ' where ' + FTable.HandleSpecialStr(edtFieldName.Text) + ' like ' + '''%'+  edtCondition.Text + '%''';
        end
        else if edtKeyword.Text = '等于' then
        begin
          Result := Result + ' where ' + FTable.HandleSpecialStr(edtFieldName.Text)  + ' = ' +  edtCondition.Text ;
        end
        else if edtKeyword.Text = '不等于' then
        begin
          Result := Result + ' where ' + FTable.HandleSpecialStr(edtFieldName.Text) + ' <> ' +  edtCondition.Text ;
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

class function TfmMain.CreateInstance(var AForm: TfmParentMenu; AFormClassName: String = ''): TfmParentMenu;
var
  FormClassName: String;
  FormClass: TPersistentClass;
begin
  FormClass := nil;

  if Trim(AFormClassName) <> '' then
    FormClass := GetClass(AFormClassName);

  if (FormClass = nil) and (FormClassName <> ClassName) then
    FormClass := FindClass(ClassName);

  if FormClass = nil then
    FormClass := TfmParentMenu;

  if FormClass <> nil then begin
    Application.CreateForm(TComponentClass(FormClass), AForm);
    Result := TfmParentMenu(AForm);
  end else
    Result := nil;
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

procedure TfmMain.LoadTableName(aFilter : String = '');
var
  aTables : TStringList;
  I : Integer;
begin
  if (FEnvironment = nil) or (FParameter = '') then Exit;
  edtTable.Properties.Items.Clear;
  aTables := TStringList.Create;
  aTables := FEnvironment.LoadTableName(aFilter);
  try
    for I := 0 to aTables.Count - 1 do
    begin
      AddTable(aTables[I]);
    end;
  finally
    aTables.Free;
  end;
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
  edtParameter.Text := FParameter;
  if Config.ConnectWay = '1' then
  begin
    FEnvironment := TDbisamEnvironment.Create(Self, FParameter);
  end
  else
  begin
    FEnvironment := TSQLEnvironment.Create(Self, FParameter);  
  end;
  ChangeConnect;
  FTable := TTable.Create(FEnvironment, '', '');
  LoadTableName;  
  FResult := TShowResultFrame.Create(Self);
  FResult.Parent := pnlResult;
  FResult.Align := alClient;
  CheckState;
  FGetTable := False;
  dMain.Height := 248;
  InitMenu;
  ShowResult;

  edtKeyword.Properties.Items.Clear;
  edtKeyword.Properties.Items.Add('包含');
  edtKeyword.Properties.Items.Add('等于');
  edtKeyword.Properties.Items.Add('不等于');  
end;


procedure TfmMain.MenuClick(Sender: TObject);
var
  aClassName : string;
  aMenuName : string;
  aNotShowFormHint : string;
  aShow : Boolean;
begin
  Config.SystemParameter := FParameter;
  aMenuName := (Sender as TMenuItem).Name;
  aNotShowFormHint := (Sender as TMenuItem).Hint;
  aClassName := Copy(aMenuName,5,Length(aMenuName)-4);
  aShow := (LeftStr(aMenuName,4)  <> 'Unit');
  LoadMenu(aClassName,aNotShowFormHint,aShow);
end;




procedure TfmMain.InitMenu;
var
  MenuItem,MenuSubItem:TMenuItem;
  I ,J: Integer;
  MenuNum : Integer;  
begin
  MenuNum := 0;
  for I := 0 to Length(Config.FMenuList) - 1 do
  begin
    if Config.FMenuList[I].ParentName <> '' then
      Continue;
      
    MenuItem:=TMenuItem.Create(MainMenu);
    if Config.FMenuList[I].ClassName = '' then
    begin
      MenuItem.Name := 'Unit' + IntToStr(Random(100));
    end
    else
    begin
      if Config.FMenuList[I].ClassType = 'Class' then
      begin
        MenuItem.Name := 'Unit' + Config.FMenuList[I].ClassName;
      end
      else
      begin
        MenuItem.Name := 'Form' + Config.FMenuList[I].ClassName;
      end;    
    end;
    MenuItem.Caption:= Config.FMenuList[I].Caption;
    MenuItem.Hint := Config.FMenuList[I].NotShowFormHint;
    MenuItem.Visible := Config.FMenuList[I].Visible;
    if Config.FMenuList[I].ClassName <> '' then
      MenuItem.OnClick := MenuClick;
    MainMenu.Items.Add(MenuItem);
    for J := 0 to Length(Config.FMenuList) - 1 do
    begin
      if (Config.FMenuList[I].Name = Config.FMenuList[J].ParentName)   then
      begin
        MenuSubItem:=TMenuItem.Create(MainMenu);
        if Config.FMenuList[J].ClassName = '' then
        begin
          MenuSubItem.Name := 'Unit' + IntToStr(Random(100));
        end
        else
        begin
          if Config.FMenuList[J].ClassType = 'Class' then
          begin
            MenuSubItem.Name := 'Unit' + Config.FMenuList[J].ClassName;
          end
          else
          begin
            MenuSubItem.Name := 'Form' + Config.FMenuList[J].ClassName;
          end;
        end;
        MenuSubItem.Caption:= Config.FMenuList[J].Caption;
        MenuSubItem.Hint := Config.FMenuList[J].NotShowFormHint;
        MenuSubItem.Visible := Config.FMenuList[J].Visible;
        if Config.FMenuList[J].ClassName <> '' then
          MenuSubItem.OnClick := MenuClick;

        MainMenu.Items[MenuNum].Add(MenuSubItem);
      end;
    end;    
    Inc(MenuNum);
  end;
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
  FParameter := Config.LastFolderPath;
  FInitConnectWay := Config.ConnectWay;

  for I := 0 to Config.Historys.Count - 1 do
  begin
    if THistory(Config.Historys[I]).ConnectWay = Config.ConnectWay then
    begin
      edtPathName.Properties.Items.Add(THistory(Config.Historys[I]).Name);
      edtParameter.Properties.Items.Add(THistory(Config.Historys[I]).Path);
    end;
  end;

  edtPathName.EditValue := Config.GetHistoryName(FParameter);

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
  if (FInitConnectWay <> Config.ConnectWay) then
  begin
    Config.LastFolderPath := '';
  end
  else
  begin
    Config.LastFolderPath := FParameter;
  end; 
  FConfigFile.Destroy;
  FTable.Destroy;
  FEnvironment.Destroy;
  inherited;
end;

procedure TfmMain.CheckState;
begin

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
  aDefaultHeight := 236;
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

procedure TfmMain.btnSelectParameterClick(Sender: TObject);
begin
  FParameter := FEnvironment.CreateParameter;
  edtPathName.EditValue := '';
  if FParameter = '' then
  begin
    Exit;
  end;
  edtParameter.Text := FParameter;
  FEnvironment.SetEnvironment(FParameter);
  LoadTableName;
end;

procedure TfmMain.edtCreatePathPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  inherited;
  edtPathName.EditValue := Config.GetHistoryName(DisplayValue);
  FParameter := DisplayValue;
  FEnvironment.SetEnvironment(FParameter);
  LoadTableName;
end;

procedure TfmMain.edtPathNamePropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  inherited;
  edtParameter.EditValue := Config.GetHistoryPath(DisplayValue);
  FParameter := edtParameter.EditValue;
  FEnvironment.SetEnvironment(FParameter);
  LoadTableName;
end;

procedure TfmMain.btnSaveParameterClick(Sender: TObject);
var
  fmSavePath: TfmSavePath;
  aName: string;
  aPath: string;
begin
  aName := edtPathName.EditValue;
  aPath := edtParameter.EditValue;
  fmSavePath := TfmSavePath.Create(Self, aName, aPath);
  try
    if fmSavePath.ShowModal = mrOk then
      FConfigFile.SaveHistory(Config.ConnectWay,fmSavePath.PathName, fmSavePath.Path);
  finally
    fmSavePath.Free;
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

procedure TfmMain.btnResult1Click(Sender: TObject);
begin
  inherited;
  WorkRun;
end;

procedure TfmMain.FormCreate(Sender: TObject);
begin
  inherited;
  FSVN := TfmSVN.Create(Self);
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

procedure TfmMain.edtTablePropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  inherited;
  FTableName := DisplayValue;
  WorkRun;
end;


procedure TfmMain.edtTablePropertiesChange(Sender: TObject);
begin
  inherited;
  edtTable.Properties.Items.Clear;
  LoadTableName(edtTable.Text);
end;

procedure TfmMain.btnDeleteClick(Sender: TObject);
begin
  inherited;
  FResult.DeleteRow;
  WorkRun;
end;

procedure TfmMain.LoadMenu(aMenuName : String;aHint : String = '';aShow : Boolean = True);
var
  aMenu : TfmParentMenu;
begin
  TfmMain.CreateInstance(aMenu,aMenuName);
  try
    if not aMenu.CheckIsShow then
    begin
      if aHint <> '' then
      begin
        ShowMessage(aHint);
      end
      else
      begin
        ShowMessage('无法使用该功能。');
      end;
      Exit;
    end;
    if aShow then
    begin
      aMenu.ShowModal;    
    end
    else
    begin
      aMenu.MenuHandle(FParameter,PageSelect.ActivePageIndex,edtTable.Text);
    end;
  finally
    aMenu.Free;
  end;
end;


procedure TfmMain.ChangeConnect;
begin
  if Config.ConnectWay = '1' then
  begin
    GroupConnect.Caption := 'DBISAM数据库';
  end
  else
  begin
    GroupConnect.Caption := 'SQLSERVER数据库';
  end;
end;


end.

