object fmMain: TfmMain
  Left = 186
  Top = 124
  Width = 925
  Height = 629
  Color = clBtnFace
  ParentFont = True
  Menu = MainMenu
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlResult: TPanel
    Left = 0
    Top = 273
    Width = 909
    Height = 298
    Align = alClient
    Caption = 'pnlResult'
    ParentBackground = True
    TabOrder = 0
  end
  object pnlCondition: TPanel
    Left = 0
    Top = 0
    Width = 909
    Height = 273
    Align = alTop
    Caption = 'pnlCondition'
    ParentBackground = True
    TabOrder = 5
    object dMain: TdxLayoutControl
      Left = 1
      Top = 1
      Width = 907
      Height = 271
      Align = alClient
      ParentBackground = True
      TabOrder = 0
      TabStop = False
      AutoContentSizes = [acsWidth, acsHeight]
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
        Transparent = True
      end
      object cbSQL: TcxRadioButton
        Left = 129
        Top = 72
        Width = 113
        Height = 17
        Caption = 'SQL'#26597#35810
        TabOrder = 5
        OnClick = cbSQLClick
        Transparent = True
      end
      object btnSelectPath: TcxButton
        Left = 822
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
        Left = 822
        Top = 10
        Width = 75
        Height = 25
        Caption = #20445#23384#36335#24452
        TabOrder = 1
        OnClick = btnSavePathClick
        LookAndFeel.Kind = lfOffice11
      end
      object PageSelect: TcxPageControl
        Left = 10
        Top = 95
        Width = 887
        Height = 120
        ActivePage = SheetTable
        HideTabs = True
        ParentShowHint = False
        ShowHint = False
        TabOrder = 6
        ClientRectBottom = 120
        ClientRectRight = 887
        ClientRectTop = 0
        object SheetTable: TcxTabSheet
          Caption = 'SheetTable'
          ImageIndex = 0
          object lcTable: TdxLayoutControl
            Left = 0
            Top = 0
            Width = 887
            Height = 120
            Align = alClient
            ParentBackground = True
            TabOrder = 0
            TabStop = False
            AutoContentSizes = [acsWidth, acsHeight]
            object edtTable: TcxComboBox
              Left = 63
              Top = 10
              Properties.ImmediatePost = True
              Properties.OnValidate = edtTablePropertiesValidate
              TabOrder = 0
              Width = 121
            end
            object edtCondition: TcxMemo
              Left = 63
              Top = 37
              Align = alClient
              TabOrder = 3
              Height = 31
              Width = 549
            end
            object edtFieldName: TcxComboBox
              Left = 243
              Top = 10
              Properties.ImmediatePost = True
              TabOrder = 1
              Width = 121
            end
            object edtKeyword: TcxComboBox
              Left = 435
              Top = 10
              Properties.ImmediatePost = True
              TabOrder = 2
              Width = 814
            end
            object dxLayoutGroup1: TdxLayoutGroup
              AutoAligns = [aaVertical]
              AlignHorz = ahClient
              ShowCaption = False
              Hidden = True
              ShowBorder = False
              object lcTableGroup1: TdxLayoutGroup
                ShowCaption = False
                Hidden = True
                LayoutDirection = ldHorizontal
                ShowBorder = False
                object dxLayoutItem1: TdxLayoutItem
                  Caption = #34920#26684#21517#31216
                  Control = edtTable
                  ControlOptions.ShowBorder = False
                end
                object lcTableItem1: TdxLayoutItem
                  Caption = #36807#28388#23383#27573
                  Control = edtFieldName
                  ControlOptions.ShowBorder = False
                end
                object lcTableItem3: TdxLayoutItem
                  AutoAligns = [aaVertical]
                  AlignHorz = ahClient
                  Caption = #20851#38190#23383#27573#65306
                  Control = edtKeyword
                  ControlOptions.ShowBorder = False
                end
              end
              object lcTableItem2: TdxLayoutItem
                AutoAligns = [aaVertical]
                AlignHorz = ahClient
                Caption = #20540#65306
                Control = edtCondition
                ControlOptions.ShowBorder = False
              end
            end
          end
        end
        object SheetSQL: TcxTabSheet
          Caption = 'SheetSQL'
          ImageIndex = 1
          object edtSQL: TcxMemo
            Left = 0
            Top = 0
            Align = alClient
            TabOrder = 0
            Height = 120
            Width = 887
          end
        end
      end
      object dockChange: TdxBarDockControl
        Left = 10
        Top = 221
        Width = 887
        Height = 27
        Align = dalNone
        BarManager = BarManager
      end
      object dxLayoutGroup2: TdxLayoutGroup
        ShowCaption = False
        Hidden = True
        ShowBorder = False
        object dMainGroup3: TdxLayoutGroup
          ShowCaption = False
          Hidden = True
          ShowBorder = False
          object dMainGroup4: TdxLayoutGroup
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
          object dMainGroup1: TdxLayoutGroup
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
        end
        object dMainGroup2: TdxLayoutGroup
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
        object dMainItem8: TdxLayoutItem
          Caption = #33719#21462#25968#25454#19981#21516#26041#24335
          ShowCaption = False
          Control = PageSelect
          ControlOptions.AutoColor = True
          ControlOptions.ShowBorder = False
        end
        object dMainItem5: TdxLayoutItem
          Caption = 'dxBarDockControl1'
          ShowCaption = False
          Control = dockChange
          ControlOptions.AutoColor = True
          ControlOptions.ShowBorder = False
        end
      end
    end
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
    object MenuSet: TMenuItem
      Caption = #35774#32622
      OnClick = MenuSetClick
    end
    object MenuAbout: TMenuItem
      Caption = #20851#20110
      OnClick = MenuAboutClick
    end
    object MenuSupply: TMenuItem
      Caption = #36741#21161#39033
      object N4: TMenuItem
        Caption = #25171#24320#37197#32622#30446#24405
        OnClick = N4Click
      end
      object N1: TMenuItem
        Caption = #25171#24320#30446#24405
        OnClick = N1Click
      end
      object N2: TMenuItem
        Caption = #25171#24320#34920
        OnClick = N2Click
      end
      object N3: TMenuItem
        Caption = 'SVN'#26356#26032#30446#24405
        OnClick = N3Click
      end
      object N6: TMenuItem
        Caption = 'SVN'#25552#20132#30446#24405
        OnClick = N6Click
      end
    end
    object MenuSVN: TMenuItem
      Caption = 'SVN'#20351#29992
      OnClick = MenuSVNClick
    end
    object MenuDiff: TMenuItem
      Caption = #23545#27604
      OnClick = MenuDiffClick
    end
    object MenuSelectAll: TMenuItem
      Caption = #26597#35810#25152#26377#34920
      OnClick = MenuSelectAllClick
    end
  end
  object BarManager: TdxBarManager
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = #24494#36719#38597#40657
    Font.Style = []
    Categories.Strings = (
      'Default')
    Categories.ItemsVisibles = (
      2)
    Categories.Visibles = (
      True)
    PopupMenuLinks = <>
    UseSystemFont = True
    Left = 568
    Top = 40
    DockControlHeights = (
      0
      0
      0
      0)
    object BarManagerBar1: TdxBar
      Caption = 'Custom 1'
      CaptionButtons = <>
      DockControl = dockChange
      DockedDockControl = dockChange
      DockedLeft = 0
      DockedTop = 0
      FloatLeft = 279
      FloatTop = 64
      FloatClientWidth = 0
      FloatClientHeight = 0
      ItemLinks = <
        item
          UserDefine = [udPaintStyle]
          Visible = True
          ItemName = 'btnResult'
        end
        item
          Visible = True
          ItemName = 'btnImportExcel'
        end
        item
          Visible = True
          ItemName = 'btnExport'
        end
        item
          Visible = True
          ItemName = 'btnAdd'
        end
        item
          Visible = True
          ItemName = 'btnProperty'
        end>
      OneOnRow = True
      Row = 0
      UseOwnFont = False
      Visible = True
      WholeRow = True
    end
    object btnResult: TdxBarButton
      Caption = #26597#35810
      Category = 0
      Hint = #26597#35810
      Visible = ivAlways
      OnClick = btnResult1Click
    end
    object btnImportExcel: TdxBarButton
      Caption = #23548#20837
      Category = 0
      Hint = #23548#20837
      Visible = ivAlways
      OnClick = btnImportExcelClick
    end
    object btnExport: TdxBarButton
      Caption = #23548#20986
      Category = 0
      Hint = #23548#20986
      Visible = ivAlways
      OnClick = btnExportClick
    end
    object btnAdd: TdxBarButton
      Caption = #22686#21152#25968#25454
      Category = 0
      Hint = #22686#21152#25968#25454
      Visible = ivAlways
      OnClick = btnAddClick
    end
    object btnProperty: TdxBarButton
      Caption = #34920#26684#23646#24615
      Category = 0
      Hint = #34920#26684#23646#24615
      Visible = ivAlways
      OnClick = btnPropertyClick
    end
    object btnImport: TdxBarButton
      Caption = 'New Button'
      Category = 0
      Hint = 'New Button'
      Visible = ivAlways
    end
  end
end
