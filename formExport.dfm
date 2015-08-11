object fmExport: TfmExport
  Left = 445
  Top = 261
  Width = 523
  Height = 252
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
    Height = 214
    ActivePage = SheetWay
    Align = alClient
    TabOrder = 0
    ClientRectBottom = 214
    ClientRectRight = 507
    ClientRectTop = 24
    object SheetWay: TcxTabSheet
      Caption = #23548#20986#26041#24335
      ImageIndex = 0
      object lcMain: TdxLayoutControl
        Left = 0
        Top = 0
        Width = 507
        Height = 190
        Align = alClient
        TabOrder = 0
        TabStop = False
        object cmbExportType: TcxImageComboBox
          Left = 75
          Top = 10
          Properties.Items = <
            item
              Description = #25991#26412#25991#20214
            end
            item
              Description = 'Excel '#25991#20214' (*.xls)'
              ImageIndex = 0
            end>
          TabOrder = 0
          Width = 121
        end
        object lcMainGroup_Root: TdxLayoutGroup
          ShowCaption = False
          Hidden = True
          LayoutDirection = ldHorizontal
          ShowBorder = False
          object lcMainItem2: TdxLayoutItem
            Caption = #25991#20214#31867#22411#65306
            Control = cmbExportType
            ControlOptions.ShowBorder = False
          end
        end
      end
    end
    object SheetField: TcxTabSheet
      Caption = #23548#20986#23383#27573
      ImageIndex = 1
    end
  end
end
