{***************************************************
功能模块:数据操作类,不存储数据.
开发人员：yr
开发日期：2016-12-12 星期一
修改日期：2016-12-12 星期一
***************************************************}
unit unitConfigHelper;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs,StdCtrls,unitConfig,unitXmlWay,unitDatWay,unitFileWay,unitHistory,
  formParentMenu, Forms,unitTable;


type
  TConfigHelper = class(TObject)
  private
    FWayStrPath : string;
    procedure LoadFile;
    procedure SaveFile;
  protected
    FFileWay : TFileWay;  
    procedure SaveSystemConfigToBoolean(aName : String;aValue : Boolean);
    function GetWayStr : String;
    procedure SaveWayStr;    
  public
    constructor Create;
    destructor Destroy; override;
    procedure SaveHistory(const aConnectWay : string;const aName : String;const aPath : String);overload;
    procedure SaveHistory(const aHistory : THistory);overload;
    procedure SaveHistory;overload;
    procedure ClearHistorys;
    procedure DelHistory(const aConnectWay : string;const aName : String;const aPath : String);overload;
    procedure DelHistory(const aHistory : THistory);overload;
    //清除软件目录的不需要的文件 yr 2016-12-08
    procedure ClearRubbish;
    //导入 yr 2016-12-12
    procedure ImportTable;
    //导出 yr 2016-12-12
    procedure ExportTable;
    //表格属性 yr 2016-12-12
    procedure TableProperty;
    function GetHistoryName(aPath: string; aInclude: Boolean = False): string;
    function GetHistoryPath(aName: string; aInclude: Boolean = False): string;
    function GetMenuCaption(const aClassName: string): string;

    procedure SaveTableEnvironment(var aTable : TTable);
    procedure ReadTableEnvironment(var aTable : TTable);

    procedure Add(AOwner: TComponent;var aTable : TTable);
    class function CreateInstance(var AForm: TfmParentMenu; AFormClassName: string = ''): TfmParentMenu; overload;
  end;

var
  ConfigHelper: TConfigHelper;


implementation
  uses
    StrUtils,unitStrHelper,cnDebug,unitFileHelper,unitSQLHelper,
    formImport,formExport,formTableProperty,formInsert;



constructor TConfigHelper.Create;
begin
  inherited;
  FWayStrPath := ExtractFilePath(ParamStr(0)) + 'FileWay.ini';
  Config.FileWay := GetWayStr;
  if Config.FileWay = 'xml' then
  begin
    FFileWay := TXmlWay.Create;
  end
  else
  begin
    FFileWay := TDatWay.Create;
  end;
  LoadFile;
end;

class function TConfigHelper.CreateInstance(var AForm: TfmParentMenu; AFormClassName: string = ''): TfmParentMenu;
var
  FormClassName: string;
  FormClass: TPersistentClass;
begin
  FormClass := nil;

  if Trim(AFormClassName) <> '' then
    FormClass := GetClass(AFormClassName);

  if (FormClass = nil) and (FormClassName <> ClassName) then
    FormClass := FindClass(ClassName);

  if FormClass = nil then
    FormClass := TfmParentMenu;

  if FormClass <> nil then
  begin
    Application.CreateForm(TComponentClass(FormClass), AForm);
    Result := TfmParentMenu(AForm);
  end
  else
    Result := nil;
end;

procedure TConfigHelper.LoadFile;
var
  aHistorys : TList;
begin
  Config.LastFolderPath := FFileWay.GetSystemConfig('LastFolderPath');
  Config.ShowName := (FFileWay.GetSystemConfig('ShowName') = '1');
  Config.ShowPath := (FFileWay.GetSystemConfig('ShowPath') = '1');
  Config.SelectShowWay := FFileWay.GetSystemConfig('SelectShowWay');
  Config.ConnectWay := FFileWay.GetSystemConfig('ConnectWay');
  aHistorys := FFileWay.LoadHistorys;
  Config.Historys := aHistorys;
  Config.Password := FFileWay.LoadPasswords;
  FFileWay.LoadMenu;
end;

procedure TConfigHelper.SaveFile;
begin
  if Config.FileWay = 'xml' then
  begin
    FFileWay := TXmlWay.Create;
  end
  else
  begin
    FFileWay := TDatWay.Create;
  end;
  FFileWay.SaveSystemConfig('LastFolderPath',Config.LastFolderPath);
  SaveSystemConfigToBoolean('ShowName',Config.ShowName);
  SaveSystemConfigToBoolean('ShowPath',Config.ShowPath);
  FFileWay.SaveSystemConfig('SelectShowWay',Config.SelectShowWay);
  FFileWay.SaveSystemConfig('ConnectWay',Config.ConnectWay);
  FFileWay.SaveMenu;
end;

procedure TConfigHelper.SaveSystemConfigToBoolean(aName : String;aValue : Boolean);
begin
  if aValue then
  begin
    FFileWay.SaveSystemConfig(aName,'1');
  end
  else
  begin
    FFileWay.SaveSystemConfig(aName,'0');
  end;
end;

procedure TConfigHelper.SaveHistory(const aHistory : THistory);
begin
  FFileWay.SaveHistory(aHistory);
end;

procedure TConfigHelper.SaveHistory(const aConnectWay : string;const aName : String;const aPath : String);
var
  aHistory : THistory;
begin
  aHistory := THistory.Create;
  try
    aHistory.ConnectWay :=aConnectWay;
    aHistory.Name :=  aName;
    aHistory.Path := aPath;
    SaveHistory(aHistory);
  finally
    aHistory.Free;
  end;
end;

procedure TConfigHelper.SaveHistory;
var
  I : Integer;
begin
  FFileWay.ClearHistorys;
  for I := 0 to Config.Historys.Count - 1 do
  begin
    SaveHistory(THistory(Config.Historys[I]));
  end;
end;

procedure TConfigHelper.DelHistory(const aHistory : THistory);
begin
  FFileWay.DelHistory(aHistory);    
end;

procedure TConfigHelper.DelHistory(const aConnectWay : string;const aName : String;const aPath : String);
var
  aHistory : THistory;
begin
  aHistory := THistory.Create;
  try
    aHistory.ConnectWay :=aConnectWay;
    aHistory.Name :=  aName;
    aHistory.Path := aPath;
    DelHistory(aHistory);
  finally
    aHistory.Free;
  end;    
end;


procedure TConfigHelper.ClearHistorys;
begin
  FFileWay.ClearHistorys;
end;

function TConfigHelper.GetWayStr : String;
var
  aFile : Textfile;
begin
  Result := 'dat';
  if not FileExists(FWayStrPath) then
  begin
    Exit;
  end;
  AssignFile(aFile, FWayStrPath);
  try
    Reset(aFile);
    Read(aFile,Result);
  finally
    Closefile(aFile);
  end;
end;

procedure TConfigHelper.SaveWayStr;
var
  aFile: TextFile;
  aStr : String;
begin
  AssignFile(aFile,FWayStrPath);
  try
    Rewrite(aFile);
    Write(aFile, Config.FileWay);
  finally
    CloseFile(aFile);
  end;
end;


destructor TConfigHelper.Destroy; 
begin
  SaveFile;
  SaveWayStr;
  FFileWay.Free;
  inherited;
end;




procedure TConfigHelper.ClearRubbish;
var
  aSoftPath : String;
begin
  aSoftPath := ExtractFileDir(ParamStr(0)) + '\';
  FileHelper.DelFiles(aSoftPath,'dat');
  FileHelper.DelFiles(aSoftPath,'idx');
  FileHelper.DelFiles(aSoftPath,'blb');
end;




procedure TConfigHelper.ImportTable;
var
  fmImport: TfmImport;
begin
  if not Config.GetTable then
  begin
    ShowMessage('未选择对应表。无法导入Excel。');
    Exit;
  end;

  fmImport := TfmImport.Create(nil, Config.SystemTable);
  try
    fmImport.ShowModal;
  finally
    fmImport.Free;
  end;
end;

procedure TConfigHelper.ExportTable;
var
  fmExport: TfmExport;
begin
  if not Config.GetTable  then
  begin
    ShowMessage('未选择对应表。无法导入Excel。');
    Exit;
  end;

  if not Config.SystemTable.ContainData then
  begin
    ShowMessage('无数据，无法导出。');
    Exit;  
  end;

  fmExport := TfmExport.Create(nil, Config.SystemTable);
  try
    fmExport.ShowModal;
  finally
    fmExport.Free;
  end;
end;

procedure TConfigHelper.TableProperty;
var
  fmTableProperty: TfmTableProperty;
begin
  if not Config.GetTable then
  begin
    ShowMessage('未选择对应表。无属性。');
    Exit;
  end;

  fmTableProperty := TfmTableProperty.Create(nil, Config.SystemTable);
  with fmTableProperty do
  try
    ShowModal;
  finally
    Free;
  end;
end;

function TConfigHelper.GetHistoryName(aPath: string; aInclude: Boolean = False): string;
var
  I: Integer;
begin
  Result := '';
//  if aPath = FLastFolderPath then
//  begin
//    Result := '最后一条记录';
//    Exit;
//  end;
  for I := 0 to Config.Historys.Count - 1 do
  begin
    if aInclude then
    begin
      if Pos(aPath, THistory(Config.Historys.Items[I]).Path) <> 0 then
      begin
        Result := THistory(Config.Historys.Items[I]).Name;
        Exit;
      end
    end
    else
    begin
      if THistory(Config.Historys.Items[I]).Path = aPath then
      begin
        Result := THistory(Config.Historys.Items[I]).Name;
        Exit;
      end
    end;
  end;
end;

function TConfigHelper.GetHistoryPath(aName: string; aInclude: Boolean = False): string;
var
  I: Integer;
begin
  Result := '';
//  if aName = '最后一条记录' then
//  begin
//    Result := FLastFolderPath;
//    Exit;
//  end;
  for I := 0 to Config.Historys.Count - 1 do
  begin
    if aInclude then
    begin
      if Pos(aName, THistory(Config.Historys.Items[I]).Name) <> 0 then
      begin
        Result := THistory(Config.Historys.Items[I]).Path;
        Exit;
      end
    end
    else
    begin
      if THistory(Config.Historys.Items[I]).Name = aName then
      begin
        Result := THistory(Config.Historys.Items[I]).Path;
        Exit;
      end
    end;

  end;
end;

function TConfigHelper.GetMenuCaption(const aClassName: string): string;
var
  I: Integer;
begin
  Result := '';
  for I := 0 to Length(Config.FMenuList) - 1 do
  begin
    if Config.FMenuList[I].ClassName = aClassName then
    begin
      Result := Config.FMenuList[I].Caption;
      Exit;
    end
  end;
end;





procedure TConfigHelper.SaveTableEnvironment(var aTable : TTable);
var
  aConfig : TXmlWay;
  aFilePath : String;
begin
  if aTable.TableName = '' then
  begin
    Exit;
  end;
  aConfig := TXmlWay.Create;
  try
    aFilePath := ExtractFileDir(ParamStr(0)) + '\Template\' + aTable.TableName + '.xml';
    aConfig.SaveFile(aFilePath,aTable);
  finally
    aConfig.Free;
  end;
end;

procedure TConfigHelper.ReadTableEnvironment(var aTable : TTable);
var
  aConfig : TXmlWay;
  aFilePath : String;  
begin
  if aTable.TableName  = '' then
  begin
    Exit;
  end;

  aConfig := TXmlWay.Create;
  try
    aFilePath := ExtractFileDir(ParamStr(0)) + '\Template\' + aTable.TableName  + '.xml';
    aConfig.ReadFile(aFilePath,aTable);
  finally
    aConfig.Free;
  end;
end;





procedure TConfigHelper.Add(AOwner: TComponent;var aTable : TTable);
var
  fmInsert : TfmInsert;
begin
  fmInsert := TfmInsert.Create(AOwner,aTable);
  with fmInsert do
  try
    ShowModal;
  finally
    Free;
  end;
end;




initialization
  StrHelper := TStrHelper.Create;
  FileHelper := TFileHelper.Create;
  SQLHelper :=  TSQLHelper.Create;
  Config := TConfig.Create;
  ConfigHelper := TConfigHelper.Create;

finalization
  ConfigHelper.Free;
  Config.Free;
  SQLHelper.Free;
  FileHelper.Free;
  StrHelper.Free;
end.
