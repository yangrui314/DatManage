object fmInsert: TfmInsert
  Left = 265
  Top = 160
  Width = 675
  Height = 439
  Caption = 'fmInsert'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object gridInsert: TcxVerticalGrid
    Left = 0
    Top = 0
    Width = 659
    Height = 352
    Align = alClient
    TabOrder = 0
  end
  object pnlButton: TPanel
    Left = 0
    Top = 352
    Width = 659
    Height = 49
    Align = alBottom
    Caption = 'pnlButton'
    TabOrder = 1
    object lcButton: TdxLayoutControl
      Left = 1
      Top = 1
      Width = 657
      Height = 47
      Align = alClient
      TabOrder = 0
      TabStop = False
      AutoContentSizes = [acsWidth, acsHeight]
      object btnOk: TcxButton
        Left = 491
        Top = 10
        Width = 75
        Height = 25
        Caption = #30830#23450
        TabOrder = 0
        OnClick = btnOkClick
      end
      object btnCancel: TcxButton
        Left = 572
        Top = 10
        Width = 75
        Height = 25
        Caption = #21462#28040
        TabOrder = 1
        OnClick = btnCancelClick
      end
      object lcButtonGroup_Root: TdxLayoutGroup
        AutoAligns = [aaVertical]
        AlignHorz = ahCenter
        ShowCaption = False
        Hidden = True
        LayoutDirection = ldHorizontal
        ShowBorder = False
        object lcButtonItem1: TdxLayoutItem
          AutoAligns = [aaVertical]
          AlignHorz = ahRight
          Caption = 'cxButton1'
          ShowCaption = False
          Control = btnOk
          ControlOptions.ShowBorder = False
        end
        object lcButtonItem2: TdxLayoutItem
          AutoAligns = [aaVertical]
          AlignHorz = ahRight
          ShowCaption = False
          Control = btnCancel
          ControlOptions.ShowBorder = False
        end
      end
    end
  end
end
