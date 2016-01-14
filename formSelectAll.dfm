inherited fmSelectAll: TfmSelectAll
  Left = 402
  Top = 241
  Width = 290
  Height = 240
  Caption = 'fmSelectAll'
  Position = poDefault
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnlMain: TPanel [0]
    Left = 0
    Top = 0
    Width = 274
    Height = 202
    Align = alClient
    Caption = 'pnlMain'
    TabOrder = 0
    object lcMain: TdxLayoutControl
      Left = 1
      Top = 1
      Width = 272
      Height = 200
      Align = alClient
      TabOrder = 0
      TabStop = False
      AutoContentSizes = [acsWidth, acsHeight]
      object edtSelectStr: TcxTextEdit
        Left = 75
        Top = 33
        TabOrder = 2
        Width = 121
      end
      object cbSelectAll: TcxButton
        Left = 187
        Top = 60
        Width = 75
        Height = 25
        Caption = #26597#25214
        TabOrder = 3
        OnClick = cbSelectAllClick
      end
      object edtMessage: TcxMemo
        Left = 75
        Top = 91
        TabOrder = 4
        Height = 89
        Width = 185
      end
      object rbData: TcxRadioButton
        Left = 10
        Top = 10
        Width = 95
        Height = 17
        Caption = #26597#35810#25968#25454
        Checked = True
        TabOrder = 0
        TabStop = True
        Transparent = True
      end
      object rbField: TcxRadioButton
        Left = 111
        Top = 10
        Width = 144
        Height = 17
        Caption = #26597#35810#23383#27573
        TabOrder = 1
        Transparent = True
      end
      object lcMainGroup_Root: TdxLayoutGroup
        ShowCaption = False
        Hidden = True
        ShowBorder = False
        object lcMainGroup2: TdxLayoutGroup
          ShowCaption = False
          Hidden = True
          LayoutDirection = ldHorizontal
          ShowBorder = False
          object lcMainItem4: TdxLayoutItem
            Caption = 'cxRadioButton1'
            ShowCaption = False
            Control = rbData
            ControlOptions.AutoColor = True
            ControlOptions.ShowBorder = False
          end
          object lcMainItem5: TdxLayoutItem
            ShowCaption = False
            Control = rbField
            ControlOptions.AutoColor = True
            ControlOptions.ShowBorder = False
          end
        end
        object lcMainItem1: TdxLayoutItem
          Caption = #26597#25214#23383#31526#65306
          Control = edtSelectStr
          ControlOptions.ShowBorder = False
        end
        object lcMainItem2: TdxLayoutItem
          AutoAligns = [aaVertical]
          AlignHorz = ahRight
          Caption = 'cxButton1'
          ShowCaption = False
          Control = cbSelectAll
          ControlOptions.ShowBorder = False
        end
        object lcMainItem3: TdxLayoutItem
          Caption = #26597#35810#32467#26524#65306
          Control = edtMessage
          ControlOptions.ShowBorder = False
        end
      end
    end
  end
  inherited lafMain: TcxLookAndFeelController
    Top = 64
  end
end
