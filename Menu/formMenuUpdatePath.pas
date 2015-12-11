unit formMenuUpdatePath;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, formParentMenu, cxLookAndFeels,ShellAPI,StrUtils,formSVN;

type
  TfmMenuUpdatePath = class(TfmParentMenu)
  private
    { Private declarations }
  public
    procedure MenuHandle;override;
  end;

var
  fmMenuUpdatePath: TfmMenuUpdatePath;

implementation

{$R *.dfm}

procedure TfmMenuUpdatePath.MenuHandle;
var
  aDatPath : string;
  FSVN : TfmSVN;
begin
  inherited;
  FSVN := TfmSVN.Create(Self);
  try
    if RightStr(FParameter, 1) = '\' then
      aDatPath := FParameter
    else
      aDatPath := FParameter + '\';
    FSVN.WorkRun(aDatPath,'update');
  finally
    FSVN.Free;
  end;
end;

initialization
  RegisterClass(TfmMenuUpdatePath);

finalization
  UnregisterClass(TfmMenuUpdatePath);

end.
