object fmExport: TfmExport
  Left = 454
  Top = 227
  Width = 523
  Height = 272
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
    Width = 507
    Height = 185
    ActivePage = SheetWay
    Align = alTop
    HideTabs = True
    TabOrder = 0
    ClientRectBottom = 185
    ClientRectRight = 507
    ClientRectTop = 0
    object SheetWay: TcxTabSheet
      Caption = #23548#20986#26041#24335
      ImageIndex = 0
      object lcMain: TdxLayoutControl
        Left = 0
        Top = 0
        Width = 507
        Height = 185
        Align = alClient
        TabOrder = 0
        TabStop = False
        object cmbExportType: TcxImageComboBox
          Left = 75
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
          Left = 75
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
        end
      end
    end
    object SheetField: TcxTabSheet
      Caption = #23548#20986#23383#27573
      ImageIndex = 1
      object pnlField: TPanel
        Left = 0
        Top = 0
        Width = 507
        Height = 161
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
        Width = 507
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
    Width = 507
    Height = 49
    Align = alClient
    Caption = 'pnlCommand'
    TabOrder = 1
    object dxLayoutControl1: TdxLayoutControl
      Left = 1
      Top = 1
      Width = 505
      Height = 47
      Align = alClient
      TabOrder = 0
      TabStop = False
      object btnFinish: TcxButton
        Left = 172
        Top = 10
        Width = 75
        Height = 25
        Caption = #23436#25104
        TabOrder = 2
        OnClick = btnFinishClick
      end
      object btnNext: TcxButton
        Left = 91
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
