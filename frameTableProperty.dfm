object frmTableProperty: TfrmTableProperty
  Left = 0
  Top = 0
  Width = 634
  Height = 249
  TabOrder = 0
  object gridProperty: TcxGrid
    Left = 0
    Top = 0
    Width = 634
    Height = 249
    Align = alClient
    TabOrder = 0
    object dgProperty: TcxGridTableView
      NavigatorButtons.ConfirmDelete = False
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.CancelOnExit = False
      OptionsData.Deleting = False
      OptionsData.DeletingConfirmation = False
      OptionsData.Inserting = False
      OptionsView.GroupByBox = False
      object dgPropertySelected: TcxGridColumn
        Caption = #36873#25321
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ImmediatePost = True
        FooterAlignmentHorz = taCenter
        GroupSummaryAlignment = taCenter
        HeaderAlignmentHorz = taCenter
        HeaderGlyphAlignmentHorz = taCenter
      end
      object dgPropertyID: TcxGridColumn
        Caption = #24207#21495
        DataBinding.ValueType = 'Integer'
        PropertiesClassName = 'TcxSpinEditProperties'
        Properties.Alignment.Horz = taCenter
        Properties.ReadOnly = True
        FooterAlignmentHorz = taCenter
        GroupSummaryAlignment = taCenter
        HeaderAlignmentHorz = taCenter
        HeaderGlyphAlignmentHorz = taCenter
        Width = 44
      end
      object dgPropertyName: TcxGridColumn
        Caption = #21517#31216
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.ReadOnly = True
        FooterAlignmentHorz = taCenter
        GroupSummaryAlignment = taCenter
        HeaderAlignmentHorz = taCenter
        Width = 105
      end
      object dgPropertyCaption: TcxGridColumn
        Caption = #20013#25991#21517
        PropertiesClassName = 'TcxTextEditProperties'
        FooterAlignmentHorz = taCenter
        GroupSummaryAlignment = taCenter
        HeaderAlignmentHorz = taCenter
        Width = 171
      end
      object dgPropertyDataType: TcxGridColumn
        Caption = #25968#25454#31867#22411
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.ReadOnly = True
        FooterAlignmentHorz = taCenter
        GroupSummaryAlignment = taCenter
        HeaderAlignmentHorz = taCenter
        Width = 89
      end
      object dgPropertySize: TcxGridColumn
        Caption = #38271#24230
        DataBinding.ValueType = 'Integer'
        PropertiesClassName = 'TcxSpinEditProperties'
        Properties.Alignment.Horz = taLeftJustify
        Properties.ReadOnly = True
        FooterAlignmentHorz = taCenter
        GroupSummaryAlignment = taCenter
        HeaderAlignmentHorz = taCenter
        Width = 65
      end
      object dgPropertyIsNull: TcxGridColumn
        Caption = #20801#35768#20026#31354
        DataBinding.ValueType = 'Boolean'
        PropertiesClassName = 'TcxCheckBoxProperties'
        Properties.ReadOnly = True
        FooterAlignmentHorz = taCenter
        GroupSummaryAlignment = taCenter
        HeaderAlignmentHorz = taCenter
        Width = 73
      end
    end
    object levelProperty: TcxGridLevel
      GridView = dgProperty
    end
  end
end
