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
    FMenuClassType : String;
    FMenuClassName : String;
    FNotShowFormHint : String;
    FParentName : string;
  protected
  public
    constructor Create;
    property Name : String read  FName write FName;
    property Caption : String read  FCaption write FCaption;
    property OrderID : Integer read  FOrderID write FOrderID;
    property Visible : Boolean read  FVisible write FVisible;
    property MenuClassType : String read  FMenuClassType write FMenuClassType;
    property MenuClassName : String read  FMenuClassName write FMenuClassName;
    property NotShowFormHint : String read  FNotShowFormHint write FNotShowFormHint;
    property ParentName : String read  FParentName write FParentName;    
  end;


implementation


constructor TMenu.Create;
begin

end;


end.

