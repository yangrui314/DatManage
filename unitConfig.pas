unit unitConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs,StdCtrls,DB, dbisamtb;

type
  TConfig = class
  private
    aMain: TDBISAMQuery;
    dMain: TDBISAMDatabase;
    aExecSQL : TDBISAMQuery;
    dExecSQL: TDBISAMDatabase;
    FRootPath : String;
    FOwner : TComponent;
    FContainData : Boolean;
    procedure InitData;
  protected
  public
    procedure SetRootPath(aRootPath : String);
    procedure SetSQL(const aSQL : String);
    procedure ExecSQL(const aSQL : String);
    procedure ExecSQLs(const aSQLs :  array of String);
    destructor Destroy;
    constructor Create(AOwner: TComponent;aRootPath : String);
    property MainData: TDBISAMQuery read aMain write aMain;
    property InitOwner: TComponent read FOwner write FOwner;
    function Clone:TConfig;
    function IsContainData : Boolean;
  end;

implementation


constructor TConfig.Create(AOwner: TComponent;aRootPath : String);
begin
  FOwner := AOwner;
  aMain := TDBISAMQuery.Create(AOwner);
  dMain := TDBISAMDatabase.Create(AOwner);

  aExecSQL := TDBISAMQuery.Create(AOwner);
  dExecSQL := TDBISAMDatabase.Create(AOwner);  
  FRootPath := aRootPath;
  InitData;
end;

procedure TConfig.SetRootPath(aRootPath : String);
begin
  FRootPath := aRootPath;
  dMain.Close;
  dMain.Directory := FRootPath;
  dMain.Open;
  dExecSQL.Close;
  dExecSQL.Directory := FRootPath;
  dExecSQL.Open;
end;

procedure TConfig.InitData;
begin
  dMain.Directory := FRootPath;
  dMain.DatabaseName := 'OmniDatabase';
  dMain.Open;
  dMain.Session.AddPassword('YouAreNotPrepared');
  dMain.Session.AddPassword('YouAreNotPrepared');
  dMain.Session.AddPassword('YouAreNotPreparedForIT');
  aMain.DatabaseName := dMain.DatabaseName;

  dExecSQL.Directory := FRootPath;
  dExecSQL.DatabaseName := 'OmniExecSQL';
  dExecSQL.Open;
  dExecSQL.Session.AddPassword('YouAreNotPrepared');
  dExecSQL.Session.AddPassword('YouAreNotPrepared');
  dExecSQL.Session.AddPassword('YouAreNotPreparedForIT');
  aExecSQL.DatabaseName := dExecSQL.DatabaseName;
end;

procedure TConfig.SetSQL(const aSQL : String);
begin
  try
    if aSQL = '' then Exit;
    aMain.Close;
    aMain.SQL.Clear;
    aMain.SQL.Add(aSQL);
    aMain.Prepare;
    aMain.ExecSQL;
    FContainData := not aMain.IsEmpty;
  except
    on E: Exception do
      showmessage('异常类名称:' + E.ClassName
        + #13#10 + '异常信息:' + E.Message);
  end;    
end;

function TConfig.IsContainData : Boolean;
begin
  Result := FContainData;
end;


destructor TConfig.Destroy; 
begin
  aMain.Close;
  aMain.CloseDatabase(dMain);
  dMain.Close;
  dMain.CloseDataSets;
  aMain.Free;
  dMain.Free;

  aExecSQL.Close;
  aExecSQL.CloseDatabase(dMain);
  dExecSQL.Close;
  dExecSQL.CloseDataSets;
  aExecSQL.Free;
  dExecSQL.Free;  
end;

procedure TConfig.ExecSQL(const aSQL : String);
begin
  try
    if aSQL = '' then Exit;
    aExecSQL.Close;
    aExecSQL.SQL.Clear;
    aExecSQL.SQL.Add(aSQL);
    aExecSQL.Prepare;
    aExecSQL.ExecSQL;
    ShowMessage('执行成功:'+aSQL)
  except
    on E: Exception do
      showmessage('异常类名称:' + E.ClassName
        + #13#10 + '异常信息:' + E.Message);
  end;    
end;

procedure TConfig.ExecSQLs(const aSQLs :  array of String);
var
  I : Integer;
  Len : Integer;
begin
  Len := Length(aSQLs);
  try
    aExecSQL.Close;
    aExecSQL.SQL.Clear;
    for I := 0 to Len -1 do
    begin
      if aSQLs[I] = '' then Continue;
      aExecSQL.SQL.Add(aSQLs[I]+';');
    end;
    aExecSQL.Prepare;
    aExecSQL.ExecSQL;

    ShowMessage('执行语句共'+ IntToStr(Len) + '条,'+'执行SQL成功!')
  except
    on E: Exception do
      showmessage('执行语句共'+ IntToStr(Len) + '条,'+'执行SQL失败'
       + #13#10 + 
      '异常类名称:' + E.ClassName
        + #13#10 + '异常信息:' + E.Message);
  end;    
end;

function TConfig.Clone:TConfig;
begin
//  Result := TConfig.Create(Self.FOwner,Self.FRootPath);
//  Result.dMain.Assign(Self.dMain);
//  Result.aMain.Assign(Self.aMain);
end;

end.
