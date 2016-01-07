unit unitHandleFileWay;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs,StdCtrls,unitTable,unitFileWay,unitXmlWay,unitDatWay,unitWorkLog;


type
  THandleFileWay = class
  private
  protected
    FFileWay : TFileWay;
    FWayStrPath : String;
  public
    destructor Destroy; virtual;
    constructor Create(aWay : String);
    function GetSystemConfig(aName : String) : String;
    procedure SaveSystemConfig(aName : String;aValue : String);
    function LoadHistorys : TList;
    procedure SaveHistory(aConnectWay : string;aName : String;aPath : String);
    function SaveFile(aFilePath : String;var aTable : TTable) : Boolean;
    function ReadFile(aFilePath : String;var aTable : TTable) : Boolean;
    procedure LoadMenu;
    procedure SaveMenu;
    procedure ClearHistorys;
    procedure SaveWorkLog(var WorkLog : TWorkLog);
    function LoadWorkLog : TWorkLog;
  end;


implementation


constructor THandleFileWay.Create(aWay : String);
begin
  if aWay = 'xml' then
  begin
    FFileWay := TXmlWay.Create;
  end
  else
  begin
    FFileWay := TDatWay.Create;
  end;
end;

function THandleFileWay.GetSystemConfig(aName : String) : String;
begin
  Result := FFileWay.GetSystemConfig(aName);
end;

procedure THandleFileWay.SaveSystemConfig(aName : String;aValue : String);
begin
  FFileWay.SaveSystemConfig(aName,aValue);
end;

function THandleFileWay.LoadHistorys : TList;
begin
  Result := FFileWay.LoadHistorys;
end;

procedure THandleFileWay.SaveHistory(aConnectWay : string;aName : String;aPath : String);
begin
  FFileWay.SaveHistory(aConnectWay,aName,aPath);
end;

procedure THandleFileWay.ClearHistorys;
begin
  FFileWay.ClearHistorys;
end;


function THandleFileWay.SaveFile(aFilePath : String;var aTable : TTable) : Boolean;
begin
  Result := FFileWay.SaveFile(aFilePath,aTable);
end;

function THandleFileWay.ReadFile(aFilePath : String;var aTable : TTable) : Boolean;
begin
  Result := FFileWay.ReadFile(aFilePath,aTable);
end;

destructor THandleFileWay.Destroy;
begin
  FFileWay.Free;
end;

procedure THandleFileWay.LoadMenu;
begin
  FFileWay.LoadMenu;    
end;

procedure THandleFileWay.SaveMenu;
begin
  FFileWay.SaveMenu;    
end;

procedure THandleFileWay.SaveWorkLog(var WorkLog : TWorkLog);
begin
  FFileWay.SaveWorkLog(WorkLog);
end;

function THandleFileWay.LoadWorkLog : TWorkLog;
begin
  Result := FFileWay.LoadWorkLog;
end;


end.
