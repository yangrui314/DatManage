unit unitMenu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs,StdCtrls;

type
  TMenu = class
  private
    FName : String;
    FCaption : String;
    FOrderID : Integer;
    FVisible : Boolean;
    FClassName : String;
    FNotShowFormHint : String;
  protected
  public
    constructor Create;
    property Name : String read  FName write FName;
    property Caption : String read  FCaption write FCaption;
    property OrderID : Integer read  FOrderID write FOrderID;
    property Visible : Boolean read  FVisible write FVisible;
    property ClassName : String read  FClassName write FClassName;
    property NotShowFormHint : String read  FNotShowFormHint write FNotShowFormHint;
  end;


implementation


constructor TMenu.Create;
begin

end;


end.

