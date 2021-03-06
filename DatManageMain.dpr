program DatManageMain;

uses
  Forms,
  DatManage in 'DatManage.pas' {fmMain},
  unitTable in 'unitTable.pas',
  unitEnvironment in 'unitEnvironment.pas',
  frameShowResult in 'frameShowResult.pas' {ShowResultFrame: TFrame},
  formTableProperty in 'formTableProperty.pas' {fmTableProperty},
  formInsert in 'formInsert.pas' {fmInsert},
  formExport in 'formExport.pas' {fmExport},
  frameTableProperty in 'frameTableProperty.pas' {frmTableProperty: TFrame},
  formAbout in 'formAbout.pas' {fmAbout},
  formImport in 'formImport.pas' {fmImport},
  frameProgressBar in 'frameProgressBar.pas' {frmProgressBar: TFrame},
  formProgress in 'formProgress.pas' {fmProgress},
  unitConfig in 'unitConfig.pas',
  formParent in 'Parent\formParent.pas' {ParentForm},
  unitHistory in 'unitHistory.pas',
  formSavePath in 'formSavePath.pas' {fmSavePath},
  formSet in 'formSet.pas' {fmSet},
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
  unitConditionals in 'unitConditionals.pas',
  formMenuViewConditionals in 'Menu\formMenuViewConditionals.pas' {fmMenuViewConditionals},
  formMenuUpdateConditionals in 'Menu\formMenuUpdateConditionals.pas' {fmMenuUpdateConditionals},
  unitUpgrade in 'unitUpgrade.pas',
  formMenuUpgrade in 'Menu\formMenuUpgrade.pas' {fmMenuUpgrade},
  unitLoadMenu in 'unitLoadMenu.pas',
  unitFileWay in 'FileWay\unitFileWay.pas',
  unitXmlWay in 'FileWay\unitXmlWay.pas',
  unitDatWay in 'FileWay\unitDatWay.pas',
  unitExcelHandle in 'FileWay\unitExcelHandle.pas',
  formBatchSQL in 'Menu\formBatchSQL.pas' {fmBatchSQL},
  formMenuBatchImportPath in 'Menu\formMenuBatchImportPath.pas' {fmMenuBatchImportPath},
  unitParentHelper in 'Helper\unitParentHelper.pas',
  unitStrHelper in 'Helper\unitStrHelper.pas',
  formMenuBatchReName in 'Menu\formMenuBatchReName.pas' {fmMenuBatchReName},
  unitFileHelper in 'Helper\unitFileHelper.pas',
  unitSQLHelper in 'Helper\unitSQLHelper.pas',
  unitConfigHelper in 'Helper\unitConfigHelper.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfmMain, fmMain);
  Application.CreateForm(TdmSys, dmSys);
  Application.CreateForm(TfmMenuBatchReName, fmMenuBatchReName);
  Application.Run;
end.
