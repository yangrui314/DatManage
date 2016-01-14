inherited fmMenuTurn: TfmMenuTurn
  Width = 455
  Height = 287
  Caption = 'fmMenuTurn'
  PixelsPerInch = 96
  TextHeight = 13
  object pnlMain: TPanel [0]
    Left = 0
    Top = 0
    Width = 439
    Height = 249
    Align = alClient
    Caption = 'pnlMain'
    ParentBackground = True
    TabOrder = 0
    object lcMain: TdxLayoutControl
      Left = 1
      Top = 1
      Width = 437
      Height = 247
      Align = alClient
      ParentBackground = True
      TabOrder = 0
      TabStop = False
      AutoContentSizes = [acsWidth, acsHeight]
      object btnOK: TcxButton
        Left = 352
        Top = 200
        Width = 75
        Height = 25
        Caption = #32763#36716
        TabOrder = 2
        OnClick = btnOKClick
      end
      object MSrc: TcxMemo
        Left = 10
        Top = 10
        TabOrder = 0
        Height = 89
        Width = 185
      end
      object MText: TcxMemo
        Left = 10
        Top = 105
        TabOrder = 1
        Height = 89
        Width = 366
      end
      object dxLayoutGroup1: TdxLayoutGroup
        AutoAligns = [aaVertical]
        ShowCaption = False
        Hidden = True
        ShowBorder = False
        object lcMainItem1: TdxLayoutItem
          Caption = 'cxMemo1'
          ShowCaption = False
          Control = MSrc
          ControlOptions.ShowBorder = False
        end
        object lcMainItem2: TdxLayoutItem
          Control = MText
          ControlOptions.ShowBorder = False
        end
        object lcMainItem3: TdxLayoutItem
          AutoAligns = [aaVertical]
          AlignHorz = ahRight
          Caption = #30830#23450
          ShowCaption = False
          Control = btnOK
          ControlOptions.ShowBorder = False
        end
      end
    end
  end
  inherited lafMain: TcxLookAndFeelController
    Left = 352
    Top = 0
  end
end
