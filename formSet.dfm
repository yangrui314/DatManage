object fmSet: TfmSet
  Left = 416
  Top = 309
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #35774#32622
  ClientHeight = 166
  ClientWidth = 246
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlSet: TPanel
    Left = 0
    Top = 0
    Width = 246
    Height = 166
    Align = alClient
    Caption = 'pnlSet'
    TabOrder = 0
    object lcMain: TdxLayoutControl
      Left = 1
      Top = 1
      Width = 244
      Height = 164
      Align = alClient
      TabOrder = 0
      TabStop = False
      AutoContentSizes = [acsWidth, acsHeight]
      object btnOK: TcxButton
        Left = 159
        Top = 129
        Width = 75
        Height = 25
        Caption = #30830#23450
        TabOrder = 2
        OnClick = btnOKClick
      end
      object cbShowName: TcxCheckBox
        Left = 10
        Top = 10
        Caption = #26174#31034#21517#31216
        Properties.ImmediatePost = True
        TabOrder = 0
        Transparent = True
        OnClick = cbShowNameClick
        Width = 121
      end
      object cbShowPath: TcxCheckBox
        Left = 10
        Top = 37
        Caption = #26174#31034#36335#24452
        Properties.ImmediatePost = True
        TabOrder = 1
        Transparent = True
        OnClick = cbShowPathClick
        Width = 121
      end
      object lcMainGroup_Root: TdxLayoutGroup
        AutoAligns = [aaVertical]
        ShowCaption = False
        Hidden = True
        LayoutDirection = ldHorizontal
        ShowBorder = False
        object lcMainGroup1: TdxLayoutGroup
          ShowCaption = False
          Hidden = True
          ShowBorder = False
          object lcMainItem1: TdxLayoutItem
            Caption = 'cxCheckBox1'
            ShowCaption = False
            Control = cbShowName
            ControlOptions.ShowBorder = False
          end
          object lcMainItem2: TdxLayoutItem
            ShowCaption = False
            Control = cbShowPath
            ControlOptions.ShowBorder = False
          end
        end
        object lcMainItem3: TdxLayoutItem
          AutoAligns = []
          AlignHorz = ahRight
          AlignVert = avBottom
          ShowCaption = False
          Control = btnOK
          ControlOptions.ShowBorder = False
        end
      end
    end
  end
end
