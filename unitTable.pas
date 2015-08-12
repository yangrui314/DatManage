unit unitTable;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs,StdCtrls,unitConfig,DB, dbisamtb;

type
  TTable = class
  private
    FFieldCount : Integer;
    FField : TStringList;
    FValue : TStringList;
    FSQL : String;
    FConfig : TConfig;
    FData: TDBISAMQuery;
    FTableName : String;
    FFieldNameArray: array of String;
    FFieldSizeArray: array of Integer;
    FFieldDataTypeArray: array of TFieldType;
    FFieldIsNullArray: array of Boolean;
    FFieldSQLTypeArray: array of String;
    FFieldVisibleArray: array of Boolean;        
    procedure InitData;
    procedure SetFieldNameArray(index:Integer;Value: String);
    function GetFieldNameArray(index:Integer): String;
    procedure SetFieldSizeArray(index:Integer;Value: Integer);
    function GetFieldSizeArray(index:Integer): Integer;
    procedure SetFieldDataTypeArray(index:Integer;Value: TFieldType);
    function GetFieldDataTypeArray(index:Integer): TFieldType;
    procedure SetFieldIsNullArray(index:Integer;Value: Boolean);
    function GetFieldIsNullArray(index:Integer): Boolean;
    procedure SetFieldSQLTypeArray(index:Integer;Value: String);
    function GetFieldSQLTypeArray(index:Integer): String;
    procedure SetFieldVisibleArray(index:Integer;Value: Boolean);
    function GetFieldVisibleArray(index:Integer): Boolean;

    function GetSQLType(aFieldType : TFieldType) : String;
  protected
  public
    destructor Destroy;
    constructor Create(aConfig : TConfig ; aSQL : String);
    procedure Add(AOwner: TComponent);
    procedure SaveSQLFile(aFilePath : String);
    function ConvertString(aValue : Variant;aType :TFieldType):String;
    function GetOrderID(aName : String) : Integer;
    property TableField: TStringList read FField write FField;
    property TableValue: TStringList read FValue write FValue;
    property TableName: String read FTableName write FTableName;    
    property TableData : TDBISAMQuery read FData write FData;
    property TableFieldCount : Integer read  FFieldCount write FFieldCount;
    property TableFieldNameArray[Index:Integer]: String read GetFieldNameArray write SetFieldNameArray;
    property TableFieldSizeArray[Index:Integer]: Integer read GetFieldSizeArray write SetFieldSizeArray;
    property TableFieldDataTypeArray[Index:Integer]: TFieldType read GetFieldDataTypeArray write SetFieldDataTypeArray;
    property TableFieldIsNullArray[Index:Integer]: Boolean read GetFieldIsNullArray write SetFieldIsNullArray;
    property TableFieldSQLTypeArray[Index:Integer]: String read GetFieldSQLTypeArray write SetFieldSQLTypeArray;
    property TableFieldVisibleArray[Index:Integer]: Boolean read GetFieldVisibleArray write SetFieldVisibleArray;
    property Config  : TConfig  read  FConfig write FConfig;
  end;

implementation

uses
  formInsert,unitStandardHandle;

constructor TTable.Create(aConfig : TConfig ; aSQL : String);
begin
  aConfig.SetSQL(aSQL);
  FConfig := aConfig;
  FSQL := aSQL;
  FData := TDBISAMQuery.Create(nil);
  InitData;    
end;

function TTable.ConvertString(aValue : Variant;aType :TFieldType):String;
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
    Result := ' ''' + aValue + ''' ' ;
  end;    
end;


function TTable.GetSQLType(aFieldType : TFieldType): String;
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

procedure TTable.InitData;
var
  I : Integer;
begin
  FData := FConfig.MainData;
  FFieldCount := FConfig.MainData.Fields.Count;

  SetLength(FFieldNameArray,FFieldCount);
  SetLength(FFieldSizeArray,FFieldCount);
  SetLength(FFieldDataTypeArray,FFieldCount);
  SetLength(FFieldIsNullArray,FFieldCount);
  SetLength(FFieldSQLTypeArray,FFieldCount);
  SetLength(FFieldVisibleArray,FFieldCount);
  for I:=0 to  FFieldCount - 1 do
  begin
    FFieldNameArray[I] :=  FConfig.MainData.Fields.Fields[I].FieldName;
    FFieldSizeArray[I] :=  FConfig.MainData.Fields.Fields[I].Size;
    FFieldDataTypeArray[I] := FConfig.MainData.Fields.Fields[I].DataType;
    FFieldIsNullArray[I] := FConfig.MainData.Fields.Fields[I].IsNull;
    FFieldSQLTypeArray[I] := GetSQLType(FFieldDataTypeArray[I]);
    FFieldVisibleArray[I] := True;
  end;  
end;


function TTable.GetFieldNameArray(index:Integer): String;
begin  
    Result := FFieldNameArray[index];
end;

procedure TTable.SetFieldNameArray(index:Integer;Value: String);
begin
  FFieldNameArray[index] := Value;
end;

function TTable.GetFieldSizeArray(index:Integer): Integer;
begin
    Result := FFieldSizeArray[index];
end;

procedure TTable.SetFieldSizeArray(index:Integer;Value: Integer);
begin
  FFieldSizeArray[index] := Value;
end;


function TTable.GetFieldDataTypeArray(index:Integer): TFieldType;
begin
  Result := FFieldDataTypeArray[index];    
end;

procedure TTable.SetFieldDataTypeArray(index:Integer;Value: TFieldType);
begin
  FFieldDataTypeArray[index] := Value;
end;


function TTable.GetFieldIsNullArray(index:Integer): Boolean;
begin
  Result := FFieldIsNullArray[index];    
end;

procedure TTable.SetFieldIsNullArray(index:Integer;Value: Boolean);
begin
  FFieldIsNullArray[index] := Value;
end;

function TTable.GetFieldSQLTypeArray(index:Integer): String;
begin  
    Result := FFieldSQLTypeArray[index];
end;

procedure TTable.SetFieldSQLTypeArray(index:Integer;Value: String);
begin
  FFieldSQLTypeArray[index] := Value;
end;


function TTable.GetFieldVisibleArray(index:Integer): Boolean;
begin
  Result := FFieldVisibleArray[index];    
end;

procedure TTable.SetFieldVisibleArray(index:Integer;Value: Boolean);
begin
  FFieldVisibleArray[index] := Value;
end;

destructor TTable.Destroy;
begin
  SetLength(FFieldNameArray,0);
  SetLength(FFieldSizeArray,0);
  SetLength(FFieldDataTypeArray,0);
  SetLength(FFieldIsNullArray,0);
  SetLength(FFieldSQLTypeArray,0);
end;

procedure TTable.Add(AOwner: TComponent);
var
  fmInsert : TfmInsert;
begin
  fmInsert := TfmInsert.Create(AOwner,Self);
  with fmInsert do
  try
    ShowModal;
  finally
    Free;
  end;
end;


function TTable.GetOrderID(aName : String) : Integer;
var
  I : Integer;
begin
  Result := -1;
  for I:=0 to  FFieldCount - 1 do
  begin
    if aName = FFieldNameArray[I] then
    begin
      Result := I;
      Exit;
    end;  
  end;    
end;


procedure TTable.SaveSQLFile(aFilePath : String);
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
begin
  for I:=0 to  TableFieldCount - 1 do
  begin
    if not TableFieldVisibleArray[I] then Continue;
    aDataType := TableFieldDataTypeArray[I];

    if  (aDataType = ftAutoInc ) then Continue;

    if aFieldName = ''
    then aFieldName := aFieldName + TableFieldNameArray[I]
    else aFieldName := aFieldName + ',' + TableFieldNameArray[I];

  end;

  aPrefixSQL := 'INSERT INTO ' + TableName + ' (' +aFieldName + ' ) ';

  TableData.First;
  while not TableData.Eof do
  begin


    aPostfixSQL := ' VALUES ( ';
    aFirst := True;
    for i:=0 to  TableData.Fields.Count - 1 do
    begin
      if not TableFieldVisibleArray[I] then Continue;
      aFieldName := TableData.Fields.Fields[I].FieldName;
      aDataType := TableFieldDataTypeArray[I];

      if  (aDataType = ftAutoInc ) then Continue;


      if aDataType = ftString then
      begin
        aValue :=  ''''+ TableData.FieldByName(aFieldName).AsString + '''';
      end
      else if  (aDataType = ftInteger)  then
      begin
        aValue := IntToStr(TableData.FieldByName(aFieldName).AsInteger);
      end
      else if  aDataType = ftFloat  then
      begin
        aValue := FloatToStr(TableData.FieldByName(aFieldName).AsFloat);
      end
      else if  aDataType = ftBoolean      then
      begin
        if  TableData.FieldByName(aFieldName).AsBoolean
        then aValue := '1'
        else aValue := '0';
      end
      else if  aDataType = ftDateTime      then
      begin
        aValue :=  ' ''' +  FormatDateTime('yyyy-mm-dd', TableData.FieldByName(aFieldName).AsDateTime) + ''' ' ;;
      end
      else
      begin
        aValue :=  ''''+ TableData.FieldByName(aFieldName).AsString + '''';
      end;
      if aFirst
      then aPostfixSQL := aPostfixSQL + aValue
      else aPostfixSQL := aPostfixSQL + ','+ aValue ;
      aFirst := False;
    end;
    aPostfixSQL :=  aPostfixSQL + ')';

    if aSQL = ''
    then aSQL := aPrefixSQL + aPostfixSQL + ';'
    else aSQL := aSQL +#13#10  + aPrefixSQL + aPostfixSQL + ';' ;
    TableData.Next;
  end;
  TStandardHandle.SaveFile(aFilePath,aSQL);
  ShowMessage('����ɹ���');
end;


end.
