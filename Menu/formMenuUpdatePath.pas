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
    procedure MenuHandle(aParameter : String;aActivePageIndex : Integer;aTable : String);override;
  end;

var
  fmMenuUpdatePath: TfmMenuUpdatePath;

implementation

{$R *.dfm}

procedure TfmMenuUpdatePath.MenuHandle(aParameter : String;aActivePageIndex : Integer;aTable : String);
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
