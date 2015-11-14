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
    procedure InitData;virtual;
  public
    procedure SetEnvironment(aParameter : String);virtual;
    procedure SetSQL(const aSQL : String);virtual;abstract;
    procedure ExecSQL(const aSQL : String);virtual;abstract;
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
  end;

implementation


constructor TEnvironment.Create(AOwner: TComponent;aParameter : String);
begin
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

end.
