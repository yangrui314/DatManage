object frmShowDiff: TfrmShowDiff
  Left = 290
  Top = 128
  Width = 907
  Height = 578
  Caption = 'ShowDiff'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object gd1: TcxGrid
    Left = 0
    Top = 56
    Width = 891
    Height = 484
    Align = alClient
    TabOrder = 0
    object gdvDiff: TcxGridBandedTableView
      NavigatorButtons.ConfirmDelete = False
      OnCustomDrawCell = gdvDiffCustomDrawCell
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      OptionsData.Inserting = False
      OptionsView.FooterAutoHeight = True
      OptionsView.GroupByBox = False
      OptionsView.Indicator = True
      Bands = <
        item
          Caption = 'DataA'
          Styles.Header = cxstyl2
          Width = 181
        end
        item
          Caption = 'Key'
          FixedKind = fkLeft
          Width = 110
        end
        item
          Caption = 'DataB'
          Styles.Header = cxstyl1
          Width = 174
        end>
      object colData: TcxGridBandedColumn
        Caption = 'Data'
        Width = 60
        Position.BandIndex = 1
        Position.ColIndex = 0
        Position.RowIndex = 0
      end
      object colModifyType: TcxGridBandedColumn
        Caption = 'MType'
        Position.BandIndex = 1
        Position.ColIndex = 1
        Position.RowIndex = 0
      end
    end
    object gdl1: TcxGridLevel
      GridView = gdvDiff
    end
  end
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 891
    Height = 56
    Align = alTop
    TabOrder = 1
    object cxchckgrp1: TcxCheckGroup
      Left = 80
      Top = 5
      Caption = #26174#31034#26041#24335
      Properties.Items = <>
      TabOrder = 0
      Height = 45
      Width = 329
    end
    object rbhx: TcxRadioButton
      Left = 141
      Top = 23
      Width = 113
      Height = 17
      Caption = #27178#21521
      Checked = True
      TabOrder = 1
      TabStop = True
      OnClick = rbhxClick
    end
    object rbzx: TcxRadioButton
      Left = 273
      Top = 23
      Width = 113
      Height = 17
      Caption = #32437#21521
      TabOrder = 2
      OnClick = rbhxClick
    end
  end
  object cxstylrpstry1: TcxStyleRepository
    PixelsPerInch = 96
    object cxstyl1: TcxStyle
      AssignedValues = [svColor]
      Color = clGradientActiveCaption
    end
    object cxstyl2: TcxStyle
      AssignedValues = [svColor]
      Color = clInactiveBorder
    end
  end
end
