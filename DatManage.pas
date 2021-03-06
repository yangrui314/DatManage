unit DatManage;

interface

{$WARN UNIT_PLATFORM OFF} 
{$WARN SYMBOL_PLATFORM OFF} 

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, dbisamtb, cxControls, cxContainer, cxEdit, cxTextEdit,
  cxMaskEdit, cxButtonEdit, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData,
  cxDataStorage, cxDBData, cxGridLevel, cxClasses, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, cxCheckBox,
  ExtCtrls, cxMemo, cxVGrid, cxDBVGrid, cxInplaceContainer, unitEnvironment,
  frameShowResult, dxLayoutControl, cxDropDownEdit, cxRadioGroup, unitTable,
  Menus, cxLookAndFeelPainters, cxButtons, cxGridExportLink, unitConfigHelper,
   formParent, cxPC, ShellAPI, WinSkinData, dxBar,
  cxLookAndFeels, RzStatus,formUpgradeProgress,unitDownLoadFile, cxLabel,
  unitSQLEnvironment,unitDbisamEnvironment,formParentMenu,unitLoadMenu;


type
  TfmMain = class(TParentForm)
    dlgOpen: TOpenDialog;
    pnlResult: TPanel;
    dlgSave: TSaveDialog;
    MainMenu: TMainMenu;
    BarManager: TdxBarManager;
    BarManagerBar1: TdxBar;
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
    dMainItem2: TdxLayoutItem;
    btnResult: TcxButton;
    dMainGroup1: TdxLayoutGroup;
    lblResult: TcxLabel;
    dMainItem1: TdxLayoutItem;
    dMainGroup3: TdxLayoutGroup;
    IsTableRefreshTimer: TTimer;
    btnDelParameter: TcxButton;
    dMainItem3: TdxLayoutItem;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnSelectParameterClick(Sender: TObject);
    procedure edtCreatePathPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure edtPathNamePropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure btnSaveParameterClick(Sender: TObject);
    procedure btnResultClick(Sender: TObject);
    procedure btnImportExcelClick(Sender: TObject);
    procedure btnExportClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnPropertyClick(Sender: TObject);
    procedure edtTablePropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption;
      var Error: Boolean);
    procedure edtTablePropertiesChange(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure PageSelectChange(Sender: TObject);
    procedure IsTableRefreshTimerTimer(Sender: TObject);
    procedure btnDelParameterClick(Sender: TObject);
  private
    FResult: TShowResultFrame;

    procedure LoadTableName(aFilter : String = '');
    procedure AddTable(const aTableName: string);
    procedure LoadField(aSQL: string);
    procedure ShowResult(bShow: Boolean); overload;
    procedure ShowResult; overload;
    procedure LoadConfig;
    procedure InitMenu;
    procedure ChangeConnect;
    procedure ClearCondition;
    procedure UpdateConfigSystem;
    //设置系统环境 yr 2016-12-12
    procedure UpdateEnvironment(aParameter : String);
    function RefreshUI : Boolean;
  protected
  public
    procedure WorkRun;
  end;

var
  fmMain: TfmMain;

implementation

uses
  FileCtrl, StrUtils, formTableProperty, unitExcelHandle,
  formExport, formAbout, formImport, unitConfig, unitHistory, formSavePath,
  formSet,formSelectAll,frmMain,unitStrHelper,
  unitFileHelper,unitSQLHelper;


{$R *.dfm}





procedure TfmMain.WorkRun;
var
  aSQL: string;
begin
  lblResult.Caption := '查询中...';
  try
    aSQL := ConfigHelper.GetSQL(edtTable.EditText,edtFieldName.Text,edtKeyword.Text,
              edtCondition.Text,edtSQL.SelText,edtSQL.Text);
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
  aHint : String;
begin
  ConfigHelper.RunSQL(aSQL,aHint);
  
  if Config.SystemEnvironment.SQLSuccess then
  begin
    lblResult.Caption := aHint +#13#10 +  '执行成功' +#13#10 + '标识号:' + IntToStr(Random(100))  ;
    lblResult.Style.TextColor := clBlue;
  end
  else
  begin
    lblResult.Caption :=  aHint + #13#10 + '失败' + #13#10 + '标识号:' + IntToStr(Random(100)) ;
    lblResult.Style.TextColor := clRed;
  end;

  //加载字段名称
  edtFieldName.Properties.Items.Clear;
  for I := 0 to   Config.SystemTable.TableFieldCount - 1 do
  begin
    edtFieldName.Properties.Items.Add(Config.SystemTable.TableFieldNameArray[I]);
  end;

  Config.GetTable := True;
  FResult.UpdateResult(Config.SystemTable, Config.SelectShowWay);
end;

procedure TfmMain.LoadTableName(aFilter : String = '');
var
  aTables : TStringList;
  I : Integer;
begin
  if (Config.SystemEnvironment = nil) or (Config.SystemParameter = '') then Exit;
  edtTable.Properties.Items.Clear;
  aTables := Config.SystemEnvironment.LoadTableName(aFilter);
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
  edtParameter.Text := Config.SystemParameter;
  if Config.ConnectWay = '1' then
  begin
    Config.SystemEnvironment := TDbisamEnvironment.Create(Self, Config.SystemParameter);
  end
  else
  begin
    Config.SystemEnvironment := TSQLEnvironment.Create(Self, Config.SystemParameter);  
  end;
  ChangeConnect;
  Config.SystemTable := TTable.Create(Config.SystemEnvironment, '', '');
  LoadTableName;  
  FResult := TShowResultFrame.Create(Self);
  FResult.Parent := pnlResult;
  FResult.Align := alClient;
  Config.GetTable := False;
  dMain.Height := 248;
  InitMenu;
  ShowResult;

  edtKeyword.Properties.Items.Clear;
  edtKeyword.Properties.Items.Add('包含');
  edtKeyword.Properties.Items.Add('等于');
  edtKeyword.Properties.Items.Add('不等于');
  
  IsTableRefreshTimer.Enabled := False;
  FResult.TRefreshMain := RefreshUI;
end;

function TfmMain.RefreshUI : Boolean;
begin
  IsTableRefreshTimer.Enabled := True;
end;


procedure TfmMain.InitMenu;
var
  aLoadMenu : TLoadMenu;
begin
  aLoadMenu := TLoadMenu.Create;
  aLoadMenu.Load(MainMenu);
end;

procedure TfmMain.LoadConfig;
var
  I: Integer;
begin
//  edtPathName.Properties.Items.Add('最后一条记录');
//  edtCreatePath.Properties.Items.Add(Config.LastFolderPath);
//  edtPathName.EditValue := '最后一条记录';
  Config.SystemParameter := Config.LastFolderPath;
  Config.InitConnectWay := Config.ConnectWay;

  for I := 0 to Config.Historys.Count - 1 do
  begin
    if THistory(Config.Historys[I]).ConnectWay = Config.ConnectWay then
    begin
      edtPathName.Properties.Items.Add(THistory(Config.Historys[I]).Name);
      edtParameter.Properties.Items.Add(THistory(Config.Historys[I]).Path);
    end;
  end;

  edtPathName.EditValue := ConfigHelper.GetHistoryName(Config.SystemParameter);
  UpdateConfigSystem;
  dMainItem4.Visible := Config.ShowName;
  dMainItem15.Visible := Config.ShowName;

  dMainItem14.Visible := Config.ShowPath;
  dMainItem10.Visible := Config.ShowPath;
end;



procedure TfmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if (Config.InitConnectWay <> Config.ConnectWay) then
  begin
    Config.LastFolderPath := '';
  end
  else
  begin
    Config.LastFolderPath := Config.SystemParameter;
  end;
  Config.SystemTable.Free;
  Config.SystemEnvironment.Free;  
  ConfigHelper.ClearRubbish;
  inherited;
end;




procedure TfmMain.ShowResult;
begin
  ShowResult(Config.GetTable);
end;

procedure TfmMain.ShowResult(bShow: Boolean);
var
  aDefaultHeight: Integer;
begin
  if fmMain.WindowState =  wsMaximized then
  begin
    pnlResult.Visible := bShow;
    Exit;
  end;

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
  Config.SystemParameter := Config.SystemEnvironment.CreateParameter;
  edtPathName.EditValue := '';
  if Config.SystemParameter = '' then
  begin
    Exit;
  end;
  edtParameter.Text := Config.SystemParameter;
  Config.SystemEnvironment.SetEnvironment(Config.SystemParameter);
  LoadTableName;
end;

procedure TfmMain.edtCreatePathPropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
var
  aParameter : String;
begin
  inherited;
  edtPathName.EditValue := ConfigHelper.GetHistoryName(DisplayValue);
  aParameter := DisplayValue;
  UpdateEnvironment(aParameter);
end;

procedure TfmMain.edtPathNamePropertiesValidate(Sender: TObject; var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
var
  aParameter : String;
begin
  inherited;
  edtParameter.EditValue := ConfigHelper.GetHistoryPath(DisplayValue);
  aParameter := edtParameter.EditValue;
  UpdateEnvironment(aParameter);
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
    begin
      aName := fmSavePath.PathName;
      aPath := fmSavePath.Path;
      ConfigHelper.SaveHistory(Config.ConnectWay,aName, aPath);
      edtPathName.Properties.Items.Add(aName);
      edtParameter.Properties.Items.Add(aPath);
      edtPathName.EditValue := aName;
      edtParameter.EditValue := aPath;
      UpdateEnvironment(aPath);
    end;
  finally
    fmSavePath.Free;
  end;
end;

procedure TfmMain.btnResultClick(Sender: TObject);
begin
  inherited;
  WorkRun;
end;

procedure TfmMain.btnImportExcelClick(Sender: TObject);
begin
  ConfigHelper.ImportTable;
end;

procedure TfmMain.btnExportClick(Sender: TObject);
begin
  ConfigHelper.ExportTable;
end;

procedure TfmMain.btnAddClick(Sender: TObject);
begin
  inherited;
  if not Config.GetTable then
  begin
    ShowMessage('未选择对应表。无属性。');
    Exit;
  end;
  ConfigHelper.Add(Self,Config.SystemTable);
end;

procedure TfmMain.btnPropertyClick(Sender: TObject);
begin
  ConfigHelper.TableProperty;
end;

procedure TfmMain.edtTablePropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  inherited;
  ClearCondition;
  Config.SystemTableName := DisplayValue;
  UpdateConfigSystem;  
  WorkRun;
end;

procedure TfmMain.ClearCondition;
begin
  edtFieldName.Text := '';
  edtKeyword.Text := '';
  edtCondition.Text := '';
end;


procedure TfmMain.edtTablePropertiesChange(Sender: TObject);
begin
  inherited;
//  ClearCondition;
//  edtTable.Properties.Items.Clear;
//  UpdateConfigSystem;  
//  LoadTableName(edtTable.Text);
end;

procedure TfmMain.btnDeleteClick(Sender: TObject);
begin
  inherited;
  if not Config.GetTable then
  begin
    ShowMessage('未选择对应表。无法删除。');
    Exit;
  end;

  if not Config.SystemTable.ContainData then
  begin
    ShowMessage('无数据，无法删除。');
    Exit;  
  end;

  FResult.DeleteRow;
  WorkRun;
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

procedure TfmMain.UpdateConfigSystem;
begin
  Config.SystemParameterCaption := edtPathName.Text;
  Config.SystemActivePageIndex := PageSelect.ActivePageIndex;
  Config.SystemTableName := edtTable.Text;    
end;


procedure TfmMain.PageSelectChange(Sender: TObject);
begin
  inherited;
  UpdateConfigSystem;
end;





procedure TfmMain.UpdateEnvironment(aParameter : String);
begin
  Config.SystemParameter := aParameter;
  UpdateConfigSystem;
  Config.SystemEnvironment.SetEnvironment(Config.SystemParameter);
  LoadTableName;
  FResult.ClearGridField;
  lblResult.Caption := '';
end;


procedure TfmMain.IsTableRefreshTimerTimer(Sender: TObject);
begin
  inherited;
  //每次仅执行一次 yr 2016-12-11
  WorkRun;
  FResult.FocusedRow(Config.NowRow);
  IsTableRefreshTimer.Enabled := False;
end;

procedure TfmMain.btnDelParameterClick(Sender: TObject);
var
  aName: string;
  aPath: string;
  aNameIndex : Integer;
  aPathIndex : Integer;
begin
  inherited;
  aName := edtPathName.EditValue;
  aPath := edtParameter.EditValue;
  if Application.MessageBox(Pchar('您确定删除'+'"'+aName+'"'+'环境吗？'), '警告', MB_ICONQUESTION or MB_OKCANCEL) <> IDOK then
  begin
    Exit;
  end;
  aNameIndex := edtPathName.Properties.Items.IndexOf(aName);
  aPathIndex := edtParameter.Properties.Items.IndexOf(aPath);
  ConfigHelper.DelHistory(Config.ConnectWay,aName, aPath);
  if THistory(Config.Historys[0]) = nil then Exit;

  edtPathName.Properties.Items.Delete(aNameIndex);
  edtParameter.Properties.Items.Delete(aPathIndex);

  edtPathName.EditValue := THistory(Config.Historys[0]).Name;
  edtParameter.EditValue := THistory(Config.Historys[0]).Path;
end;

end.

