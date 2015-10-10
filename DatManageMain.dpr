program DatManageMain;

uses
  Forms,
  DatManage in 'DatManage.pas' {fmMain},
  UnitFileHandle in 'FileHandle\unitFileHandle.pas',
  unitStandardHandle in 'FileHandle\unitStandardHandle.pas',
  unitTable in 'unitTable.pas',
  unitEnvironment in 'unitEnvironment.pas',
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
  formImport in 'formImport.pas' {fmImport},
  frameProgressBar in 'frameProgressBar.pas' {frmProgressBar: TFrame},
  formProgress in 'formProgress.pas' {fmProgress},
  unitConfig in 'unitConfig.pas',
  unitConfigFile in 'ConfigFile\unitConfigFile.pas',
  unitConfigDat in 'ConfigFile\unitConfigDat.pas',
  formParent in 'Parent\formParent.pas' {ParentForm},
  unitHistory in 'unitHistory.pas',
  formSavePath in 'formSavePath.pas' {fmSavePath},
  formSet in 'formSet.pas' {fmSet},
  formSVN in 'formSVN.pas' {fmSVN};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfmMain, fmMain);
  Application.CreateForm(TfmSVN, fmSVN);
  Application.Run;
end.
