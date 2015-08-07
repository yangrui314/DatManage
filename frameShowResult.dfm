object ShowResultFrame: TShowResultFrame
  Left = 0
  Top = 0
  Width = 562
  Height = 147
  TabOrder = 0
  object gridField: TcxGrid
    Left = 0
    Top = 0
    Width = 562
    Height = 147
    Align = alClient
    BorderStyle = cxcbsNone
    TabOrder = 0
    object dgField: TcxGridTableView
      NavigatorButtons.ConfirmDelete = False
      FilterBox.CustomizeDialog = False
      DataController.Options = [dcoAssignGroupingValues, dcoAssignMasterDetailKeys, dcoSaveExpanding, dcoGroupsAlwaysExpanded]
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsCustomize.ColumnFiltering = False
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.GroupByBox = False
    end
    object levelField: TcxGridLevel
      GridView = dgField
    end
  end
end
