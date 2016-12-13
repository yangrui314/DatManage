{***************************************************
功能模块:数据操作类,不存储数据.
开发人员：yr
开发日期：2016-12-12 星期一
修改日期：2016-12-12 星期一
***************************************************}
unit unitConfigHelper;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs,StdCtrls,unitConfig,unitXmlWay,unitDatWay,unitFileWay,unitHistory,
  formParentMenu, Forms,DB, dbisamtb,unitTable;


type
  TConfigHelper = class(TObject)
  private
    FWayStrPath : string;
    procedure LoadFile;
    procedure SaveFile;overload;
  protected
    FFileWay : TFileWay;  
    procedure SaveSystemConfigToBoolean(aName : String;aValue : Boolean);
    function GetWayStr : String;
    procedure SaveWayStr;    
  public
    constructor Create;
    destructor Destroy; override;
    procedure SaveHistory(const aConnectWay : string;const aName : String;const aPath : String);overload;
    procedure SaveHistory(const aHistory : THistory);overload;
    procedure SaveHistory;overload;
    procedure ClearHistorys;
    procedure DelHistory(const aConnectWay : string;const aName : String;const aPath : String);overload;
    procedure DelHistory(const aHistory : THistory);overload;
    //清除软件目录的不需要的文件 yr 2016-12-08
    procedure ClearRubbish;
    //删除指定目录指定后缀的文件 yr 2916-12-12
    procedure DelFiles(const aFilePath : String;const aExt : String);
    //是否是特殊类型 针对SQL查询 yr 2016-12-12
    function IsQuotation(const aFieldType : String) : Boolean;
    //获取SQL类型 yr 2016-12-12
    function GetFieldType(aFieldName : String) : String;
    //获取sql yr 2016-12-12
    function GetSQL(aTable : String;aFieldName : String;aKeyword : String;
      aCondition : String;aSelSQL : String; aSQL : String): string;
    //执行SQL yr 2016-12-12
    procedure RunSQL(aSQL : String;var aMsg : String);
    //导入 yr 2016-12-12
    procedure ImportTable;
    //导出 yr 2016-12-12
    procedure ExportTable;
    //表格属性 yr 2016-12-12
    procedure TableProperty;
    function GetHistoryName(aPath: string; aInclude: Boolean = False): string;
    function GetHistoryPath(aName: string; aInclude: Boolean = False): string;
    function GetMenuCaption(const aClassName: string): string;

    function HandleSpecialStr(aFieldName : String) : String;
    function IsSpecial(aStr : String) : Boolean;
    function IsKeyNameAccordValue(aFieldName : String;aKeyField : String) : Boolean;    
    function ConvertString(aValue : Variant;aType :TFieldType):String;

    procedure SaveTableEnvironment(var aTable : TTable);
    procedure ReadTableEnvironment(var aTable : TTable);

    function GetSQLType(aFieldType : TFieldType) : String;
    procedure Add(AOwner: TComponent;var aTable : TTable);
    procedure  SaveFile(aFilePath : String;aData : String);overload;
    function GetOrderID(aName : String;var aTable : TTable) : Integer;
    procedure SaveSQLFile(aFilePath : String;aContainDelSQL : Boolean;
            aDelKeyField : String;var aTable : TTable);
    procedure SaveLog(const aIsSuccess : Boolean;const aSQL : String;const aMessage: String = '');
    class function CreateInstance(var AForm: TfmParentMenu; AFormClassName: string = ''): TfmParentMenu; overload;
  end;

var
  ConfigHelper: TConfigHelper;


implementation
  uses
    StrUtils,unitStrHelper,cnDebug,unitFileHelper,
    formImport,formExport,formTableProperty,formInsert,unitStandardHandle;



constructor TConfigHelper.Create;
begin
  inherited;
  FWayStrPath := ExtractFilePath(ParamStr(0)) + 'FileWay.ini';
  Config.FileWay := GetWayStr;
  if Config.FileWay = 'xml' then
  begin
    FFileWay := TXmlWay.Create;
  end
  else
  begin
    FFileWay := TDatWay.Create;
  end;
  LoadFile;
end;

class function TConfigHelper.CreateInstance(var AForm: TfmParentMenu; AFormClassName: string = ''): TfmParentMenu;
var
  FormClassName: string;
  FormClass: TPersistentClass;
begin
  FormClass := nil;

  if Trim(AFormClassName) <> '' then
    FormClass := GetClass(AFormClassName);

  if (FormClass = nil) and (FormClassName <> ClassName) then
    FormClass := FindClass(ClassName);

  if FormClass = nil then
    FormClass := TfmParentMenu;

  if FormClass <> nil then
  begin
    Application.CreateForm(TComponentClass(FormClass), AForm);
    Result := TfmParentMenu(AForm);
  end
  else
    Result := nil;
end;

procedure TConfigHelper.LoadFile;
var
  aHistorys : TList;
begin
  Config.LastFolderPath := FFileWay.GetSystemConfig('LastFolderPath');
  Config.ShowName := (FFileWay.GetSystemConfig('ShowName') = '1');
  Config.ShowPath := (FFileWay.GetSystemConfig('ShowPath') = '1');
  Config.SelectShowWay := FFileWay.GetSystemConfig('SelectShowWay');
  Config.ConnectWay := FFileWay.GetSystemConfig('ConnectWay');
  aHistorys := FFileWay.LoadHistorys;
  Config.Historys := aHistorys;
  Config.Password := FFileWay.LoadPasswords;
  FFileWay.LoadMenu;
end;

procedure TConfigHelper.SaveFile;
begin
  if Config.FileWay = 'xml' then
  begin
    FFileWay := TXmlWay.Create;
  end
  else
  begin
    FFileWay := TDatWay.Create;
  end;
  FFileWay.SaveSystemConfig('LastFolderPath',Config.LastFolderPath);
  SaveSystemConfigToBoolean('ShowName',Config.ShowName);
  SaveSystemConfigToBoolean('ShowPath',Config.ShowPath);
  FFileWay.SaveSystemConfig('SelectShowWay',Config.SelectShowWay);
  FFileWay.SaveSystemConfig('ConnectWay',Config.ConnectWay);
  FFileWay.SaveMenu;
end;

procedure TConfigHelper.SaveSystemConfigToBoolean(aName : String;aValue : Boolean);
begin
  if aValue then
  begin
    FFileWay.SaveSystemConfig(aName,'1');
  end
  else
  begin
    FFileWay.SaveSystemConfig(aName,'0');
  end;
end;

procedure TConfigHelper.SaveHistory(const aHistory : THistory);
begin
  FFileWay.SaveHistory(aHistory);
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
  FFileWay.ClearHistorys;
  for I := 0 to Config.Historys.Count - 1 do
  begin
    SaveHistory(THistory(Config.Historys[I]));
  end;
end;

procedure TConfigHelper.DelHistory(const aHistory : THistory);
begin
  FFileWay.DelHistory(aHistory);    
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
  FFileWay.ClearHistorys;
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
  FFileWay.Free;
  inherited;
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
      ShowMessage('请输入表格名称');
      Exit;
    end
    else
    begin
      Result := Config.SystemEnvironment.GetBaseTableSQL(Config.SystemTableName);
      aFieldType := ConfigHelper.GetFieldType(aFieldName);
      if  (aFieldName <> '') and  (aKeyword <> '') and (aCondition <> '') then
      begin
        if aKeyword = '包含' then
        begin
          if ConfigHelper.IsQuotation(aFieldType)   then
          begin
            ShowMessage('该字段不能使用''包含''查询。');
            Result := '';
          end
          else
          begin
            Result := Result + ' where ' + HandleSpecialStr(aFieldName) + ' like ' + '''%'+  aCondition + '%''';
          end;
        end
        else if aKeyword = '等于' then
        begin
          if ConfigHelper.IsQuotation(aFieldType)   then
          begin
            Result := Result + ' where ' + HandleSpecialStr(aFieldName)  + ' = ' +  aCondition ;
          end
          else
          begin
            Result := Result + ' where ' + HandleSpecialStr(aFieldName)  + ' = ' + ''''+  aCondition + '''';
          end;
        end
        else if aKeyword = '不等于' then
        begin
          if ConfigHelper.IsQuotation(aFieldType) then
          begin
            Result := Result + ' where ' + HandleSpecialStr(aFieldName)  + ' <> ' +  aCondition ;
          end
          else
          begin
            Result := Result + ' where ' + HandleSpecialStr(aFieldName)  + ' <> ' + ''''+  aCondition + '''';          
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
    aHint := '打开'+ Config.SystemTableName;
  end
  else
  begin
    if (Pos('update',aSQL) <> 0 ) then
    begin
      aHint := '更新';
      aHint := aHint + Trim(StrHelper.GetMidStr(aSQL,'update','set'))
    end
    else if (Pos('delete',aSQL) <> 0) then
    begin
      aHint := '删除';
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
      aHint := '插入';
      aHint := aHint + Trim(StrHelper.GetMidStr(aSQL,'into','('));
    end
    else
    begin
      aHint := '查询';
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
    ShowMessage('未选择对应表。无法导入Excel。');
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
    ShowMessage('未选择对应表。无法导入Excel。');
    Exit;
  end;

  if not Config.SystemTable.ContainData then
  begin
    ShowMessage('无数据，无法导出。');
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
    ShowMessage('未选择对应表。无属性。');
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

function TConfigHelper.GetHistoryName(aPath: string; aInclude: Boolean = False): string;
var
  I: Integer;
begin
  Result := '';
//  if aPath = FLastFolderPath then
//  begin
//    Result := '最后一条记录';
//    Exit;
//  end;
  for I := 0 to Config.Historys.Count - 1 do
  begin
    if aInclude then
    begin
      if Pos(aPath, THistory(Config.Historys.Items[I]).Path) <> 0 then
      begin
        Result := THistory(Config.Historys.Items[I]).Name;
        Exit;
      end
    end
    else
    begin
      if THistory(Config.Historys.Items[I]).Path = aPath then
      begin
        Result := THistory(Config.Historys.Items[I]).Name;
        Exit;
      end
    end;
  end;
end;

function TConfigHelper.GetHistoryPath(aName: string; aInclude: Boolean = False): string;
var
  I: Integer;
begin
  Result := '';
//  if aName = '最后一条记录' then
//  begin
//    Result := FLastFolderPath;
//    Exit;
//  end;
  for I := 0 to Config.Historys.Count - 1 do
  begin
    if aInclude then
    begin
      if Pos(aName, THistory(Config.Historys.Items[I]).Name) <> 0 then
      begin
        Result := THistory(Config.Historys.Items[I]).Path;
        Exit;
      end
    end
    else
    begin
      if THistory(Config.Historys.Items[I]).Name = aName then
      begin
        Result := THistory(Config.Historys.Items[I]).Path;
        Exit;
      end
    end;

  end;
end;

function TConfigHelper.GetMenuCaption(const aClassName: string): string;
var
  I: Integer;
begin
  Result := '';
  for I := 0 to Length(Config.FMenuList) - 1 do
  begin
    if Config.FMenuList[I].ClassName = aClassName then
    begin
      Result := Config.FMenuList[I].Caption;
      Exit;
    end
  end;
end;


function TConfigHelper.HandleSpecialStr(aFieldName : String) : String;
begin
  if IsSpecial(aFieldName) then
  begin
    Result :=   '['+ aFieldName + ']';
  end
  else
  begin
    Result :=  aFieldName;
  end;
end;


function TConfigHelper.IsSpecial(aStr : String) : Boolean;
begin
  Result := False;
  Result := (aStr = 'Sign');
end;

function TConfigHelper.IsKeyNameAccordValue(aFieldName : String;aKeyField : String) : Boolean;
begin
  Result := False;
  if Pos(';',aKeyField) <> 0 then
  begin
    Result := (Pos(aFieldName,aKeyField) <> 0);
  end
  else
  begin
    if aKeyField =  'RecordID' then
    begin
      Result := (aFieldName ='RecordID_1');
    end
    else
    begin
      Result := (aFieldName = aKeyField)
    end;
  end;
end;


function TConfigHelper.ConvertString(aValue : Variant;aType :TFieldType):String;
begin
  if aType = ftInteger then
  begin
    Result := IntToStr(aValue) ;
  end
  else if aType = ftFloat  then
  begin
    Result := FloatToStr(aValue);
  end
  else if aType = ftBoolean  then
  begin
    if aValue
    then  Result := '1'
    else  Result := '0' ;
  end
  else if aType = ftDateTime  then
  begin
    Result :=  ' ''' +  FormatDateTime('yyyy-mm-dd', aValue) + ''' ' ;
  end
  else
  begin
    Result := ' ''' + VarToStr(aValue) + ''' ' ;
  end;    
end;


procedure TConfigHelper.SaveTableEnvironment(var aTable : TTable);
var
  aConfig : TXmlWay;
  aFilePath : String;
begin
  if aTable.TableName = '' then
  begin
    Exit;
  end;
  aConfig := TXmlWay.Create;
  try
    aFilePath := ExtractFileDir(ParamStr(0)) + '\Template\' + aTable.TableName + '.xml';
    aConfig.SaveFile(aFilePath,aTable);
  finally
    aConfig.Free;
  end;
end;

procedure TConfigHelper.ReadTableEnvironment(var aTable : TTable);
var
  aConfig : TXmlWay;
  aFilePath : String;  
begin
  if aTable.TableName  = '' then
  begin
    Exit;
  end;

  aConfig := TXmlWay.Create;
  try
    aFilePath := ExtractFileDir(ParamStr(0)) + '\Template\' + aTable.TableName  + '.xml';
    aConfig.ReadFile(aFilePath,aTable);
  finally
    aConfig.Free;
  end;
end;


function TConfigHelper.GetSQLType(aFieldType : TFieldType): String;
begin
  if aFieldType = ftAutoInc then
  begin
    Result := 'AutoInt';
  end
  else if aFieldType = ftInteger then
  begin
    Result := 'integer';
  end
  else if aFieldType = ftWord then
  begin
    Result := 'tinyint';
  end
  else if aFieldType = ftSmallint then
  begin
    Result := 'smallint';
  end
  else if aFieldType = ftLargeint then
  begin
    Result := 'bigint';
  end
  else if aFieldType = ftBCD then
  begin
    Result := 'money';
  end
  else if aFieldType = ftBCD then
  begin
    Result := 'smallmoney';
  end
  else if aFieldType = ftBCD then
  begin
    Result := 'decimal';
  end
  else if aFieldType = ftBCD then
  begin
    Result := 'numeric';
  end
  else if aFieldType = ftFloat then
  begin
    Result := 'real';
  end
  else if aFieldType = ftFloat then
  begin
    Result := 'float';
  end
  else if aFieldType = ftBoolean then
  begin
    Result := 'bit';
  end
  else if aFieldType = ftDateTime then
  begin
    Result := 'datetime';
  end
  else if aFieldType = ftDateTime then
  begin
    Result := 'smalldatetime';
  end
  else if aFieldType = ftString then
  begin
    Result := 'String';
  end
  else if aFieldType = ftWideString then
  begin
    Result := 'String';
  end
  else if aFieldType = ftMemo then
  begin
    Result := 'text';
  end
  else if aFieldType = ftBlob then
  begin
    Result := 'image';
  end
  else if aFieldType = ftBytes then
  begin
    Result := 'binnary';
  end
  else if aFieldType = ftVarBytes then
  begin
    Result := 'varbinary';
  end
  else if aFieldType = ftVariant then
  begin
    Result := 'sql_variant';
  end
  else if aFieldType = ftGuid then
  begin
    Result := 'uniqueidentifier';
  end
  else if aFieldType = ftBytes then
  begin
    Result := 'timestamp';
  end;
end;


procedure TConfigHelper.Add(AOwner: TComponent;var aTable : TTable);
var
  fmInsert : TfmInsert;
begin
  fmInsert := TfmInsert.Create(AOwner,aTable);
  with fmInsert do
  try
    ShowModal;
  finally
    Free;
  end;
end;


procedure  TConfigHelper.SaveFile(aFilePath : String;aData : String);
var
  aFile : TStandardHandle;
begin
  aFile := TStandardHandle.Create;
  try
    aFile.SaveFile(aFilePath,aData);
  finally
    aFile.Free;
  end;

end;

function TConfigHelper.GetOrderID(aName : String;var aTable : TTable ) : Integer;
var
  I : Integer;
begin
  Result := -1;
  for I:=0 to  aTable.TableFieldCount - 1 do
  begin
    if aName = aTable.TableFieldNameArray[I] then
    begin
      Result := I;
      Exit;
    end;  
  end;    
end;


procedure TConfigHelper.SaveSQLFile(aFilePath : String;aContainDelSQL : Boolean;
    aDelKeyField : String;var aTable : TTable);
var
  aSQL : String;
  aPrefixSQL : String;
  aPostfixSQL : String;
  aType : TFieldType;
  aValue : String;
  aFieldName : String;
  I : Integer;
  aDataType : TFieldType;
  aFirst : Boolean;
  aDelCondition : String;
  DelSQL : String;
begin
  for I:=0 to  aTable.TableFieldCount - 1 do
  begin
    if not aTable.TableFieldVisibleArray[I] then Continue;
    aDataType := aTable.TableFieldDataTypeArray[I];

    if  (aDataType = ftAutoInc ) then Continue;

    if aFieldName = ''
    then aFieldName := aFieldName + ConfigHelper.HandleSpecialStr(aTable.TableFieldNameArray[I])
    else aFieldName := aFieldName + ',' + ConfigHelper.HandleSpecialStr(aTable.TableFieldNameArray[I]);

  end;

  aPrefixSQL := 'INSERT INTO ' + aTable.TableName + ' (' +aFieldName + ' ) ';

  aTable.TableData.First;
  while not aTable.TableData.Eof do
  begin

    aPostfixSQL := ' VALUES ( ';
    aFirst := True;
    for i:=0 to aTable.TableData.Fields.Count - 1 do
    begin
      if not aTable.TableFieldVisibleArray[I] then Continue;
      aFieldName := aTable.TableData.Fields.Fields[I].FieldName;
      aDataType := aTable.TableFieldDataTypeArray[I];

      if  (aDataType = ftAutoInc ) then Continue;


      if aDataType = ftString then
      begin
        aValue :=  ''''+ aTable.TableData.FieldByName(aFieldName).AsString + '''';
      end
      else if  (aDataType = ftInteger) or (aDataType = ftSmallint)  then
      begin
        aValue := IntToStr(aTable.TableData.FieldByName(aFieldName).AsInteger);
      end
      else if  aDataType = ftFloat  then
      begin
        aValue := FloatToStr(aTable.TableData.FieldByName(aFieldName).AsFloat);
      end
      else if  aDataType = ftBoolean      then
      begin
        if  aTable.TableData.FieldByName(aFieldName).AsBoolean
        then aValue := '1'
        else aValue := '0';
      end
      else if  aDataType = ftDateTime  then
      begin
        aValue :=  ' ''' +  FormatDateTime('yyyy-mm-dd', aTable.TableData.FieldByName(aFieldName).AsDateTime) + ''' ' ;;
      end
      else if aDataType = ftLargeint then
      begin
        if  aTable.TableData.FieldByName(aFieldName).AsString = ''
        then aValue := 'null'
        else aValue := IntToStr(aTable.TableData.FieldByName(aFieldName).AsInteger);
      end
      else
      begin
        aValue :=  ''''+ aTable.TableData.FieldByName(aFieldName).AsString + '''';
      end;
      if aFirst
      then aPostfixSQL := aPostfixSQL + aValue
      else aPostfixSQL := aPostfixSQL + ','+ aValue ;
      aFirst := False;
      if aDelKeyField =aFieldName then
        aDelCondition := aValue;
    end;
    aPostfixSQL :=  aPostfixSQL + ')';

    if aContainDelSQL and (aTable.TableName <> '') and (aDelKeyField <> '') then
    begin
      DelSQL := 'Delete from ' + aTable.TableName +
      ' where '+ aDelKeyField + ' = ' + aDelCondition +' ' + ';';
    end;

    if aSQL = ''
    then aSQL := DelSQL + #13#10+ aPrefixSQL + aPostfixSQL + ';'
    else aSQL := aSQL +#13#10  + DelSQL + #13#10 + aPrefixSQL + aPostfixSQL + ';' ;
    aTable.TableData.Next;
  end;
  SaveFile(aFilePath,aSQL);
end;


procedure TConfigHelper.SaveLog(const aIsSuccess : Boolean;const aSQL : String;const aMessage: String = '');
var
  aLogFile : TStandardHandle;
  aLogStr : string;
  aNewLog : string;
  FLogPath : String;
  aDirPath : String;

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
  aDirPath := ExtractFilePath(ParamStr(0)) + 'log\';
  if not DirectoryExists(aDirPath) then
  begin
    CreateDir(aDirPath);
  end;
  FLogPath := aDirPath + FormatDateTime('yyyymmdd', Now) +  '.txt';
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


initialization
  Config := TConfig.Create;
  ConfigHelper := TConfigHelper.Create;

finalization
  ConfigHelper.Free;
  Config.Free;


end.
