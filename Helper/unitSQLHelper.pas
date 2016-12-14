{***************************************************
����ģ��:SQL����ز���,���漰��Config�Ĳ������漰��Config��
�������ŵ�ConfigHelper�С�
������Ա��yr
�������ڣ�2016-12-14 ������
�޸����ڣ�2016-12-14 ������
***************************************************}
unit unitSQLHelper;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs,StdCtrls,unitParentHelper,StrUtils,DB, dbisamtb,unitTable;
type
  TSQLHelper = class
  private
    //�ֶ��Ƿ���Ҫ���������� yr 2016-12-14
    function IsAddBracket(aFieldName : String) : Boolean;
  protected
  public
    constructor Create;
    //����Ҫ���ŵ��������� yr 2016-12-14
    function NotQuotationMark(const aFieldType : String) : Boolean;
    //������Ҫ���������ŵ��ֶ� yr 2016-12-14
    function CheckFieldBracket(aFieldName : String) : String;
    //�Ƿ������� yr 2016-12-14
    function IsKeyField(aAllKey : String;aFieldName : String) : Boolean;
    //�����������ͷ���ֵ yr 2016-12-14
    function GetStrByFieldType(aValue : Variant;aType :TFieldType):String;
    //��������תΪ�ַ��� yr 2016-12-14
    function GetSQLType(aFieldType : TFieldType) : String;
    //SQL���ת��Ϊ������ʾ yr 2016-12-14
    function GetMsgBySQL(aSQL : String) : String;
    //ͨ�����������õ�SQL��������� yr 2016-12-14
    function GetConditionSQL(aFieldName : String;aFieldType :String;aKeyword : String;
  aCondition : String) : String;  
  end;

var
  SQLHelper: TSQLHelper;

implementation
  uses
    unitStrHelper;


constructor TSQLHelper.Create;
begin

end;

function TSQLHelper.NotQuotationMark(const aFieldType : String) : Boolean;
begin
  Result := ( aFieldType= 'integer') or (aFieldType = 'AutoInt')
  or (aFieldType = 'tinyint') or (aFieldType = 'smallint')
  or (aFieldType = 'bigint') or (aFieldType = 'money')
  or (aFieldType = 'smallmoney') or (aFieldType = 'float')
  or (aFieldType = 'bit') or (aFieldType = 'datatime') ;
end;




function TSQLHelper.CheckFieldBracket(aFieldName : String) : String;
begin
  if IsAddBracket(aFieldName) then
  begin
    Result :=   '['+ aFieldName + ']';
  end
  else
  begin
    Result :=  aFieldName;
  end;
end;


function TSQLHelper.IsAddBracket(aFieldName : String) : Boolean;
begin
  Result := (aFieldName = 'Sign');
end;

function TSQLHelper.IsKeyField(aAllKey : String;aFieldName : String) : Boolean;
begin
  if Pos(';',aAllKey) <> 0 then
  begin
    Result := (Pos(aFieldName,aAllKey) <> 0);
  end
  else
  begin
    if aAllKey =  'RecordID' then
    begin
      Result := (aFieldName ='RecordID_1');
    end
    else
    begin
      Result := (aFieldName = aAllKey)
    end;
  end;
end;


function TSQLHelper.GetStrByFieldType(aValue : Variant;aType :TFieldType):String;
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





function TSQLHelper.GetMsgBySQL(aSQL : String) : String;
begin
  Result := '';
  if (Pos('update',aSQL) <> 0 ) then
  begin
    Result := '����';
    Result := Result + Trim(StrHelper.GetMidStr(aSQL,'update','set'))
  end
  else if (Pos('delete',aSQL) <> 0) then
  begin
    Result := 'ɾ��';
    if (Pos('where',aSQL) <> 0) then
    begin
      Result := Result + Trim(StrHelper.GetMidStr(aSQL,'from','where'))
    end
    else
    begin
      Result := Result + Trim(StrHelper.GetMidStr(aSQL,'from'))
    end;
  end
  else if (Pos('insert',aSQL) <> 0) then
  begin
    Result := '����';
    Result := Result + Trim(StrHelper.GetMidStr(aSQL,'into','('));
  end
  else
  begin
    Result := '��ѯ';
    if (Pos('where',aSQL) <> 0) then
    begin
      Result := Result + Trim(StrHelper.GetMidStr(aSQL,'from','where'))
    end
    else
    begin
      Result := Result + Trim(StrHelper.GetMidStr(aSQL,'from'))
    end;
  end;
end;


function TSQLHelper.GetConditionSQL(aFieldName : String;aFieldType :String;aKeyword : String;
  aCondition : String) : String;
begin
  Result := '';
  if  (aFieldName <> '') and  (aKeyword <> '') and (aCondition <> '') then
  begin
    if aKeyword = '����' then
    begin
      if NotQuotationMark(aFieldType) then
      begin
        //ShowMessage('���ֶβ���ʹ��''����''��ѯ��');
        Exit;
      end
      else
      begin
        Result := ' where ' + CheckFieldBracket(aFieldName) + ' like ' + '''%'+  aCondition + '%''';
      end;
    end
    else if aKeyword = '����' then
    begin
      if NotQuotationMark(aFieldType)   then
      begin
        Result := ' where ' + CheckFieldBracket(aFieldName)  + ' = ' +  aCondition ;
      end
      else
      begin
        Result := ' where ' + CheckFieldBracket(aFieldName)  + ' = ' + ''''+  aCondition + '''';
      end;
    end
    else if aKeyword = '������' then
    begin
      if NotQuotationMark(aFieldType) then
      begin
        Result :=  ' where ' + CheckFieldBracket(aFieldName)  + ' <> ' +  aCondition ;
      end
      else
      begin
        Result :=  ' where ' + CheckFieldBracket(aFieldName)  + ' <> ' + ''''+  aCondition + '''';
      end;
    end;
  end;

  if  (aFieldName = '') and  (aKeyword = '') and (aCondition <> '') then
  begin
    if (Pos('where',aCondition) <> 0) then
      Result := aCondition
    else
      Result := ' where ' + aCondition;
  end;  
end;


end.
 