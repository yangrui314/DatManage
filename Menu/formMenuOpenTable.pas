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
    procedure MenuHandle;override;
  end;

var
  fmMenuOpenTable: TfmMenuOpenTable;

implementation

{$R *.dfm}
procedure TfmMenuOpenTable.MenuHandle;
var
  aDatPath: string;
begin
  inherited;
  //打开表
  if (FActivePageIndex = 1) or (FTableName = '') then
  begin
    ShowMessage('未选择表或SQL查询模式。');
    Exit;
  end;
  if RightStr(FParameter, 1) = '\' then
    aDatPath := FParameter
  else
    aDatPath := FParameter + '\';
  aDatPath := aDatPath + FTableName + '.dat';
  ShellExecute(Handle, 'open', 'Explorer.exe', PChar(aDatPath), nil, 1);
end;

initialization
  RegisterClass(TfmMenuOpenTable);

finalization
  UnregisterClass(TfmMenuOpenTable);

end.
