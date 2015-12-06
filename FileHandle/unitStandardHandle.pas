unit unitStandardHandle;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs,StdCtrls,unitFileHandle,unitTable,unitFileWay;

type
  TStandardHandle = class(TFileWay)
  private
    FData : TStringList;
  protected
  public
    destructor Destroy; override;
    constructor Create;override;
    function SaveFile(aFilePath : String ; aData : String) : Boolean; overload;
    function ReadFile(aFilePath : String) : Boolean;
    property FileData: TStringList read FData write FData;
  end;

implementation

constructor TStandardHandle.Create;
begin
  inherited;
  FData := TStringList.Create;  
end;



function TStandardHandle.SaveFile(aFilePath : String ; aData : String) : Boolean;
var
  aFile: TextFile;
  aStr : String;
begin
  aStr := aData;
  AssignFile(aFile,aFilePath);
  Rewrite(aFile);
  Writeln(aFile, aStr);
  CloseFile(aFile);
  Result := True;
end;

function TStandardHandle.ReadFile(aFilePath : String) : Boolean;
var
  aStr : String;
  aFile : Textfile;
begin
  AssignFile(aFile, aFilePath);
  Reset(aFile);
  while not Eof(aFile) do
  begin
    Readln(aFile, aStr);
    FData.Add(aStr) ;
  end;
  Closefile(aFile);
  Result := True;    
end;



destructor TStandardHandle.Destroy;
begin
  FData.Free;
  inherited;
end;

end.
