inherited fmSVN: TfmSVN
  Left = 481
  Top = 283
  Width = 385
  Height = 161
  Caption = 'formSVN'
  PixelsPerInch = 96
  TextHeight = 13
  object pnlMain: TPanel
    Left = 0
    Top = 0
    Width = 369
    Height = 123
    Align = alClient
    Caption = 'pnlMain'
    TabOrder = 0
    object lcMain: TdxLayoutControl
      Left = 1
      Top = 1
      Width = 367
      Height = 121
      Align = alClient
      TabOrder = 0
      TabStop = False
      AutoContentSizes = [acsWidth, acsHeight]
      object edtSvnPath: TcxComboBox
        Left = 51
        Top = 10
        Properties.ImmediatePost = True
        TabOrder = 0
        Width = 121
      end
      object btnSelectPath: TcxButton
        Left = 282
        Top = 10
        Width = 75
        Height = 25
        Caption = #36873#25321
        TabOrder = 1
        OnClick = btnSelectPathClick
      end
      object btnCommit: TcxButton
        Left = 91
        Top = 41
        Width = 75
        Height = 25
        Caption = #25552#20132
        TabOrder = 3
        OnClick = btnCommitClick
      end
      object btnUpdate: TcxButton
        Left = 10
        Top = 41
        Width = 75
        Height = 25
        Caption = #26356#26032
        TabOrder = 2
        OnClick = btnUpdateClick
      end
      object btnLog: TcxButton
        Left = 172
        Top = 41
        Width = 75
        Height = 25
        Caption = #26597#30475#26085#24535
        TabOrder = 4
        OnClick = btnLogClick
      end
      object btnDiff: TcxButton
        Left = 253
        Top = 41
        Width = 75
        Height = 25
        Caption = #27604#36739#24046#24322
        TabOrder = 5
        OnClick = btnDiffClick
      end
      object lcMainGroup_Root: TdxLayoutGroup
        ShowCaption = False
        Hidden = True
        ShowBorder = False
        object lcMainGroup1: TdxLayoutGroup
          ShowCaption = False
          Hidden = True
          LayoutDirection = ldHorizontal
          ShowBorder = False
          object lcMainItem1: TdxLayoutItem
            AutoAligns = [aaVertical]
            AlignHorz = ahClient
            Caption = #36335#24452#65306
            Control = edtSvnPath
            ControlOptions.ShowBorder = False
          end
          object lcMainItem2: TdxLayoutItem
            AutoAligns = [aaVertical]
            AlignHorz = ahRight
            Caption = 'cxButton1'
            ShowCaption = False
            Control = btnSelectPath
            ControlOptions.ShowBorder = False
          end
        end
        object lcMainGroup2: TdxLayoutGroup
          ShowCaption = False
          Hidden = True
          LayoutDirection = ldHorizontal
          ShowBorder = False
          object lcMainItem4: TdxLayoutItem
            ShowCaption = False
            Control = btnUpdate
            ControlOptions.ShowBorder = False
          end
          object lcMainItem3: TdxLayoutItem
            Caption = 'cxButton1'
            ShowCaption = False
            Control = btnCommit
            ControlOptions.ShowBorder = False
          end
          object lcMainItem5: TdxLayoutItem
            ShowCaption = False
            Control = btnLog
            ControlOptions.ShowBorder = False
          end
          object lcMainItem6: TdxLayoutItem
            ShowCaption = False
            Control = btnDiff
            ControlOptions.ShowBorder = False
          end
        end
      end
    end
  end
  object dlgOpen: TOpenDialog
    Left = 256
    Top = 40
  end
end
