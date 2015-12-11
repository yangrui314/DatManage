unit formMenuOpenPath;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, formParentMenu, cxLookAndFeels,ShellAPI,StrUtils;

type
  TfmMenuOpenPath = class(TfmParentMenu)
  private
    { Private declarations }
  public
    procedure MenuHandle;override;
  end;

var
  fmMenuOpenPath: TfmMenuOpenPath;

implementation

{$R *.dfm}

procedure TfmMenuOpenPath.MenuHandle;
var
  aDatPath: string;
begin
  inherited;
  if (FActivePageIndex = 1) or (FTableName = '') then
  begin
    //打开目录
    ShellExecute(Handle, 'open', 'Explorer.exe', PChar(FParameter), nil, 1);
  end
  else
  begin
    //打开目录并定位。
    if RightStr(FParameter, 1) = '\' then
      aDatPath := FParameter
    else
      aDatPath := FParameter + '\';
    aDatPath := aDatPath + FTableName + '.dat';
    ShellExecute(0, nil, PChar('explorer.exe'), PChar('/e, ' + '/select,' + aDatPath), nil, SW_NORMAL);
  end;
end;

initialization
  RegisterClass(TfmMenuOpenPath);

finalization
  UnregisterClass(TfmMenuOpenPath);
end.
