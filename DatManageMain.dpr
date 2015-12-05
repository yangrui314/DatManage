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
  formSVN in 'formSVN.pas' {fmSVN},
  formSelectAll in 'formSelectAll.pas' {fmSelectAll},
  cxTextEdit in 'thirdparty\devexpress\cxTextEdit.pas',
  frmMain in 'Diff\frmMain.pas' {MainForm},
  UnitSys in 'Diff\UnitSys.pas' {dmSys: TDataModule},
  UnitContrast in 'Diff\UnitContrast.pas',
  UnitShowDiff in 'Diff\UnitShowDiff.pas' {frmShowDiff},
  formUpgradeProgress in 'formUpgradeProgress.pas' {fmUpgradeProgress},
  unitDownLoadFile in 'unitDownLoadFile.pas',
  unitMenu in 'unitMenu.pas',
  unitSQLEnvironment in 'unitSQLEnvironment.pas',
  unitDbisamEnvironment in 'unitDbisamEnvironment.pas',
  formParentMenu in 'Menu\formParentMenu.pas' {fmParentMenu},
  formMenuConfigPath in 'Menu\formMenuConfigPath.pas' {fmMenuConfigPath},
  formMenuOpenPath in 'Menu\formMenuOpenPath.pas' {fmMenuOpenPath},
  formMenuOpenTable in 'Menu\formMenuOpenTable.pas' {fmMenuOpenTable},
  formMenuUpdatePath in 'Menu\formMenuUpdatePath.pas' {fmMenuUpdatePath},
  formMenuCommitPath in 'Menu\formMenuCommitPath.pas' {fmMenuCommitPath},
  unitConditionals in 'unitConditionals.pas',
  formMenuViewConditionals in 'Menu\formMenuViewConditionals.pas' {fmMenuViewConditionals},
  formMenuUpdateConditionals in 'Menu\formMenuUpdateConditionals.pas' {fmMenuUpdateConditionals};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfmMain, fmMain);
  Application.CreateForm(TdmSys, dmSys);
  Application.CreateForm(TfmParentMenu, fmParentMenu);
  Application.CreateForm(TfmMenuConfigPath, fmMenuConfigPath);
  Application.CreateForm(TfmMenuOpenPath, fmMenuOpenPath);
  Application.CreateForm(TfmMenuOpenTable, fmMenuOpenTable);
  Application.CreateForm(TfmMenuUpdatePath, fmMenuUpdatePath);
  Application.CreateForm(TfmMenuCommitPath, fmMenuCommitPath);
  Application.CreateForm(TfmMenuViewConditionals, fmMenuViewConditionals);
  Application.CreateForm(TfmMenuUpdateConditionals, fmMenuUpdateConditionals);
  Application.Run;
end.
