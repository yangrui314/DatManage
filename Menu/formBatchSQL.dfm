inherited fmBatchSQL: TfmBatchSQL
  Left = 379
  Top = 158
  Width = 787
  Height = 362
  Caption = #25209#37327#22788#29702'SQL'
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlBatchSQL: TPanel [0]
    Left = 0
    Top = 0
    Width = 771
    Height = 324
    Align = alClient
    Caption = 'pnl'
    ParentBackground = True
    TabOrder = 0
    object lcMain: TdxLayoutControl
      Left = 1
      Top = 1
      Width = 769
      Height = 322
      Align = alClient
      ParentBackground = True
      TabOrder = 0
      TabStop = False
      AutoContentSizes = [acsWidth, acsHeight]
      object gridParameter: TcxGrid
        Left = 10
        Top = 10
        Width = 711
        Height = 127
        Align = alClient
        TabOrder = 0
        object dgParameter: TcxGridTableView
          NavigatorButtons.ConfirmDelete = False
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
          OptionsData.CancelOnExit = False
          OptionsData.Deleting = False
          OptionsData.DeletingConfirmation = False
          OptionsData.Inserting = False
          OptionsView.GroupByBox = False
          object dgParameterSelected: TcxGridColumn
            Caption = #36873#25321
            PropertiesClassName = 'TcxCheckBoxProperties'
            Properties.ImmediatePost = True
            FooterAlignmentHorz = taCenter
            GroupSummaryAlignment = taCenter
            HeaderAlignmentHorz = taCenter
            HeaderGlyphAlignmentHorz = taCenter
          end
          object dgParameterID: TcxGridColumn
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
          object dgParameterName: TcxGridColumn
            Caption = #21517#31216
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.ReadOnly = True
            FooterAlignmentHorz = taCenter
            GroupSummaryAlignment = taCenter
            HeaderAlignmentHorz = taCenter
            Width = 149
          end
          object dgParameterPath: TcxGridColumn
            Caption = #36335#24452
            PropertiesClassName = 'TcxTextEditProperties'
            Properties.ReadOnly = True
            FooterAlignmentHorz = taCenter
            GroupSummaryAlignment = taCenter
            HeaderAlignmentHorz = taCenter
            Width = 471
          end
        end
        object levelParameter: TcxGridLevel
          GridView = dgParameter
        end
      end
      object edtSQL: TcxMemo
        Left = 10
        Top = 171
        TabOrder = 1
        Height = 89
        Width = 185
      end
      object cbOK: TcxButton
        Left = 684
        Top = 266
        Width = 75
        Height = 43
        Caption = #25209#37327#25191#34892
        TabOrder = 2
        OnClick = cbOKClick
      end
      object dxLayoutGroup1: TdxLayoutGroup
        AutoAligns = [aaVertical]
        ShowCaption = False
        Hidden = True
        ShowBorder = False
        object lcMainItem1: TdxLayoutItem
          Control = gridParameter
          ControlOptions.ShowBorder = False
        end
        object lcMainItem2: TdxLayoutItem
          Caption = 'SQL'#35821#21477':'
          CaptionOptions.Layout = clTop
          Offsets.Top = 10
          Control = edtSQL
          ControlOptions.ShowBorder = False
        end
        object lcMainItem3: TdxLayoutItem
          AutoAligns = [aaVertical]
          AlignHorz = ahRight
          Caption = 'cxButton1'
          ShowCaption = False
          Control = cbOK
          ControlOptions.ShowBorder = False
        end
      end
    end
  end
end
