inherited fmMenuBatchImportPath: TfmMenuBatchImportPath
  Left = 346
  Top = 178
  Width = 827
  Height = 430
  Caption = 'fmMenuBatchImportPath'
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlMain: TPanel [0]
    Left = 0
    Top = 0
    Width = 811
    Height = 344
    Align = alClient
    Caption = 'pnl'
    ParentBackground = True
    TabOrder = 0
    object PageExport: TcxPageControl
      Left = 1
      Top = 1
      Width = 809
      Height = 342
      ActivePage = SheetPreview
      Align = alClient
      HideTabs = True
      TabOrder = 0
      ClientRectBottom = 342
      ClientRectRight = 809
      ClientRectTop = 0
      object SheetConfig: TcxTabSheet
        Caption = #23548#20986#26041#24335
        ImageIndex = 0
        object dxLayoutControl1: TdxLayoutControl
          Left = 0
          Top = 0
          Width = 809
          Height = 342
          Align = alClient
          TabOrder = 0
          TabStop = False
          AutoContentSizes = [acsWidth, acsHeight]
          object edtFilePath: TcxButtonEdit
            Left = 75
            Top = 10
            Properties.Buttons = <
              item
                Default = True
                Kind = bkEllipsis
              end>
            Properties.OnButtonClick = btnFilePathPropertiesButtonClick
            Properties.OnValidate = btnFilePathPropertiesValidate
            TabOrder = 0
            Text = 'D:\Project\new_omni\'
            Width = 121
          end
          object cbClearOld: TcxCheckBox
            Left = 10
            Top = 37
            Caption = #26159#21542#28165#38500#21407#25968#25454
            Properties.ImmediatePost = True
            TabOrder = 1
            Width = 121
          end
          object lcMainGroup_Root: TdxLayoutGroup
            ShowCaption = False
            Hidden = True
            ShowBorder = False
            object lcMainItem1: TdxLayoutItem
              Caption = #35774#32622#36335#24452#65306
              Control = edtFilePath
              ControlOptions.ShowBorder = False
            end
            object lcMainItem3: TdxLayoutItem
              Caption = 'cxCheckBox1'
              ShowCaption = False
              Control = cbClearOld
              ControlOptions.ShowBorder = False
            end
          end
        end
      end
      object SheetPreview: TcxTabSheet
        Caption = #39044#35272
        ImageIndex = 2
        object pnlPreview: TPanel
          Left = 0
          Top = 0
          Width = 809
          Height = 342
          Align = alClient
          Caption = 'pnlPreview'
          TabOrder = 0
          object gridParameter: TcxGrid
            Left = 1
            Top = 1
            Width = 807
            Height = 340
            Align = alClient
            TabOrder = 0
            object dgParameter: TcxGridTableView
              NavigatorButtons.ConfirmDelete = False
              DataController.Summary.DefaultGroupSummaryItems = <>
              DataController.Summary.FooterSummaryItems = <>
              DataController.Summary.SummaryGroups = <>
              OptionsData.CancelOnExit = False
              OptionsData.Deleting = False
              OptionsData.DeletingConfirmation = False
              OptionsData.Inserting = False
              OptionsView.GroupByBox = False
              object dgParameterSelected: TcxGridColumn
                Caption = #36873#25321
                PropertiesClassName = 'TcxCheckBoxProperties'
                Properties.ImmediatePost = True
                FooterAlignmentHorz = taCenter
                GroupSummaryAlignment = taCenter
                HeaderAlignmentHorz = taCenter
                HeaderGlyphAlignmentHorz = taCenter
                Width = 51
              end
              object dgParameterID: TcxGridColumn
                Caption = #24207#21495
                DataBinding.ValueType = 'Integer'
                PropertiesClassName = 'TcxSpinEditProperties'
                Properties.Alignment.Horz = taCenter
                Properties.ReadOnly = True
                FooterAlignmentHorz = taCenter
                GroupSummaryAlignment = taCenter
                HeaderAlignmentHorz = taCenter
                HeaderGlyphAlignmentHorz = taCenter
                Width = 44
              end
              object dgParameterFullName: TcxGridColumn
                Caption = #20840#21517
                PropertiesClassName = 'TcxTextEditProperties'
                Properties.ReadOnly = True
                FooterAlignmentHorz = taCenter
                GroupSummaryAlignment = taCenter
                HeaderAlignmentHorz = taCenter
                Width = 151
              end
              object dgParameterName: TcxGridColumn
                Caption = #31616#31216
                PropertiesClassName = 'TcxTextEditProperties'
                Properties.MaxLength = 12
                FooterAlignmentHorz = taCenter
                GroupSummaryAlignment = taCenter
                HeaderAlignmentHorz = taCenter
                Width = 98
              end
              object dgParameterOutputDir: TcxGridColumn
                Caption = #32534#35793#36755#20986#30446#24405
                PropertiesClassName = 'TcxTextEditProperties'
                Properties.ReadOnly = True
                FooterAlignmentHorz = taCenter
                GroupSummaryAlignment = taCenter
                HeaderAlignmentHorz = taCenter
                Width = 112
              end
              object dgParameterPath: TcxGridColumn
                Caption = #36335#24452
                PropertiesClassName = 'TcxTextEditProperties'
                Properties.ReadOnly = True
                FooterAlignmentHorz = taCenter
                GroupSummaryAlignment = taCenter
                HeaderAlignmentHorz = taCenter
                Width = 157
              end
              object dgParameterConditionals: TcxGridColumn
                Caption = #32534#35793#25351#20196
                PropertiesClassName = 'TcxTextEditProperties'
                Properties.ReadOnly = True
                FooterAlignmentHorz = taCenter
                GroupSummaryAlignment = taCenter
                HeaderAlignmentHorz = taCenter
                Width = 92
              end
            end
            object levelParameter: TcxGridLevel
              GridView = dgParameter
            end
          end
        end
      end
    end
  end
  object pnlCommand: TPanel [1]
    Left = 0
    Top = 344
    Width = 811
    Height = 48
    Align = alBottom
    Caption = 'pnlCommand'
    TabOrder = 1
    object dxLayoutControl2: TdxLayoutControl
      Left = 1
      Top = 1
      Width = 809
      Height = 46
      Align = alClient
      TabOrder = 0
      TabStop = False
      AutoContentSizes = [acsWidth, acsHeight]
      object btnFinish: TcxButton
        Left = 724
        Top = 10
        Width = 75
        Height = 25
        Caption = #23436#25104
        TabOrder = 2
        OnClick = btnFinishClick
      end
      object btnNext: TcxButton
        Left = 643
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
  inherited lafMain: TcxLookAndFeelController
    Left = 768
    Top = 112
  end
end
