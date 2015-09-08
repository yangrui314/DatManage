object fmMain: TfmMain
  Left = 329
  Top = 89
  Width = 925
  Height = 664
  Color = clBtnFace
  ParentFont = True
  Menu = MainMenu
  OldCreateOrder = False
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object dMain: TdxLayoutControl
    Left = 0
    Top = 0
    Width = 909
    Height = 289
    Align = alTop
    ParentBackground = True
    TabOrder = 0
    TabStop = False
    object btnResult: TButton
      Left = 558
      Top = 95
      Width = 75
      Height = 25
      Caption = #25191#34892'SQL'
      TabOrder = 8
      OnClick = btnResultClick
    end
    object edtSQL: TcxMemo
      Left = 63
      Top = 95
      TabOrder = 7
      Height = 65
      Width = 489
    end
    object btnLoadTableName: TButton
      Left = 190
      Top = 64
      Width = 75
      Height = 25
      Caption = #21047#26032#34920#21517#31216
      TabOrder = 5
      OnClick = btnLoadTableNameClick
    end
    object edtTable: TcxComboBox
      Left = 63
      Top = 64
      Properties.ImmediatePost = True
      Properties.OnValidate = cbTablePropertiesValidate
      TabOrder = 4
      Width = 121
    end
    object cbTable: TcxRadioButton
      Left = 10
      Top = 41
      Width = 113
      Height = 17
      Caption = #34920#26684
      Checked = True
      TabOrder = 2
      TabStop = True
      OnClick = cbTableClick
    end
    object cbSQL: TcxRadioButton
      Left = 129
      Top = 41
      Width = 113
      Height = 17
      Caption = 'SQL'#26597#35810
      TabOrder = 3
      OnClick = cbSQLClick
    end
    object btnProperty: TButton
      Left = 558
      Top = 166
      Width = 75
      Height = 25
      Caption = #34920#26684#23646#24615
      TabOrder = 11
      OnClick = btnPropertyClick
    end
    object btnAdd: TButton
      Left = 10
      Top = 197
      Width = 75
      Height = 25
      Caption = #22686#21152#25968#25454
      TabOrder = 12
      OnClick = btnAddClick
    end
    object btnImportExcel: TButton
      Left = 10
      Top = 166
      Width = 75
      Height = 25
      Caption = #23548#20837
      TabOrder = 9
      OnClick = btnImportExcelClick
    end
    object btnExport: TButton
      Left = 91
      Top = 166
      Width = 75
      Height = 25
      Caption = #23548#20986
      TabOrder = 10
      OnClick = btnExportClick
    end
    object btnRefresh: TButton
      Left = 271
      Top = 64
      Width = 75
      Height = 25
      Caption = #21047#26032#20013#25991#21517
      TabOrder = 6
      OnClick = btnRefreshClick
    end
    object btnSelectPath: TcxButton
      Left = 558
      Top = 10
      Width = 75
      Height = 25
      Caption = #36873#25321
      TabOrder = 1
      OnClick = btnSelectPathClick
    end
    object edtCreatePath: TcxComboBox
      Left = 63
      Top = 10
      Properties.OnValidate = cxComboBox1PropertiesValidate
      TabOrder = 0
      Width = 121
    end
    object dMainGroup_Root: TdxLayoutGroup
      ShowCaption = False
      Hidden = True
      ShowBorder = False
      object dMainGroup6: TdxLayoutGroup
        ShowCaption = False
        Hidden = True
        LayoutDirection = ldHorizontal
        ShowBorder = False
        object dMainItem14: TdxLayoutItem
          AutoAligns = [aaVertical]
          AlignHorz = ahClient
          Caption = #36335#24452
          Control = edtCreatePath
          ControlOptions.ShowBorder = False
        end
        object dMainItem10: TdxLayoutItem
          Caption = 'cxButton1'
          ShowCaption = False
          Control = btnSelectPath
          ControlOptions.ShowBorder = False
        end
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
          object dMainItem2: TdxLayoutItem
            AutoAligns = [aaVertical]
            ShowCaption = False
            Control = btnResult
            ControlOptions.ShowBorder = False
          end
        end
        object dMainGroup8: TdxLayoutGroup
          ShowCaption = False
          Hidden = True
          ShowBorder = False
          object dMainGroup5: TdxLayoutGroup
            ShowCaption = False
            Hidden = True
            LayoutDirection = ldHorizontal
            ShowBorder = False
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
            object dMainItem1: TdxLayoutItem
              AutoAligns = [aaVertical]
              AlignHorz = ahRight
              ShowCaption = False
              Control = btnProperty
              ControlOptions.ShowBorder = False
            end
          end
          object dMainItem8: TdxLayoutItem
            AutoAligns = [aaVertical]
            ShowCaption = False
            Control = btnAdd
            ControlOptions.ShowBorder = False
          end
        end
      end
    end
  end
  object pnlResult: TPanel
    Left = 0
    Top = 289
    Width = 909
    Height = 317
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
    Left = 464
    Top = 40
  end
  object MainMenu: TMainMenu
    Left = 520
    Top = 40
    object MenuAbout: TMenuItem
      Caption = #20851#20110
      OnClick = MenuAboutClick
    end
  end
end
