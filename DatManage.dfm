object fmMain: TfmMain
  Left = 268
  Top = 88
  Width = 925
  Height = 642
  Caption = 'fmMain'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object dMain: TdxLayoutControl
    Left = 0
    Top = 0
    Width = 909
    Height = 225
    Align = alTop
    ParentBackground = True
    TabOrder = 0
    TabStop = False
    object btnResult: TButton
      Left = 778
      Top = 122
      Width = 75
      Height = 25
      Caption = #26174#31034#32467#26524
      TabOrder = 8
      OnClick = btnResultClick
    end
    object edtCreatePath: TcxButtonEdit
      Left = 63
      Top = 10
      Properties.Buttons = <
        item
          Default = True
          Kind = bkEllipsis
        end>
      Properties.OnButtonClick = btnCreatePathPropertiesButtonClick
      Properties.OnValidate = edtCreatePathPropertiesValidate
      Style.BorderColor = clWindowFrame
      Style.BorderStyle = ebs3D
      Style.HotTrack = False
      Style.LookAndFeel.SkinName = ''
      Style.ButtonStyle = bts3D
      StyleDisabled.LookAndFeel.SkinName = ''
      StyleFocused.LookAndFeel.SkinName = ''
      StyleHot.LookAndFeel.SkinName = ''
      TabOrder = 0
      Width = 790
    end
    object edtSQL: TcxMemo
      Left = 63
      Top = 91
      TabOrder = 6
      Height = 65
      Width = 489
    end
    object btnLoadTableName: TButton
      Left = 190
      Top = 60
      Width = 75
      Height = 25
      Caption = #21047#26032#34920#21517#31216
      TabOrder = 4
      OnClick = btnLoadTableNameClick
    end
    object btnImport: TButton
      Left = 778
      Top = 91
      Width = 50
      Height = 25
      Caption = #23548#20837#25991#20214
      TabOrder = 7
      OnClick = btnImportClick
    end
    object edtTable: TcxComboBox
      Left = 63
      Top = 60
      Properties.ImmediatePost = True
      Properties.OnValidate = cbTablePropertiesValidate
      TabOrder = 3
      Width = 121
    end
    object cbTable: TcxRadioButton
      Left = 10
      Top = 37
      Width = 113
      Height = 17
      Caption = #34920#26684
      Checked = True
      TabOrder = 1
      TabStop = True
      OnClick = cbTableClick
    end
    object cbSQL: TcxRadioButton
      Left = 129
      Top = 37
      Width = 113
      Height = 17
      Caption = 'SQL'#26597#35810
      TabOrder = 2
      OnClick = cbSQLClick
    end
    object btnProperty: TButton
      Left = 778
      Top = 162
      Width = 75
      Height = 25
      Caption = #34920#26684#23646#24615
      TabOrder = 13
      OnClick = btnPropertyClick
    end
    object btnAdd: TButton
      Left = 10
      Top = 162
      Width = 75
      Height = 25
      Caption = #22686#21152#25968#25454
      TabOrder = 9
      OnClick = btnAddClick
    end
    object btnImportExcel: TButton
      Left = 91
      Top = 162
      Width = 75
      Height = 25
      Caption = #23548#20837'Excel'
      TabOrder = 10
      OnClick = btnImportExcelClick
    end
    object btnExport: TButton
      Left = 172
      Top = 162
      Width = 75
      Height = 25
      Caption = #23548#20986
      TabOrder = 11
      OnClick = btnExportClick
    end
    object btnRefresh: TButton
      Left = 271
      Top = 60
      Width = 75
      Height = 25
      Caption = #21047#26032#20013#25991#21517
      TabOrder = 5
      OnClick = btnRefreshClick
    end
    object btnTest: TButton
      Left = 253
      Top = 162
      Width = 75
      Height = 25
      Caption = #27979#35797
      TabOrder = 12
    end
    object dMainGroup_Root: TdxLayoutGroup
      ShowCaption = False
      Hidden = True
      ShowBorder = False
      object dMainItem4: TdxLayoutItem
        Caption = #36335#24452#65306
        Control = edtCreatePath
        ControlOptions.ShowBorder = False
      end
      object dMainGroup2: TdxLayoutGroup
        ShowCaption = False
        Hidden = True
        ShowBorder = False
        object dMainGroup4: TdxLayoutGroup
          ShowCaption = False
          Hidden = True
          LayoutDirection = ldHorizontal
          ShowBorder = False
          object dMainItem3: TdxLayoutItem
            Caption = 'cxRadioButton1'
            ShowCaption = False
            Control = cbTable
            ControlOptions.AutoColor = True
            ControlOptions.ShowBorder = False
          end
          object dMainItem6: TdxLayoutItem
            ShowCaption = False
            Control = cbSQL
            ControlOptions.AutoColor = True
            ControlOptions.ShowBorder = False
          end
        end
        object dMainGroup3: TdxLayoutGroup
          ShowCaption = False
          Hidden = True
          LayoutDirection = ldHorizontal
          ShowBorder = False
          object dMainItem7: TdxLayoutItem
            Caption = #34920#26684#21517#31216
            Control = edtTable
            ControlOptions.ShowBorder = False
          end
          object dMainItem9: TdxLayoutItem
            ShowCaption = False
            Control = btnLoadTableName
            ControlOptions.ShowBorder = False
          end
          object dMainItem12: TdxLayoutItem
            ShowCaption = False
            Control = btnRefresh
            ControlOptions.ShowBorder = False
          end
        end
      end
      object dMainGroup1: TdxLayoutGroup
        ShowCaption = False
        Hidden = True
        ShowBorder = False
        object dMainGroup9: TdxLayoutGroup
          ShowCaption = False
          Hidden = True
          LayoutDirection = ldHorizontal
          ShowBorder = False
          object dMainItem5: TdxLayoutItem
            AutoAligns = [aaVertical]
            AlignHorz = ahClient
            Caption = #26597#35810#65306
            Control = edtSQL
            ControlOptions.ShowBorder = False
          end
          object dMainGroup5: TdxLayoutGroup
            ShowCaption = False
            Hidden = True
            ShowBorder = False
            object dMainItem10: TdxLayoutItem
              AutoAligns = [aaVertical]
              AlignHorz = ahClient
              ShowCaption = False
              Control = btnImport
              ControlOptions.ShowBorder = False
            end
            object dMainItem2: TdxLayoutItem
              AutoAligns = [aaVertical]
              ShowCaption = False
              Control = btnResult
              ControlOptions.ShowBorder = False
            end
          end
        end
        object dMainGroup8: TdxLayoutGroup
          ShowCaption = False
          Hidden = True
          LayoutDirection = ldHorizontal
          ShowBorder = False
          object dMainItem8: TdxLayoutItem
            ShowCaption = False
            Control = btnAdd
            ControlOptions.ShowBorder = False
          end
          object dMainItem11: TdxLayoutItem
            ShowCaption = False
            Control = btnImportExcel
            ControlOptions.ShowBorder = False
          end
          object dMainItem13: TdxLayoutItem
            ShowCaption = False
            Control = btnExport
            ControlOptions.ShowBorder = False
          end
          object dMainItem14: TdxLayoutItem
            ShowCaption = False
            Control = btnTest
            ControlOptions.ShowBorder = False
          end
          object dMainItem1: TdxLayoutItem
            AutoAligns = [aaVertical]
            AlignHorz = ahRight
            ShowCaption = False
            Control = btnProperty
            ControlOptions.ShowBorder = False
          end
        end
      end
    end
  end
  object pnlResult: TPanel
    Left = 0
    Top = 225
    Width = 909
    Height = 379
    Align = alClient
    Caption = 'pnlResult'
    ParentBackground = True
    TabOrder = 1
  end
  object dlgOpen: TOpenDialog
    Left = 408
    Top = 40
  end
  object dlgSave: TSaveDialog
    Left = 448
    Top = 40
  end
end
