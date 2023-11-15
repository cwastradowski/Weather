object frmSetup: TfrmSetup
  Left = 174
  Top = 115
  Caption = 'MPC Weather Records Setup Form'
  ClientHeight = 415
  ClientWidth = 1057
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Label5: TLabel
    Left = 23
    Top = 12
    Width = 52
    Height = 13
    Caption = 'Chart Days'
  end
  object Label1: TLabel
    Left = 8
    Top = 201
    Width = 33
    Height = 13
    Caption = 'Station'
  end
  object Label2: TLabel
    Left = 264
    Top = 201
    Width = 56
    Height = 13
    Caption = 'Short Name'
  end
  object Label3: TLabel
    Left = 500
    Top = 200
    Width = 48
    Height = 13
    Caption = 'Sort Order'
  end
  object Label4: TLabel
    Left = 8
    Top = 236
    Width = 66
    Height = 13
    Caption = 'Weather URL'
  end
  object Label6: TLabel
    Left = 8
    Top = 271
    Width = 91
    Height = 13
    Caption = 'NWS Web Caption'
  end
  object Label7: TLabel
    Left = 8
    Top = 341
    Width = 36
    Height = 13
    Caption = 'Temp 1'
  end
  object Label8: TLabel
    Left = 264
    Top = 341
    Width = 36
    Height = 13
    Caption = 'Temp 2'
  end
  object Label9: TLabel
    Left = 500
    Top = 341
    Width = 36
    Height = 13
    Caption = 'Temp 3'
  end
  object Label10: TLabel
    Left = 8
    Top = 376
    Width = 36
    Height = 13
    Caption = 'Temp 4'
  end
  object Label11: TLabel
    Left = 264
    Top = 378
    Width = 36
    Height = 13
    Caption = 'Temp 5'
  end
  object Label12: TLabel
    Left = 500
    Top = 377
    Width = 36
    Height = 13
    Caption = 'Temp 6'
  end
  object Label13: TLabel
    Left = 8
    Top = 307
    Width = 70
    Height = 13
    Caption = 'NWS File Path'
  end
  object dbTextStationName: TDBText
    Left = 264
    Top = 159
    Width = 272
    Height = 32
    DataField = 'sStation'
    DataSource = dsStations
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -24
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object editChartDays: TEdit
    Left = 92
    Top = 8
    Width = 121
    Height = 21
    TabStop = False
    TabOrder = 12
  end
  object dbGridStations: TDBGrid
    Left = 0
    Top = 43
    Width = 1049
    Height = 110
    TabStop = False
    DataSource = dsStations
    ReadOnly = True
    TabOrder = 14
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'sStation'
        Title.Caption = 'Station'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'sShortName'
        Title.Caption = 'Short Name'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'iSortOrder'
        Title.Caption = 'Sort Order'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'sNWSUrl'
        Title.Caption = 'Weather URL'
        Width = 168
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'sNWSUrlFormCaption'
        Title.Caption = 'NWS Web Form Caption'
        Width = 168
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'sNWSFilePath'
        Title.Caption = 'NWS File Path'
        Width = 168
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'iTemp1'
        Title.Caption = 'Temp 1'
        Width = 40
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'iTemp2'
        Title.Caption = 'Temp 2'
        Width = 40
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'iTemp3'
        Title.Caption = 'Temp 3'
        Width = 40
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'iTemp4'
        Title.Caption = 'Temp 4'
        Width = 40
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'iTemp5'
        Title.Caption = 'Temp 5'
        Width = 40
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'iTemp6'
        Title.Caption = 'Temp 6'
        Width = 40
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'bActive'
        PickList.Strings = (
          'True'
          'False')
        Title.Caption = 'Active'
        Width = 40
        Visible = True
      end>
  end
  object DBNavigator1: TDBNavigator
    Left = 8
    Top = 159
    Width = 231
    Height = 25
    DataSource = dsStations
    VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbInsert, nbPost, nbCancel]
    ParentShowHint = False
    ShowHint = True
    TabOrder = 15
  end
  object dbEditStation: TDBEdit
    Left = 118
    Top = 197
    Width = 121
    Height = 21
    DataField = 'sStation'
    DataSource = dsStations
    TabOrder = 0
  end
  object dbEditShortName: TDBEdit
    Left = 336
    Top = 197
    Width = 121
    Height = 21
    DataField = 'sShortName'
    DataSource = dsStations
    TabOrder = 1
  end
  object dbEditURl: TDBEdit
    Left = 118
    Top = 232
    Width = 569
    Height = 21
    DataField = 'sNWSUrl'
    DataSource = dsStations
    TabOrder = 3
  end
  object dbEditWebCaption: TDBEdit
    Left = 118
    Top = 267
    Width = 569
    Height = 21
    DataField = 'sNWSUrlFormCaption'
    DataSource = dsStations
    TabOrder = 4
  end
  object dbEditFilePath: TDBEdit
    Left = 118
    Top = 307
    Width = 569
    Height = 21
    DataField = 'sNWSFilePath'
    DataSource = dsStations
    TabOrder = 5
  end
  object dbEditTemp2: TDBEdit
    Left = 336
    Top = 337
    Width = 121
    Height = 21
    DataField = 'iTemp2'
    DataSource = dsStations
    TabOrder = 7
  end
  object dbEditTemp3: TDBEdit
    Left = 566
    Top = 337
    Width = 121
    Height = 21
    DataField = 'iTemp3'
    DataSource = dsStations
    TabOrder = 8
  end
  object dbEditTemp1: TDBEdit
    Left = 118
    Top = 337
    Width = 121
    Height = 21
    DataField = 'iTemp1'
    DataSource = dsStations
    TabOrder = 6
  end
  object dbEditTemp4: TDBEdit
    Left = 118
    Top = 376
    Width = 121
    Height = 21
    DataField = 'iTemp4'
    DataSource = dsStations
    TabOrder = 9
  end
  object dbEditTemp5: TDBEdit
    Left = 336
    Top = 376
    Width = 121
    Height = 21
    DataField = 'iTemp5'
    DataSource = dsStations
    TabOrder = 10
  end
  object dbEditTemp6: TDBEdit
    Left = 566
    Top = 373
    Width = 121
    Height = 21
    DataField = 'iTemp6'
    DataSource = dsStations
    TabOrder = 11
  end
  object dbcbActive: TDBCheckBox
    Left = 566
    Top = 159
    Width = 97
    Height = 17
    TabStop = False
    Caption = 'Active'
    DataField = 'bActive'
    DataSource = dsStations
    TabOrder = 13
    ValueChecked = 'True'
    ValueUnchecked = 'False'
  end
  object dbEditSortOrder: TDBEdit
    Left = 566
    Top = 196
    Width = 121
    Height = 21
    DataField = 'iSortOrder'
    DataSource = dsStations
    TabOrder = 2
  end
  object dsStations: TDataSource
    DataSet = spStations
    Left = 576
    Top = 8
  end
  object spStations: TADOStoredProc
    Connection = frmMain.connWeather
    CursorType = ctStatic
    ProcedureName = 'mpc_wx_GetAllStations;1'
    Parameters = <>
    Left = 536
    Top = 8
  end
end
