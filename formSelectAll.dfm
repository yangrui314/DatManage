inherited fmSelectAll: TfmSelectAll
  Left = 489
  Top = 194
  Width = 526
  Height = 135
  Caption = 'fmSelectAll'
  Position = poDefault
  PixelsPerInch = 96
  TextHeight = 13
  object pnlMain: TPanel
    Left = 0
    Top = 0
    Width = 510
    Height = 97
    Align = alClient
    Caption = 'pnlMain'
    TabOrder = 0
    object lcMain: TdxLayoutControl
      Left = 1
      Top = 1
      Width = 508
      Height = 95
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
        Left = 423
        Top = 37
        Width = 75
        Height = 25
        Caption = #26597#25214
        TabOrder = 1
        OnClick = cbSelectAllClick
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
      end
    end
  end
end