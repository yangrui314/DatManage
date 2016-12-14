unit formMenuUpdateConditionals;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, formParentMenu, cxLookAndFeels,unitConditionals;

type
  TfmMenuUpdateConditionals = class(TfmParentMenu)
  private
    { Private declarations }
  public
    procedure MenuHandle;override;
  end;

var
  fmMenuUpdateConditionals: TfmMenuUpdateConditionals;

implementation

  uses
    unitConfig;

{$R *.dfm}

procedure TfmMenuUpdateConditionals.MenuHandle;
var
  aCdn : TConditionals;
begin
  inherited;
  aCdn := TConditionals.Create;
  try
    aCdn.UpdateConditionals(FParameter);
  finally
    aCdn.Free;
  end;
end;

initialization
  RegisterClass(TfmMenuUpdateConditionals);

finalization
  UnregisterClass(TfmMenuUpdateConditionals);



end.
