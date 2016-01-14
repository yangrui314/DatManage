unit unitFileWay;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs,StdCtrls,unitTable,unitMenu,unitWorkLog,unitHistory;


type
  TFileWay = class
  private
  protected
    FConfigPath : String;

    FSystemConfigName : String;
    FHistoryName : String;
    FMenuName : String;
    FWorkLogName : String;
    FPasswordName : String;

    FSystemConfigFilePath : String;
    FHistoryFilePath : String;
    FMenuFilePath : String;
    FWorkLogFilePath : String;
    FPasswordFilePath : String;    

    FExt : String;
    procedure ForceCreateConfigPath;
    procedure InitData; virtual;
    procedure CreateSystemConfig;virtual;abstract;
    procedure CreateHistory; virtual;abstract;
    procedure CreateMenu; virtual;abstract;
    procedure CreateWorkLog; virtual;abstract;
    procedure CreatePassword; virtual;abstract;         
    procedure NotFileCreateFile;
  public
    constructor Create; virtual;
    destructor Destroy; virtual;
    function GetSystemConfig(aName : String) : String; virtual;abstract;
    procedure SaveSystemConfig(aName : String;aValue : String); virtual;abstract;
    function LoadHistorys : TList; virtual;abstract;
    procedure SaveHistory(const aHistory : THistory); virtual;abstract;
    function SaveFile(aFilePath : String;var aTable : TTable) : Boolean; virtual;abstract;
    function ReadFile(aFilePath : String;var aTable : TTable) : Boolean; virtual;abstract;
    procedure LoadMenu; virtual;abstract;
    procedure SaveMenu; virtual;abstract;
    procedure ClearHistorys;virtual;abstract;
    procedure SaveWorkLog(var WorkLog : TWorkLog);virtual;abstract;
    function LoadWorkLog : TWorkLog;virtual;abstract;
    function LoadPasswords : TStringList; virtual;abstract;
  end;

implementation


constructor TFileWay.Create;
begin
  if FConfigPath = '' then
    FConfigPath := ExtractFileDir(ParamStr(0)) + '\Config';
  FSystemConfigName := 'SystemConfig';
  FHistoryName := 'History';
  FMenuName := 'Menu';
  FWorkLogName := 'WorkLog';
  FPasswordName := 'Password';  
  FExt := '';
  InitData;
end;


procedure TFileWay.NotFileCreateFile;
begin
  if FExt <> '' then
  begin
    if  not FileExists(FSystemConfigFilePath) then
    begin
      CreateSystemConfig;  
    end;

    if not FileExists(FHistoryFilePath) then
    begin
      CreateHistory;  
    end;

    if not FileExists(FMenuFilePath) then
    begin
      CreateMenu;  
    end;

    if not FileExists(FWorkLogFilePath) then
    begin
      CreateWorkLog;  
    end;

    if  not FileExists(FPasswordFilePath) then
    begin
      CreatePassword;
    end;
  end;    
end;

procedure TFileWay.InitData;
begin
  ForceCreateConfigPath;
  FSystemConfigFilePath := FConfigPath + '\' + FSystemConfigName + FExt;
  FHistoryFilePath := FConfigPath + '\' + FHistoryName + FExt;
  FMenuFilePath := FConfigPath + '\' + FMenuName + FExt;
  FWorkLogFilePath := FConfigPath + '\' + FWorkLogName + FExt;
  FPasswordFilePath := FConfigPath + '\' + FPasswordName + FExt;  
  NotFileCreateFile;
end;

procedure TFileWay.ForceCreateConfigPath;
begin
  if not DirectoryExists(FConfigPath) then
  begin
    CreateDir(FConfigPath);
  end;
end;



destructor TFileWay.Destroy;
begin

end;

end.
