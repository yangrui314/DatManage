object fmMain: TfmMain
  Left = 329
  Top = 64
  Width = 925
  Height = 610
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
    Height = 266
    Align = alClient
    ParentBackground = True
    TabOrder = 0
    TabStop = False
    AutoContentSizes = [acsWidth, acsHeight]
    object btnResult: TButton
      Left = 824
      Top = 126
      Width = 75
      Height = 25
      Caption = #25191#34892'SQL'
      TabOrder = 10
      OnClick = btnResultClick
    end
    object edtSQL: TcxMemo
      Left = 75
      Top = 126
      TabOrder = 9
      Height = 65
      Width = 489
    end
    object btnLoadTableName: TButton
      Left = 202
      Top = 95
      Width = 75
      Height = 25
      Caption = #21047#26032#34920#21517#31216
      TabOrder = 7
      OnClick = btnLoadTableNameClick
    end
    object edtTable: TcxComboBox
      Left = 75
      Top = 95
      Properties.ImmediatePost = True
      Properties.OnValidate = cbTablePropertiesValidate
      TabOrder = 6
      Width = 121
    end
    object cbTable: TcxRadioButton
      Left = 10
      Top = 72
      Width = 113
      Height = 17
      Caption = #34920#26684
      Checked = True
      TabOrder = 4
      TabStop = True
      OnClick = cbTableClick
    end
    object cbSQL: TcxRadioButton
      Left = 129
      Top = 72
      Width = 113
      Height = 17
      Caption = 'SQL'#26597#35810
      TabOrder = 5
      OnClick = cbSQLClick
    end
    object btnProperty: TButton
      Left = 824
      Top = 197
      Width = 75
      Height = 25
      Caption = #34920#26684#23646#24615
      TabOrder = 13
      OnClick = btnPropertyClick
    end
    object btnAdd: TButton
      Left = 10
      Top = 228
      Width = 75
      Height = 25
      Caption = #22686#21152#25968#25454
      TabOrder = 14
      OnClick = btnAddClick
    end
    object btnImportExcel: TButton
      Left = 10
      Top = 197
      Width = 75
      Height = 25
      Caption = #23548#20837
      TabOrder = 11
      OnClick = btnImportExcelClick
    end
    object btnExport: TButton
      Left = 91
      Top = 197
      Width = 75
      Height = 25
      Caption = #23548#20986
      TabOrder = 12
      OnClick = btnExportClick
    end
    object btnRefresh: TButton
      Left = 283
      Top = 95
      Width = 75
      Height = 25
      Caption = #21047#26032#20013#25991#21517
      TabOrder = 8
      OnClick = btnRefreshClick
    end
    object btnSelectPath: TcxButton
      Left = 824
      Top = 41
      Width = 75
      Height = 25
      Caption = #36873#25321
      TabOrder = 3
      OnClick = btnSelectPathClick
    end
    object edtCreatePath: TcxComboBox
      Left = 75
      Top = 41
      Properties.ImmediatePost = True
      Properties.OnValidate = edtCreatePathPropertiesValidate
      TabOrder = 2
      Width = 121
    end
    object edtPathName: TcxComboBox
      Left = 75
      Top = 10
      Properties.ImmediatePost = True
      Properties.OnValidate = edtPathNamePropertiesValidate
      TabOrder = 0
      Width = 489
    end
    object btnSavePath: TcxButton
      Left = 824
      Top = 10
      Width = 75
      Height = 25
      Caption = #20445#23384#36335#24452
      TabOrder = 1
      OnClick = btnSavePathClick
    end
    object dMainGroup_Root: TdxLayoutGroup
      ShowCaption = False
      Hidden = True
      ShowBorder = False
      object dMainGroup7: TdxLayoutGroup
        ShowCaption = False
        Hidden = True
        LayoutDirection = ldHorizontal
        ShowBorder = False
        object dMainItem4: TdxLayoutItem
          AutoAligns = [aaVertical]
          AlignHorz = ahClient
          Caption = #36335#24452#21517#31216#65306
          Control = edtPathName
          ControlOptions.ShowBorder = False
        end
        object dMainItem15: TdxLayoutItem
          ShowCaption = False
          Control = btnSavePath
          ControlOptions.ShowBorder = False
        end
      end
      object dMainGroup6: TdxLayoutGroup
        ShowCaption = False
        Hidden = True
        LayoutDirection = ldHorizontal
        ShowBorder = False
        object dMainItem14: TdxLayoutItem
          AutoAligns = [aaVertical]
          AlignHorz = ahClient
          Caption = #36335#24452':'
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
    Top = 266
    Width = 909
    Height = 286
    Align = alBottom
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
