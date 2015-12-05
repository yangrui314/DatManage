unit unitConfigFile;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs,StdCtrls,unitConfig,unitXmlWay,unitHandleFileWay;


type
  TConfigFile = class
  private
    FReadFileWay : THandleFileWay;
    FHandleFileWay : THandleFileWay;
    procedure LoadFile;
    procedure SaveFile;
  protected
    procedure SaveSystemConfigToBoolean(aName : String;aValue : Boolean);
  public
    constructor Create; virtual;
    destructor Destroy; virtual;
    procedure SaveHistory(aConnectWay : string;aName : String;aPath : String);    
  end;


implementation


constructor TConfigFile.Create;
begin
  FHandleFileWay := THandleFileWay.Create('xml');
  FReadFileWay := THandleFileWay.Create('dat');
  LoadFile;
end;


procedure TConfigFile.LoadFile;
var
  aHistorys : TList;
begin
  Config.LastFolderPath := FReadFileWay.GetSystemConfig('LastFolderPath');
  Config.ShowName := (FReadFileWay.GetSystemConfig('ShowName') = '1');
  Config.ShowPath := (FReadFileWay.GetSystemConfig('ShowPath') = '1');
  Config.SelectShowWay := FReadFileWay.GetSystemConfig('SelectShowWay');
  Config.ConnectWay := FReadFileWay.GetSystemConfig('ConnectWay');
  aHistorys := FReadFileWay.LoadHistorys;
  Config.Historys := aHistorys;
  FReadFileWay.LoadMenu;
end;

procedure TConfigFile.SaveFile;
begin
  FHandleFileWay.SaveSystemConfig('LastFolderPath',Config.LastFolderPath);
  SaveSystemConfigToBoolean('ShowName',Config.ShowName);
  SaveSystemConfigToBoolean('ShowPath',Config.ShowPath);
  FHandleFileWay.SaveSystemConfig('SelectShowWay',Config.SelectShowWay);
  FHandleFileWay.SaveSystemConfig('ConnectWay',Config.ConnectWay);
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


destructor TConfigFile.Destroy; 
begin
  SaveFile;
  FHandleFileWay.Free;
  FReadFileWay.Free;
end;

end.
