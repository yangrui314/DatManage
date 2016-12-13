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
    FData: TDataSet;
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

  protected
  public
    destructor Destroy;
    constructor Create(aEnvironment : TEnvironment ; aSQL : String;aTableName : String;aShowError : Boolean = True);


    property TableField: TStringList read FField write FField;
    property TableValue: TStringList read FValue write FValue;
    property TableName: String read FTableName write FTableName;    
    property TableData : TDataSet read FData write FData;
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
  formInsert,unitXmlWay,unitConfigHelper,unitSQLHelper;

constructor TTable.Create(aEnvironment : TEnvironment ; aSQL : String;aTableName : String;aShowError : Boolean = True);
begin
  aEnvironment.SetSQL(aSQL,aShowError);
  FEnvironment := aEnvironment;
  FSQL := aSQL;
  FTableName := aTableName;
  FData := TDataSet.Create(nil);
  FContainData := FEnvironment.IsContainData;
  if  (FTableName <> '') and FEnvironment.GetLoadTable  then
  FKeyField := FEnvironment.GetPrimary(FTableName);
  InitData;    
end;



procedure TTable.InitData;
var
  I : Integer;
begin
//  if not FContainData then
//  begin
//    Exit;
//  end;


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
    FFieldSQLTypeArray[I] := SQLHelper.GetSQLType(FFieldDataTypeArray[I]);
    FFieldVisibleArray[I] := True;
    FFieldCaptionArray[I] := '';
    FFieldMainArray[I] := SQLHelper.IsKeyNameAccordValue(FFieldNameArray[I],FKeyField);
  end;
  ConfigHelper.ReadTableEnvironment(Self);
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







end.
