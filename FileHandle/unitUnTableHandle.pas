unit unitUnTableHandle;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs,StdCtrls,unitTable;


type
  TUnTableHandle = class
  private
  protected
    FTable : TTable;
  public
    function SaveFile(aFilePath : String) : Boolean; virtual;
    function ReadFile(aFilePath : String) : Boolean; virtual;  
    destructor Destroy; virtual;
    constructor Create(aTable : TTable); virtual;
  end;


implementation


constructor TUnTableHandle.Create(aTable : TTable);
begin
  FTable := aTable;
end;

function TUnTableHandle.SaveFile(aFilePath : String) : Boolean;
begin
  Result := False;  
end;

function TUnTableHandle.ReadFile(aFilePath : String) : Boolean;
begin
  Result := False;
end;

destructor TUnTableHandle.Destroy;
begin
    
end;

end.
