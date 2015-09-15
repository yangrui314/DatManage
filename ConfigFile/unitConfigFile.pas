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

    function LoadLastFolderPath : String; virtual;abstract;
    procedure SaveLastFolderPath(aPath : String); virtual;abstract;
    function LoadHistorys : TList; virtual;abstract;
  public
    constructor Create; virtual;
    destructor Destroy; virtual;
    procedure SaveHistory(aName : String;aPath : String);virtual;abstract;
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
  Config.LastFolderPath := LoadLastFolderPath;
  aHistorys := LoadHistorys;
  Config.Historys := aHistorys;
end;

procedure TConfigFile.SaveFile;
begin                            
  SaveLastFolderPath(Config.LastFolderPath);
end;

destructor TConfigFile.Destroy; 
begin
  SaveFile;    
end;

end.
