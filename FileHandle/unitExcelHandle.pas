unit unitExcelHandle;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs,StdCtrls,unitTableHandle,ComObj,unitTable,unitStandardHandle;

type
  TExcelHandle = class(TTableHandle)
  private
    Excel,Sheet:Variant;
    aInsertSQLs:  array of String;
    FSheetRow : Integer;
    FSheetColumn : Integer;    
    function OpenExcel(AFileName : String): Variant;
    procedure AddInsertSQL(RowNum : Integer);
    function LoadInsertSQL(RowNum : Integer): String;
    procedure ExecSQL;
  protected
  public
    destructor Destroy; override;
    constructor Create(aTable : TTable);override;
    function ReadFile(aFilePath : String) : Boolean; override;        
  end;


implementation


constructor TExcelHandle.Create(aTable : TTable);
begin
  inherited;
end;

function TExcelHandle.ReadFile(aFilePath : String) : Boolean;
var
  I : Integer;
begin
  Excel := OpenExcel(aFilePath);
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
  s : String;
begin
//  FTable.Config.ExecSQLs(aInsertSQLs);

  for I := 0 to FSheetRow-2 do
  begin
    if s = ''
    then s := s +  aInsertSQLs[I]
    else s := s + ';' + #13#10 + aInsertSQLs[I];
  end;
  FTable.SaveFile(ExtractFileDir(ParamStr(0)) + '\xls.sql',s);
  ShowMessage('����'+ExtractFileDir(ParamStr(0)) + '\xls.sql'+'�ɹ�');
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
    Result.Workbooks[1].WorkSheets[1].Name := '����';
  except
    Showmessage('��ʼ��Excelʧ�ܣ�����ûװExcel�����������������������ԡ�');
    Result.DisplayAlerts := false;//�Ƿ���ʾ����
    Result.Quit;//����������˳�
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
    aFirst : Boolean;
  begin
    Result := '';
    aFirst := True;
    for I := 1 to FSheetColumn do
    begin
      aFieldName :=  Sheet.Cells[1,I].Value;
      TableFieldOrderID := FTable.GetOrderID(aFieldName);
      if TableFieldOrderID = -1 then Continue;

      if (not FTable.TableFieldIsNullArray[TableFieldOrderID]) and (Sheet.Cells[RowNum ,I].Value = '') then
      begin
        Result := '';
        Exit;;
      end;


      if  aFirst
      then  aField :=  Sheet.Cells[1,I].Value
      else  aField := aField + ',' + aFieldName;


      if aFirst
      then aValue := FTable.ConvertString(Sheet.Cells[RowNum ,I].Value,FTable.TableFieldDataTypeArray[TableFieldOrderID])
      else aValue := aValue + ',' + FTable.ConvertString(Sheet.Cells[RowNum ,I].Value,FTable.TableFieldDataTypeArray[TableFieldOrderID]);

      aFirst := False;
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
