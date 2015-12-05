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
    procedure MenuHandle(aParameter : String;aActivePageIndex : Integer;aTable : String);override;
  end;

var
  fmMenuViewConditionals: TfmMenuViewConditionals;

implementation

{$R *.dfm}

procedure TfmMenuViewConditionals.MenuHandle(aParameter : String;aActivePageIndex : Integer;aTable : String);
var
  aCdn : TConditionals;
begin
  inherited;
  aCdn := TConditionals.Create;
  try
    aCdn.View(aParameter);
  finally
    aCdn.Free;
  end;
end;

initialization
  RegisterClass(TfmMenuViewConditionals);

finalization
  UnregisterClass(TfmMenuViewConditionals);

end.
