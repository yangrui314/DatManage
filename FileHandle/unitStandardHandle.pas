unit unitStandardHandle;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls,
  Dialogs,StdCtrls,unitFileHandle;

type
  TStandardHandle = class(TFileHandle)
  private
    FFile : Textfile;
    FData : TStringList;
  protected
    procedure LoadFile; override;
    procedure LoadData;    
  public
    destructor Destroy; override;
    constructor Create(aFilePath : String); override;
    property FileData: TStringList read FData write FData;
  end;

implementation

constructor TStandardHandle.Create(aFilePath : String);
begin
  FData := TStringList.Create;
  inherited;
end;

procedure TStandardHandle.LoadFile;
begin
  inherited;
  AssignFile(FFile, FFilePath);
  LoadData;
end;

procedure TStandardHandle.LoadData;
var
  aStr : String;
begin
  Reset(FFile);
  while not Eof(FFile) do
  begin
    Readln(FFile, aStr);
    FData.Add(aStr) ;
  end;
end;


destructor TStandardHandle.Destroy;
begin
  FData.Free;
  Closefile(FFile);
  inherited;
end;

end.
