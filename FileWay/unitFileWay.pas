unit unitFileWay;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs,StdCtrls;


type
  TFileWay = class
  private
  protected
    FConfigPath : String;
    FSystemConfigName : String;
    FHistoryName : String;
    FMenuName : String;
    FSystemConfigFilePath : String;
    FHistoryFilePath : String;
    FMenuFilePath : String;
    FExt : String;
    procedure ForceCreateConfigPath;
    procedure InitData; virtual;
    procedure CreateSystemConfig;virtual;abstract;
    procedure CreateHistory; virtual;abstract;
    procedure CreateMenu; virtual;abstract;
    procedure NotFileCreateFile;
  public
    constructor Create; virtual;
    destructor Destroy; virtual;
    function GetSystemConfig(aName : String) : String; virtual;abstract;
    procedure SaveSystemConfig(aName : String;aValue : String); virtual;abstract;
  end;

implementation


constructor TFileWay.Create;
begin
  if FConfigPath = '' then
    FConfigPath := ExtractFileDir(ParamStr(0)) + '\Config';
  FSystemConfigName := 'SystemConfig';
  FHistoryName := 'History';
  FMenuName := 'Menu';
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
  end;    
end;

procedure TFileWay.InitData;
begin
  ForceCreateConfigPath;
  FSystemConfigFilePath := FConfigPath + '\' + FSystemConfigName + FExt;
  FHistoryFilePath := FConfigPath + '\' + FHistoryName + FExt;
  FMenuFilePath := FConfigPath + '\' + FMenuName + FExt;
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