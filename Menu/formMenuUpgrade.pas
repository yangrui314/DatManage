unit formMenuUpgrade;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, formParentMenu, cxLookAndFeels,unitUpgrade;

type
  TfmMenuUpgrade = class(TfmParentMenu)
  private
    { Private declarations }
  public
    procedure MenuHandle(aParameter : String;aActivePageIndex : Integer;aTable : String);override;
  end;

var
  fmMenuUpgrade: TfmMenuUpgrade;

implementation

{$R *.dfm}

procedure TfmMenuUpgrade.MenuHandle(aParameter : String;aActivePageIndex : Integer;aTable : String);
var
  aUpgrade : TUpgrade;
begin
  inherited;
  aUpgrade := TUpgrade.Create;
  try
    aUpgrade.UpdateSelf(Self);
  finally
    aUpgrade.Free;
  end;
end;

initialization
  RegisterClass(TfmMenuUpgrade);

finalization
  UnregisterClass(TfmMenuUpgrade);

end.
