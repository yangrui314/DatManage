unit unitConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,unitHistory,
  Dialogs;

type
  TConfig = class
  private
    FInitFolderPath : String;
    FLastFolderPath : String;
    FHistorys: TList;
    constructor Create;
    procedure InitData;
    procedure SetHistorys(aHistorys : TList);    
    procedure FreeHistorys;
    destructor Destroy;
  protected
  public
    property InitFolderPath: string read FInitFolderPath;
    property LastFolderPath: string read FLastFolderPath write FLastFolderPath;
    property Historys : TList read FHistorys write FHistorys;
    function GetHistoryName(aPath : String) : String;
    function GetHistoryPath(aName : String) : String;    
  end;

var
  Config: TConfig;

implementation

constructor TConfig.Create;
begin
  InitData;
end;

procedure TConfig.InitData;
begin
  FHistorys := TList.Create;
  FInitFolderPath :='D:\Project\new_omni\trunk\engineering\deploy\client\'
        +'gd-n-tax(GuiZhou)\deploy(WS)\data\';
end;

procedure TConfig.FreeHistorys;
var
  I: Integer;
  aHistory: THistory;
begin
  for I := 0 to FHistorys.Count - 1 do
  begin
    aHistory := THistory(FHistorys.Items[I]);
    FreeAndNil(aHistory);
  end;
  FHistorys.Clear;
end;

procedure TConfig.SetHistorys(aHistorys : TList);
var
  I: Integer;
begin
  FreeHistorys;
  for I := 0 to aHistorys.Count - 1 do
  begin
    FHistorys.Add(THistory(aHistorys.Items[I]));
  end;
end;


function TConfig.GetHistoryName(aPath : String) : String;
var
  I: Integer;
begin
  Result := '';
  if aPath = FLastFolderPath then
  begin
    Result := '最后一条记录';
    Exit;
  end;
  for I := 0 to FHistorys.Count - 1 do
  begin
    if THistory(FHistorys.Items[I]).Path = aPath then
    begin
      Result :=  THistory(FHistorys.Items[I]).Name;
      Exit;
    end
  end;
end;

function TConfig.GetHistoryPath(aName : String) : String;
var
  I: Integer;
begin
  Result := '';
  if aName = '最后一条记录' then
  begin
    Result := FLastFolderPath;
    Exit;
  end;
  for I := 0 to FHistorys.Count - 1 do
  begin
    if THistory(FHistorys.Items[I]).Name = aName then
    begin
      Result :=  THistory(FHistorys.Items[I]).Path;
      Exit;
    end
  end;
end;


destructor TConfig.Destroy;
begin
  FreeHistorys;
  FreeAndNil(FHistorys);
end;


initialization
  Config := TConfig.Create;

finalization
  Config.Destroy;

end.
