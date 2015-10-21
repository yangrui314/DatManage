unit formDiff;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, formParent, dxLayoutControl, cxControls, ExtCtrls, cxGraphics,
  Menus, cxLookAndFeelPainters, StdCtrls, cxButtons, cxContainer, cxEdit,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, DB, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGrid;

type
  TfmDiff = class(TParentForm)
    pnlMain: TPanel;
    lcMainGroup_Root: TdxLayoutGroup;
    lcMain: TdxLayoutControl;
    lcMainItem1: TdxLayoutItem;
    edtScrPath: TcxComboBox;
    lcMainItem2: TdxLayoutItem;
    edtDiffPath: TcxComboBox;
    cbDiff: TcxButton;
    lcMainItem3: TdxLayoutItem;
    lcMainItem4: TdxLayoutItem;
    edtTable: TcxComboBox;
    lcMainGroup1: TdxLayoutGroup;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    cxGrid1: TcxGrid;
    lcMainItem5: TdxLayoutItem;
    cxGrid2DBTableView1: TcxGridDBTableView;
    cxGrid2Level1: TcxGridLevel;
    cxGrid2: TcxGrid;
    lcMainItem6: TdxLayoutItem;
    lcMainGroup2: TdxLayoutGroup;
  private
    procedure LoadTableName(const sPath: string);
    procedure AddTable(const aTableName: string);    
  public
    { Public declarations }
  end;

var
  fmDiff: TfmDiff;

implementation

  uses
    StrUtils;

{$R *.dfm}

procedure TfmDiff.LoadTableName(const sPath: string);
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


procedure TfmDiff.AddTable(const aTableName: string);
begin
  edtTable.Properties.Items.Add(aTableName);
end;

end.
