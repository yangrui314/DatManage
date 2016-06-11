object fmExport: TfmExport
  Left = 454
  Top = 227
  Width = 612
  Height = 271
  Caption = #23548#20986
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object PageExport: TcxPageControl
    Left = 0
    Top = 0
    Width = 596
    Height = 185
    ActivePage = SheetWay
    Align = alTop
    HideTabs = True
    TabOrder = 0
    ClientRectBottom = 185
    ClientRectRight = 596
    ClientRectTop = 0
    object SheetWay: TcxTabSheet
      Caption = #23548#20986#26041#24335
      ImageIndex = 0
      object lcMain: TdxLayoutControl
        Left = 0
        Top = 0
        Width = 596
        Height = 185
        Align = alClient
        TabOrder = 0
        TabStop = False
        AutoContentSizes = [acsWidth, acsHeight]
        object cmbExportType: TcxImageComboBox
          Left = 99
          Top = 10
          EditValue = 0
          Properties.ImmediatePost = True
          Properties.Items = <
            item
              Description = '*.xls'
              ImageIndex = 0
              Value = 0
            end
            item
              Description = '*.sql'
              Tag = 1
              Value = 1
            end>
          Properties.OnValidate = cmbExportTypePropertiesValidate
          TabOrder = 0
          Width = 121
        end
        object btnFilePath: TcxButtonEdit
          Left = 99
          Top = 37
          Properties.Buttons = <
            item
              Default = True
              Kind = bkEllipsis
            end>
          Properties.OnButtonClick = btnFilePathPropertiesButtonClick
          Properties.OnValidate = btnFilePathPropertiesValidate
          TabOrder = 1
          Width = 121
        end
        object cbSelectField: TcxCheckBox
          Left = 10
          Top = 91
          Caption = #36807#28388#23383#27573
          Properties.ImmediatePost = True
          TabOrder = 3
          Width = 121
        end
        object edtExportTableName: TcxTextEdit
          Left = 99
          Top = 64
          TabOrder = 2
          Width = 121
        end
        object edtDelKeyField: TcxComboBox
          Left = 99
          Top = 145
          Properties.ImmediatePost = True
          TabOrder = 5
          Width = 360
        end
        object cbContainDelSQL: TcxCheckBox
          Left = 10
          Top = 118
          Caption = #21253#21547#21024#38500#35821#21477
          Properties.ImmediatePost = True
          TabOrder = 4
          Width = 425
        end
        object lcMainGroup_Root: TdxLayoutGroup
          ShowCaption = False
          Hidden = True
          ShowBorder = False
          object lcMainItem2: TdxLayoutItem
            Caption = #25991#20214#31867#22411#65306
            Control = cmbExportType
            ControlOptions.ShowBorder = False
          end
          object lcMainItem1: TdxLayoutItem
            Caption = #20445#23384#20301#32622#65306
            Control = btnFilePath
            ControlOptions.ShowBorder = False
          end
          object lcMainItem4: TdxLayoutItem
            Caption = #23548#20986#34920#26684#21517#31216#65306
            Control = edtExportTableName
            ControlOptions.ShowBorder = False
          end
          object lcMainItem3: TdxLayoutItem
            Caption = 'cxCheckBox1'
            ShowCaption = False
            Control = cbSelectField
            ControlOptions.ShowBorder = False
          end
          object lcMainItem6: TdxLayoutItem
            ShowCaption = False
            Control = cbContainDelSQL
            ControlOptions.ShowBorder = False
          end
          object lcMainItem5: TdxLayoutItem
            Caption = #20851#38190#23383#27573#65306
            Control = edtDelKeyField
            ControlOptions.ShowBorder = False
          end
        end
      end
    end
    object SheetField: TcxTabSheet
      Caption = #23548#20986#23383#27573
      ImageIndex = 1
      object pnlField: TPanel
        Left = 0
        Top = 0
        Width = 596
        Height = 185
        Align = alClient
        Caption = 'pnlField'
        TabOrder = 0
      end
    end
    object SheetPreview: TcxTabSheet
      Caption = #39044#35272
      ImageIndex = 2
      object pnlPreview: TPanel
        Left = 0
        Top = 0
        Width = 596
        Height = 185
        Align = alClient
        Caption = 'pnlPreview'
        TabOrder = 0
      end
    end
    object SheetFinish: TcxTabSheet
      Caption = #23436#25104
      ImageIndex = 3
    end
  end
  object pnlCommand: TPanel
    Left = 0
    Top = 185
    Width = 596
    Height = 48
    Align = alClient
    Caption = 'pnlCommand'
    TabOrder = 1
    object dxLayoutControl1: TdxLayoutControl
      Left = 1
      Top = 1
      Width = 594
      Height = 46
      Align = alClient
      TabOrder = 0
      TabStop = False
      AutoContentSizes = [acsWidth, acsHeight]
      object btnFinish: TcxButton
        Left = 509
        Top = 10
        Width = 75
        Height = 25
        Caption = #23436#25104
        TabOrder = 2
        OnClick = btnFinishClick
      end
      object btnNext: TcxButton
        Left = 428
        Top = 10
        Width = 75
        Height = 25
        Caption = #19979#19968#27493
        TabOrder = 1
        OnClick = btnNextClick
      end
      object btnPrevious: TcxButton
        Left = 10
        Top = 10
        Width = 75
        Height = 25
        Caption = #19978#19968#27493
        TabOrder = 0
        OnClick = btnPreviousClick
      end
      object dxLayoutControl1Group_Root: TdxLayoutGroup
        ShowCaption = False
        Hidden = True
        LayoutDirection = ldHorizontal
        ShowBorder = False
        object dxLayoutControl1Item3: TdxLayoutItem
          ShowCaption = False
          Control = btnPrevious
          ControlOptions.ShowBorder = False
        end
        object dxLayoutControl1Item2: TdxLayoutItem
          AutoAligns = [aaVertical]
          AlignHorz = ahRight
          ShowCaption = False
          Control = btnNext
          ControlOptions.ShowBorder = False
        end
        object dxLayoutControl1Item1: TdxLayoutItem
          AutoAligns = [aaVertical]
          AlignHorz = ahRight
          ShowCaption = False
          Control = btnFinish
          ControlOptions.ShowBorder = False
        end
      end
    end
  end
  object dlgSave: TSaveDialog
    Left = 232
    Top = 32
  end
end
