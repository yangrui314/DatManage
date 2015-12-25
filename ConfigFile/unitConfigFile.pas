unit unitConfigFile;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs,StdCtrls,unitConfig,unitXmlWay,unitHandleFileWay;


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
    procedure SaveHistory(aConnectWay : string;aName : String;aPath : String);overload;    
    procedure SaveHistory;overload;
  end;


implementation

  uses
    unitHistory;


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

procedure TConfigFile.SaveHistory(aConnectWay : string;aName : String;aPath : String);
begin
  FHandleFileWay.SaveHistory(aConnectWay,aName,aPath);
end;

procedure TConfigFile.SaveHistory;
var
  I : Integer;
begin
  FHandleFileWay.ClearHistorys;
  for I := 0 to Config.Historys.Count - 1 do
  begin
    SaveHistory(THistory(Config.Historys[I]).ConnectWay,THistory(Config.Historys[I]).Name,THistory(Config.Historys[I]).Path);
  end;
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
