unit UnitSys;

interface

uses
  SysUtils, Classes, dbisamtb, DB;

type
  TdmSys = class(TDataModule)
    dbA: TDBISAMDatabase;
    tbA: TDBISAMTable;
    dbB: TDBISAMDatabase;
    qryA: TDBISAMQuery;
  private
    { Private declarations }
  public
    { Public declarations }
    function OpenDataA(FileStr: string): Boolean;
    function OpenDataB(FileStr: string): Boolean;
  end;

var
  dmSys: TdmSys;

implementation

{$R *.dfm}

{ TdmSys }

function TdmSys.OpenDataA(FileStr: string): Boolean;
begin
  Result := False;
  dbA.Close;
  dbA.Directory := FileStr;
  dbA.Open;
  dbA.Session.AddPassword('YouAreNotPrepared');
  dbA.Session.AddPassword('YouAreNotPrepared');
  dbA.Session.AddPassword('YouAreNotPreparedForIT');
  Result := True;
end;

function TdmSys.OpenDataB(FileStr: string): Boolean;
begin
  Result := False;
  dbB.Close;
  dbB.Directory := FileStr;
  dbB.Open;
  dbB.Session.AddPassword('YouAreNotPrepared');
  dbB.Session.AddPassword('YouAreNotPrepared');
  dbB.Session.AddPassword('YouAreNotPreparedForIT');
  Result := True;
end;

end.
