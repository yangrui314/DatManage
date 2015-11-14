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
    procedure InitData;virtual;
  public
    procedure SetEnvironment(aParameter : String);virtual;abstract;
    procedure SetSQL(const aSQL : String);virtual;abstract;
    procedure ExecSQL(const aSQL : String);virtual;abstract;
    procedure ExecSQLs(const aSQLs :  array of String);virtual;abstract;
    destructor Destroy;virtual;
    constructor Create(AOwner: TComponent;aParameter : String); virtual;
    property MainData: TDataSet read aMain write aMain;
    property InitOwner: TComponent read FOwner write FOwner;
    function IsContainData : Boolean; virtual;
    function GetPrimary(aTableName : String) : String;virtual;abstract;
  end;

implementation


constructor TEnvironment.Create(AOwner: TComponent;aParameter : String);
begin
  FOwner := AOwner;
  InitData;
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


end.
