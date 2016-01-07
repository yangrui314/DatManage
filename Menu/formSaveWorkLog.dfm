inherited fmSaveWorkLog: TfmSaveWorkLog
  Width = 713
  Height = 265
  Caption = #20445#23384#26085#24535
  PixelsPerInch = 96
  TextHeight = 13
  object pnlMain: TPanel [0]
    Left = 0
    Top = 0
    Width = 697
    Height = 227
    Align = alClient
    Caption = 'pnlMain'
    ParentBackground = True
    TabOrder = 0
    object lcMain: TdxLayoutControl
      Left = 1
      Top = 1
      Width = 695
      Height = 225
      Align = alClient
      ParentBackground = True
      TabOrder = 0
      TabStop = False
      AutoContentSizes = [acsWidth, acsHeight]
      object edtPathName: TcxComboBox
        Left = 75
        Top = 10
        Properties.ImmediatePost = True
        TabOrder = 0
        Width = 125
      end
      object edtBeginDate: TcxDateEdit
        Left = 75
        Top = 37
        TabOrder = 1
        Width = 125
      end
      object edtEndDate: TcxDateEdit
        Left = 271
        Top = 37
        TabOrder = 2
        Width = 125
      end
      object edtExpectDay: TcxSpinEdit
        Left = 527
        Top = 37
        TabOrder = 3
        Width = 121
      end
      object edtWorkLog: TcxMemo
        Left = 10
        Top = 82
        Lines.Strings = (
          '')
        TabOrder = 4
        Height = 89
        Width = 185
      end
      object btnSaveLog: TcxButton
        Left = 610
        Top = 177
        Width = 75
        Height = 25
        Caption = #20445#23384
        TabOrder = 5
        OnClick = btnSaveLogClick
      end
      object dxLayoutGroup1: TdxLayoutGroup
        AutoAligns = [aaVertical]
        AlignHorz = ahClient
        ShowCaption = False
        Hidden = True
        ShowBorder = False
        object lcMainItem1: TdxLayoutItem
          Caption = #29615#22659#21517#31216#65306
          Control = edtPathName
          ControlOptions.ShowBorder = False
        end
        object lcMainGroup1: TdxLayoutGroup
          ShowCaption = False
          Hidden = True
          LayoutDirection = ldHorizontal
          ShowBorder = False
          object lcMainItem3: TdxLayoutItem
            Caption = #24320#22987#26085#26399#65306
            Control = edtBeginDate
            ControlOptions.ShowBorder = False
          end
          object lcMainItem2: TdxLayoutItem
            Caption = #32467#26463#26085#26399#65306
            Control = edtEndDate
            ControlOptions.ShowBorder = False
          end
          object lcMainItem4: TdxLayoutItem
            AutoAligns = [aaVertical]
            AlignHorz = ahClient
            Caption = #39044#35745#23436#25104#26102#38388#65288#22825#65289#65306
            Control = edtExpectDay
            ControlOptions.ShowBorder = False
          end
        end
        object lcMainItem5: TdxLayoutItem
          Caption = #26085#24535#20449#24687#65306
          CaptionOptions.Layout = clTop
          Control = edtWorkLog
          ControlOptions.ShowBorder = False
        end
        object lcMainItem6: TdxLayoutItem
          AutoAligns = [aaVertical]
          AlignHorz = ahRight
          Caption = 'cxButton1'
          ShowCaption = False
          Control = btnSaveLog
          ControlOptions.ShowBorder = False
        end
      end
    end
  end
  inherited lafMain: TcxLookAndFeelController
    Left = 368
  end
end
