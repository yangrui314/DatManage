object fmSet: TfmSet
  Left = 416
  Top = 309
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #35774#32622
  ClientHeight = 190
  ClientWidth = 274
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
    Width = 274
    Height = 190
    Align = alClient
    Caption = 'pnlSet'
    TabOrder = 0
    object Page: TcxPageControl
      Left = 1
      Top = 1
      Width = 272
      Height = 137
      ActivePage = SheetConnect
      Align = alClient
      TabOrder = 0
      ClientRectBottom = 137
      ClientRectRight = 272
      ClientRectTop = 24
      object SheetShow: TcxTabSheet
        Caption = #26174#31034
        ImageIndex = 0
        object lcMain: TdxLayoutControl
          Left = 0
          Top = 0
          Width = 272
          Height = 113
          Align = alClient
          TabOrder = 0
          TabStop = False
          AutoContentSizes = [acsWidth, acsHeight]
          object cbShowName: TcxCheckBox
            Left = 22
            Top = 28
            Caption = #21517#31216
            Properties.ImmediatePost = True
            TabOrder = 0
            Transparent = True
            OnClick = cbShowNameClick
            Width = 121
          end
          object cbShowPath: TcxCheckBox
            Left = 22
            Top = 55
            Caption = #29615#22659
            Properties.ImmediatePost = True
            TabOrder = 1
            Transparent = True
            OnClick = cbShowPathClick
            Width = 121
          end
          object dxLayoutGroup1: TdxLayoutGroup
            AutoAligns = [aaVertical]
            ShowCaption = False
            Hidden = True
            ShowBorder = False
            object lcMainGroup1: TdxLayoutGroup
              Caption = #26174#31034#36335#24452#65306
              object dxLayoutItem1: TdxLayoutItem
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
          end
        end
      end
      object SheetSelect: TcxTabSheet
        Caption = #26597#35810
        ImageIndex = 1
        object lcSelect: TdxLayoutControl
          Left = 0
          Top = 0
          Width = 272
          Height = 113
          Align = alClient
          TabOrder = 0
          TabStop = False
          AutoContentSizes = [acsWidth, acsHeight]
          object rbSelectCaption: TcxRadioButton
            Left = 22
            Top = 51
            Width = 80
            Height = 17
            Caption = #20013#25991#21517
            TabOrder = 1
            OnClick = rbSelectCaptionClick
            Transparent = True
          end
          object rbSelectField: TcxRadioButton
            Left = 22
            Top = 28
            Width = 113
            Height = 17
            Caption = #23383#27573
            TabOrder = 0
            OnClick = rbSelectFieldClick
            Transparent = True
          end
          object dxLayoutGroup3: TdxLayoutGroup
            AutoAligns = [aaVertical]
            ShowCaption = False
            Hidden = True
            ShowBorder = False
            object lcSelectGroup1: TdxLayoutGroup
              Caption = #26597#35810#26174#31034#26041#24335#65306
              object lcSelectItem2: TdxLayoutItem
                ShowCaption = False
                Control = rbSelectField
                ControlOptions.AutoColor = True
                ControlOptions.ShowBorder = False
              end
              object lcSelectItem1: TdxLayoutItem
                AutoAligns = [aaVertical]
                AlignHorz = ahClient
                Caption = 'cxRadioButton1'
                ShowCaption = False
                Control = rbSelectCaption
                ControlOptions.AutoColor = True
                ControlOptions.ShowBorder = False
              end
            end
          end
        end
      end
      object SheetConnect: TcxTabSheet
        Caption = #25968#25454#24211
        ImageIndex = 2
        object lcConnect: TdxLayoutControl
          Left = 0
          Top = 0
          Width = 272
          Height = 113
          Align = alClient
          TabOrder = 0
          TabStop = False
          AutoContentSizes = [acsWidth, acsHeight]
          object rbDBISAM: TcxRadioButton
            Left = 10
            Top = 10
            Width = 80
            Height = 17
            Caption = 'DBISAM'#25968#25454#24211
            TabOrder = 0
            OnClick = rbDBISAMClick
            Transparent = True
          end
          object rbSQLSERVER: TcxRadioButton
            Left = 10
            Top = 33
            Width = 113
            Height = 17
            Caption = 'SQLSERVER'#25968#25454#24211
            TabOrder = 1
            OnClick = rbSQLSERVERClick
            Transparent = True
          end
          object dxLayoutGroup2: TdxLayoutGroup
            AutoAligns = [aaVertical]
            ShowCaption = False
            Hidden = True
            ShowBorder = False
            object dxLayoutItem3: TdxLayoutItem
              AutoAligns = [aaVertical]
              AlignHorz = ahClient
              Caption = 'cxRadioButton1'
              ShowCaption = False
              Control = rbDBISAM
              ControlOptions.AutoColor = True
              ControlOptions.ShowBorder = False
            end
            object dxLayoutItem2: TdxLayoutItem
              ShowCaption = False
              Control = rbSQLSERVER
              ControlOptions.AutoColor = True
              ControlOptions.ShowBorder = False
            end
          end
        end
      end
    end
    object pnlOK: TPanel
      Left = 1
      Top = 138
      Width = 272
      Height = 51
      Align = alBottom
      Caption = 'pnlOK'
      TabOrder = 1
      object lcOK: TdxLayoutControl
        Left = 1
        Top = 1
        Width = 270
        Height = 49
        Align = alClient
        TabOrder = 0
        TabStop = False
        AutoContentSizes = [acsWidth, acsHeight]
        object cxButton2: TcxButton
          Left = 185
          Top = 14
          Width = 75
          Height = 25
          Caption = #30830#23450
          TabOrder = 0
          OnClick = btnOKClick
        end
        object dxLayoutGroup4: TdxLayoutGroup
          AutoAligns = [aaVertical]
          ShowCaption = False
          Hidden = True
          LayoutDirection = ldHorizontal
          ShowBorder = False
          object dxLayoutItem5: TdxLayoutItem
            AutoAligns = []
            AlignHorz = ahRight
            AlignVert = avBottom
            ShowCaption = False
            Control = cxButton2
            ControlOptions.ShowBorder = False
          end
        end
      end
    end
  end
end
