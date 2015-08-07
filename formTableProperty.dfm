object fmTableProperty: TfmTableProperty
  Left = 476
  Top = 277
  Width = 475
  Height = 244
  Caption = 'fmTableProperty'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object gridProperty: TcxGrid
    Left = 0
    Top = 0
    Width = 459
    Height = 206
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
        Width = 73
      end
      object dgPropertyName: TcxGridColumn
        Caption = #21517#31216
        PropertiesClassName = 'TcxTextEditProperties'
        Properties.ReadOnly = True
        FooterAlignmentHorz = taCenter
        GroupSummaryAlignment = taCenter
        HeaderAlignmentHorz = taCenter
        Width = 156
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
