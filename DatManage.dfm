object fmMain: TfmMain
  Left = 329
  Top = 64
  Width = 925
  Height = 610
  Color = clBtnFace
  ParentFont = True
  Menu = MainMenu
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object dMain: TdxLayoutControl
    Left = 0
    Top = 0
    Width = 909
    Height = 248
    Align = alClient
    ParentBackground = True
    TabOrder = 0
    TabStop = False
    AutoContentSizes = [acsWidth, acsHeight]
    object cbTable: TcxRadioButton
      Left = 10
      Top = 103
      Width = 113
      Height = 17
      Caption = #34920#26684
      Checked = True
      TabOrder = 9
      TabStop = True
      OnClick = cbTableClick
    end
    object cbSQL: TcxRadioButton
      Left = 129
      Top = 103
      Width = 113
      Height = 17
      Caption = 'SQL'#26597#35810
      TabOrder = 10
      OnClick = cbSQLClick
    end
    object btnSelectPath: TcxButton
      Left = 824
      Top = 41
      Width = 75
      Height = 25
      Caption = #36873#25321
      TabOrder = 3
      OnClick = btnSelectPathClick
      LookAndFeel.Kind = lfOffice11
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
      LookAndFeel.Kind = lfOffice11
    end
    object btnProperty: TcxButton
      Left = 824
      Top = 72
      Width = 75
      Height = 25
      Caption = #34920#26684#23646#24615
      TabOrder = 8
      OnClick = btnPropertyClick
      LookAndFeel.Kind = lfOffice11
    end
    object btnExport: TcxButton
      Left = 91
      Top = 72
      Width = 75
      Height = 25
      Caption = #23548#20986
      TabOrder = 5
      OnClick = btnExportClick
      LookAndFeel.Kind = lfOffice11
    end
    object btnImportExcel: TcxButton
      Left = 10
      Top = 72
      Width = 75
      Height = 25
      Caption = #23548#20837
      TabOrder = 4
      OnClick = btnImportExcelClick
      LookAndFeel.Kind = lfOffice11
    end
    object btnAdd: TcxButton
      Left = 172
      Top = 72
      Width = 75
      Height = 25
      Caption = #22686#21152#25968#25454
      TabOrder = 6
      OnClick = btnAddClick
      LookAndFeel.Kind = lfOffice11
    end
    object cxButton1: TcxButton
      Left = 253
      Top = 72
      Width = 75
      Height = 25
      Caption = #27979#35797
      TabOrder = 7
      LookAndFeel.Kind = lfOffice11
    end
    object PageSelect: TcxPageControl
      Left = 10
      Top = 126
      Width = 889
      Height = 99
      ActivePage = SheetSQL
      HideTabs = True
      ParentShowHint = False
      ShowHint = False
      TabOrder = 11
      ClientRectBottom = 99
      ClientRectRight = 889
      ClientRectTop = 0
      object SheetTable: TcxTabSheet
        Caption = 'SheetTable'
        ImageIndex = 0
        object lcTable: TdxLayoutControl
          Left = 0
          Top = 0
          Width = 889
          Height = 99
          Align = alClient
          TabOrder = 0
          TabStop = False
          object edtTable: TcxComboBox
            Left = 63
            Top = 10
            Properties.ImmediatePost = True
            Properties.OnValidate = cxComboBox1PropertiesValidate
            TabOrder = 0
            Width = 121
          end
          object edtCondition: TcxMemo
            Left = 63
            Top = 37
            Align = alClient
            TabOrder = 1
            Height = 40
            Width = 726
          end
          object btnCondition: TcxButton
            Left = 795
            Top = 37
            Width = 75
            Height = 25
            Caption = #36807#28388
            TabOrder = 2
            OnClick = btnConditionClick
            LookAndFeel.Kind = lfOffice11
          end
          object lcTableGroup_Root: TdxLayoutGroup
            ShowCaption = False
            Hidden = True
            ShowBorder = False
            object lcTableItem1: TdxLayoutItem
              Caption = #34920#26684#21517#31216
              Control = edtTable
              ControlOptions.ShowBorder = False
            end
            object lcTableGroup1: TdxLayoutGroup
              ShowCaption = False
              Hidden = True
              LayoutDirection = ldHorizontal
              ShowBorder = False
              object lcTableItem2: TdxLayoutItem
                Caption = #26465#20214#65306
                Control = edtCondition
                ControlOptions.ShowBorder = False
              end
              object lcTableItem3: TdxLayoutItem
                Caption = 'cxButton2'
                ShowCaption = False
                Control = btnCondition
                ControlOptions.ShowBorder = False
              end
            end
          end
        end
      end
      object SheetSQL: TcxTabSheet
        Caption = 'SheetSQL'
        ImageIndex = 1
        object lcSQL: TdxLayoutControl
          Left = 0
          Top = 0
          Width = 889
          Height = 99
          Align = alClient
          TabOrder = 0
          TabStop = False
          object edtSQL: TcxMemo
            Left = 51
            Top = 10
            Align = alClient
            TabOrder = 0
            Height = 65
            Width = 726
          end
          object btnResult: TcxButton
            Left = 783
            Top = 10
            Width = 75
            Height = 25
            Caption = #25191#34892'SQL'
            TabOrder = 1
            OnClick = btnResultClick
            LookAndFeel.Kind = lfOffice11
          end
          object dxLayoutGroup1: TdxLayoutGroup
            ShowCaption = False
            Hidden = True
            LayoutDirection = ldHorizontal
            ShowBorder = False
            object lcSQLItem1: TdxLayoutItem
              AutoAligns = [aaVertical]
              AlignHorz = ahClient
              Caption = #26597#35810#65306
              Control = edtSQL
              ControlOptions.ShowBorder = False
            end
            object lcSQLItem2: TdxLayoutItem
              ShowCaption = False
              Control = btnResult
              ControlOptions.ShowBorder = False
            end
          end
        end
      end
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
        ShowBorder = False
        object dMainGroup3: TdxLayoutGroup
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
            object dMainItem17: TdxLayoutItem
              ShowCaption = False
              Control = btnImportExcel
              ControlOptions.ShowBorder = False
            end
            object dMainItem1: TdxLayoutItem
              ShowCaption = False
              Control = btnExport
              ControlOptions.ShowBorder = False
            end
            object dMainItem11: TdxLayoutItem
              AutoAligns = [aaVertical]
              ShowCaption = False
              Control = btnAdd
              ControlOptions.ShowBorder = False
            end
            object dMainItem9: TdxLayoutItem
              ShowCaption = False
              Control = cxButton1
              ControlOptions.ShowBorder = False
            end
            object dMainItem2: TdxLayoutItem
              AutoAligns = [aaVertical]
              AlignHorz = ahRight
              ShowCaption = False
              Control = btnProperty
              ControlOptions.ShowBorder = False
            end
          end
          object dMainGroup5: TdxLayoutGroup
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
        end
        object dMainItem8: TdxLayoutItem
          Caption = #33719#21462#25968#25454#19981#21516#26041#24335
          ShowCaption = False
          Control = PageSelect
          ControlOptions.AutoColor = True
          ControlOptions.ShowBorder = False
        end
      end
    end
  end
  object pnlResult: TPanel
    Left = 0
    Top = 248
    Width = 909
    Height = 304
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
    object MenuSet: TMenuItem
      Caption = #35774#32622
      OnClick = MenuSetClick
    end
  end
end
