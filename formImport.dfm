object fmImport: TfmImport
  Left = 425
  Top = 217
  Width = 485
  Height = 258
  Caption = #23548#20837
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
  object lcMain: TdxLayoutControl
    Left = 0
    Top = 0
    Width = 469
    Height = 220
    Align = alClient
    TabOrder = 0
    TabStop = False
    AutoContentSizes = [acsWidth, acsHeight]
    object cmbImportType: TcxImageComboBox
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
      Properties.OnValidate = cmbImportTypePropertiesValidate
      TabOrder = 0
      Width = 398
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
    object cbSaveSQL: TcxCheckBox
      Left = 10
      Top = 64
      Caption = #20445#23384'SQL'#35821#21477
      Properties.ImmediatePost = True
      Properties.OnValidate = cbSaveSQLPropertiesValidate
      TabOrder = 2
      Width = 121
    end
    object cbContainDelSQL: TcxCheckBox
      Left = 22
      Top = 109
      Caption = #21253#21547#21024#38500#35821#21477
      Properties.ImmediatePost = True
      Properties.OnValidate = cbContainDelSQLPropertiesValidate
      TabOrder = 3
      Width = 187
    end
    object edtDelKeyField: TcxComboBox
      Left = 87
      Top = 136
      Properties.ImmediatePost = True
      TabOrder = 4
      Width = 121
    end
    object btnFinish: TcxButton
      Left = 384
      Top = 175
      Width = 75
      Height = 25
      Caption = #23548#20837
      TabOrder = 5
      OnClick = btnFinishClick
    end
    object dxLayoutGroup1: TdxLayoutGroup
      AutoAligns = [aaVertical]
      AlignHorz = ahClient
      ShowCaption = False
      Hidden = True
      ShowBorder = False
      object lcMainItem2: TdxLayoutItem
        Caption = #25991#20214#31867#22411#65306
        Control = cmbImportType
        ControlOptions.ShowBorder = False
      end
      object dxLayoutItem1: TdxLayoutItem
        Caption = #20445#23384#20301#32622#65306
        Control = btnFilePath
        ControlOptions.ShowBorder = False
      end
      object lcMainItem3: TdxLayoutItem
        Caption = 'cxCheckBox1'
        ShowCaption = False
        Control = cbSaveSQL
        ControlOptions.ShowBorder = False
      end
      object dxLayoutGroup2: TdxLayoutGroup
        Caption = #21024#38500#35821#21477
        object lcMainItem4: TdxLayoutItem
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
      object lcMainItem7: TdxLayoutItem
        AutoAligns = [aaVertical]
        AlignHorz = ahRight
        ShowCaption = False
        Control = btnFinish
        ControlOptions.ShowBorder = False
      end
    end
  end
  object dlgOpen: TOpenDialog
    Left = 248
  end
end
