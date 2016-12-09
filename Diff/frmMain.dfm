object MainForm: TMainForm
  Left = 279
  Top = 124
  Width = 905
  Height = 578
  Caption = 'DBContrastTooler'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlDIC: TPanel
    Left = 0
    Top = 0
    Width = 889
    Height = 113
    Align = alTop
    TabOrder = 0
    object lblDataA: TLabel
      Left = 32
      Top = 16
      Width = 42
      Height = 13
      Caption = 'DataA'#65306
    end
    object lblDataB: TLabel
      Left = 32
      Top = 44
      Width = 42
      Height = 13
      Caption = 'DataB'#65306
    end
    object edtDataA: TcxTextEdit
      Left = 170
      Top = 12
      TabOrder = 0
      Width = 649
    end
    object edtDataB: TcxTextEdit
      Left = 170
      Top = 40
      TabOrder = 1
      Width = 649
    end
    object btn2: TcxButton
      Left = 818
      Top = 40
      Width = 24
      Height = 20
      Caption = '...'
      TabOrder = 2
      OnClick = btn2Click
    end
    object btnStart: TcxButton
      Left = 64
      Top = 76
      Width = 73
      Height = 25
      Caption = #24320#22987#23545#27604
      TabOrder = 3
      OnClick = btnStartClick
    end
    object pbMain: TcxProgressBar
      Left = 160
      Top = 86
      TabOrder = 4
      Width = 649
    end
    object edtDataACaption: TcxTextEdit
      Left = 82
      Top = 12
      TabOrder = 5
      Width = 79
    end
  end
  object gd1: TcxGrid
    Left = 0
    Top = 113
    Width = 889
    Height = 427
    Align = alClient
    TabOrder = 1
    object gdvResult: TcxGridBandedTableView
      NavigatorButtons.ConfirmDelete = False
      OnCustomDrawCell = gdvResultCustomDrawCell
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Inserting = False
      OptionsView.ColumnAutoWidth = True
      OptionsView.FooterAutoHeight = True
      OptionsView.GroupByBox = False
      OptionsView.Indicator = True
      Bands = <
        item
          Caption = 'DataA'
          Width = 268
        end
        item
          Caption = 'DataB'
          Width = 268
        end
        item
          Caption = 'Result'
          Width = 200
        end>
      object colATable: TcxGridBandedColumn
        Caption = 'A'#25968#25454#34920
        Width = 200
        Position.BandIndex = 0
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object colBTable: TcxGridBandedColumn
        Caption = 'B'#25968#25454#34920
        Width = 200
        Position.BandIndex = 1
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object colType: TcxGridBandedColumn
        Caption = #31867#22411
        Options.Editing = False
        Position.BandIndex = 2
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object colOp: TcxGridBandedColumn
        Caption = #25805#20316
        PropertiesClassName = 'TcxButtonEditProperties'
        Properties.Buttons = <
          item
            Default = True
            Kind = bkEllipsis
          end>
        Properties.OnButtonClick = colOpPropertiesButtonClick
        Options.ShowEditButtons = isebAlways
        Position.BandIndex = 2
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
    end
    object gdl1: TcxGridLevel
      GridView = gdvResult
    end
  end
  object pbDetail: TcxProgressBar
    Left = 160
    Top = 68
    TabOrder = 2
    Width = 649
  end
end
