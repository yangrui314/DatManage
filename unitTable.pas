unit unitTable;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs,StdCtrls,unitEnvironment,DB, dbisamtb;

type
  TTable = class
  private
    FContainData : Boolean;
    FFieldCount : Integer;
    FField : TStringList;
    FValue : TStringList;
    FSQL : String;
    FEnvironment : TEnvironment;
    FData: TDBISAMQuery;
    FTableName : String;
    FKeyField : String;
    FKeyValue : String;
    FFieldNameArray: array of String;
    FFieldSizeArray: array of Integer;
    FFieldDataTypeArray: array of TFieldType;
    FFieldIsNullArray: array of Boolean;
    FFieldSQLTypeArray: array of String;
    FFieldVisibleArray: array of Boolean;
    FFieldCaptionArray: array of String;
    FFieldMainArray: array of Boolean;                
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

    procedure SetFieldCaptionArray(index:Integer;Value: String);
    function GetFieldCaptionArray(index:Integer): String;

    procedure SetFieldMainArray(index:Integer;Value: Boolean);
    function GetFieldMainArray(index:Integer): Boolean;

    function GetSQLType(aFieldType : TFieldType) : String;
  protected
  public
    destructor Destroy;
    constructor Create(aEnvironment : TEnvironment ; aSQL : String;aTableName : String);
    procedure Add(AOwner: TComponent);
    procedure SaveSQLFile(aFilePath : String);

    procedure SaveTableEnvironment;
    procedure ReadTableEnvironment;

    function ConvertString(aValue : Variant;aType :TFieldType):String;
    function GetOrderID(aName : String) : Integer;
    function IsKeyNameAccordValue(aFieldName : String) : Boolean;
    function HandleSpecialStr(aFieldName : String) : String;
    function IsSpecial(aStr : String) : Boolean;
    procedure  SaveFile(aFilePath : String;aData : String);

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
    property TableFieldCaptionArray[Index:Integer]: String read GetFieldCaptionArray write SetFieldCaptionArray;
    property TableFieldMainArray[Index:Integer]: Boolean read GetFieldMainArray write SetFieldMainArray;

    property TableKeyField: String read FKeyField;
    property Environment  : TEnvironment  read  FEnvironment write FEnvironment;
    property ContainData : Boolean read  FContainData write FContainData;
  end;

implementation

uses
  formInsert,unitStandardHandle,unitXmlHandle;

constructor TTable.Create(aEnvironment : TEnvironment ; aSQL : String;aTableName : String);
begin
  aEnvironment.SetSQL(aSQL);
  FEnvironment := aEnvironment;
  FSQL := aSQL;
  FTableName := aTableName;
  FData := TDBISAMQuery.Create(nil);
  FContainData := FEnvironment.IsContainData;
  if  FTableName <> '' then 
  FKeyField := FEnvironment.GetPrimary(FTableName);
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
    Result := ' ''' + VarToStr(aValue) + ''' ' ;
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
  if not FContainData then
  begin
    Exit;
  end;


  FData := FEnvironment.MainData;
  FFieldCount := FEnvironment.MainData.Fields.Count;

  SetLength(FFieldNameArray,FFieldCount);
  SetLength(FFieldSizeArray,FFieldCount);
  SetLength(FFieldDataTypeArray,FFieldCount);
  SetLength(FFieldIsNullArray,FFieldCount);
  SetLength(FFieldSQLTypeArray,FFieldCount);
  SetLength(FFieldVisibleArray,FFieldCount);
  SetLength(FFieldCaptionArray,FFieldCount);
  SetLength(FFieldMainArray,FFieldCount);
  for I:=0 to  FFieldCount - 1 do
  begin
    FFieldNameArray[I] :=  FEnvironment.MainData.Fields.Fields[I].FieldName;
    FFieldSizeArray[I] :=  FEnvironment.MainData.Fields.Fields[I].Size;
    FFieldDataTypeArray[I] := FEnvironment.MainData.Fields.Fields[I].DataType;
    FFieldIsNullArray[I] := FEnvironment.MainData.Fields.Fields[I].IsNull;
    FFieldSQLTypeArray[I] := GetSQLType(FFieldDataTypeArray[I]);
    FFieldVisibleArray[I] := True;
    FFieldCaptionArray[I] := '';
    FFieldMainArray[I] := IsKeyNameAccordValue(FFieldNameArray[I]);
  end;
  ReadTableEnvironment;
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


function TTable.GetFieldMainArray(index:Integer): Boolean;
begin
  Result := FFieldMainArray[index];    
end;

procedure TTable.SetFieldMainArray(index:Integer;Value: Boolean);
begin
  FFieldMainArray[index] := Value;
end;

function TTable.GetFieldCaptionArray(index:Integer): String;
begin  
    Result := FFieldCaptionArray[index];
end;

procedure TTable.SetFieldCaptionArray(index:Integer;Value: String);
begin
  FFieldCaptionArray[index] := Value;
end;

destructor TTable.Destroy;
begin
  SetLength(FFieldNameArray,0);
  SetLength(FFieldSizeArray,0);
  SetLength(FFieldDataTypeArray,0);
  SetLength(FFieldIsNullArray,0);
  SetLength(FFieldSQLTypeArray,0);
  SetLength(FFieldVisibleArray,0);
  SetLength(FFieldCaptionArray,0);
  SetLength(FFieldMainArray,0);  
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

function TTable.IsKeyNameAccordValue(aFieldName : String) : Boolean;
begin
  Result := False;
  if Pos(';',FKeyField) <> 0 then
  begin
    Result := (Pos(aFieldName,FKeyField) <> 0);
  end
  else
  begin
    if FKeyField =  'RecordID' then
    begin
      Result := (aFieldName ='RecordID_1');
    end
    else
    begin
      Result := (aFieldName = FKeyField)
    end;
  end;
end;


function TTable.HandleSpecialStr(aFieldName : String) : String;
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


function TTable.IsSpecial(aStr : String) : Boolean;
begin
  Result := False;
  Result := (aStr = 'Sign');
end;

procedure TTable.SaveTableEnvironment;
var
  aConfig : TXmlHandle;
  aFilePath : String;
begin
  if TableName = '' then
  begin
    Exit;
  end;
  aConfig := TXmlHandle.Create(Self);
  try
    aFilePath := ExtractFileDir(ParamStr(0)) + '\Template\' + TableName + '.xml';
    aConfig.SaveFile(aFilePath);
  finally
    aConfig.Free;
  end;
end;

procedure TTable.ReadTableEnvironment;
var
  aConfig : TXmlHandle;
  aFilePath : String;  
begin
  if TableName = '' then
  begin
    Exit;
  end;

  aConfig := TXmlHandle.Create(Self);
  try
    aFilePath := ExtractFileDir(ParamStr(0)) + '\Template\' + TableName + '.xml';
    aConfig.ReadFile(aFilePath);
  finally
    aConfig.Free;
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
      else if  (aDataType = ftInteger) or (aDataType = ftSmallint)  then
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
  SaveFile(aFilePath,aSQL);
end;

procedure  TTable.SaveFile(aFilePath : String;aData : String);
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


end.
