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
    procedure MenuHandle(aParameter : String;aActivePageIndex : Integer;aTable : String);override;
  end;

var
  fmMenuUpdateConditionals: TfmMenuUpdateConditionals;

implementation

  uses
    unitConfig;

{$R *.dfm}

procedure TfmMenuUpdateConditionals.MenuHandle(aParameter : String;aActivePageIndex : Integer;aTable : String);
var
  aCdn : TConditionals;
begin
  inherited;
  aCdn := TConditionals.Create;
  try
    aCdn.Update(Config.SystemParameter);
  finally
    aCdn.Free;
  end;
end;

initialization
  RegisterClass(TfmMenuUpdateConditionals);

finalization
  UnregisterClass(TfmMenuUpdateConditionals);



end.
