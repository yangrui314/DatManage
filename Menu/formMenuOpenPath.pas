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
    procedure MenuHandle(aParameter : String;aActivePageIndex : Integer;aTable : String);override;
  end;

var
  fmMenuOpenPath: TfmMenuOpenPath;

implementation

{$R *.dfm}

procedure TfmMenuOpenPath.MenuHandle(aParameter : String;aActivePageIndex : Integer;aTable : String);
var
  aDatPath: string;
begin
  inherited;
  if (aActivePageIndex = 1) or (aTable = '') then
  begin
    //打开目录
    ShellExecute(Handle, 'open', 'Explorer.exe', PChar(aParameter), nil, 1);
  end
  else
  begin
    //打开目录并定位。
    if RightStr(aParameter, 1) = '\' then
      aDatPath := aParameter
    else
      aDatPath := aParameter + '\';
    aDatPath := aDatPath + aTable + '.dat';
    ShellExecute(0, nil, PChar('explorer.exe'), PChar('/e, ' + '/select,' + aDatPath), nil, SW_NORMAL);
  end;
end;

initialization
  RegisterClass(TfmMenuOpenPath);

finalization
  UnregisterClass(TfmMenuOpenPath);
end.
