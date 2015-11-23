object fmMain: TfmMain
  Left = 245
  Top = 69
  Width = 876
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
    Top = 225
    Width = 860
    Height = 346
    Align = alClient
    Caption = 'pnlResult'
    ParentBackground = True
    TabOrder = 0
  end
  object pnlCondition: TPanel
    Left = 0
    Top = 0
    Width = 860
    Height = 225
    Align = alTop
    Caption = 'pnlCondition'
    ParentBackground = True
    TabOrder = 5
    object dMain: TdxLayoutControl
      Left = 1
      Top = 1
      Width = 858
      Height = 223
      Align = alClient
      ParentBackground = True
      TabOrder = 0
      TabStop = False
      AutoContentSizes = [acsWidth, acsHeight]
      object btnSelectParameter: TcxButton
        Left = 680
        Top = 28
        Width = 75
        Height = 25
        Caption = #37197#32622#29615#22659
        TabOrder = 2
        OnClick = btnSelectParameterClick
        LookAndFeel.Kind = lfOffice11
      end
      object edtParameter: TcxComboBox
        Left = 250
        Top = 28
        Properties.ImmediatePost = True
        Properties.OnValidate = edtCreatePathPropertiesValidate
        TabOrder = 1
        Width = 121
      end
      object edtPathName: TcxComboBox
        Left = 87
        Top = 28
        Properties.ImmediatePost = True
        Properties.OnValidate = edtPathNamePropertiesValidate
        TabOrder = 0
        Width = 125
      end
      object btnSaveParameter: TcxButton
        Left = 761
        Top = 28
        Width = 75
        Height = 25
        Caption = #20445#23384#29615#22659
        TabOrder = 3
        OnClick = btnSaveParameterClick
        LookAndFeel.Kind = lfOffice11
      end
      object PageSelect: TcxPageControl
        Left = 10
        Top = 71
        Width = 821
        Height = 98
        ActivePage = SheetTable
        ParentShowHint = False
        ShowHint = False
        TabOrder = 4
        ClientRectBottom = 98
        ClientRectRight = 821
        ClientRectTop = 24
        object SheetTable: TcxTabSheet
          Caption = #34920
          ImageIndex = 0
          object lcTable: TdxLayoutControl
            Left = 0
            Top = 0
            Width = 821
            Height = 74
            Align = alClient
            ParentBackground = True
            TabOrder = 0
            TabStop = False
            AutoContentSizes = [acsWidth, acsHeight]
            object edtTable: TcxComboBox
              Left = 75
              Top = 10
              Properties.ImmediatePost = True
              Properties.OnChange = edtTablePropertiesChange
              Properties.OnValidate = edtTablePropertiesValidate
              TabOrder = 0
              Width = 200
            end
            object edtFieldName: TcxComboBox
              Left = 334
              Top = 10
              Properties.ImmediatePost = True
              TabOrder = 1
              Width = 121
            end
            object edtKeyword: TcxComboBox
              Left = 75
              Top = 37
              Properties.ImmediatePost = True
              TabOrder = 2
              Width = 200
            end
            object edtCondition: TcxTextEdit
              Left = 334
              Top = 37
              TabOrder = 3
              Width = 121
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
                  AutoAligns = [aaVertical]
                  AlignHorz = ahClient
                  Caption = #36807#28388#23383#27573
                  Control = edtFieldName
                  ControlOptions.ShowBorder = False
                end
              end
              object lcTableGroup2: TdxLayoutGroup
                ShowCaption = False
                Hidden = True
                LayoutDirection = ldHorizontal
                ShowBorder = False
                object lcTableItem3: TdxLayoutItem
                  AutoAligns = [aaVertical]
                  Caption = #20851#38190#23383#27573#65306
                  Control = edtKeyword
                  ControlOptions.ShowBorder = False
                end
                object lcTableItem4: TdxLayoutItem
                  AutoAligns = [aaVertical]
                  AlignHorz = ahClient
                  Caption = #20540#65306
                  Control = edtCondition
                  ControlOptions.ShowBorder = False
                end
              end
            end
          end
        end
        object SheetSQL: TcxTabSheet
          Caption = 'SQL'#26597#35810
          ImageIndex = 1
          object edtSQL: TcxMemo
            Left = 0
            Top = 0
            Align = alClient
            TabOrder = 0
            Height = 74
            Width = 821
          end
        end
      end
      object dockChange: TdxBarDockControl
        Left = 10
        Top = 175
        Width = 887
        Height = 27
        Align = dalNone
        BarManager = BarManager
      end
      object dxLayoutGroup2: TdxLayoutGroup
        ShowCaption = False
        Hidden = True
        ShowBorder = False
        object GroupConnect: TdxLayoutGroup
          Caption = #36830#25509#26041#24335
          LayoutDirection = ldHorizontal
          object dMainItem4: TdxLayoutItem
            AutoAligns = [aaVertical]
            Caption = #29615#22659#21517#31216#65306
            Control = edtPathName
            ControlOptions.ShowBorder = False
          end
          object dMainItem14: TdxLayoutItem
            AutoAligns = [aaVertical]
            AlignHorz = ahClient
            Caption = #29615#22659':'
            Control = edtParameter
            ControlOptions.ShowBorder = False
          end
          object dMainItem10: TdxLayoutItem
            AutoAligns = [aaVertical]
            AlignHorz = ahRight
            Caption = 'cxButton1'
            ShowCaption = False
            Control = btnSelectParameter
            ControlOptions.ShowBorder = False
          end
          object dMainItem15: TdxLayoutItem
            AutoAligns = [aaVertical]
            AlignHorz = ahRight
            ShowCaption = False
            Control = btnSaveParameter
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
      object N7: TMenuItem
        Caption = #20462#25913#32534#35793#25351#20196
        OnClick = N7Click
      end
      object N8: TMenuItem
        Caption = #26597#30475#32534#35793#25351#20196
        OnClick = N8Click
      end
    end
    object MenuUpadate: TMenuItem
      Caption = #26356#26032
      Visible = False
      OnClick = MenuUpadateClick
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
    Left = 608
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
          ItemName = 'btnDelete'
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
    object dxBarSubItem1: TdxBarSubItem
      Caption = 'New SubItem'
      Category = 0
      Visible = ivAlways
      ItemLinks = <>
    end
    object btnDelete: TdxBarButton
      Caption = #21024#38500#25968#25454
      Category = 0
      Hint = #21024#38500#25968#25454
      Visible = ivAlways
      OnClick = btnDeleteClick
    end
    object dxBarButton1: TdxBarButton
      Caption = 'New Button'
      Category = 0
      Hint = 'New Button'
      Visible = ivAlways
    end
    object dxBarButton2: TdxBarButton
      Caption = 'New Button'
      Category = 0
      Hint = 'New Button'
      Visible = ivAlways
    end
  end
  object RzVersionInfo: TRzVersionInfo
    Left = 353
    Top = 41
  end
end
