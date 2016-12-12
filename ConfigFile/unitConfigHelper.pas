{***************************************************
����ģ��:���ݲ�����,���洢����.
������Ա��yr
�������ڣ�2016-12-12 ����һ
�޸����ڣ�2016-12-12 ����һ
***************************************************}
unit unitConfigHelper;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs,StdCtrls,unitConfig,unitXmlWay,unitHandleFileWay,unitHistory;


type
  TConfigHelper = class
  private
    FHandleFileWay : THandleFileWay;
    FWayStrPath : string;
    procedure LoadFile;
    procedure SaveFile;
  protected
    procedure SaveSystemConfigToBoolean(aName : String;aValue : Boolean);
    function GetWayStr : String;
    procedure SaveWayStr;    
  public
    constructor Create; virtual;
    destructor Destroy; virtual;
    procedure SaveHistory(const aConnectWay : string;const aName : String;const aPath : String);overload;
    procedure SaveHistory(const aHistory : THistory);overload;
    procedure SaveHistory;overload;
    procedure ClearHistorys;
    procedure DelHistory(const aConnectWay : string;const aName : String;const aPath : String);overload;
    procedure DelHistory(const aHistory : THistory);overload;
    //������Ŀ¼�Ĳ���Ҫ���ļ� yr 2016-12-08
    procedure ClearRubbish;
    //ɾ��ָ��Ŀ¼ָ����׺���ļ� yr 2916-12-12
    procedure DelFiles(const aFilePath : String;const aExt : String);
    //�Ƿ����������� ���SQL��ѯ yr 2016-12-12
    function IsQuotation(const aFieldType : String) : Boolean;
    //��ȡSQL���� yr 2016-12-12
    function GetFieldType(aFieldName : String) : String;
    //��ȡsql yr 2016-12-12
    function GetSQL(aTable : String;aFieldName : String;aKeyword : String;
      aCondition : String;aSelSQL : String; aSQL : String): string;
    //ִ��SQL yr 2016-12-12
    procedure RunSQL(aSQL : String;var aMsg : String);
    //���� yr 2016-12-12
    procedure ImportTable;
    //���� yr 2016-12-12
    procedure ExportTable;
    //������� yr 2016-12-12
    procedure TableProperty;
  end;

var
  ConfigHelper: TConfigHelper;


implementation
  uses
    StrUtils,unitStrHelper,unitSystemHelper,cnDebug,unitFileHelper,unitTable,
    formImport,formExport,formTableProperty;



constructor TConfigHelper.Create;
begin
  FWayStrPath := ExtractFilePath(ParamStr(0)) + 'FileWay.ini';
  Config.FileWay := GetWayStr;
  FHandleFileWay := THandleFileWay.Create(Config.FileWay);
  LoadFile;
end;


procedure TConfigHelper.LoadFile;
var
  aHistorys : TList;
begin
  Config.LastFolderPath := FHandleFileWay.GetSystemConfig('LastFolderPath');
  Config.ShowName := (FHandleFileWay.GetSystemConfig('ShowName') = '1');
  Config.ShowPath := (FHandleFileWay.GetSystemConfig('ShowPath') = '1');
  Config.SelectShowWay := FHandleFileWay.GetSystemConfig('SelectShowWay');
  Config.ConnectWay := FHandleFileWay.GetSystemConfig('ConnectWay');
  aHistorys := FHandleFileWay.LoadHistorys;
  Config.Historys := aHistorys;
  Config.Password := FHandleFileWay.LoadPasswords;
  FHandleFileWay.LoadMenu;
end;

procedure TConfigHelper.SaveFile;
begin
  FHandleFileWay := THandleFileWay.Create(Config.FileWay);
  FHandleFileWay.SaveSystemConfig('LastFolderPath',Config.LastFolderPath);
  SaveSystemConfigToBoolean('ShowName',Config.ShowName);
  SaveSystemConfigToBoolean('ShowPath',Config.ShowPath);
  FHandleFileWay.SaveSystemConfig('SelectShowWay',Config.SelectShowWay);
  FHandleFileWay.SaveSystemConfig('ConnectWay',Config.ConnectWay);
  FHandleFileWay.SaveMenu;
end;

procedure TConfigHelper.SaveSystemConfigToBoolean(aName : String;aValue : Boolean);
begin
  if aValue then
  begin
    FHandleFileWay.SaveSystemConfig(aName,'1');
  end
  else
  begin
    FHandleFileWay.SaveSystemConfig(aName,'0');
  end;
end;

procedure TConfigHelper.SaveHistory(const aHistory : THistory);
begin
  FHandleFileWay.SaveHistory(aHistory);
end;

procedure TConfigHelper.SaveHistory(const aConnectWay : string;const aName : String;const aPath : String);
var
  aHistory : THistory;
begin
  aHistory := THistory.Create;
  try
    aHistory.ConnectWay :=aConnectWay;
    aHistory.Name :=  aName;
    aHistory.Path := aPath;
    SaveHistory(aHistory);
  finally
    aHistory.Free;
  end;
end;

procedure TConfigHelper.SaveHistory;
var
  I : Integer;
begin
  FHandleFileWay.ClearHistorys;
  for I := 0 to Config.Historys.Count - 1 do
  begin
    SaveHistory(THistory(Config.Historys[I]));
  end;
end;

procedure TConfigHelper.DelHistory(const aHistory : THistory);
begin
  FHandleFileWay.DelHistory(aHistory);    
end;

procedure TConfigHelper.DelHistory(const aConnectWay : string;const aName : String;const aPath : String);
var
  aHistory : THistory;
begin
  aHistory := THistory.Create;
  try
    aHistory.ConnectWay :=aConnectWay;
    aHistory.Name :=  aName;
    aHistory.Path := aPath;
    DelHistory(aHistory);
  finally
    aHistory.Free;
  end;    
end;


procedure TConfigHelper.ClearHistorys;
begin
  FHandleFileWay.ClearHistorys;
end;

function TConfigHelper.GetWayStr : String;
var
  aFile : Textfile;
begin
  Result := 'dat';
  if not FileExists(FWayStrPath) then
  begin
    Exit;
  end;
  AssignFile(aFile, FWayStrPath);
  try
    Reset(aFile);
    Read(aFile,Result);
  finally
    Closefile(aFile);
  end;
end;

procedure TConfigHelper.SaveWayStr;
var
  aFile: TextFile;
  aStr : String;
begin
  AssignFile(aFile,FWayStrPath);
  try
    Rewrite(aFile);
    Write(aFile, Config.FileWay);
  finally
    CloseFile(aFile);
  end;
end;


destructor TConfigHelper.Destroy; 
begin
  SaveFile;
  SaveWayStr;
  FHandleFileWay.Free;
end;

procedure TConfigHelper.DelFiles(const aFilePath : String;const aExt : String);
var
  TmpFiles :TStringList;
  TmpPath : String;
  TempExt : String;
  I : Integer;
begin
  TempExt := aExt;
  if LeftStr(TempExt,1) <> '.' then
    TempExt := '.' + TempExt;
    
  TmpFiles := FileHelper.GetFilesByPathAndExt(aFilePath,TempExt);
  for I := 0 to TmpFiles.Count - 1 do
  begin
    TmpPath := ExtractFileDir(ParamStr(0)) + '\' + TmpFiles[I] + TempExt;
    if FileExists(TmpPath) then
      DeleteFile(TmpPath);
  end;
end;


procedure TConfigHelper.ClearRubbish;
var
  aSoftPath : String;
begin
  aSoftPath := ExtractFileDir(ParamStr(0)) + '\';
  DelFiles(aSoftPath,'dat');
  DelFiles(aSoftPath,'idx');
  DelFiles(aSoftPath,'blb');
end;

function TConfigHelper.IsQuotation(const aFieldType : String) : Boolean;
begin
  Result := False;
  Result := ( aFieldType= 'integer') or (aFieldType = 'AutoInt')
  or (aFieldType = 'tinyint') or (aFieldType = 'smallint')
  or (aFieldType = 'bigint') or (aFieldType = 'money')
  or (aFieldType = 'smallmoney') or (aFieldType = 'float')
  or (aFieldType = 'bit') or (aFieldType = 'datatime') ;
end;

function TConfigHelper.GetFieldType(aFieldName : String) : String;
var
  I : Integer;
begin
  Result := '';
  for I := 0 to  Config.SystemTable.TableFieldCount - 1 do
  begin
    if (Config.SystemTable.TableFieldNameArray[I] = aFieldName) then
    begin
      Result := Config.SystemTable.TableFieldSQLTypeArray[I];
      Exit;
    end;
  end;
end;

function TConfigHelper.GetSQL(aTable : String;aFieldName : String;aKeyword : String;
      aCondition : String;aSelSQL : String; aSQL : String): string;
var
  aFieldType : string;
begin
  if Config.SystemActivePageIndex = 0 then
  begin
    if Config.SystemTableName = '' then Config.SystemTableName := aTable;
    if Config.SystemTableName = '' then
    begin
      Result := '';
      ShowMessage('������������');
      Exit;
    end
    else
    begin
      Result := Config.SystemEnvironment.GetBaseTableSQL(Config.SystemTableName);
      aFieldType := ConfigHelper.GetFieldType(aFieldName);
      if  (aFieldName <> '') and  (aKeyword <> '') and (aCondition <> '') then
      begin
        if aKeyword = '����' then
        begin
          if ConfigHelper.IsQuotation(aFieldType)   then
          begin
            ShowMessage('���ֶβ���ʹ��''����''��ѯ��');
            Result := '';
          end
          else
          begin
            Result := Result + ' where ' + Config.SystemTable.HandleSpecialStr(aFieldName) + ' like ' + '''%'+  aCondition + '%''';
          end;
        end
        else if aKeyword = '����' then
        begin
          if ConfigHelper.IsQuotation(aFieldType)   then
          begin
            Result := Result + ' where ' + Config.SystemTable.HandleSpecialStr(aFieldName)  + ' = ' +  aCondition ;
          end
          else
          begin
            Result := Result + ' where ' + Config.SystemTable.HandleSpecialStr(aFieldName)  + ' = ' + ''''+  aCondition + '''';
          end;
        end
        else if aKeyword = '������' then
        begin
          if ConfigHelper.IsQuotation(aFieldType) then
          begin
            Result := Result + ' where ' + Config.SystemTable.HandleSpecialStr(aFieldName)  + ' <> ' +  aCondition ;
          end
          else
          begin
            Result := Result + ' where ' + Config.SystemTable.HandleSpecialStr(aFieldName)  + ' <> ' + ''''+  aCondition + '''';          
          end;
        end;
      end;
      if  (aFieldName = '') and  (aKeyword = '') and (aCondition <> '') then
      begin
        Result := Result + ' where ' + aCondition;     
      end;
    end;
  end
  else
  begin
    Config.SystemTableName := '';
    if aSelSQL = '' then
      Result := aSQL
    else
      Result := aSelSQL;
  end;
end;


procedure TConfigHelper.RunSQL(aSQL : String;var aMsg : String);
var
  aHint : String;
begin
  Config.SystemTable := TTable.Create(Config.SystemEnvironment, aSQL, Config.SystemTableName);
  if  Config.SystemActivePageIndex = 0  then
  begin
    aHint := '��'+ Config.SystemTableName;
  end
  else
  begin
    if (Pos('update',aSQL) <> 0 ) then
    begin
      aHint := '����';
      aHint := aHint + Trim(StrHelper.GetMidStr(aSQL,'update','set'))
    end
    else if (Pos('delete',aSQL) <> 0) then
    begin
      aHint := 'ɾ��';
      if (Pos('where',aSQL) <> 0) then
      begin
        aHint := aHint + Trim(StrHelper.GetMidStr(aSQL,'from','where'))
      end
      else
      begin
        aHint := aHint + Trim(StrHelper.GetMidStr(aSQL,'from'))
      end;      
    end
    else if (Pos('insert',aSQL) <> 0) then
    begin
      aHint := '����';
      aHint := aHint + Trim(StrHelper.GetMidStr(aSQL,'into','('));
    end
    else
    begin
      aHint := '��ѯ';
      if (Pos('where',aSQL) <> 0) then
      begin
        aHint := aHint + Trim(StrHelper.GetMidStr(aSQL,'from','where'))
      end
      else
      begin
        aHint := aHint + Trim(StrHelper.GetMidStr(aSQL,'from'))
      end;       
    end;
  end;
  aMsg := aHint;
end;

procedure TConfigHelper.ImportTable;
var
  fmImport: TfmImport;
begin
  if not Config.GetTable then
  begin
    ShowMessage('δѡ���Ӧ���޷�����Excel��');
    Exit;
  end;

  fmImport := TfmImport.Create(nil, Config.SystemTable);
  try
    fmImport.ShowModal;
  finally
    fmImport.Free;
  end;
end;

procedure TConfigHelper.ExportTable;
var
  fmExport: TfmExport;
begin
  if not Config.GetTable  then
  begin
    ShowMessage('δѡ���Ӧ���޷�����Excel��');
    Exit;
  end;

  if not Config.SystemTable.ContainData then
  begin
    ShowMessage('�����ݣ��޷�������');
    Exit;  
  end;

  fmExport := TfmExport.Create(nil, Config.SystemTable);
  try
    fmExport.ShowModal;
  finally
    fmExport.Free;
  end;
end;

procedure TConfigHelper.TableProperty;
var
  fmTableProperty: TfmTableProperty;
begin
  if not Config.GetTable then
  begin
    ShowMessage('δѡ���Ӧ�������ԡ�');
    Exit;
  end;

  fmTableProperty := TfmTableProperty.Create(nil, Config.SystemTable);
  with fmTableProperty do
  try
    ShowModal;
  finally
    Free;
  end;
end;


initialization
  ConfigHelper := TConfigHelper.Create;

finalization
  ConfigHelper.Destroy;

end.
