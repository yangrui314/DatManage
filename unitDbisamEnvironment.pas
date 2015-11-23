unit unitDbisamEnvironment;


interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs,StdCtrls,DB, dbisamtb,unitEnvironment,StrUtils,FileCtrl;

type
  TDbisamEnvironment = class(TEnvironment)
  private
    dMain: TDBISAMDatabase;
    aExecSQL : TDBISAMQuery;
    dExecSQL: TDBISAMDatabase;
  protected
    procedure InitData;override;
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
    function GetBaseTableSQL(aTableName : String) : string;override;    
  end;

implementation



constructor TDbisamEnvironment.Create(AOwner: TComponent;aParameter : String);
begin
  aMain := TDBISAMQuery.Create(AOwner);
  dMain := TDBISAMDatabase.Create(AOwner);
  aExecSQL := TDBISAMQuery.Create(AOwner);
  dExecSQL := TDBISAMDatabase.Create(AOwner);
  inherited Create(AOwner,aParameter);
end;

procedure TDbisamEnvironment.SetEnvironment(aParameter : String);
begin
  inherited;
  dMain.Close;
  dMain.Directory := FParameter;
  dMain.Open;

  dExecSQL.Close;
  dExecSQL.Directory := FParameter;
  dExecSQL.Open;
end;

procedure TDbisamEnvironment.InitData;
var
  Test : String;
begin
  inherited;
  dMain.Directory := FParameter;
  dMain.DatabaseName := 'OmniDatabase' + IntToStr(Random(100));
  dMain.Open;
  dMain.Session.AddPassword('YouAreNotPrepared');
  dMain.Session.AddPassword('YouAreNotPrepared');
  dMain.Session.AddPassword('YouAreNotPreparedForIT');
  TDBISAMQuery(aMain).DatabaseName := dMain.DatabaseName;




  dExecSQL.Directory := FParameter;
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
    TDBISAMQuery(aMain).DatabaseName := dMain.DatabaseName;    
    TDBISAMQuery(aMain).SQL.Clear;
    TDBISAMQuery(aMain).SQL.Add(aSQL);
    TDBISAMQuery(aMain).Prepare;
    TDBISAMQuery(aMain).ExecSQL;
    FContainData := not aMain.IsEmpty;
  except
    on E: Exception do
      showmessage('�쳣������:' + E.ClassName
        + #13#10 + '�쳣��Ϣ:' + E.Message + #13#10 +aSQL );
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
    ShowMessage('ִ�гɹ�:'+aSQL)
  except
    on E: Exception do
      showmessage('�쳣������:' + E.ClassName
        + #13#10 + '�쳣��Ϣ:' + E.Message);
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

    ShowMessage('ִ����乲'+ IntToStr(Len) + '��,'+'ִ��SQL�ɹ�!')
  except
    on E: Exception do
      showmessage('ִ����乲'+ IntToStr(Len) + '��,'+'ִ��SQLʧ��'
       + #13#10 + 
      '�쳣������:' + E.ClassName
        + #13#10 + '�쳣��Ϣ:' + E.Message);
  end;    
end;


function TDbisamEnvironment.LoadTableName(aFilter : String = '') : TStringList;
var
  SearchRec: TSearchRec;
  Found: Integer;
  TablePath : string;
begin
  Result := TStringList.Create;

  if RightStr(FParameter, 1) = '\' then
    TablePath := FParameter
  else
    TablePath := FParameter + '\';

  Found := FindFirst(TablePath + '*.*', faAnyFile, SearchRec);
  try
    while Found = 0 do
    begin
      if ((Pos(UpperCase(aFilter),UpperCase(SearchRec.Name)) <> 0) or (aFilter = '')) and
        (SearchRec.Name <> '.') and (SearchRec.Name <> '..') and (SearchRec.Attr <> faDirectory) and ((ExtractFileExt(SearchRec.Name) = '.dat')) then
      begin
        Result.Add(ChangeFileExt(SearchRec.Name, ''));
      end;
      found := FindNext(SearchRec);
    end;  
  finally
    FindClose(SearchRec);  
  end;
end;


function TDbisamEnvironment.CreateParameter : string;
var
  DirectoryPath: string;
begin
  Result := '';
  if SelectDirectory('��ָ���ļ���', '', DirectoryPath) then
  begin
    if RightStr(DirectoryPath, 1) = '\' then
      Result := DirectoryPath
    else
      Result := DirectoryPath + '\';
  end;
end;

function TDbisamEnvironment.GetBaseTableSQL(aTableName : String) : string;
begin
  Result := 'select RecordID,* from '  + aTableName;
end;

end.