inherited fmSendEmail: TfmSendEmail
  Width = 506
  Height = 173
  Caption = #21457#36865#24037#20316#26085#24535#37038#20214
  PixelsPerInch = 96
  TextHeight = 13
  object pnlMain: TPanel [0]
    Left = 0
    Top = 0
    Width = 490
    Height = 135
    Align = alClient
    Caption = 'pnlMain'
    ParentBackground = True
    TabOrder = 0
    object lcMain: TdxLayoutControl
      Left = 1
      Top = 1
      Width = 488
      Height = 133
      Align = alClient
      ParentBackground = True
      TabOrder = 0
      TabStop = False
      AutoContentSizes = [acsWidth, acsHeight]
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
      object btnSaveLogAndSendEmail: TcxButton
        Left = 403
        Top = 64
        Width = 75
        Height = 25
        Caption = #21457#36865'Email'
        TabOrder = 3
        OnClick = btnSaveLogAndSendEmailClick
      end
      object edtPathName: TcxComboBox
        Left = 75
        Top = 10
        Properties.ImmediatePost = True
        TabOrder = 0
        Width = 610
      end
      object dxLayoutGroup1: TdxLayoutGroup
        AutoAligns = [aaVertical]
        AlignHorz = ahClient
        ShowCaption = False
        Hidden = True
        ShowBorder = False
        object lcMainItem1: TdxLayoutItem
          Caption = #29615#22659#65306
          Control = edtPathName
          ControlOptions.ShowBorder = False
        end
        object dxLayoutGroup2: TdxLayoutGroup
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
            AutoAligns = [aaVertical]
            AlignHorz = ahClient
            Caption = #32467#26463#26085#26399#65306
            Control = edtEndDate
            ControlOptions.ShowBorder = False
          end
        end
        object lcMainItem6: TdxLayoutItem
          AutoAligns = [aaVertical]
          AlignHorz = ahRight
          Caption = 'cxButton1'
          ShowCaption = False
          Control = btnSaveLogAndSendEmail
          ControlOptions.ShowBorder = False
        end
      end
    end
  end
  inherited lafMain: TcxLookAndFeelController
    Left = 368
  end
end
