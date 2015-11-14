unit unitDbisamEnvironment;


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs,StdCtrls,DB, dbisamtb,unitEnvironment;

type
  TDbisamEnvironment = class(TEnvironment)
  private
    dMain: TDBISAMDatabase;
    aExecSQL : TDBISAMQuery;
    dExecSQL: TDBISAMDatabase;
    FRootPath : String;
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
  end;

implementation


constructor TDbisamEnvironment.Create(AOwner: TComponent;aParameter : String);
begin
  aMain := TDBISAMQuery.Create(AOwner);
  dMain := TDBISAMDatabase.Create(AOwner);
  aExecSQL := TDBISAMQuery.Create(AOwner);
  dExecSQL := TDBISAMDatabase.Create(AOwner);  
  FRootPath := aParameter;
  inherited Create(AOwner,aParameter);
end;

procedure TDbisamEnvironment.SetEnvironment(aParameter : String);
begin
  FRootPath := aParameter;
  dMain.Close;
  dMain.Directory := FRootPath;
  dMain.Open;

  dExecSQL.Close;
  dExecSQL.Directory := FRootPath;
  dExecSQL.Open;
end;

procedure TDbisamEnvironment.InitData;
var
  Test : String;
begin
  inherited;
  dMain.Directory := FRootPath;
  dMain.DatabaseName := 'OmniDatabase' + IntToStr(Random(100));
  dMain.Open;
  dMain.Session.AddPassword('YouAreNotPrepared');
  dMain.Session.AddPassword('YouAreNotPrepared');
  dMain.Session.AddPassword('YouAreNotPreparedForIT');
  TDBISAMQuery(aMain).DatabaseName := dMain.DatabaseName;




  dExecSQL.Directory := FRootPath;
  dExecSQL.DatabaseName := 'OmniExecSQL' + IntToStr(Random(100));
  dExecSQL.Open;
  dExecSQL.Session.AddPassword('YouAreNotPrepared');
  dExecSQL.Session.AddPassword('YouAreNotPrepared');
  dExecSQL.Session.AddPassword('YouAreNotPreparedForIT');
  aExecSQL.DatabaseName := dExecSQL.DatabaseName;
end;

procedure TDbisamEnvironment.SetSQL(const aSQL : String);
begin
  try
    if aSQL = '' then Exit;
    TDBISAMQuery(aMain).Close;
    TDBISAMQuery(aMain).SQL.Clear;
    TDBISAMQuery(aMain).SQL.Add(aSQL);
    TDBISAMQuery(aMain).Prepare;
    TDBISAMQuery(aMain).ExecSQL;
    FContainData := not aMain.IsEmpty;
  except
    on E: Exception do
      showmessage('异常类名称:' + E.ClassName
        + #13#10 + '异常信息:' + E.Message + #13#10 +aSQL );
  end;    
end;


function TDbisamEnvironment.GetPrimary(aTableName : String) : String;
var
  aTableDB : TDBISAMTable;
  I : Integer;
begin
  aTableDB :=  TDBISAMTable.Create(FOwner);
  aTableDB.DatabaseName := dMain.DatabaseName;
  try
    with aTableDB do
    begin
      Close;
      TableName:=aTableName;
      Open;

      for I:=0 to  IndexDefs.Count - 1 do
      begin
         if ixPrimary in IndexDefs.Items[I].Options  then
         begin
          Result := IndexDefs.Items[I].Fields;
          Exit;
         end;
      end;
    end;
  finally
    aTableDB.Close;
    aTableDB.CloseDatabase(dMain);
    aTableDB.Free;
  end;
end;

function TDbisamEnvironment.IsContainData : Boolean;
begin
  Result := FContainData;
end;


destructor TDbisamEnvironment.Destroy; 
begin
  inherited;
  aMain.Close;
  TDBISAMQuery(aMain).CloseDatabase(dMain);
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

procedure TDbisamEnvironment.ExecSQL(const aSQL : String);
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

procedure TDbisamEnvironment.ExecSQLs(const aSQLs :  array of String);
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


end.
