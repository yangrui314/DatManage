unit unitConfigFile;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs,StdCtrls,unitConfig,unitXmlWay,unitHandleFileWay,unitHistory;


type
  TConfigFile = class
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
  end;


implementation



constructor TConfigFile.Create;
begin
  FWayStrPath := ExtractFilePath(ParamStr(0)) + 'FileWay.ini';
  Config.FileWay := GetWayStr;
  FHandleFileWay := THandleFileWay.Create(Config.FileWay);
  LoadFile;
end;


procedure TConfigFile.LoadFile;
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

procedure TConfigFile.SaveFile;
begin
  FHandleFileWay := THandleFileWay.Create(Config.FileWay);
  FHandleFileWay.SaveSystemConfig('LastFolderPath',Config.LastFolderPath);
  SaveSystemConfigToBoolean('ShowName',Config.ShowName);
  SaveSystemConfigToBoolean('ShowPath',Config.ShowPath);
  FHandleFileWay.SaveSystemConfig('SelectShowWay',Config.SelectShowWay);
  FHandleFileWay.SaveSystemConfig('ConnectWay',Config.ConnectWay);
  SaveHistory;
  FHandleFileWay.SaveMenu;
end;

procedure TConfigFile.SaveSystemConfigToBoolean(aName : String;aValue : Boolean);
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

procedure TConfigFile.SaveHistory(const aHistory : THistory);
begin
  FHandleFileWay.SaveHistory(aHistory);
end;

procedure TConfigFile.SaveHistory(const aConnectWay : string;const aName : String;const aPath : String);
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


procedure TConfigFile.SaveHistory;
var
  I : Integer;
begin
  FHandleFileWay.ClearHistorys;
  for I := 0 to Config.Historys.Count - 1 do
  begin
    SaveHistory(THistory(Config.Historys[I]));
  end;
end;

procedure TConfigFile.ClearHistorys;
begin
  FHandleFileWay.ClearHistorys;
end;

function TConfigFile.GetWayStr : String;
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

procedure TConfigFile.SaveWayStr;
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


destructor TConfigFile.Destroy; 
begin
  SaveFile;
  SaveWayStr;
  FHandleFileWay.Free;
end;

end.
