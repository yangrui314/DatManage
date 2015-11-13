unit formSelectAll;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, formParent, dxLayoutControl, cxContainer, cxEdit, cxTextEdit,
  cxControls, ExtCtrls, Menus, cxLookAndFeelPainters, StdCtrls, cxButtons,unitEnvironment,
  unitTable,DB, cxLookAndFeels, cxMemo;

type
  TfmSelectAll = class(TParentForm)
    pnlMain: TPanel;
    lcMainGroup_Root: TdxLayoutGroup;
    lcMain: TdxLayoutControl;
    edtSelectStr: TcxTextEdit;
    lcMainItem1: TdxLayoutItem;
    cbSelectAll: TcxButton;
    lcMainItem2: TdxLayoutItem;
    edtMessage: TcxMemo;
    lcMainItem3: TdxLayoutItem;
    procedure cbSelectAllClick(Sender: TObject);
  private
    FPath : string;
    FTableList : TStringList;
    FEnvironment: TEnvironment;
    FOwner : TComponent;    
    FTableField: TTable;
    FTableSQL : TTable;
    procedure InitData;
    procedure LoadTableName(const sPath: string);
    procedure AddTable(const aTableName: string);
    function GetResult : String;
    function SingleTableSelect(const aTableName : String) : String;
  public
    constructor Create(AOwner: TComponent;const aPath : String);
    destructor Destroy;     
  end;

var
  fmSelectAll: TfmSelectAll;

implementation


  uses
    StrUtils;

{$R *.dfm}

constructor TfmSelectAll.Create(AOwner: TComponent;const aPath : String);
begin
  inherited Create(AOwner);
  FPath := aPath;
  Height := 215;
  Width := 300;
  FTableList :=  TStringList.Create;
  FEnvironment := TEnvironment.Create(AOwner, FPath);
  FTableField := TTable.Create(FEnvironment, '', '');
  FTableSQL := TTable.Create(FEnvironment, '', '');
  InitData;
end;


procedure TfmSelectAll.InitData;
begin
  LoadTableName(FPath);
end;


procedure TfmSelectAll.LoadTableName(const sPath: string);
var
  SearchRec: TSearchRec;
  Found: Integer;
  NewName: string;
  TablePath: string;
begin

  if RightStr(sPath, 1) = '\' then
    TablePath := sPath
  else
    TablePath := sPath + '\';

  Found := FindFirst(TablePath + '*.*', faAnyFile, SearchRec);
  while Found = 0 do
  begin
    if (SearchRec.Name <> '.') and (SearchRec.Name <> '..') and (SearchRec.Attr <> faDirectory) and ((ExtractFileExt(SearchRec.Name) = '.dat')) then
    begin
      AddTable(ChangeFileExt(SearchRec.Name, ''));
    end;
    found := FindNext(SearchRec);
  end;
  FindClose(SearchRec);
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
begin
  Result := '';
  for I := 0 to FTableList.Count - 1 do
  begin
    aTableName := FTableList[I];
    if Result = '' then
    begin
      Result :=  SingleTableSelect(aTableName);
    end
    else
    begin
      aStr := SingleTableSelect(aTableName);
      if aStr <> '' then
      Result := Result  + #13#10 + SingleTableSelect(aTableName);
    end;

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
  FTableField := TTable.Create(FEnvironment, aSQL, aTableName);

  for I := 0 to   FTableField.TableFieldCount - 1 do
  begin
    if (FTableField.TableFieldDataTypeArray[I]  <> ftString) then Continue;
    aStr := FTableField.HandleSpecialStr(FTableField.TableFieldNameArray[I]);
    aSQL := 'select * from ' + aTableName + ' where ' + aStr + ' like '
           + ''''  + '%'  + edtSelectStr.EditValue + '%' + '''' ;
    FTableSQL := TTable.Create(FEnvironment, aSQL, aTableName);
    if FTableSQL.ContainData then
    begin
      if Result = '' then
      begin
        Result := '±í'+aTableName +':'+  FTableField.TableFieldNameArray[I] +';';
      end
      else
      begin
        Result := Result +#13#10 + '±í'+aTableName +':'+  FTableField.TableFieldNameArray[I] +';';
      end;
    end;

  end;
  except
  on E: Exception do
    Result := '';
  end;
end;

procedure TfmSelectAll.cbSelectAllClick(Sender: TObject);
var
  aMessage : string;
begin
  inherited;
  aMessage := GetResult;
  edtMessage.Text := aMessage;
end;


initialization
  RegisterClass(TfmSelectAll);

finalization
  UnregisterClass(TfmSelectAll);

end.
