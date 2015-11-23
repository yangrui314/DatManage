inherited fmSelectAll: TfmSelectAll
  Left = 400
  Top = 318
  Width = 348
  Height = 215
  Caption = 'fmSelectAll'
  Position = poDefault
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnlMain: TPanel [0]
    Left = 0
    Top = 0
    Width = 332
    Height = 177
    Align = alClient
    Caption = 'pnlMain'
    TabOrder = 0
    object lcMain: TdxLayoutControl
      Left = 1
      Top = 1
      Width = 330
      Height = 175
      Align = alClient
      TabOrder = 0
      TabStop = False
      AutoContentSizes = [acsWidth, acsHeight]
      object edtSelectStr: TcxTextEdit
        Left = 75
        Top = 10
        TabOrder = 0
        Width = 121
      end
      object cbSelectAll: TcxButton
        Left = 245
        Top = 37
        Width = 75
        Height = 25
        Caption = #26597#25214
        TabOrder = 1
        OnClick = cbSelectAllClick
      end
      object edtMessage: TcxMemo
        Left = 75
        Top = 68
        TabOrder = 2
        Height = 89
        Width = 185
      end
      object lcMainGroup_Root: TdxLayoutGroup
        ShowCaption = False
        Hidden = True
        ShowBorder = False
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
end
