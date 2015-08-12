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
  frameTableProperty in 'frameTableProperty.pas' {frmTableProperty: TFrame};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfmMain, fmMain);
  Application.CreateForm(TfmTableProperty, fmTableProperty);
  Application.CreateForm(TfmInsert, fmInsert);
  Application.CreateForm(TfmExport, fmExport);
  Application.Run;
end.
