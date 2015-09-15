inherited fmSavePath: TfmSavePath
  Left = 445
  Top = 246
  Width = 524
  Height = 145
  Caption = 'fmSavePath'
  PixelsPerInch = 96
  TextHeight = 13
  object dxLayoutControl1: TdxLayoutControl
    Left = 0
    Top = 0
    Width = 508
    Height = 107
    Align = alClient
    TabOrder = 0
    TabStop = False
    AutoContentSizes = [acsWidth, acsHeight]
    object edtPath: TcxTextEdit
      Left = 51
      Top = 37
      TabOrder = 1
      Width = 121
    end
    object edtName: TcxTextEdit
      Left = 51
      Top = 10
      TabOrder = 0
      Width = 274
    end
    object btnCancel: TcxButton
      Left = 423
      Top = 64
      Width = 75
      Height = 25
      Caption = #21462#28040
      TabOrder = 3
      OnClick = btnCancelClick
    end
    object btnOK: TcxButton
      Left = 342
      Top = 64
      Width = 75
      Height = 25
      Caption = #20445#23384
      ModalResult = 1
      TabOrder = 2
      OnClick = btnOKClick
    end
    object dxLayoutControl1Group_Root: TdxLayoutGroup
      ShowCaption = False
      Hidden = True
      ShowBorder = False
      object dxLayoutControl1Item2: TdxLayoutItem
        Caption = #21517#31216#65306
        Control = edtName
        ControlOptions.ShowBorder = False
      end
      object dxLayoutControl1Item1: TdxLayoutItem
        Caption = #36335#24452
        Control = edtPath
        ControlOptions.ShowBorder = False
      end
      object dxLayoutControl1Group1: TdxLayoutGroup
        ShowCaption = False
        Hidden = True
        LayoutDirection = ldHorizontal
        ShowBorder = False
        object dxLayoutControl1Item4: TdxLayoutItem
          AutoAligns = [aaVertical]
          AlignHorz = ahRight
          ShowCaption = False
          Control = btnOK
          ControlOptions.ShowBorder = False
        end
        object dxLayoutControl1Item3: TdxLayoutItem
          AutoAligns = [aaVertical]
          AlignHorz = ahRight
          Caption = 'cxButton1'
          ShowCaption = False
          Control = btnCancel
          ControlOptions.ShowBorder = False
        end
      end
    end
  end
end
