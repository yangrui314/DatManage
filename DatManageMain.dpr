program DatManageMain;

uses
  ExceptionLog,
  Forms,
  DatManage in 'DatManage.pas' {fmMain},
  UnitFileHandle in 'FileHandle\unitFileHandle.pas',
  unitStandardHandle in 'FileHandle\unitStandardHandle.pas',
  unitTable in 'unitTable.pas',
  unitConfig in 'unitConfig.pas',
  frameShowResult in 'frameShowResult.pas' {ShowResultFrame: TFrame},
  formTableProperty in 'formTableProperty.pas' {fmTableProperty},
  formInsert in 'formInsert.pas' {fmInsert},
  unitExcelHandle in 'FileHandle\unitExcelHandle.pas',
  formExport in 'formExport.pas' {fmExport},
  frameTableProperty in 'frameTableProperty.pas' {frmTableProperty: TFrame},
  unitXmlHandle in 'FileHandle\unitXmlHandle.pas',
  formAbout in 'formAbout.pas' {fmAbout},
  unitTableHandle in 'FileHandle\unitTableHandle.pas',
  unitUnTableHandle in 'FileHandle\unitUnTableHandle.pas',
  formImport in 'formImport.pas' {fmImport};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfmMain, fmMain);
  Application.CreateForm(TfmTableProperty, fmTableProperty);
  Application.CreateForm(TfmInsert, fmInsert);
  Application.CreateForm(TfmExport, fmExport);
  Application.CreateForm(TfmAbout, fmAbout);
  Application.CreateForm(TfmImport, fmImport);
  Application.Run;
end.
