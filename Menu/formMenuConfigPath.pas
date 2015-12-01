unit formMenuConfigPath;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, formParentMenu, cxLookAndFeels,ShellAPI;

type
  TfmMenuConfigPath = class(TfmParentMenu)
  private

  public
    procedure MenuHandle(aParameter : String;aActivePageIndex : Integer;aTable : String);override;
  end;

var
  fmMenuConfigPath: TfmMenuConfigPath;

implementation

{$R *.dfm}

procedure TfmMenuConfigPath.MenuHandle(aParameter : String;aActivePageIndex : Integer;aTable : String);
begin
  ShellExecute(Handle, 'open', 'Explorer.exe', PChar(ExtractFileDir(ParamStr(0)) + '\Config'), nil, 1);
end;

initialization
  RegisterClass(TfmMenuConfigPath);

finalization
  UnregisterClass(TfmMenuConfigPath);

end.
