unit unitConfigFile;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs,StdCtrls,unitConfig;


type
  TConfigFile = class
  private
    procedure LoadFile;
    procedure SaveFile;
    procedure ForceCreateConfigPath;
  protected
    FConfig : TConfig;
    FConfigPath : String;
    procedure InitData; virtual;
    function GetSystemConfigValue(aName : String) : String; virtual;abstract;
    procedure SaveSystemConfig(aName : String;aValue : String); virtual;abstract;
    procedure SaveSystemConfigToBoolean(aName : String;aValue : Boolean);virtual;

    function LoadHistorys : TList; virtual;abstract;
  public
    constructor Create; virtual;
    destructor Destroy; virtual;
    procedure SaveHistory(aConnectWay : string;aName : String;aPath : String);virtual;abstract;
  end;


implementation

procedure TConfigFile.ForceCreateConfigPath;
begin
  if not DirectoryExists(FConfigPath) then
  begin
    CreateDir(FConfigPath);
  end;
end;

procedure TConfigFile.InitData;
begin
  ForceCreateConfigPath;
end;

constructor TConfigFile.Create;
begin
  FConfig := Config;
  if FConfigPath = '' then
    FConfigPath := ExtractFileDir(ParamStr(0)) + '\Config';
  InitData;
  LoadFile;
end;


procedure TConfigFile.LoadFile;
var
  aHistorys : TList;
begin
  Config.LastFolderPath := GetSystemConfigValue('LastFolderPath');
  Config.ShowName := (GetSystemConfigValue('ShowName') = '1');
  Config.ShowPath := (GetSystemConfigValue('ShowPath') = '1');
  Config.SelectShowWay := GetSystemConfigValue('SelectShowWay');
  Config.ConnectWay := GetSystemConfigValue('ConnectWay');
  aHistorys := LoadHistorys;
  Config.Historys := aHistorys;
end;

procedure TConfigFile.SaveFile;
begin                            
  SaveSystemConfig('LastFolderPath',Config.LastFolderPath);
  SaveSystemConfigToBoolean('ShowName',Config.ShowName);
  SaveSystemConfigToBoolean('ShowPath',Config.ShowPath);
  SaveSystemConfig('SelectShowWay',Config.SelectShowWay);
  SaveSystemConfig('ConnectWay',Config.ConnectWay);  
end;

procedure TConfigFile.SaveSystemConfigToBoolean(aName : String;aValue : Boolean);
begin
  if aValue then
  begin
    SaveSystemConfig(aName,'1');
  end
  else
  begin
    SaveSystemConfig(aName,'0');  
  end;
end;


destructor TConfigFile.Destroy; 
begin
  SaveFile;    
end;

end.
