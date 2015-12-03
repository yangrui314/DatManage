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
      OnCellDblClick = dgFieldCellDblClick
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Editing = False
      OptionsView.NoDataToDisplayInfoText = '<'#26080#25968#25454'>'
      OptionsView.GroupByBox = False
    end
    object levelField: TcxGridLevel
      GridView = dgField
    end
  end
end
