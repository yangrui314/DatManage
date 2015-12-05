unit formMenuOpenTable;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, formParentMenu, cxLookAndFeels,ShellAPI,StrUtils;

type
  TfmMenuOpenTable = class(TfmParentMenu)
  private
    { Private declarations }
  public
    procedure MenuHandle(aParameter : String;aActivePageIndex : Integer;aTable : String);override;
  end;

var
  fmMenuOpenTable: TfmMenuOpenTable;

implementation

{$R *.dfm}
procedure TfmMenuOpenTable.MenuHandle(aParameter : String;aActivePageIndex : Integer;aTable : String);
var
  aDatPath: string;
begin
  inherited;
  //打开表
  if (aActivePageIndex = 1) or (aTable = '') then
  begin
    ShowMessage('未选择表或SQL查询模式。');
    Exit;
  end;
  if RightStr(aParameter, 1) = '\' then
    aDatPath := aParameter
  else
    aDatPath := aParameter + '\';
  aDatPath := aDatPath + aTable + '.dat';
  ShellExecute(Handle, 'open', 'Explorer.exe', PChar(aDatPath), nil, 1);
end;

initialization
  RegisterClass(TfmMenuOpenTable);

finalization
  UnregisterClass(TfmMenuOpenTable);

end.
