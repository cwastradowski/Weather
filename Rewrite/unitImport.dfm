object frmImport: TfrmImport
  Left = 444
  Top = 97
  Caption = 'Import Raw Data File to Database'
  ClientHeight = 680
  ClientWidth = 835
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = mmFrmImportMainMenu
  OldCreateOrder = False
  Visible = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object lblFileInfo: TLabel
    Left = 8
    Top = 0
    Width = 697
    Height = 25
    AutoSize = False
  end
  object lblPassFail: TLabel
    Left = 270
    Top = 31
    Width = 124
    Height = 33
    Alignment = taCenter
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object sgridData: TStringGrid
    Left = 8
    Top = 32
    Width = 264
    Height = 42
    ColCount = 4
    DefaultRowHeight = 18
    RowCount = 2
    TabOrder = 0
  end
  object dbGridImport: TDBGrid
    Left = 400
    Top = 31
    Width = 305
    Height = 583
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        Visible = True
      end>
  end
  object dbNavImport: TDBNavigator
    Left = 376
    Top = 624
    Width = 392
    Height = 25
    VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbEdit, nbPost, nbCancel, nbRefresh]
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
  end
  object btnCompare: TButton
    Left = 294
    Top = 80
    Width = 75
    Height = 25
    Caption = '&Compare'
    TabOrder = 3
    Visible = False
    OnClick = btnCompareClick
  end
  object btnFix: TButton
    Left = 294
    Top = 104
    Width = 75
    Height = 25
    Caption = '&Fix'
    TabOrder = 4
    Visible = False
    OnClick = btnFixClick
  end
  object mmFrmImportMainMenu: TMainMenu
    Tag = 555
    Left = 160
    Top = 80
    object menuFile: TMenuItem
      Caption = '&File'
    end
  end
end
