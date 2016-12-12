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
  Dialogs,StdCtrls,unitConfig,unitXmlWay,unitHandleFileWay,unitHistory;


type
  TConfigHelper = class
  private
    FHandleFileWay : THandleFileWay;
    FWayStrPath : string;
    procedure LoadFile;
    procedure SaveFile;
  protected
    procedure SaveSystemConfigToBoolean(aName : String;aValue : Boolean);
    function GetWayStr : String;
    procedure SaveWayStr;    
  public
    constructor Create; virtual;
    destructor Destroy; virtual;
    procedure SaveHistory(const aConnectWay : string;const aName : String;const aPath : String);overload;
    procedure SaveHistory(const aHistory : THistory);overload;
    procedure SaveHistory;overload;
    procedure ClearHistorys;
    procedure DelHistory(const aConnectWay : string;const aName : String;const aPath : String);overload;
    procedure DelHistory(const aHistory : THistory);overload;
  end;

var
  ConfigHelper: TConfigHelper;


implementation



constructor TConfigHelper.Create;
begin
  FWayStrPath := ExtractFilePath(ParamStr(0)) + 'FileWay.ini';
  Config.FileWay := GetWayStr;
  FHandleFileWay := THandleFileWay.Create(Config.FileWay);
  LoadFile;
end;


procedure TConfigHelper.LoadFile;
var
  aHistorys : TList;
begin
  Config.LastFolderPath := FHandleFileWay.GetSystemConfig('LastFolderPath');
  Config.ShowName := (FHandleFileWay.GetSystemConfig('ShowName') = '1');
  Config.ShowPath := (FHandleFileWay.GetSystemConfig('ShowPath') = '1');
  Config.SelectShowWay := FHandleFileWay.GetSystemConfig('SelectShowWay');
  Config.ConnectWay := FHandleFileWay.GetSystemConfig('ConnectWay');
  aHistorys := FHandleFileWay.LoadHistorys;
  Config.Historys := aHistorys;
  Config.Password := FHandleFileWay.LoadPasswords;
  FHandleFileWay.LoadMenu;
end;

procedure TConfigHelper.SaveFile;
begin
  FHandleFileWay := THandleFileWay.Create(Config.FileWay);
  FHandleFileWay.SaveSystemConfig('LastFolderPath',Config.LastFolderPath);
  SaveSystemConfigToBoolean('ShowName',Config.ShowName);
  SaveSystemConfigToBoolean('ShowPath',Config.ShowPath);
  FHandleFileWay.SaveSystemConfig('SelectShowWay',Config.SelectShowWay);
  FHandleFileWay.SaveSystemConfig('ConnectWay',Config.ConnectWay);
  FHandleFileWay.SaveMenu;
end;

procedure TConfigHelper.SaveSystemConfigToBoolean(aName : String;aValue : Boolean);
begin
  if aValue then
  begin
    FHandleFileWay.SaveSystemConfig(aName,'1');
  end
  else
  begin
    FHandleFileWay.SaveSystemConfig(aName,'0');
  end;
end;

procedure TConfigHelper.SaveHistory(const aHistory : THistory);
begin
  FHandleFileWay.SaveHistory(aHistory);
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
  FHandleFileWay.ClearHistorys;
  for I := 0 to Config.Historys.Count - 1 do
  begin
    SaveHistory(THistory(Config.Historys[I]));
  end;
end;

procedure TConfigHelper.DelHistory(const aHistory : THistory);
begin
  FHandleFileWay.DelHistory(aHistory);    
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
  FHandleFileWay.ClearHistorys;
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
  FHandleFileWay.Free;
end;

initialization
  ConfigHelper := TConfigHelper.Create;

finalization
  ConfigHelper.Destroy;

end.
