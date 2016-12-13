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
  formParentMenu, Forms;


type
  TConfigHelper = class
  private
    FWayStrPath : string;
    procedure LoadFile;
    procedure SaveFile;
  protected
    FFileWay : TFileWay;  
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
    class function CreateInstance(var AForm: TfmParentMenu; AFormClassName: string = ''): TfmParentMenu; overload;
  end;

var
  ConfigHelper: TConfigHelper;


implementation
  uses
    StrUtils,unitStrHelper,cnDebug,unitFileHelper,unitTable,
    formImport,formExport,formTableProperty;



constructor TConfigHelper.Create;
begin
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

initialization
  Config := TConfig.Create;
  ConfigHelper := TConfigHelper.Create;

finalization
  Config.Free;
  ConfigHelper.Free;

end.
