unit unitSQLHelper;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs,StdCtrls,unitParentHelper,StrUtils,DB, dbisamtb,unitTable;
type
  TSQLHelper = class
  private
  protected
  public
    constructor Create;
    //是否是特殊类型 针对SQL查询 yr 2016-12-12
    function IsQuotation(const aFieldType : String) : Boolean;
    //获取SQL类型 yr 2016-12-12
    function GetFieldType(aFieldName : String) : String;
    //获取sql yr 2016-12-12
    function GetSQL(aTable : String;aFieldName : String;aKeyword : String;
      aCondition : String;aSelSQL : String; aSQL : String): string;
    //执行SQL yr 2016-12-12
    procedure RunSQL(aSQL : String;var aMsg : String);
    function HandleSpecialStr(aFieldName : String) : String;
    function IsSpecial(aStr : String) : Boolean;
    function IsKeyNameAccordValue(aFieldName : String;aKeyField : String) : Boolean;
    function ConvertString(aValue : Variant;aType :TFieldType):String;
    function GetSQLType(aFieldType : TFieldType) : String;
    function GetOrderID(aName : String;var aTable : TTable) : Integer;
    procedure SaveSQLFile(aFilePath : String;aContainDelSQL : Boolean;
            aDelKeyField : String;var aTable : TTable);            
  end;

var
  SQLHelper: TSQLHelper;

implementation
  uses
    unitConfig,unitStrHelper,unitFileHelper;


constructor TSQLHelper.Create;
begin

end;

function TSQLHelper.IsQuotation(const aFieldType : String) : Boolean;
begin
  Result := False;
  Result := ( aFieldType= 'integer') or (aFieldType = 'AutoInt')
  or (aFieldType = 'tinyint') or (aFieldType = 'smallint')
  or (aFieldType = 'bigint') or (aFieldType = 'money')
  or (aFieldType = 'smallmoney') or (aFieldType = 'float')
  or (aFieldType = 'bit') or (aFieldType = 'datatime') ;
end;

function TSQLHelper.GetFieldType(aFieldName : String) : String;
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

function TSQLHelper.GetSQL(aTable : String;aFieldName : String;aKeyword : String;
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
      aFieldType := GetFieldType(aFieldName);
      if  (aFieldName <> '') and  (aKeyword <> '') and (aCondition <> '') then
      begin
        if aKeyword = '包含' then
        begin
          if IsQuotation(aFieldType)   then
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
          if IsQuotation(aFieldType)   then
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
          if IsQuotation(aFieldType) then
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


procedure TSQLHelper.RunSQL(aSQL : String;var aMsg : String);
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

function TSQLHelper.HandleSpecialStr(aFieldName : String) : String;
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


function TSQLHelper.IsSpecial(aStr : String) : Boolean;
begin
  Result := False;
  Result := (aStr = 'Sign');
end;

function TSQLHelper.IsKeyNameAccordValue(aFieldName : String;aKeyField : String) : Boolean;
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


function TSQLHelper.ConvertString(aValue : Variant;aType :TFieldType):String;
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

function TSQLHelper.GetSQLType(aFieldType : TFieldType): String;
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

function TSQLHelper.GetOrderID(aName : String;var aTable : TTable ) : Integer;
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


procedure TSQLHelper.SaveSQLFile(aFilePath : String;aContainDelSQL : Boolean;
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
    then aFieldName := aFieldName + HandleSpecialStr(aTable.TableFieldNameArray[I])
    else aFieldName := aFieldName + ',' + HandleSpecialStr(aTable.TableFieldNameArray[I]);

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
  FileHelper.SaveFile(aFilePath,aSQL);
end;



end.
 