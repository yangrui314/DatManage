unit formMenuViewConditionals;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, formParentMenu, cxLookAndFeels,unitConditionals;

type
  TfmMenuViewConditionals = class(TfmParentMenu)
  private
    { Private declarations }
  public
    procedure MenuHandle;override;
  end;

var
  fmMenuViewConditionals: TfmMenuViewConditionals;

implementation

  uses
    unitConfig;

{$R *.dfm}

procedure TfmMenuViewConditionals.MenuHandle;
var
  aCdn : TConditionals;
begin
  inherited;
  aCdn := TConditionals.Create;
  try
    aCdn.View(FParameter);
  finally
    aCdn.Free;
  end;
end;

initialization
  RegisterClass(TfmMenuViewConditionals);

finalization
  UnregisterClass(TfmMenuViewConditionals);

end.
