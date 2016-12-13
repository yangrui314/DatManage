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
    procedure SetSQL(const aSQL : String; aShowError : Boolean = True);override;
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
  uses
    unitConfig,unitConfigHelper,unitFileHelper;



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
  I : Integer;
begin
  inherited;
  dMain.Directory := FParameter;
  dMain.DatabaseName := 'OmniDatabase' + IntToStr(Random(100));
  dMain.Open;

  for I:= 0  to  Config.Password.Count - 1 do
  begin
    dMain.Session.AddPassword(Config.Password[I]);
  end;
  TDBISAMQuery(aMain).DatabaseName := dMain.DatabaseName;

  dExecSQL.Directory := FParameter;
  dExecSQL.DatabaseName := 'OmniExecSQL' + IntToStr(Random(100));
  dExecSQL.Open;
  for I:= 0  to  Config.Password.Count - 1 do
  begin
    dExecSQL.Session.AddPassword(Config.Password[I]);
  end;
  aExecSQL.DatabaseName := dExecSQL.DatabaseName;
end;

procedure TDbisamEnvironment.SetSQL(const aSQL : String; aShowError : Boolean = True);
begin
  FLoadTable := True;
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
    begin
      FSQLSuccess := False;
      FileHelper.SaveLog(False,aSQL);
      FLoadTable := False;
      if aShowError then
      begin
        showmessage('异常类名称:' + E.ClassName
          + #13#10 + '异常信息:' + E.Message + #13#10 +aSQL );
      end
      else
      begin

      end;
      Exit;
    end;
  end;
  FSQLSuccess := True;
  FileHelper.SaveLog(FSQLSuccess,aSQL);
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



procedure TDbisamEnvironment.ExecSQLs(const aSQLs :  array of String);
var
  I : Integer;
  Len : Integer;
  aSQL : string;
begin
  aSQL := '';
  Len := Length(aSQLs);
  try
    aExecSQL.Close;
    aExecSQL.SQL.Clear;
    for I := 0 to Len -1 do
    begin
      if aSQLs[I] = '' then Continue;
      aExecSQL.SQL.Add(aSQLs[I]+';');
      if aSQL = '' then
      begin
        aSQL := aSQLs[I]+';'
      end
      else
      begin
        aSQL := aSQL +  #13#10 + aSQLs[I]+';'
      end;      
    end;
    aExecSQL.Prepare;
    aExecSQL.ExecSQL;

    ShowMessage('执行语句共'+ IntToStr(Len) + '条,'+'执行SQL成功!')
  except
    on E: Exception do
    begin
      FSQLSuccess :=False;
      FileHelper.SaveLog(FSQLSuccess,aSQL);
      showmessage('执行语句共'+ IntToStr(Len) + '条,'+'执行SQL失败'
       + #13#10 +
      '异常类名称:' + E.ClassName
        + #13#10 + '异常信息:' + E.Message);
      Exit;
    end
  end;
  FSQLSuccess := True;
  FileHelper.SaveLog(FSQLSuccess,aSQL);
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
  if SelectDirectory('请指定文件夹', '', DirectoryPath) then
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
