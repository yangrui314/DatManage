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
    FFullName : String;
    FOutputDir : String;
    FConditionals : String;
  protected
  public
    constructor Create(aConnectWay : string;aName : String; aPath : String);overload;
    constructor Create;overload;
    property ConnectWay : String read  FConnectWay write FConnectWay;
    property Name : String read  FName write FName;
    property Path : String read  FPath write FPath;
    property FullName : String read  FFullName write FFullName;
    property OutputDir : String read  FOutputDir write FOutputDir;
    property Conditionals : String read  FConditionals write FConditionals;               
  end;


implementation


constructor THistory.Create(aConnectWay : string;aName : String; aPath : String);
begin
  FConnectWay := aConnectWay;
  FName := aName;
  FPath := aPath;
end;

constructor THistory.Create;
begin
    
end;

end.

