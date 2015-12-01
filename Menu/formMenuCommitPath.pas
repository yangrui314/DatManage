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
    procedure MenuHandle(aParameter : String;aActivePageIndex : Integer;aTable : String);override;
  end;

var
  fmMenuCommitPath: TfmMenuCommitPath;

implementation

{$R *.dfm}


procedure TfmMenuCommitPath.MenuHandle(aParameter : String;aActivePageIndex : Integer;aTable : String);
var
  aDatPath : string;
  FSVN : TfmSVN;
begin
  inherited;
  FSVN := TfmSVN.Create(Self);
  try
    if RightStr(aParameter, 1) = '\' then
      aDatPath := aParameter
    else
      aDatPath := aParameter + '\';  
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
