unit unitSQLEnvironment;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs,StdCtrls,DB, DBTables, ADODB,unitEnvironment;

type
  TSQLEnvironment = class(TEnvironment)
  private
    aMainConn: TADOConnection;
    procedure aMainConnection;
  protected
    procedure InitData;
  public
    procedure SetEnvironment(aParameter : String);override;
    procedure SetSQL(const aSQL : String);override;
    procedure ExecSQL(const aSQL : String);override;
    procedure ExecSQLs(const aSQLs :  array of String);override;
    destructor Destroy;override;
    constructor Create(AOwner: TComponent;aParameter : String);override;
    function IsContainData : Boolean; override;
    function GetPrimary(aTableName : String) : String; override;
    function LoadTableName(aFilter : String = '') : TStringList;override;
    function CreateParameter : string;override;   
  end;

implementation


constructor TSQLEnvironment.Create(AOwner: TComponent;aParameter : String);
begin
  aMain := TADOQuery.Create(AOwner);
  aMainConn := TADOConnection.Create(AOwner);
  inherited Create(AOwner,aParameter);
end;

procedure TSQLEnvironment.SetEnvironment(aParameter : String);
begin
  inherited;
end;


procedure TSQLEnvironment.InitData;
begin
  inherited;
end;

procedure TSQLEnvironment.aMainConnection;
begin
  aMainConn.Close;
  aMainConn.ConnectionString:=FParameter;
  //取消用户名等验证
  aMainConn.LoginPrompt:= False;
  aMainConn.Open; 
  if  not aMainConn.Connected then
  begin
    ShowMessage('连接数据库失败');  
  end;
  TADOQuery(aMain).Connection := aMainConn;
end;

procedure TSQLEnvironment.SetSQL(const aSQL : String);
begin
  try
    if aSQL = '' then Exit;
    TADOQuery(aMain).Close;
    aMainConnection;
    TADOQuery(aMain).SQL.Clear;
    TADOQuery(aMain).SQL.Add(aSQL);
    TADOQuery(aMain).ExecSQL;
    TADOQuery(aMain).Open;    
    FContainData := not aMain.IsEmpty;
  except
    on E: Exception do
      showmessage('异常类名称:' + E.ClassName
        + #13#10 + '异常信息:' + E.Message + #13#10 +aSQL );
  end;    
end;


function TSQLEnvironment.GetPrimary(aTableName : String) : String;
var
  adsTable: TADOQuery;
  TableSQL : string;
  adsConn : TADOConnection;
begin
  Result := '';
  TableSQL := 'SELECT   name FROM SysColumns ' +
  ' WHERE id = Object_Id(''' +aTableName+ ''') and ' +
  ' colid in(select keyno from sysindexkeys where id =Object_Id((''' +aTableName+ ''')))';
  adsTable := TADOQuery.Create(FOwner);
  adsConn := TADOConnection.Create(FOwner);
  try
    adsTable.Close;
    adsConn.Close;
    adsConn.ConnectionString:=FParameter;
    adsConn.LoginPrompt:= False;
    adsConn.Open;
    if  not adsConn.Connected then
    begin
      ShowMessage('连接数据库失败');
      Exit;
    end;
    adsTable.Connection := adsConn;
    adsTable.SQL.Clear;
    adsTable.SQL.Add(TableSQL);
    adsTable.ExecSQL;
    adsTable.Open;
    
    adsTable.First;
    while not adsTable.Eof do
    begin
      if adsTable.FieldByName('name').AsString <> '' then
      begin
        if Result = '' then
        begin
          Result := adsTable.FieldByName('name').AsString;
        end
        else
        begin
          Result := Result + ';' + adsTable.FieldByName('name').AsString;
        end;      
      end;
      adsTable.Next;
    end;
  finally
    adsTable.Close;
    adsTable.Free;
    adsConn.Close;
    adsConn.Free;
  end;

end;

function TSQLEnvironment.IsContainData : Boolean;
begin
  Result := FContainData;
end;


destructor TSQLEnvironment.Destroy; 
begin
  aMain.Close;
  aMain.Free;
end;

procedure TSQLEnvironment.ExecSQL(const aSQL : String);
begin
  try
    if aSQL = '' then Exit;
    TADOQuery(aMain).Close;
    aMainConnection;
    TADOQuery(aMain).SQL.Clear;
    TADOQuery(aMain).SQL.Add(aSQL);
    TADOQuery(aMain).ExecSQL;
    ShowMessage('执行成功:'+aSQL)
  except
    on E: Exception do
      showmessage('异常类名称:' + E.ClassName
        + #13#10 + '异常信息:' + E.Message);
  end;    
end;

procedure TSQLEnvironment.ExecSQLs(const aSQLs :  array of String);
var
  I : Integer;
  Len : Integer;
begin
  Len := Length(aSQLs);
  try
    TADOQuery(aMain).Close;
    aMainConnection;
    TADOQuery(aMain).SQL.Clear;
    for I := 0 to Len -1 do
    begin
      if aSQLs[I] = '' then Continue;
      TADOQuery(aMain).SQL.Add(aSQLs[I]+';');
    end;
    TADOQuery(aMain).ExecSQL;
    ShowMessage('执行语句共'+ IntToStr(Len) + '条,'+'执行SQL成功!')
  except
    on E: Exception do
      showmessage('执行语句共'+ IntToStr(Len) + '条,'+'执行SQL失败'
       + #13#10 + 
      '异常类名称:' + E.ClassName
        + #13#10 + '异常信息:' + E.Message);
  end;    
end;

function TSQLEnvironment.LoadTableName(aFilter : String = '') : TStringList;
var
  adsTable: TADOQuery;
  TableSQL : string;
  adsConn : TADOConnection;
begin
  TableSQL := 'SELECT Name FROM SysObjects Where XType=''U'' ORDER BY Name';
  adsTable := TADOQuery.Create(FOwner);
  adsConn := TADOConnection.Create(FOwner);
  Result := TStringList.Create;
  try
    adsTable.Close;
    adsConn.Close;
    adsConn.ConnectionString:=FParameter;
    adsConn.LoginPrompt:= False;
    adsConn.Open;
    if  not adsConn.Connected then
    begin
      ShowMessage('连接数据库失败');
      Exit;
    end;
    adsTable.Connection := adsConn;
    adsTable.SQL.Clear;
    adsTable.SQL.Add(TableSQL);
    adsTable.ExecSQL;
    adsTable.Open;
    
    adsTable.First;
    while not adsTable.Eof do
    begin
      Result.Add(adsTable.FieldByName('Name').AsString);
      adsTable.Next;
    end;
  finally
    adsTable.Close;
    adsTable.Free;
    adsConn.Close;
    adsConn.Free;
  end;

end;


function TSQLEnvironment.CreateParameter : string;
begin
  Result := '';
  Result := PromptDataSource(GetActiveWindow, '');
end;

end.
