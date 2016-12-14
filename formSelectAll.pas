unit formSelectAll;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, formParent, dxLayoutControl, cxContainer, cxEdit, cxTextEdit,
  cxControls, ExtCtrls, Menus, cxLookAndFeelPainters, StdCtrls, cxButtons,unitEnvironment,
  unitTable,DB, cxLookAndFeels, cxMemo,unitConfig,unitSQLEnvironment,unitDbisamEnvironment,formParentMenu,
  cxRadioGroup;

type
  TfmSelectAll = class(TfmParentMenu)
    pnlMain: TPanel;
    lcMainGroup_Root: TdxLayoutGroup;
    lcMain: TdxLayoutControl;
    edtSelectStr: TcxTextEdit;
    lcMainItem1: TdxLayoutItem;
    cbSelectAll: TcxButton;
    lcMainItem2: TdxLayoutItem;
    edtMessage: TcxMemo;
    lcMainItem3: TdxLayoutItem;
    rbData: TcxRadioButton;
    lcMainItem4: TdxLayoutItem;
    lcMainItem5: TdxLayoutItem;
    rbField: TcxRadioButton;
    lcMainGroup2: TdxLayoutGroup;
    procedure cbSelectAllClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FPath : string;
    FTableList : TStringList;
    FEnvironment: TEnvironment;
    FTableField: TTable;
    FTableSQL : TTable;
    procedure InitData;
    procedure LoadTableName;
    procedure AddTable(const aTableName: string);
    function GetResult : String;
    function SingleTable(const aTableName : String) : String;
    function SingleTableSelect(const aTableName : String) : String;
    function SingleTableSelectField(const aTableName : String) : String;
  public
    destructor Destroy;override;
  end;

var
  fmSelectAll: TfmSelectAll;

implementation
  uses
    StrUtils,formProgress,unitConfigHelper;

{$R *.dfm}



procedure TfmSelectAll.InitData;
begin
  LoadTableName;
end;


procedure TfmSelectAll.LoadTableName;
var
  aTables : TStringList;
  I : Integer;
begin
  if (FEnvironment = nil) or (FPath = '') then Exit;
  aTables := FEnvironment.LoadTableName('');
  try
    for I := 0 to aTables.Count - 1 do
    begin
      AddTable(aTables[I]);
    end;
  finally
    aTables.Free;
  end;
end;



procedure TfmSelectAll.AddTable(const aTableName: string);
begin
  FTableList.Add(aTableName);
end;


destructor TfmSelectAll.Destroy;
begin
  FTableSQL.Free;
  FTableField.Free;
  FEnvironment.Free;
  FTableList.Free;
end;


function TfmSelectAll.GetResult : String;
var
  I : Integer;
  aTableName : String;
  aStr : string;
  aProgress : TfmProgress;
begin
  Result := '';
  aProgress := TfmProgress.Create(Self);
  try
    aProgress.FProgressBar.SetCaption('正在加载数据...');
    aProgress.FProgressBar.SetPosition(0);
    aProgress.FProgressBar.SetMax(FTableList.Count);
    aProgress.Show;    
    for I := 0 to FTableList.Count - 1 do
    begin
      if aProgress.FProgressBar.GetCancel then Exit;

      aProgress.FProgressBar.SetCaption('正在查询表'+FTableList[I]+','+ IntToStr(I)+ '/'+IntToStr(FTableList.Count));
      aProgress.FProgressBar.SetPosition(I);
      aProgress.FProgressBar.UpdateProcess;
      aTableName := FTableList[I];
      if Result = '' then
      begin
        Result :=  SingleTable(aTableName);
      end
      else
      begin
        aStr := SingleTable(aTableName);
        if aStr <> '' then
        Result := Result  + #13#10 + aStr;
      end;
    end;
  finally
    aProgress.Free;
  end;

end;

function TfmSelectAll.SingleTable(const aTableName : String) : String;
begin
  Result := '';
  if rbData.Checked then
  begin
    Result := SingleTableSelect(aTableName);
  end
  else
  begin
    Result := SingleTableSelectField(aTableName);  
  end;
end;


function TfmSelectAll.SingleTableSelect(const aTableName : String) : String;
var
  I : Integer;
  aSQL : string;
  aStr : string;
begin
  Result := '';
  try
  aSQL := 'select * from ' + aTableName;
  FTableField := TTable.Create(FEnvironment, aSQL, aTableName,False);

  if not FTableField.Environment.GetLoadTable then
  begin
    Result :='表'+aTableName +':'+  '打开失败' +';';
  end;

  for I := 0 to   FTableField.TableFieldCount - 1 do
  begin
    if (FTableField.TableFieldDataTypeArray[I]  <> ftString) then Continue;
    aStr := ConfigHelper.CheckFieldBracket(FTableField.TableFieldNameArray[I]);
    aSQL := 'select * from ' + aTableName + ' where ' + aStr + ' like '
           + ''''  + '%'  + edtSelectStr.EditValue + '%' + '''' ;
    FTableSQL := TTable.Create(FEnvironment, aSQL, aTableName,False);
    if FTableSQL.ContainData then
    begin
      if Result = '' then
      begin
        Result := '表'+aTableName +':'+  FTableField.TableFieldNameArray[I] +';';
      end
      else
      begin
        Result := Result +#13#10 + '表'+aTableName +':'+  FTableField.TableFieldNameArray[I] +';';
      end;
    end;

  end;
  except
  on E: Exception do
    Result :='表'+aTableName +':'+  '打开失败' +';';
  end;
end;


function TfmSelectAll.SingleTableSelectField(const aTableName : String) : String;
var
  I : Integer;
  aSQL : string;
begin
  Result := '';
  try
  aSQL := 'select * from ' + aTableName;
  FTableField := TTable.Create(FEnvironment, aSQL, aTableName,False);

  if not FTableField.Environment.GetLoadTable then
  begin
    Result :='表'+aTableName +':'+  '打开失败' +';';
  end;

  for I := 0 to   FTableField.TableFieldCount - 1 do
  begin
    if ( Pos(edtSelectStr.EditValue,FTableField.TableFieldNameArray[I]) <> 0 ) then
    begin
      if Result = '' then
      begin
        Result := '表'+aTableName +':'+  FTableField.TableFieldNameArray[I] +';';
      end
      else
      begin
        Result := Result +#13#10 + '表'+aTableName +':'+  FTableField.TableFieldNameArray[I] +';';
      end;
    end;
  end;
  except
  on E: Exception do
    Result :='表'+aTableName +':'+  '打开失败' +';';
  end;
end;


procedure TfmSelectAll.cbSelectAllClick(Sender: TObject);
var
  aMessage : string;
begin
  inherited;
  aMessage := GetResult;
  if aMessage <> '' then
  begin
    edtMessage.Text := aMessage;  
  end
  else
  begin
    edtMessage.Text := '<没找到对应数据>';    
  end;
end;


procedure TfmSelectAll.FormCreate(Sender: TObject);
begin
  inherited;
  FPath := Config.SystemParameter;
  Height := 265;
  Width := 300;
  FTableList :=  TStringList.Create;
  if Config.ConnectWay = '1' then
  begin
    FEnvironment := TDbisamEnvironment.Create(Self, FPath);
  end
  else
  begin
    FEnvironment := TSQLEnvironment.Create(Self, FPath);
  end;
  FTableField := TTable.Create(FEnvironment, '', '');
  FTableSQL := TTable.Create(FEnvironment, '', '');
  InitData;
end;

initialization
  RegisterClass(TfmSelectAll);

finalization
  UnregisterClass(TfmSelectAll);

end.
