inherited fmDiff: TfmDiff
  Left = 231
  Top = 166
  Width = 934
  Height = 515
  Caption = 'fmDiff'
  PixelsPerInch = 96
  TextHeight = 13
  object pnlMain: TPanel
    Left = 0
    Top = 0
    Width = 918
    Height = 477
    Align = alClient
    Caption = 'pnlMain'
    TabOrder = 0
    object lcMain: TdxLayoutControl
      Left = 1
      Top = 1
      Width = 916
      Height = 475
      Align = alClient
      TabOrder = 0
      TabStop = False
      AutoContentSizes = [acsWidth, acsHeight]
      object edtScrPath: TcxComboBox
        Left = 63
        Top = 10
        Properties.ImmediatePost = True
        TabOrder = 0
        Width = 743
      end
      object edtDiffPath: TcxComboBox
        Left = 63
        Top = 37
        Properties.ImmediatePost = True
        TabOrder = 1
        Width = 743
      end
      object cbDiff: TcxButton
        Left = 831
        Top = 64
        Width = 75
        Height = 25
        Caption = #23545#27604
        TabOrder = 3
      end
      object edtTable: TcxComboBox
        Left = 63
        Top = 64
        Properties.ImmediatePost = True
        TabOrder = 2
        Width = 121
      end
      object cxGrid1: TcxGrid
        Left = 10
        Top = 95
        Width = 455
        Height = 362
        TabOrder = 4
        object cxGrid1DBTableView1: TcxGridDBTableView
          NavigatorButtons.ConfirmDelete = False
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
        end
        object cxGrid1Level1: TcxGridLevel
          GridView = cxGrid1DBTableView1
        end
      end
      object cxGrid2: TcxGrid
        Left = 471
        Top = 95
        Width = 435
        Height = 362
        Align = alClient
        TabOrder = 5
        object cxGrid2DBTableView1: TcxGridDBTableView
          NavigatorButtons.ConfirmDelete = False
          DataController.Summary.DefaultGroupSummaryItems = <>
          DataController.Summary.FooterSummaryItems = <>
          DataController.Summary.SummaryGroups = <>
        end
        object cxGrid2Level1: TcxGridLevel
          GridView = cxGrid2DBTableView1
        end
      end
      object lcMainGroup_Root: TdxLayoutGroup
        ShowCaption = False
        Hidden = True
        ShowBorder = False
        object lcMainItem1: TdxLayoutItem
          Caption = #28304#36335#24452#65306
          Control = edtScrPath
          ControlOptions.ShowBorder = False
        end
        object lcMainItem2: TdxLayoutItem
          Caption = #23545#27604#36335#24452
          Control = edtDiffPath
          ControlOptions.ShowBorder = False
        end
        object lcMainGroup1: TdxLayoutGroup
          ShowCaption = False
          Hidden = True
          LayoutDirection = ldHorizontal
          ShowBorder = False
          object lcMainItem4: TdxLayoutItem
            Caption = #34920#21517#31216
            Control = edtTable
            ControlOptions.ShowBorder = False
          end
          object lcMainItem3: TdxLayoutItem
            AutoAligns = [aaVertical]
            AlignHorz = ahRight
            Caption = 'cxButton1'
            ShowCaption = False
            Control = cbDiff
            ControlOptions.ShowBorder = False
          end
        end
        object lcMainGroup2: TdxLayoutGroup
          ShowCaption = False
          Hidden = True
          LayoutDirection = ldHorizontal
          ShowBorder = False
          object lcMainItem5: TdxLayoutItem
            Caption = 'cxGrid1'
            ShowCaption = False
            Control = cxGrid1
            ControlOptions.ShowBorder = False
          end
          object lcMainItem6: TdxLayoutItem
            AutoAligns = [aaVertical]
            AlignHorz = ahClient
            Caption = 'cxGrid2'
            ShowCaption = False
            Control = cxGrid2
            ControlOptions.ShowBorder = False
          end
        end
      end
    end
  end
end
