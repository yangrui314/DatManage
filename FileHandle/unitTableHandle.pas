unit unitTableHandle;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs,StdCtrls,unitFileHandle,unitTable;


type
  TTableHandle = class(TFileHandle)
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


constructor TTableHandle.Create(aTable : TTable);
begin
  inherited Create;
  FTable := aTable;
end;

function TTableHandle.SaveFile(aFilePath : String) : Boolean;
begin
  Result := False;  
end;

function TTableHandle.ReadFile(aFilePath : String) : Boolean;
begin
  Result := False;
end;

destructor TTableHandle.Destroy;
begin
  inherited;    
end;

end.
