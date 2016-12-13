unit unitEnvironment;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs,StdCtrls,DB;

type
  TEnvironment = class
  private
  protected
    FOwner : TComponent;
    FContainData : Boolean;
    aMain : TDataSet;
    FParameter : String;
    FLoadTable : Boolean;
    FSQLSuccess : Boolean;
    procedure InitData;virtual;
  public
    procedure SetEnvironment(aParameter : String);virtual;
    procedure SetSQL(const aSQL : String ; aShowError : Boolean = True);virtual;abstract;
    procedure ExecSQLs(const aSQLs :  array of String);virtual;abstract;
    destructor Destroy;virtual;
    constructor Create(AOwner: TComponent;aParameter : String); virtual;
    property MainData: TDataSet read aMain write aMain;
    property InitOwner: TComponent read FOwner write FOwner;
    function IsContainData : Boolean; virtual;
    function GetPrimary(aTableName : String) : String;virtual;abstract;
    function LoadTableName(aFilter : String = '') : TStringList;virtual;abstract;
    function CreateParameter : string;virtual;abstract;
    function GetBaseTableSQL(aTableName : String) : string;virtual;
    function GetLoadTable : Boolean;
    property SQLSuccess: Boolean read FSQLSuccess;
  end;

implementation
  uses
    unitConfig;


constructor TEnvironment.Create(AOwner: TComponent;aParameter : String);
begin
  FSQLSuccess := False;
  FLoadTable := False;
  FParameter := aParameter;
  FOwner := AOwner;
  InitData;
end;

procedure TEnvironment.SetEnvironment(aParameter : String);
begin
  FParameter := aParameter;    
end;

procedure TEnvironment.InitData;
begin
  //初始化数据
end;


function TEnvironment.IsContainData : Boolean;
begin
  Result := False;
end;


destructor TEnvironment.Destroy;
begin

end;

function TEnvironment.GetBaseTableSQL(aTableName : String) : string;
begin
  Result := 'select * from '  + aTableName;
end;

function TEnvironment.GetLoadTable : Boolean;
begin
  Result := FLoadTable;
end;



end.
