unit unitSQLEnvironment;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs,StdCtrls,DB, DBTables, ADODB,unitEnvironment;

type
  TSQLEnvironment = class(TEnvironment)
  private
    aMainConn: TADOConnection;
    FConnectionStr : String;
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
  end;

implementation


constructor TSQLEnvironment.Create(AOwner: TComponent;aParameter : String);
begin
  aMain := TADOQuery.Create(AOwner);
  aMainConn := TADOConnection.Create(AOwner);
  FConnectionStr := aParameter;
  FConnectionStr := 'Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security Info=False;Initial Catalog=QFWineERP;Data Source=YR\SQL2008';;
  inherited Create(AOwner,aParameter);
end;

procedure TSQLEnvironment.SetEnvironment(aParameter : String);
begin
  FConnectionStr := aParameter;

end;


procedure TSQLEnvironment.InitData;
begin

end;

procedure TSQLEnvironment.aMainConnection;
begin
  aMainConn.Close;
  aMainConn.ConnectionString:=FConnectionStr;
  //ȡ���û�������֤
  aMainConn.LoginPrompt:= False;
  aMainConn.Open; 
  if  not aMainConn.Connected then
  begin
    ShowMessage('�������ݿ�ʧ��');  
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
      showmessage('�쳣������:' + E.ClassName
        + #13#10 + '�쳣��Ϣ:' + E.Message + #13#10 +aSQL );
  end;    
end;


function TSQLEnvironment.GetPrimary(aTableName : String) : String;
begin
  Result := 'RecordID';
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
    TADOQuery(aMain).Open;
    ShowMessage('ִ�гɹ�:'+aSQL)
  except
    on E: Exception do
      showmessage('�쳣������:' + E.ClassName
        + #13#10 + '�쳣��Ϣ:' + E.Message);
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
    TADOQuery(aMain).Open;
    ShowMessage('ִ����乲'+ IntToStr(Len) + '��,'+'ִ��SQL�ɹ�!')
  except
    on E: Exception do
      showmessage('ִ����乲'+ IntToStr(Len) + '��,'+'ִ��SQLʧ��'
       + #13#10 + 
      '�쳣������:' + E.ClassName
        + #13#10 + '�쳣��Ϣ:' + E.Message);
  end;    
end;



end.
