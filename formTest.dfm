object Form1: TForm1
  Left = 265
  Top = 160
  Width = 928
  Height = 480
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object cxGrid1: TcxGrid
    Left = 0
    Top = 0
    Width = 912
    Height = 442
    Align = alClient
    TabOrder = 0
    object dg: TcxGridTableView
      NavigatorButtons.ConfirmDelete = False
      DataController.Summary.DefaultGroupSummaryItems = <>
      DataController.Summary.FooterSummaryItems = <>
      DataController.Summary.SummaryGroups = <>
      object dgColumn1: TcxGridColumn
        Caption = '1'
        PropertiesClassName = 'TcxTextEditProperties'
        Width = 530
      end
    end
    object cxGrid1Level1: TcxGridLevel
      GridView = dg
    end
  end
end
