unit formMenuCommitPath;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, formParentMenu, cxLookAndFeels,ShellAPI,StrUtils,formSVN;

type
  TfmMenuCommitPath = class(TfmParentMenu)
  private
    { Private declarations }
  public
    procedure MenuHandle;override;
  end;

var
  fmMenuCommitPath: TfmMenuCommitPath;

implementation

{$R *.dfm}


procedure TfmMenuCommitPath.MenuHandle;
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
    FSVN.WorkRun(aDatPath,'commit');
  finally
    FSVN.Free;
  end;

end;

initialization
  RegisterClass(TfmMenuCommitPath);

finalization
  UnregisterClass(TfmMenuCommitPath);


end.
