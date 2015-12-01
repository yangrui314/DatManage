unit formParentMenu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, formParent, cxLookAndFeels;

type
  TfmParentMenu = class(TParentForm)
  private
  public
    procedure MenuHandle(aParameter : String;aActivePageIndex : Integer;aTable : String) ;virtual;
    function CheckIsShow : Boolean; virtual;    
  end;

var
  fmParentMenu: TfmParentMenu;

implementation

{$R *.dfm}

function TfmParentMenu.CheckIsShow : Boolean; 
begin
  Result := True;
end;

procedure TfmParentMenu.MenuHandle(aParameter : String;aActivePageIndex : Integer;aTable : String) ;
begin
  //不做处理    
end;


initialization
  RegisterClass(TfmParentMenu);

finalization
  UnregisterClass(TfmParentMenu);


end.
