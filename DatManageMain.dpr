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
  mLookAndFeelRES in 'mLookAndFeelRES.pas' {LookAndFeelRES: TDataModule},
  dxSkinsForm in 'dxSkinsForm.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TLookAndFeelRES, LookAndFeelRES);
  Application.CreateForm(TfmMain, fmMain);
  Application.CreateForm(TfmTableProperty, fmTableProperty);
  Application.CreateForm(TfmInsert, fmInsert);
  Application.CreateForm(TfmExport, fmExport);
  Application.CreateForm(TfmAbout, fmAbout);
  Application.CreateForm(TfmImport, fmImport);
  Application.CreateForm(TfmProgress, fmProgress);
  Application.CreateForm(TParentForm, ParentForm);
  Application.CreateForm(TfmSavePath, fmSavePath);
  Application.Run;
end.
