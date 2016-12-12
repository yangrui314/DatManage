unit unitHandleFileWay;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs,StdCtrls,unitTable,unitFileWay,unitXmlWay,unitDatWay,unitHistory;


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
    procedure SaveHistory(const aHistory : THistory);
    function SaveFile(aFilePath : String;var aTable : TTable) : Boolean;
    function ReadFile(aFilePath : String;var aTable : TTable) : Boolean;
    procedure LoadMenu;
    procedure SaveMenu;
    procedure ClearHistorys;
    function LoadPasswords : TStringList;
    procedure DelHistory(const aHistory : THistory);
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

function THandleFileWay.LoadPasswords : TStringList;
begin
  Result := FFileWay.LoadPasswords;
end;

procedure THandleFileWay.SaveHistory(const aHistory : THistory);
begin
  FFileWay.SaveHistory(aHistory);
end;

procedure THandleFileWay.DelHistory(const aHistory : THistory);
begin
  FFileWay.DelHistory(aHistory);
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




end.
