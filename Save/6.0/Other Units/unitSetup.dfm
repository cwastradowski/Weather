object frmSetup: TfrmSetup
  Left = 174
  Top = 115
  Caption = 'Miracle Programming Company - Weather Records - Setup Form'
  ClientHeight = 487
  ClientWidth = 1009
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnHide = FormHide
  PixelsPerInch = 96
  TextHeight = 13
  object dbGridStations: TDBGrid
    Left = 38
    Top = 8
    Width = 189
    Height = 110
    TabStop = False
    DataSource = dsStations
    ReadOnly = True
    TabOrder = 0
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
      end>
  end
  object DBNavigator1: TDBNavigator
    Left = 38
    Top = 124
    Width = 189
    Height = 25
    DataSource = dsStations
    VisibleButtons = [nbFirst, nbPrior, nbNext, nbLast, nbInsert, nbPost, nbCancel]
    ParentShowHint = False
    ShowHint = True
    TabOrder = 4
  end
  object groupBoxChartSetup: TGroupBox
    Left = 783
    Top = 280
    Width = 217
    Height = 148
    Caption = 'Chart Set Up'
    TabOrder = 3
    object Label14: TLabel
      Left = 3
      Top = 51
      Width = 79
      Height = 13
      Caption = 'High Temp Color'
    end
    object Label15: TLabel
      Left = 3
      Top = 78
      Width = 77
      Height = 13
      Caption = 'Low Temp Color'
    end
    object Label5: TLabel
      Left = 3
      Top = 24
      Width = 52
      Height = 13
      Caption = 'Chart Days'
    end
    object Label16: TLabel
      Left = 5
      Top = 105
      Width = 49
      Height = 13
      Caption = 'Rain Color'
    end
    object dbEditChartLineHighColor: TDBEdit
      Left = 88
      Top = 47
      Width = 121
      Height = 21
      DataField = 'iChartLineColorHigh'
      DataSource = dsStations
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnChange = dbEditChartLineHighColorChange
      OnDblClick = dbEditChartLineHighColorDblClick
    end
    object dbEditChartLineLowColor: TDBEdit
      Left = 88
      Top = 74
      Width = 121
      Height = 21
      DataField = 'iChartLineColorLow'
      DataSource = dsStations
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnChange = dbEditChartLineLowColorChange
      OnDblClick = dbEditChartLineLowColorDblClick
    end
    object editChartDays: TEdit
      Left = 88
      Top = 20
      Width = 121
      Height = 21
      TabOrder = 0
    end
    object dbEditChartLineRainColor: TDBEdit
      Left = 88
      Top = 101
      Width = 121
      Height = 21
      DataField = 'iChartLineColorRain'
      DataSource = dsStations
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      OnChange = dbEditChartLineRainColorChange
      OnDblClick = dbEditChartLineRainColorDblClick
    end
  end
  object gbImport: TGroupBox
    Left = 8
    Top = 280
    Width = 769
    Height = 203
    Caption = 'Import Elements Setup'
    TabOrder = 2
    object Label19: TLabel
      Left = 5
      Top = 163
      Width = 174
      Height = 13
      Caption = 'New Import Type Name to be cloned'
    end
    object Label17: TLabel
      Left = 3
      Top = 22
      Width = 56
      Height = 13
      Caption = 'Import Type'
    end
    object Label18: TLabel
      Left = 267
      Top = 22
      Width = 75
      Height = 13
      Caption = 'Import Elements'
    end
    object DBGrid1: TDBGrid
      Left = 3
      Top = 41
      Width = 258
      Height = 116
      DataSource = dsImportType
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'sName'
          Title.Caption = 'Type Name'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'bDefault'
          PickList.Strings = (
            'True'
            'False')
          Title.Caption = 'Default'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'bActive'
          PickList.Strings = (
            'True'
            'False')
          Title.Caption = 'Active'
          Visible = True
        end>
    end
    object btnCloneType: TButton
      Left = 186
      Top = 175
      Width = 75
      Height = 25
      Caption = 'Clone Type'
      Enabled = False
      TabOrder = 2
      OnClick = btnCloneTypeClick
    end
    object editNewImportTypeName: TEdit
      Left = 5
      Top = 179
      Width = 175
      Height = 21
      TabOrder = 1
      OnChange = editNewImportTypeNameChange
    end
    object DBGrid2: TDBGrid
      Left = 267
      Top = 41
      Width = 483
      Height = 129
      DataSource = dsImportData
      TabOrder = 3
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'idElement'
          Title.Caption = 'Element #'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'iFirstLine'
          Title.Caption = 'First Line'
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'iLastLine'
          Title.Caption = 'Last Line'
          Width = 60
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'iFirstPosition'
          Title.Caption = 'First Position'
          Width = 65
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'iLastPosition'
          Title.Caption = 'Last Position'
          Width = 65
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'sComments'
          Title.Caption = 'Comments'
          Width = 130
          Visible = True
        end>
    end
  end
  object gbStationData: TGroupBox
    Left = 267
    Top = 8
    Width = 698
    Height = 257
    Caption = 'Station Data'
    TabOrder = 1
    object dbTextStationName: TDBText
      Left = 152
      Top = 14
      Width = 272
      Height = 22
      DataField = 'sStation'
      DataSource = dsStations
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label10: TLabel
      Left = 99
      Top = 192
      Width = 36
      Height = 13
      Caption = 'Temp 4'
    end
    object Label7: TLabel
      Left = 99
      Top = 154
      Width = 36
      Height = 13
      Caption = 'Temp 1'
    end
    object Label13: TLabel
      Left = 3
      Top = 126
      Width = 70
      Height = 13
      Caption = 'NWS File Path'
    end
    object Label6: TLabel
      Left = 3
      Top = 99
      Width = 91
      Height = 13
      Caption = 'NWS Web Caption'
    end
    object Label4: TLabel
      Left = 3
      Top = 72
      Width = 66
      Height = 13
      Caption = 'Weather URL'
    end
    object Label1: TLabel
      Left = 99
      Top = 46
      Width = 33
      Height = 13
      Caption = 'Station'
    end
    object Label2: TLabel
      Left = 304
      Top = 46
      Width = 56
      Height = 13
      Caption = 'Short Name'
    end
    object Label3: TLabel
      Left = 493
      Top = 46
      Width = 48
      Height = 13
      Caption = 'Sort Order'
    end
    object Label8: TLabel
      Left = 279
      Top = 154
      Width = 36
      Height = 13
      Caption = 'Temp 2'
    end
    object Label11: TLabel
      Left = 279
      Top = 192
      Width = 36
      Height = 13
      Caption = 'Temp 5'
    end
    object Label9: TLabel
      Left = 468
      Top = 154
      Width = 36
      Height = 13
      Caption = 'Temp 3'
    end
    object Label12: TLabel
      Left = 468
      Top = 192
      Width = 36
      Height = 13
      Caption = 'Temp 6'
    end
    object Label20: TLabel
      Left = 99
      Top = 233
      Width = 77
      Height = 13
      Caption = 'Begin Rain Year'
    end
    object Label21: TLabel
      Left = 279
      Top = 233
      Width = 69
      Height = 13
      Caption = 'End Rain Year'
    end
    object dbEditTemp4: TDBEdit
      Left = 141
      Top = 189
      Width = 121
      Height = 21
      DataField = 'iTemp4'
      DataSource = dsStations
      TabOrder = 10
    end
    object dbEditTemp1: TDBEdit
      Left = 141
      Top = 150
      Width = 121
      Height = 21
      DataField = 'iTemp1'
      DataSource = dsStations
      TabOrder = 7
    end
    object dbEditFilePath: TDBEdit
      Left = 99
      Top = 123
      Width = 569
      Height = 21
      DataField = 'sNWSFilePath'
      DataSource = dsStations
      TabOrder = 6
    end
    object dbEditWebCaption: TDBEdit
      Left = 99
      Top = 96
      Width = 569
      Height = 21
      DataField = 'sNWSUrlFormCaption'
      DataSource = dsStations
      TabOrder = 5
    end
    object dbEditURl: TDBEdit
      Left = 99
      Top = 69
      Width = 569
      Height = 21
      DataField = 'sNWSUrl'
      DataSource = dsStations
      TabOrder = 4
    end
    object dbEditStation: TDBEdit
      Left = 152
      Top = 42
      Width = 121
      Height = 21
      DataField = 'sStation'
      DataSource = dsStations
      TabOrder = 0
    end
    object dbEditShortName: TDBEdit
      Left = 366
      Top = 42
      Width = 121
      Height = 21
      DataField = 'sShortName'
      DataSource = dsStations
      TabOrder = 1
    end
    object dbEditSortOrder: TDBEdit
      Left = 547
      Top = 42
      Width = 121
      Height = 21
      DataField = 'iSortOrder'
      DataSource = dsStations
      TabOrder = 2
    end
    object dbEditTemp2: TDBEdit
      Left = 325
      Top = 150
      Width = 121
      Height = 21
      DataField = 'iTemp2'
      DataSource = dsStations
      TabOrder = 8
    end
    object dbEditTemp5: TDBEdit
      Left = 325
      Top = 189
      Width = 121
      Height = 21
      DataField = 'iTemp5'
      DataSource = dsStations
      TabOrder = 11
    end
    object dbEditTemp3: TDBEdit
      Left = 518
      Top = 150
      Width = 121
      Height = 21
      DataField = 'iTemp3'
      DataSource = dsStations
      TabOrder = 9
    end
    object dbEditTemp6: TDBEdit
      Left = 518
      Top = 189
      Width = 121
      Height = 21
      DataField = 'iTemp6'
      DataSource = dsStations
      TabOrder = 12
    end
    object dbcbActive: TDBCheckBox
      Left = 602
      Top = 19
      Width = 63
      Height = 17
      TabStop = False
      Caption = 'Active'
      DataField = 'bActive'
      DataSource = dsStations
      TabOrder = 3
    end
    object DBEdit1: TDBEdit
      Left = 354
      Top = 233
      Width = 91
      Height = 21
      DataField = 'sEndRainYear'
      DataSource = dsStations
      TabOrder = 13
    end
    object DBEdit2: TDBEdit
      Left = 182
      Top = 233
      Width = 80
      Height = 21
      DataField = 'sBeginRainYear'
      DataSource = dsStations
      TabOrder = 14
    end
  end
  object dsStations: TDataSource
    DataSet = simpleDSStations
    Left = 376
    Top = 8
  end
  object diaColor1: TColorDialog
    Left = 144
    Top = 56
  end
  object dsImportData: TDataSource
    DataSet = simpleDSlImportData
    Left = 456
    Top = 312
  end
  object dsImportType: TDataSource
    DataSet = simpleDSlImportType
    Left = 184
    Top = 312
  end
  object simpleDSlImportType: TSimpleDataSet
    Aggregates = <>
    Connection = frmMain.conWeather
    DataSet.CommandText = 'tblImportType'
    DataSet.CommandType = ctTable
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    Params = <>
    AfterPost = simpleDSlImportTypeAfterPost
    AfterDelete = simpleDSlImportTypeAfterDelete
    Left = 64
    Top = 320
  end
  object simpleDSlImportData: TSimpleDataSet
    Aggregates = <>
    Connection = frmMain.conWeather
    DataSet.CommandText = 'tblImportData'
    DataSet.CommandType = ctTable
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    IndexFieldNames = 'idImportType'
    MasterFields = 'idImportType'
    MasterSource = dsImportType
    PacketRecords = 0
    Params = <>
    AfterPost = simpleDSlImportDataAfterPost
    AfterDelete = simpleDSlImportDataAfterDelete
    Left = 344
    Top = 312
  end
  object simpleDSStations: TSimpleDataSet
    Aggregates = <>
    Connection = frmMain.conWeather
    DataSet.CommandText = 'select * from tblStation order by iSortOrder'
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    Params = <>
    AfterPost = simpleDSStationsAfterPost
    AfterDelete = simpleDSStationsAfterDelete
    Left = 288
    Top = 32
  end
end
