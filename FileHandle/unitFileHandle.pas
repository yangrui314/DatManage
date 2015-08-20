unit unitFileHandle;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs,StdCtrls,unitTable;


type
  TFileHandle = class
  private
  protected
  public
    function SaveFile(aFilePath : String) : Boolean; virtual;
    function ReadFile(aFilePath : String) : Boolean; virtual;  
    destructor Destroy; virtual;
    constructor Create; virtual;
  end;


implementation


constructor TFileHandle.Create;
begin

end;

function TFileHandle.SaveFile(aFilePath : String) : Boolean;
begin
  Result := False;  
end;

function TFileHandle.ReadFile(aFilePath : String) : Boolean;
begin
  Result := False;
end;

destructor TFileHandle.Destroy; 
begin
    
end;

end.
