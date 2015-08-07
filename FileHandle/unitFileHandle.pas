unit unitFileHandle;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs,StdCtrls;


type
  TFileHandle = class
  private
    procedure Delete;
  protected
    FFilePath : String;
    procedure LoadFile; virtual;
    procedure ImportFile; virtual;
    procedure ExportFile; virtual;
    function IsExist: Boolean;virtual;
  public
    destructor Destroy; virtual;
    constructor Create(aFilePath : String); virtual;
  end;


implementation

constructor TFileHandle.Create(aFilePath : String);
begin
  FFilePath := aFilePath;
  LoadFile;    
end;

procedure TFileHandle.Delete;
begin
  if IsExist then
    DeleteFile(FFilePath);
end;


procedure TFileHandle.LoadFile;
begin

end;


procedure TFileHandle.ImportFile;
begin

end;


procedure TFileHandle.ExportFile;
begin

end;

function TFileHandle.IsExist : Boolean;
begin
  Result := False;
  if FFilePath = '' then
  begin
    Exit;
  end;
  Result := FileExists(FFilePath);
end;

destructor TFileHandle.Destroy; 
begin
    
end;


end.
