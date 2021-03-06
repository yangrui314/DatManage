unit unitExcelHandle;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs,StdCtrls,ComObj,unitTable,formProgress,unitFileWay;

type
  TExcelHandle = class
  private
    Excel,Sheet:Variant;
    aInsertSQLs:  array of String;
    FSheetRow : Integer;
    FSheetColumn : Integer;
    FContainDelSQL : Boolean;
    FDelKeyField : String;
    FDelCondition : String;
    FSQLSavePath : String;
    FTable : TTable;
    function OpenExcel(AFileName : String): Variant;
    function LoadInsertSQL(RowNum : Integer): String;
    procedure ExecSQL;
  protected
  public
    destructor Destroy; override;
    constructor Create(aTable : TTable);Reintroduce;overload;
    function ReadFile(aFilePath : String;aContainDelSQL : Boolean;aDelKeyField : String;aSQLSavePath : String) : Boolean;Reintroduce;overload;        
  end;


implementation
  uses
    unitConfigHelper;


constructor TExcelHandle.Create(aTable : TTable);
begin
  FTable := aTable;
  FContainDelSQL := False;
  FDelKeyField :='';
  FDelCondition :='';  
end;

function TExcelHandle.ReadFile(aFilePath : String;aContainDelSQL : Boolean;aDelKeyField : String;aSQLSavePath : String) : Boolean;
var
  I : Integer;
  aProgress : TfmProgress;
begin
  Result := False;
  FContainDelSQL := aContainDelSQL;
  FDelKeyField := aDelKeyField;
  FSQLSavePath := aSQLSavePath;
  Excel := OpenExcel(aFilePath);
  Sheet:= Excel.Workbooks[1].WorkSheets[1];
  FSheetRow:= Sheet.Usedrange.Rows.count;
  FSheetColumn := Sheet.UsedRange.Columns.Count;
  SetLength(aInsertSQLs,FSheetRow-1);
  aProgress := TfmProgress.Create(nil);
  try
    aProgress.FProgressBar.SetMax(FSheetRow - 1);
    aProgress.FProgressBar.SetPosition(0);
    aProgress.Show;
    for I := 0 to FSheetRow-2 do
    begin
      if aProgress.FProgressBar.GetCancel then
      begin
        Exit;
      end;
      aInsertSQLs[I] := LoadInsertSQL(I + 2);
  //    ShowMessage(aInsertSQLs[I]);
      aProgress.FProgressBar.UpdateProcess;
    end;
    aProgress.FProgressBar.SetCaption('执行SQL...');
    ExecSQL;
    aProgress.FProgressBar.SetCaption('导入成功!');
  finally
    aProgress.Free;
  end;
end;





procedure TExcelHandle.ExecSQL;
var
  I : Integer;
  s : String;
  DelSQL : String;
begin
//  FTable.Config.ExecSQLs(aInsertSQLs);
  //FExcelName := AFileName;

  if FContainDelSQL and (FTable.TableName <> '') and (FDelKeyField <> '') then
  begin
    DelSQL := 'delete from ' + FTable.TableName +
    ' where '+ FDelKeyField + ' in (  ' + FDelCondition +' )' + ';';
  end;

  for I := 0 to FSheetRow-2 do
  begin
    if s = ''
    then s := s +  aInsertSQLs[I]
    else s := s + ';' + #13#10 + aInsertSQLs[I];
  end;


  ConfigHelper.SaveFile(FSQLSavePath,DelSQL + #13#10 + s);
  ShowMessage('导出'+FSQLSavePath+'成功');
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
    aFirst : Boolean;
  begin
    Result := '';
    aFirst := True;
    for I := 1 to FSheetColumn do
    begin
      aFieldName :=  Sheet.Cells[1,I].Value;
      TableFieldOrderID := FTable.GetOrderID(aFieldName);
      if TableFieldOrderID = -1 then Continue;

//      if (not FTable.TableFieldIsNullArray[TableFieldOrderID]) and (Sheet.Cells[RowNum ,I].Value = '') then
//      begin
//        Result := '';
//        Exit;;
//      end;


      if  aFirst
      then  aField :=  Sheet.Cells[1,I].Value
      else  aField := aField + ',' + aFieldName;


      if aFirst
      then aValue := ConfigHelper.GetStrByFieldType(Sheet.Cells[RowNum ,I].Value,FTable.TableFieldDataTypeArray[TableFieldOrderID])
      else aValue := aValue + ',' + ConfigHelper.GetStrByFieldType(Sheet.Cells[RowNum ,I].Value,FTable.TableFieldDataTypeArray[TableFieldOrderID]);


      //获取删除语句的条件。
      if aFieldName = FDelKeyField then
      begin
        if FDelCondition = ''
        then FDelCondition := ConfigHelper.GetStrByFieldType(Sheet.Cells[RowNum ,I].Value,FTable.TableFieldDataTypeArray[TableFieldOrderID])
        else FDelCondition := FDelCondition + ',' + ConfigHelper.GetStrByFieldType(Sheet.Cells[RowNum ,I].Value,FTable.TableFieldDataTypeArray[TableFieldOrderID]);
      end;
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
