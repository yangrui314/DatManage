unit unitHistory;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs,StdCtrls;

type
  THistory = class
  private
    FName : String;
    FPath : String;
  protected
  public
    constructor Create(aName : String; aPath : String);
    property Name : String read  FName write FName;
    property Path : String read  FPath write FPath;          
  end;


implementation


constructor THistory.Create(aName : String; aPath : String);
begin
  FName := aName;
  FPath := aPath;
end;


end.

