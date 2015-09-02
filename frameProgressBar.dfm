object frmProgressBar: TfrmProgressBar
  Left = 0
  Top = 0
  Width = 440
  Height = 109
  TabOrder = 0
  object pnlProgressBar: TPanel
    Left = 0
    Top = 0
    Width = 440
    Height = 109
    Align = alClient
    Caption = 'pnlProgressBar'
    TabOrder = 0
    object lcMain: TdxLayoutControl
      Left = 1
      Top = 1
      Width = 438
      Height = 107
      Align = alClient
      TabOrder = 0
      TabStop = False
      object lblProgressBarMessage: TcxLabel
        Left = 146
        Top = 10
        Caption = #27491#22312#23548#20837#25968#25454#65292#35831#31245#31561'......'
      end
      object PgB: TcxProgressBar
        Left = 10
        Top = 33
        TabOrder = 1
        Width = 415
      end
      object btnProgressBarCancel: TcxButton
        Left = 165
        Top = 60
        Width = 104
        Height = 29
        Caption = #21462#28040
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnClick = btnProgressBarCancelClick
      end
      object lcMainGroup_Root: TdxLayoutGroup
        AutoAligns = [aaVertical]
        AlignHorz = ahCenter
        ShowCaption = False
        Hidden = True
        ShowBorder = False
        object lcMainItem1: TdxLayoutItem
          AutoAligns = [aaVertical]
          AlignHorz = ahCenter
          Caption = 'cxLabel1'
          ShowCaption = False
          Control = lblProgressBarMessage
          ControlOptions.ShowBorder = False
        end
        object lcMainItem2: TdxLayoutItem
          Control = PgB
          ControlOptions.ShowBorder = False
        end
        object lcMainItem3: TdxLayoutItem
          AutoAligns = [aaVertical]
          AlignHorz = ahCenter
          Caption = 'cxButton1'
          ShowCaption = False
          Control = btnProgressBarCancel
          ControlOptions.ShowBorder = False
        end
      end
    end
  end
end
