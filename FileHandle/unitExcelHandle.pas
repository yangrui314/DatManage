unit unitExcelHandle;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs,StdCtrls,unitFileHandle,ComObj,unitTable;

type
  TExcelHandle = class(TFileHandle)
  private
    Excel,Sheet:Variant;
    aInsertSQLs:  array of String;
    FTestSQL : String;
    FTable : TTable;
    FSheetRow : Integer;
    FSheetColumn : Integer;    
    function OpenExcel(AFileName : String): Variant;
    procedure AddInsertSQL(RowNum : Integer);
    function LoadInsertSQL(RowNum : Integer): String;
    procedure ExecSQL;
  protected
    procedure LoadFile; override;
  public
    destructor Destroy; override;
    constructor Create(aFilePath : String;aTable : TTable);
    property TestSQL: String read FTestSQL write FTestSQL;    
  end;


implementation


constructor TExcelHandle.Create(aFilePath : String ;aTable : TTable);
begin
  FTable := aTable;
  inherited Create(aFilePath);
end;

procedure TExcelHandle.LoadFile;
var
  I : Integer;
begin
  inherited;
  Excel := OpenExcel(FFilePath);
  Sheet:= Excel.Workbooks[1].WorkSheets[1];
  FSheetRow:= Sheet.Usedrange.Rows.count;
  FSheetColumn := Sheet.UsedRange.Columns.Count;
  SetLength(aInsertSQLs,FSheetRow-1);
  for I := 0 to FSheetRow-2 do
  begin
    aInsertSQLs[I] := LoadInsertSQL(I + 2);
//    ShowMessage(aInsertSQLs[I]);
  end;
  ExecSQL;
end;

procedure TExcelHandle.ExecSQL;
var
  I : Integer;
begin
  for I := 0 to FSheetRow-2 do
  begin
    FTable.Config.ExecSQL(aInsertSQLs[I]);
  end;
end;


procedure TExcelHandle.AddInsertSQL(RowNum : Integer);
begin
//  TestSQL := LoadInsertSQL(RowNum);
//  aInsertSQLs.Add(LoadInsertSQL(RowNum));
end;


function TExcelHandle.OpenExcel(AFileName : String): Variant;
begin
  try
    Result:= CreateOleObject('Excel.Application');
    Result.visible:=false;
    Result.WorkBooks.Open(AFileName);
    Result.Workbooks[1].WorkSheets[1].Name := '导入';
  except
    Showmessage('初始化Excel失败，可能没装Excel，或者其他错误；请重起再试。');
    Result.DisplayAlerts := false;//是否提示存盘
    Result.Quit;//如果出错则退出
    exit;
  end;
end;

function TExcelHandle.LoadInsertSQL(RowNum : Integer): String;
  var
    Sql,SqlValue : String;
    aField :String;
    aValue : String;
    I : Integer;
    TableFieldOrderID : Integer;
    aFieldName : String;
  begin
    Result := '';
    for I := 1 to FSheetColumn do
    begin
      aFieldName :=  Sheet.Cells[1,I].Value;
      if  aField  = ''
      then  aField :=  Sheet.Cells[1,I].Value
      else  aField := aField + ',' + aFieldName;
      TableFieldOrderID := FTable.GetOrderID(aFieldName);

      if aValue = ''
      then aValue := Sheet.Cells[RowNum ,I].Value
      else aValue := aValue + ',' + FTable.ConvertString(Sheet.Cells[RowNum ,I].Value,FTable.TableFieldDataTypeArray[TableFieldOrderID]);
    end;
    Sql := ' INSERT INTO ' + FTable.TableName + ' (' +aField + ')';
    SqlValue := ' VALUES ( ' + aValue + ')';
    Result := Sql + ' ' + SqlValue;
  end;


destructor TExcelHandle.Destroy;
begin
  Excel.DisplayAlerts := false;
  Excel.Quit;
  inherited;
end;

end.
