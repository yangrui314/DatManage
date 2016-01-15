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
    FLogPath : String;
    FLoadTable : Boolean;
    FSQLSuccess : Boolean;
    procedure InitData;virtual;
    procedure SaveLog(const aIsSuccess : Boolean;const aSQL : String;const aMessage: String = '');
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
    unitStandardHandle,unitConfig;


constructor TEnvironment.Create(AOwner: TComponent;aParameter : String);
begin
  FSQLSuccess := False;
  FLoadTable := False;
  FParameter := aParameter;
  FOwner := AOwner;
  FLogPath := ExtractFilePath(ParamStr(0)) + 'Log.txt';
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


procedure TEnvironment.SaveLog(const aIsSuccess : Boolean;const aSQL : String;const aMessage: String = '');
var
 aLogFile : TStandardHandle;
 aLogStr : string;
 aNewLog : string;

 function GetNewLog : string;
 var
   aModeStr : string;
   aResultStr : string;
   aSQLStr : string;
   aMessageStr : string;
   aTimeStr : string;
 begin
  Result := '';
  Result := Config.SystemParameterCaption;

  if Config.ConnectWay = '1' then
  begin
    aModeStr := #13#10  + '数据库:' + 'DBISAM模式';
  end
  else
  begin
    aModeStr := #13#10 + '数据库:' + 'SQL模式';
  end;

  if aIsSuccess then
  begin
    aResultStr := #13#10 + '执行成功。';
  end
  else
  begin
    aResultStr := #13#10 + '执行失败!';
  end;
  aSQLStr :=   #13#10 + '执行SQL:' + aSQL;
  aMessageStr :=  #13#10 + '相关信息:' + aMessage;
  aTimeStr  :=   #13#10 + '保存时间:' + FormatDatetime('YYYY/MM/DD HH:MM:SS',Now);
  Result := Result + aModeStr + aResultStr  + aSQLStr ;
  if aMessage <> '' then
  begin
    Result := Result  + aMessageStr ;
  end;
  Result := Result  + aTimeStr;
 end;

begin
  FSQLSuccess:= aIsSuccess;
  aLogFile := TStandardHandle.Create;
  try
    aLogStr := aLogFile.ReadFileToStr(FLogPath);
    aNewLog := GetNewLog;
    if aLogStr <> '' then
      aLogStr := aLogStr + #13#10 +  #13#10  + aNewLog
    else
      aLogStr := aNewLog;
    aLogFile.SaveFile(FLogPath,aLogStr);
  finally
    aLogFile.Free;
  end;
end;

end.
