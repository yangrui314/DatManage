unit unitHistory;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs,StdCtrls;

type
  THistory = class
  private
    FConnectWay : String;
    FName : String;
    FPath : String;
  protected
  public
    constructor Create(aConnectWay : string;aName : String; aPath : String);
    property ConnectWay : String read  FConnectWay write FConnectWay;    
    property Name : String read  FName write FName;
    property Path : String read  FPath write FPath;          
  end;


implementation


constructor THistory.Create(aConnectWay : string;aName : String; aPath : String);
begin
  FConnectWay := aConnectWay;
  FName := aName;
  FPath := aPath;
end;


end.

