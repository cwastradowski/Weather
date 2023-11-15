unit Main;

interface

uses
  //DBTables,
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, DBCtrls, TeEngine,ActnList, Menus,  mpcSQL,
  Series, TeeProcs, Chart, DBChart, StdCtrls, TeeFunci, ComCtrls, Registry,
  mpcUserName, DBClient, Provider,  DateUtils, WideStrings, FMTBcd,
  SqlExpr, Data.DBXMSSQL, SimpleDS, Data.DB, Vcl.ExtCtrls, System.Actions,
  FmPosIni;

type
  TfrmMain = class(TForm)
    btnReset: TButton;
    menuMain: TMainMenu;
    ActionList1: TActionList;
    actFileExit: TAction;
    actReportsSummaryMonthly: TAction;
    File1: TMenuItem;
    FileExit: TMenuItem;
    Reports1: TMenuItem;
    ReportsSummaryMonthly: TMenuItem;
    menufileOnTop: TMenuItem;
    actOnTop: TAction;
    actImport: TAction;
    menuImport: TMenuItem;
    actBtnLA: TAction;
    actBtnPhx: TAction;
    actCloseWebFrm: TAction;
    menuSetup: TMenuItem;
    actSetup: TAction;
    btnStats: TButton;
    panelStats: TPanel;
    calQueryEndDate: TMonthCalendar;
    btnRefreshStats: TButton;
    btnCancelRefresh: TButton;
    calQueryStartDate: TMonthCalendar;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    lblQueryRange: TLabel;
    btnMidYear: TButton;
    btnCurrentYear: TButton;
    btnFullDatabase: TButton;
    btnDefaultStats: TButton;
    cbCompareToDate: TCheckBox;
    StatusBar1: TStatusBar;
    actBtnSNA: TAction;
    pnlWxGrid: TPanel;
    pgCtrTempGrid: TPageControl;
    pnlAllStats: TPanel;
    pgCtrAllStats: TPageControl;
    pnlChart: TPanel;
    pgCTRChart: TPageControl;
    conWeather: TSQLConnection;

    procedure FormCreate(Sender: TObject);
    function max(a, b: Integer): Integer;
    function min(a, b: Integer): Integer;
    function maxFloat(a, b: single): single;
    procedure btnRefreshStatsClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnResetClick(Sender: TObject);
    procedure actFileExitExecute(Sender: TObject);
    procedure actOnTopExecute(Sender: TObject);
    procedure actImportExecute(Sender: TObject);
    procedure actCloseWebFrmExecute(Sender: TObject);
    procedure actSetupExecute(Sender: TObject);
    procedure calQueryEndDateClick(Sender: TObject);
    procedure btnStatsClick(Sender: TObject);
    procedure btnCancelRefreshClick(Sender: TObject);
    procedure calQueryStartDateClick(Sender: TObject);
    procedure btnMidYearClick(Sender: TObject);
    procedure btnCurrentYearClick(Sender: TObject);
    procedure btnFullDatabaseClick(Sender: TObject);
    procedure btnDefaultStatsClick(Sender: TObject);
    procedure initializePGCTRTempGrid;
    procedure initializePGCTRAllStats;
    procedure initializePGCTRChart;
    procedure OnNewWxRecord(_WxDataSet: TDataSet);
    procedure OnURLBtnClick(Sender: TObject);
    procedure WxGridTabSheetOnShow(Sender: TObject);
    procedure dbTempgridColors(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure CDSAfterPost(DataSet: TDataSet);
    procedure CDSAfterDelete(DataSet: TDataSet);
    procedure pgCtrTempGridChange(Sender: TObject);
    procedure pgCTRChartChange(Sender: TObject);
    procedure pgCtrAllStatsChange(Sender: TObject);

  private
    { Private declarations }

    procedure GetReg;
    procedure SetReg;
    procedure InitializeStationInfo;
    procedure AddHighLowSeriesToChart(iChartIndex: Integer; DBChart: TDBChart);
    procedure AddAverageSeriesToChart(iChartIndex: Integer; DBChart: TDBChart);
    procedure AddRainSeriesToChart(iChartIndex: Integer; DBChart: TDBChart);
    procedure ShowDefaultStats;

  public
    { Public declarations }
    bStatsControlsCreated: boolean;
    aPGCTRStatsPages, aPGCTRLChartPages: array of TPageControl;
    aTabSheetTemp, aTabSheetStats, aTabSheetChart: array of TTabSheet;
    aTabSheetStatsPage1, aTabSheetStatsPage2, aTabSheetStatsPage3,
      aTabSheetStatsPage4: array of TTabSheet;
    aTabSheetChartHighLow, aTabSheetChartAverage,
      aTabSheetChartRain: array of TTabSheet;
    aDBGridTemp: array of TDBGrid;
    aStringGridStatsPage1, aStringGridStatsPage2, aStringGridStatsPage3,
      aStringGridStatsPage4: array of TStringGrid;

    aSPTempGrid: array of TSimpleDataSet;

    aSDS: array of TSQLDataSet;
    aDSP: array of TDataSetProvider;
    aCDS: array of TClientDataSet;




    aDBGridDataSource: array of TDataSource;
    aDBNav: array of TDBNavigator;
    aURLBtn: array of TButton;
    aHighLowCharts, aAverageCharts, aRainCharts: array of TDBChart;

  end;

type
  TDefaultValues = record
    IndexNo: Integer;
    UserName: string;
    KeyName: string;
    SubKeyName: string;
    Value: string;
    Datatype: string;
  end;

type
  TStationInfo = record
    idStation: Integer;
    sStation: string;
    sShortName: string;
    sNWSUrl: string;
    sNWSUrlFormCaption: string;
    sNWSFilePath: string;
    dFirstDate: TDateTime;
    dLastDate: TDateTime;
    sBeginRainYear : string;
    sEndRainYear : string;
    iTemp1: Integer;
    iTemp2: Integer;
    iTemp3: Integer;
    iTemp4: Integer;
    iTemp5: Integer;
    iTemp6: Integer;
    iSortOrder: Integer;
    iChartColorHigh: Integer;
    iChartColorLow: Integer;
    iChartColorRain: Integer;
  end;

var
  frmMain: TfrmMain;
  bViewStats: boolean;
  Present, FirstDate: TDateTime;
  LA_URL, PHX_URL, SNA_URL: string;
  Year, Month, Day: Word;
  clOrange: TColor;
  Headers1LA, Headers2LA, Headers1Px, Headers2Px, Headers1, Headers2,
    Headers3: array [1 .. 7] of Integer;
  sPhxRawDataPath, sLARawDataPath, sSNARawDataPath, sXMLPath: string;
  wQueryBeginYear, wQueryBeginMonth, wQueryBeginDay: Word;
  wQueryEndYear, wQueryEndMonth, wQueryEndDay: Word;
  iChartDays: Integer;
  dtLastDate: TDateTime;
  bDataChanged: boolean;
  sServerName: string;
  sUserName: string;
  sDefaultUserName: string;
  aLAPage2Temps: array [0 .. 5] of Integer;
  aPhxPage2Temps: array [0 .. 5] of Integer;
  iDefaultArrayLength: Integer;
  aDefaults1, aDefaults2, aDefaults3: array [0 .. 11] of string;
  aDefaults: array [0 .. 11] of TDefaultValues;
  aStationInfo: array of TStationInfo;
  clColor: TColor = clBtnFace;
  nStationCount: Integer;

implementation

uses unitStats, unitWebBrowser, unitSetup, unitImport;
{$R *.DFM}

{$REGION 'Initialize Stuff'}

procedure TfrmMain.FormCreate(Sender: TObject);
var
  sVersion : String;
begin
  sVersion :='Version 6.0 -- 9/1/2021';
  //Modifidy the main form caption to append Platform Identifier
  {$IFDEF Win64}
  frmMain.Caption := frmMain.Caption + ' 10.3 Win 64';
  {$ELSE}
  frmMain.Caption := frmMain.Caption + ' 10.3 Win 32';
  {$ENDIF}

  bStatsControlsCreated := False;
  bDataChanged := False;

  // Connection String
  sServerName := mpcGetComputerName;
  sUserName := mpcGetUserName;
  sDefaultUserName := '   ' + sServerName + '\' + sUserName;
  StatusBar1.Panels[0].Text := sDefaultUserName;
  StatusBar1.Panels[1].Text := sVersion;

  Present := Now;
  DecodeDate(Present, Year, Month, Day);
  // Read the Registry
  GetReg;

  // Define the color orange
  clOrange := RGB(255, 128, 0);

  // Default values for the query year
  calQueryStartDate.Date := FirstDate;
  calQueryEndDate.Date := Now - 1;
  DecodeDate(calQueryStartDate.Date, wQueryBeginYear, wQueryBeginMonth,
    wQueryBeginDay);
  DecodeDate(Now - 1, wQueryEndYear, wQueryEndMonth, wQueryEndDay);

  lblQueryRange.Caption := 'Stats for dates from ' + DateToStr
    (calQueryStartDate.Date) + ' to ' + DateToStr
    (calQueryEndDate.Date) + '.';

  InitializeStationInfo;
  initializePGCTRTempGrid;
  initializePGCTRChart;

end;

procedure TfrmMain.FormDestroy(Sender: TObject);
var
  i:Integer;
begin
  SetReg;
  for i := 0 to Length(aStationInfo) - 1 do
  begin
    aCDS[i].ApplyUpdates(0);
  end;
end;

procedure TfrmMain.dbTempgridColors(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if (Column.FieldName = 'fRain') then
  begin
    if Column.Field.Value > 0 then
    begin
      aDBGridTemp[TDBGrid(Sender).Tag].Canvas.Font.Color := clBlue;
      aDBGridTemp[TDBGrid(Sender).Tag].DefaultDrawColumnCell(Rect, DataCol,
        Column, State);
    end;
  end;
  if Column.FieldName = 'iHigh' then
  begin
    if Column.Field.Value >= 80 then
    begin
      aDBGridTemp[TDBGrid(Sender).Tag].Canvas.Font.Color := clOrange;
      aDBGridTemp[TDBGrid(Sender).Tag].DefaultDrawColumnCell(Rect, DataCol,
        Column, State);
    end
  end;
end;

procedure TfrmMain.initializePGCTRTempGrid;
var
  i: Integer;
begin
  SetLength(aSDS, nStationCount);
  SetLength(aDSP, nStationCount);
  SetLength(aCDS, nStationCount);
  SetLength(aTabSheetTemp, nStationCount);
  SetLength(aDBGridTemp, nStationCount);

  SetLength(aDBGridDataSource, nStationCount);
  SetLength(aDBNav, nStationCount);
  SetLength(aURLBtn, nStationCount);

  for i := 0 to nStationCount - 1 do
  begin
    //set up the database components
    //TSQLDataSet
    aSDS[i] := TSQLDataSet.Create(nil);
    aSDS[i].Tag := aStationInfo[i].idStation;
    aSDS[i].SQLConnection := conWeather;
    aSDS[i].CommandType := ctQuery;
    aSDS[i].CommandText := 'select * from tblWeather where idStation = ' +
                           IntToStr(aSDS[i].Tag) + ' order by dtDate';
    //TDataSetProvider
    aDSP[i] := TDataSetProvider.Create(nil);
    aDSP[i].Tag := aStationInfo[i].idStation;
    aDSP[i].DataSet := aSDS[i];

    //TClientDataSet
    aCDS[i] := TClientDataSet.Create(nil);
    aCDS[i].Tag := aStationInfo[i].idStation;
    //Use Set Provider function rather that providernamer property
    aCDS[i].SetProvider(aDSP[i]);
    aCDS[i].OnNewRecord := OnNewWxRecord;
    aCDS[i].AfterPost := CDSAfterPost;
    aCDS[i].AfterDelete := CDSAfterDelete;

    //Create the tab sheets for each station
    aTabSheetTemp[i] := TTabSheet.Create(self);
    aTabSheetTemp[i].PageControl := pgCtrTempGrid;
    aTabSheetTemp[i].Caption := aStationInfo[i].sShortName;
    aTabSheetTemp[i].Tag := i;
    aTabSheetTemp[i].OnShow := WxGridTabSheetOnShow;
    //create the dbgrid and put it on the tab sheets
    aDBGridTemp[i] := TDBGrid.Create(self);
    aDBGridTemp[i].Parent := aTabSheetTemp[i];
    aDBGridTemp[i].Top := 0;
    aDBGridTemp[i].Left := 0;
    aDBGridTemp[i].Width := 232;
    aDBGridTemp[i].Height := 150;
    aDBGridTemp[i].Tag := i;
    aDBGridTemp[i].OnDrawColumnCell := dbTempgridColors;


    aDBGridDataSource[i] := TDataSource.Create(self);
    aDBGridDataSource[i].DataSet := aCDS[i];
    aDBGridTemp[i].DataSource := aDBGridDataSource[i];
    aDBGridTemp[i].Font.Style := [fsBold];
    aDBGridTemp[i].Columns.Add;
    aDBGridTemp[i].Columns[0].FieldName := 'dtDate';
    aDBGridTemp[i].Columns[0].Title.Caption := 'Date';
    aDBGridTemp[i].Columns[0].Width := 75;
    aDBGridTemp[i].Columns.Add;
    aDBGridTemp[i].Columns[1].FieldName := 'iHigh';
    aDBGridTemp[i].Columns[1].Title.Caption := 'High';
    aDBGridTemp[i].Columns[1].Width := 40;
    aDBGridTemp[i].Columns.Add;
    aDBGridTemp[i].Columns[2].FieldName := 'iLow';
    aDBGridTemp[i].Columns[2].Title.Caption := 'Low';
    aDBGridTemp[i].Columns[2].Width := 40;
    aDBGridTemp[i].Columns.Add;
    aDBGridTemp[i].Columns[3].FieldName := 'fRain';
    aDBGridTemp[i].Columns[3].Title.Caption := 'Rain';
    aDBGridTemp[i].Columns[3].Width := 40;

    aDBNav[i] := TDBNavigator.Create(self);
    aDBNav[i].Parent := aTabSheetTemp[i];
    aDBNav[i].Left := 0;
    aDBNav[i].Top := 155;
    aDBNav[i].Width := 230;
    aDBNav[i].Height := 30;
    aDBNav[i].VisibleButtons := [nbFirst, nbPrior, nbNext, nbLast, nbPost,nbApplyUpdates];
    aDBNav[i].DataSource := aDBGridDataSource[i];
    aDBNav[i].ShowHint := True;

    aURLBtn[i] := TButton.Create(self);
    aURLBtn[i].Parent := aTabSheetTemp[i];
    aURLBtn[i].Tag := i;
    aURLBtn[i].Caption := aStationInfo[i].sShortName + ' &URL';
    aURLBtn[i].OnClick := OnURLBtnClick;
    aURLBtn[i].Top := 30;
    aURLBtn[i].Left := 240;
    aURLBtn[i].Width := 80;

    aCDS[i].Active := True;
    aCDS[i].Last;


  end;
end;

procedure TfrmMain.WxGridTabSheetOnShow(Sender: TObject);
begin
  aDBGridTemp[TTabSheet(Sender).Tag].SetFocus;
end;

procedure TfrmMain.initializePGCTRAllStats;
var
  i: Integer;
begin
  bStatsControlsCreated := True;
  SetLength(aTabSheetStats, nStationCount);
  SetLength(aTabSheetStatsPage1, nStationCount);
  SetLength(aTabSheetStatsPage2, nStationCount);
  SetLength(aTabSheetStatsPage3, nStationCount);
  SetLength(aTabSheetStatsPage4, nStationCount);
  SetLength(aStringGridStatsPage1, nStationCount);
  SetLength(aStringGridStatsPage2, nStationCount);
  SetLength(aStringGridStatsPage3, nStationCount);
  SetLength(aStringGridStatsPage4, nStationCount);
  SetLength(aPGCTRStatsPages, nStationCount);
  for i := 0 to nStationCount - 1 do
  begin
    aTabSheetStats[i] := TTabSheet.Create(self);
    aTabSheetStats[i].PageControl := pgCtrAllStats;
    aTabSheetStats[i].Caption := aStationInfo[i].sShortName;

    aPGCTRStatsPages[i] := TPageControl.Create(self);
    aPGCTRStatsPages[i].TabPosition := tpBottom;
    aPGCTRStatsPages[i].Parent := aTabSheetStats[i];
    aPGCTRStatsPages[i].Top := 0;
    aPGCTRStatsPages[i].Left := 0;
    aPGCTRStatsPages[i].Width := aTabSheetStats[i].Width;
    aPGCTRStatsPages[i].Height := aTabSheetStats[i].Height;

    aTabSheetStatsPage1[i] := TTabSheet.Create(self);
    aTabSheetStatsPage1[i].PageControl := aPGCTRStatsPages[i];
    aTabSheetStatsPage1[i].Caption := 'Page 1';

    aTabSheetStatsPage2[i] := TTabSheet.Create(self);
    aTabSheetStatsPage2[i].PageControl := aPGCTRStatsPages[i];
    aTabSheetStatsPage2[i].Caption := 'Page 2';

    aTabSheetStatsPage3[i] := TTabSheet.Create(self);
    aTabSheetStatsPage3[i].PageControl := aPGCTRStatsPages[i];
    aTabSheetStatsPage3[i].Caption := 'Page 3';

    aTabSheetStatsPage4[i] := TTabSheet.Create(self);
    aTabSheetStatsPage4[i].PageControl := aPGCTRStatsPages[i];
    aTabSheetStatsPage4[i].Caption := 'Page 4';

    aStringGridStatsPage1[i] := TStringGrid.Create(self);
    aStringGridStatsPage1[i].Parent := aTabSheetStatsPage1[i];
    aStringGridStatsPage1[i].Top := 0;
    aStringGridStatsPage1[i].Left := 0;
    aStringGridStatsPage1[i].Width := 500;
    aStringGridStatsPage1[i].Height := 200;
    aStringGridStatsPage1[i].DefaultColWidth := 58;
    aStringGridStatsPage1[i].ColWidths[0] := 65;
    aStringGridStatsPage1[i].DefaultRowHeight := 17;
    aStringGridStatsPage1[i].ScrollBars := ssBoth;
    aStringGridStatsPage1[i].ColCount := 8;
    aStringGridStatsPage1[i].RowCount := 2;
    aStringGridStatsPage1[i].FixedRows := 1;
    aStringGridStatsPage1[i].FixedCols := 1;
    aStringGridStatsPage1[i].Tag := i;

    aStringGridStatsPage2[i] := TStringGrid.Create(self);
    aStringGridStatsPage2[i].Parent := aTabSheetStatsPage2[i];
    aStringGridStatsPage2[i].Top := 0;
    aStringGridStatsPage2[i].Left := 0;
    aStringGridStatsPage2[i].Width := 500;
    aStringGridStatsPage2[i].Height := 200;
    aStringGridStatsPage2[i].DefaultColWidth := 67;
    aStringGridStatsPage2[i].ColWidths[0] := 70;
    aStringGridStatsPage2[i].DefaultRowHeight := 17;
    aStringGridStatsPage2[i].ScrollBars := ssBoth;
    aStringGridStatsPage2[i].ColCount := 7;
    aStringGridStatsPage2[i].RowCount := 2;
    aStringGridStatsPage2[i].FixedRows := 1;
    aStringGridStatsPage2[i].FixedCols := 1;
    aStringGridStatsPage2[i].Tag := i;

    aStringGridStatsPage3[i] := TStringGrid.Create(self);
    aStringGridStatsPage3[i].Parent := aTabSheetStatsPage3[i];
    aStringGridStatsPage3[i].Top := 0;
    aStringGridStatsPage3[i].Left := 0;
    aStringGridStatsPage3[i].Width := 500;
    aStringGridStatsPage3[i].Height := 200;
    aStringGridStatsPage3[i].DefaultColWidth := 67;
    aStringGridStatsPage3[i].ColWidths[0] := 70;
    aStringGridStatsPage3[i].DefaultRowHeight := 17;
    aStringGridStatsPage3[i].ScrollBars := ssBoth;
    aStringGridStatsPage3[i].ColCount := 7;
    aStringGridStatsPage3[i].RowCount := 2;
    aStringGridStatsPage3[i].FixedRows := 1;
    aStringGridStatsPage3[i].FixedCols := 1;
    aStringGridStatsPage3[i].Tag := i;

    aStringGridStatsPage4[i] := TStringGrid.Create(self);
    aStringGridStatsPage4[i].Parent := aTabSheetStatsPage4[i];
    aStringGridStatsPage4[i].Top := 0;
    aStringGridStatsPage4[i].Left := 0;
    aStringGridStatsPage4[i].Width := 500;
    aStringGridStatsPage4[i].Height := 200;
    aStringGridStatsPage4[i].DefaultColWidth := 67;
    aStringGridStatsPage4[i].ColWidths[0] := 70;
    aStringGridStatsPage4[i].DefaultRowHeight := 17;
    aStringGridStatsPage4[i].ScrollBars := ssBoth;
    aStringGridStatsPage4[i].ColCount := 7;
    aStringGridStatsPage4[i].RowCount := 4;
    aStringGridStatsPage4[i].FixedRows := 1;
    aStringGridStatsPage4[i].FixedCols := 1;
    aStringGridStatsPage4[i].Tag := i;

  end;
end;

procedure TfrmMain.initializePGCTRChart;
const
  iWidth: Integer = 971;
  iHeight: Integer = 282;
var
  i: Integer;
begin
  SetLength(aTabSheetChart, nStationCount);
  SetLength(aHighLowCharts, nStationCount);
  SetLength(aAverageCharts, nStationCount);
  SetLength(aRainCharts, nStationCount);
  SetLength(aPGCTRLChartPages, nStationCount);
  SetLength(aTabSheetChartHighLow, nStationCount);
  SetLength(aTabSheetChartAverage, nStationCount);
  SetLength(aTabSheetChartRain, nStationCount);
  // Set up the dimensions of the pgCtrChart
  pgCTRChart.Parent := pnlChart;
  // pgCtrChart.Brush.Color := clRed;
  pgCTRChart.Top := 1;
  pgCTRChart.Left := 1;
  pgCTRChart.Width := iWidth;
  pgCTRChart.Height := iHeight;

  for i := 0 to nStationCount - 1 do
  begin
    // Create the Tab Sheets for the page control
    aTabSheetChart[i] := TTabSheet.Create(pgCTRChart);
    aTabSheetChart[i].PageControl := pgCTRChart;
    aTabSheetChart[i].Tag := i;
    aTabSheetChart[i].Caption := aStationInfo[i].sShortName;
    aTabSheetChart[i].Top := 1;
    aTabSheetChart[i].Left := 1;
    aTabSheetChart[i].Width := iWidth - 1;
    aTabSheetChart[i].Height := iHeight - 1;
    // aTabSheetChart[i].Brush.Color := clRed;

    // Create the Page Control for each Tab Sheet
    aPGCTRLChartPages[i] := TPageControl.Create(aTabSheetChart[i]);
    aPGCTRLChartPages[i].Parent := aTabSheetChart[i];
    aPGCTRLChartPages[i].Top := 1;
    aPGCTRLChartPages[i].Left := 1;
    aPGCTRLChartPages[i].Width := iWidth - 2;
    aPGCTRLChartPages[i].Height := iHeight - 2;
    aPGCTRLChartPages[i].Style := tsButtons;
    // aPgCtrlChartPages[i].Brush.Color := clRed;

    // Create the 3 Tab Sheets for the above page control
    // High Low Tab Sheets
    aTabSheetChartHighLow[i] := TTabSheet.Create(self);
    aTabSheetChartHighLow[i].PageControl := aPGCTRLChartPages[i];
    aTabSheetChartHighLow[i].Caption := 'Highs and Lows';
    aTabSheetChartHighLow[i].Top := 1;
    aTabSheetChartHighLow[i].Left := 1;
    aTabSheetChartHighLow[i].Width := iWidth - 3;
    aTabSheetChartHighLow[i].Height := iHeight - 3;
    aTabSheetChartHighLow[i].Brush.Color := clRed;
    // Average Tab Sheets
    aTabSheetChartAverage[i] := TTabSheet.Create(self);
    aTabSheetChartAverage[i].PageControl := aPGCTRLChartPages[i];
    aTabSheetChartAverage[i].Caption := 'Average';
    aTabSheetChartAverage[i].Top := 1;
    aTabSheetChartAverage[i].Left := 1;
    aTabSheetChartAverage[i].Width := iWidth - 3;
    aTabSheetChartAverage[i].Height := iHeight - 3;
    // Rain Tab Sheets
    aTabSheetChartRain[i] := TTabSheet.Create(self);
    aTabSheetChartRain[i].PageControl := aPGCTRLChartPages[i];
    aTabSheetChartRain[i].Caption := 'Rain';
    aTabSheetChartRain[i].Top := 1;
    aTabSheetChartRain[i].Left := 1;
    aTabSheetChartRain[i].Width := iWidth - 3;
    aTabSheetChartRain[i].Height := iHeight - 3;

    // Create the charts for each Tab Sheet
    // High Low Charts
    aHighLowCharts[i] := TDBChart.Create(aTabSheetChartHighLow[i]);
    with aHighLowCharts[i] do
    begin
      Parent := aTabSheetChartHighLow[i];
      Tag := i;
      Top := 1;
      Left := 1;
      Width := iWidth - 4;
      Height := iHeight - 30;
      BackWall.Brush.Color := clWhite;
      BackWall.Brush.Style := bsClear;
      Title.Font.Color := clTeal;
      Title.Font.Height := -16;
      Title.Font.Style := [fsBold, fsUnderline];
      Title.Frame.Color := 33023;
      Title.Frame.Style := psDashDot;
      Title.Text.Add('Highs and Lows for the last ' + IntToStr(iChartDays)
          + ' days for ' + Trim(aStationInfo[i].sStation));
      BottomAxis.DateTimeFormat := 'mm/dd/yy';
      Chart3DPercent := 5;
      DepthAxis.Automatic := False;
      DepthAxis.AutomaticMaximum := False;
      DepthAxis.AutomaticMinimum := False;
      DepthAxis.Maximum := 1.490000000000001000;
      DepthAxis.Minimum := 0.490000000000000500;
      DepthTopAxis.Automatic := False;
      DepthTopAxis.AutomaticMaximum := False;
      DepthTopAxis.AutomaticMinimum := False;
      DepthTopAxis.Maximum := 1.490000000000001000;
      DepthTopAxis.Minimum := 0.490000000000000500;
      LeftAxis.Title.Caption := 'Temperature';
      Legend.Visible := True;
      BottomAxis.Title.Caption := 'Date';
      View3D := False;
      View3DWalls := False;
      Align := alBottom;
      TabOrder := 0;
      Visible := True;
    end;
    AddHighLowSeriesToChart(i, aHighLowCharts[i]);

    // Average Charts
    aAverageCharts[i] := TDBChart.Create(self);
    with aAverageCharts[i] do
    begin
      Parent := aTabSheetChartAverage[i];
      Tag := i;
      Top := 1;
      Left := 1;
      Width := iWidth - 4;
      Height := iHeight - 30;
      BackWall.Brush.Color := clWhite;
      BackWall.Brush.Style := bsClear;
      Title.Font.Color := clTeal;
      Title.Font.Height := -16;
      Title.Font.Style := [fsBold, fsUnderline];
      Title.Frame.Color := 33023;
      Title.Frame.Style := psDashDot;
      Title.Text.Add('Average Temperatures for the last ' + IntToStr
          (iChartDays) + ' days for ' + Trim(aStationInfo[i].sStation));
      BottomAxis.DateTimeFormat := 'mm/dd/yy';
      Chart3DPercent := 5;
      DepthAxis.Automatic := False;
      DepthAxis.AutomaticMaximum := False;
      DepthAxis.AutomaticMinimum := False;
      DepthAxis.Maximum := 1.490000000000001000;
      DepthAxis.Minimum := 0.490000000000000500;
      DepthTopAxis.Automatic := False;
      DepthTopAxis.AutomaticMaximum := False;
      DepthTopAxis.AutomaticMinimum := False;
      DepthTopAxis.Maximum := 1.490000000000001000;
      DepthTopAxis.Minimum := 0.490000000000000500;
      LeftAxis.Title.Caption := 'Temperature';
      Legend.Visible := False;
      BottomAxis.Title.Caption := 'Date';
      View3D := False;
      View3DWalls := False;
      Align := alBottom;
      TabOrder := 0;
      Visible := True;
    end;
    AddAverageSeriesToChart(i, aAverageCharts[i]);

    // Rain Charts
    aRainCharts[i] := TDBChart.Create(self);
    with aRainCharts[i] do
    begin
      Parent := aTabSheetChartRain[i];
      Tag := i;
      Top := 1;
      Left := 1;
      Width := iWidth - 4;
      Height := iHeight - 30;
      BackWall.Brush.Color := clWhite;
      BackWall.Brush.Style := bsClear;
      Title.Font.Color := clTeal;
      Title.Font.Height := -16;
      Title.Font.Style := [fsBold, fsUnderline];
      Title.Frame.Color := 33023;
      Title.Frame.Style := psDashDot;
      Title.Text.Add('Rain Amounts for the last ' + IntToStr(iChartDays)
          + ' days for ' + Trim(aStationInfo[i].sStation));
      BottomAxis.DateTimeFormat := 'mm/dd/yy';
      Chart3DPercent := 5;
      DepthAxis.Automatic := False;
      DepthAxis.AutomaticMaximum := False;
      DepthAxis.AutomaticMinimum := False;
      DepthAxis.Maximum := 1.490000000000001000;
      DepthAxis.Minimum := 0.490000000000000500;
      DepthTopAxis.Automatic := False;
      DepthTopAxis.AutomaticMaximum := False;
      DepthTopAxis.AutomaticMinimum := False;
      DepthTopAxis.Maximum := 1.490000000000001000;
      DepthTopAxis.Minimum := 0.490000000000000500;
      LeftAxis.Title.Caption := 'Rain Fall';
      Legend.Visible := False;
      BottomAxis.Title.Caption := 'Date';
      View3D := False;
      View3DWalls := False;
      Align := alBottom;
      TabOrder := 0;
      Visible := True;
    end;
    AddRainSeriesToChart(i, aRainCharts[i]);

  end;
end;

procedure TfrmMain.InitializeStationInfo;
var
  //sdsActiveStations is the TSimpleDataSet component to retrieve the active
  //weather stations
  sdsStations : TSimpleDataSet;
  i: Integer;
begin
  //Create the Simple Data Set component
  with sdsStations do
  begin
    sdsStations := TSimpleDataSet.Create(nil);
    Connection := conWeather;
    DataSet.CommandType := ctStoredProc;
    DataSet.CommandText := 'mpc_wx_GetActiveStations';
    Active := True;
    nStationCount := RecordCount;
    //Tell record type aStationInfo how many members there are
    SetLength(aStationInfo, nStationCount);
    First;
    for i:= 0 to RecordCount - 1 do
    begin
      //aStationInfo is an record type containing information about the weather stations
      //Fill the record with data
      aStationInfo[i].idStation := FieldByName('idStation').AsInteger;
      aStationInfo[i].sStation := FieldByName('sStation').AsString;
      aStationInfo[i].sShortName := FieldByName('sShortName').AsString;
      aStationInfo[i].sNWSUrl := FieldByName('sNWSUrl').AsString;
      aStationInfo[i].sNWSUrlFormCaption := FieldByName('sNWSUrlFormCaption')
        .AsString;
      aStationInfo[i].sNWSFilePath := FieldByName('sNWSFilePath').AsString;
      aStationInfo[i].iTemp1 := FieldByName('iTemp1').AsInteger;
      aStationInfo[i].iTemp2 := FieldByName('iTemp2').AsInteger;
      aStationInfo[i].iTemp3 := FieldByName('iTemp3').AsInteger;
      aStationInfo[i].iTemp4 := FieldByName('iTemp4').AsInteger;
      aStationInfo[i].iTemp5 := FieldByName('iTemp5').AsInteger;
      aStationInfo[i].iTemp6 := FieldByName('iTemp6').AsInteger;
      aStationInfo[i].iSortOrder := FieldByName('iSortOrder').AsInteger;
      aStationInfo[i].iChartColorHigh := FieldByName('iChartLineColorHigh')
        .AsInteger;
      aStationInfo[i].iChartColorLow := FieldByName('iChartLineColorLow')
        .AsInteger;
      aStationInfo[i].iChartColorRain := FieldByName('iChartLineColorRain')
        .AsInteger;
      aStationInfo[i].dFirstDate := FieldByName('FirstDate').AsDateTime;
      aStationInfo[i].dLastDate := FieldByName('LastDate').AsDateTime;
      aStationInfo[i].sBeginRainYear := FieldByName('sBeginRainYear').AsString;
      aStationInfo[i].sEndRainYear := FieldByName('sEndRainYear').AsString;
      Next;
    end;
    //Clean up the sdsStations component
    Active := False;
    Destroy;
  end;
end;
{$ENDREGION}

{$REGION 'Misc Functions'}
function TfrmMain.max(a, b: Integer): Integer;
begin
  if a > b then
    result := a
  else
    result := b;
end;

function TfrmMain.min(a, b: Integer): Integer;
begin
  if a < b then
    result := a
  else
    result := b;
end;

function TfrmMain.maxFloat(a, b: single): single;
begin
  if a > b then
    result := a
  else
    result := b;
end;

procedure TfrmMain.ShowDefaultStats;
begin
  calQueryStartDate.Date := FirstDate;
  calQueryEndDate.Date := Now - 1;
  lblQueryRange.Caption := 'Stats for dates from ' +
    DateToStr(calQueryStartDate.Date) + ' to ' +
    DateToStr(calQueryEndDate.Date) + '.';
  lblQueryRange.Refresh;
  btnRefreshStatsClick(self);
  pgCtrAllStats.ActivePageIndex := pgCtrTempGrid.ActivePageIndex;
end;
{$ENDREGION}

{$REGION 'Weather Events'}
procedure TfrmMain.OnNewWxRecord(_WxDataSet: TDataSet);
var
  sdsLastDate : TSimpleDataSet;
begin
  sdsLastDate := TSimpleDataSet.Create(nil);
  with sdsLastDate do
  begin
    //Use Stored Procedure called like a query to get the last date for the
    //current weather data set.
    Connection := conWeather;
    DataSet.CommandType := ctQuery;
    //Here is the stored procedure and _WxDataSet.Tag is the idStation of the
    //current weather data set
    DataSet.commandText := 'mpc_wx_LastDate ' + intToStr(_WxDataSet.Tag);
    Active := True;
    //Get the last date and increment by one for the next date
    _WxDataSet.FieldByName('dtDate').AsDateTime := FieldByName('LastDate').AsDateTime + 1;
    //clean up the simple data set component
    Active := False;
    Destroy;
  end;
  _WxDataSet.FieldByName('idStation').AsInteger := _WxDataSet.Tag;
  _WxDataSet.FieldByName('iHigh').AsInteger := 0;
  _WxDataSet.FieldByName('iLow').AsInteger := 0;
  _WxDataSet.FieldByName('fRain').AsFloat := 0;
end;

procedure TfrmMain.CDSAfterPost(DataSet: TDataSet);
begin
  TClientDataSet(DataSet).ApplyUpdates(0);
end;

procedure TfrmMain.CDSAfterDelete(DataSet: TDataSet);
begin
  TClientDataSet(DataSet).ApplyUpdates(0);
end;

procedure TfrmMain.OnURLBtnClick(Sender: TObject);
var
  bExists: boolean;
  i: Integer;
begin
  bExists := False;
  for i := 0 to Screen.FormCount - 1 do
  begin
    if Screen.Forms[i].name = 'frmWeb' then
      bExists := True;
  end;
  if not bExists then
  begin
    Application.CreateForm(TfrmWeb, frmWeb);
  end;
  frmWeb.Caption := aStationInfo[TButton(Sender).Tag].sNWSUrlFormCaption;
  frmWeb.webBro.Navigate(aStationInfo[TButton(Sender).Tag].sNWSUrl);
  frmWeb.Show;
  aDBGridTemp[TButton(Sender).Tag].SetFocus;
end;

procedure TfrmMain.pgCtrAllStatsChange(Sender: TObject);
begin
  pgCtrTempGrid.ActivePageIndex := pgCtrAllStats.ActivePageIndex;
  pgCtrChart.ActivePageIndex := pgCtrAllStats.ActivePageIndex;
end;

procedure TfrmMain.pgCTRChartChange(Sender: TObject);
begin
  pgCtrTempGrid.ActivePageIndex := pgCtrChart.ActivePageIndex;
  pgCtrAllStats.ActivePageIndex := pgCtrChart.ActivePageIndex;
end;

procedure TfrmMain.pgCtrTempGridChange(Sender: TObject);
begin
  pgCtrChart.ActivePageIndex := pgCtrTempGrid.ActivePageIndex;
  pgCtrAllStats.ActivePageIndex := pgCtrTempGrid.ActivePageIndex;
end;

{$ENDREGION}

{$REGION 'Calendar Clicks'}
procedure TfrmMain.calQueryStartDateClick(Sender: TObject);
begin
  DecodeDate(calQueryStartDate.Date, wQueryBeginYear, wQueryBeginMonth,
    wQueryBeginDay);
  lblQueryRange.Caption := 'Stats for dates from ' + DateToStr
    (calQueryStartDate.Date) + ' to ' + DateToStr
    (calQueryEndDate.Date) + '.';
  lblQueryRange.Refresh;
end;

procedure TfrmMain.calQueryEndDateClick(Sender: TObject);
begin
  DecodeDate(calQueryEndDate.Date, wQueryEndYear, wQueryEndMonth, wQueryEndDay);
  lblQueryRange.Caption := 'Stats for dates from ' + DateToStr
    (calQueryStartDate.Date) + ' to ' + DateToStr
    (calQueryEndDate.Date) + '.';
  lblQueryRange.Refresh;
end;
{$ENDREGION}

{$REGION 'Button clicks'}

procedure TfrmMain.btnStatsClick(Sender: TObject);
begin
  panelStats.Visible := True;
  pnlAllStats.Visible := False;
  lblQueryRange.Visible := True;
end;

procedure TfrmMain.btnCancelRefreshClick(Sender: TObject);
begin
  panelStats.Visible := False;
end;

procedure TfrmMain.btnMidYearClick(Sender: TObject);
var
  wYear, wMonth, wDay: Word;
begin
  DecodeDate(Now, wYear, wMonth, wDay);
  if wMonth >= 7 then
  begin
    calQueryStartDate.Date := StrToDate('07/01/' + IntToStr(wYear));
    calQueryEndDate.Date := StrToDate('06/30/' + IntToStr(wYear + 1))
  end
  else
  begin
    calQueryStartDate.Date := StrToDate('07/01/' + IntToStr(wYear - 1));
    calQueryEndDate.Date := StrToDate('06/30/' + IntToStr(wYear));
  end;
  calQueryStartDateClick(self);
end;

procedure TfrmMain.btnCurrentYearClick(Sender: TObject);
var
  wYear, wMonth, wDay: Word;
begin
  DecodeDate(Now, wYear, wMonth, wDay);
  calQueryStartDate.Date := StrToDate('01/01/' + IntToStr(wYear));
  calQueryEndDate.Date := Now - 1;
  calQueryStartDateClick(self);
  calQueryEndDateClick(self);
end;

procedure TfrmMain.btnDefaultStatsClick(Sender: TObject);
begin
  ShowDefaultStats;
end;

procedure TfrmMain.btnFullDatabaseClick(Sender: TObject);
begin
  calQueryStartDate.Date := aStationInfo[pgCtrTempGrid.ActivePageIndex].dFirstDate;
  calQueryEndDate.Date := aStationInfo[pgCtrTempGrid.ActivePageIndex].dLastDate;
  calQueryStartDateClick(self);
  calQueryEndDateClick(self);
end;

procedure TfrmMain.btnResetClick(Sender: TObject);
var
  reg: TRegIniFile;
begin
  reg := TRegIniFile.Create('software\mpc\weather');
  frmMain.Top := reg.ReadInteger('Form', 'Top', frmMain.Top);
  frmMain.Left := reg.ReadInteger('Form', 'Left', frmMain.Left);
  frmMain.Width := reg.ReadInteger('Form', 'Width', frmMain.Width);
  frmMain.Height := reg.ReadInteger('Form', 'Height', frmMain.Height);
  reg.Free;
end;

procedure TfrmMain.btnRefreshStatsClick(Sender: TObject);
begin
  // Create the stats controls only if they haven't already been created
  if bStatsControlsCreated = False then
    initializePGCTRAllStats;

  // Hide the button and calander
  panelStats.Visible := False;
  // Show the label
  lblQueryRange.Visible := True;
  // Fill the grid with the statistics
  // but first turn off the string grid with data
  btnReset.Visible := False;

  // Compute and Populate the Grids
  ComputeAllStats;

  // Show the Grids
  pnlAllStats.Visible := True;

end;
{$ENDREGION}

{$REGION 'Actions'}

procedure TfrmMain.actFileExitExecute(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmMain.actOnTopExecute(Sender: TObject);
begin
  if actOnTop.checked = True then
  begin
    actOnTop.checked := False;
    frmMain.FormStyle := fsNormal;
  end
  else
  begin
    actOnTop.checked := True;
    frmMain.FormStyle := fsStayOnTop;
  end
end;

procedure TfrmMain.actImportExecute(Sender: TObject);
var
  bExists: boolean;
  i: Integer;
begin
  bExists := False;
  for i := 0 to Screen.FormCount - 1 do
  begin
    if Screen.Forms[i].name = 'frmImport' then
      bExists := True;
  end;
  if not bExists then
  begin
    Application.CreateForm(TfrmImport, frmImport);
  end;
  // Bug??? I started getting an error when I called show module as the program
  // though the form was already showing????  Hiding it first solved this problem.
  frmImport.Hide;
  frmImport.ShowModal;
end;

procedure TfrmMain.actCloseWebFrmExecute(Sender: TObject);
var
  bExists: boolean;
  i: Integer;
begin
  bExists := False;
  for i := 0 to Screen.FormCount - 1 do
  begin
    if Screen.Forms[i].name = 'frmWeb' then
      bExists := True;
  end;
  if bExists then
  begin
    frmWeb.Close;
  end;
end;

procedure TfrmMain.actSetupExecute(Sender: TObject);
var
  bExists: boolean;
  i: Integer;
begin
  bExists := False;
  for i := 0 to Screen.FormCount - 1 do
  begin
    if Screen.Forms[i].name = 'frmSetup' then
      bExists := True;
  end;
  if not bExists then
  begin
    Application.CreateForm(TfrmSetup, frmSetup);
  end;
  frmSetup.ShowModal;
end;
{$ENDREGION}

{$REGION 'Registry Functions'}

procedure TfrmMain.GetReg;
var
  reg: TRegIniFile;
begin
  reg := TRegIniFile.Create('software\mpc\weather');
  iChartDays := reg.ReadInteger('Chart', 'Days', 50);
  frmMain.Top := reg.ReadInteger('Form', 'Top', frmMain.Top);
  frmMain.Left := reg.ReadInteger('Form', 'Left', frmMain.Left);
  frmMain.Width := reg.ReadInteger('Form', 'Width', frmMain.Width);
  frmMain.Height := reg.ReadInteger('Form', 'Height', frmMain.Height);
  actOnTop.checked := reg.ReadBool('Form', 'OnTop', False);
  cbCompareToDate.checked := reg.ReadBool('Query', 'CompareToDate', False);
  if actOnTop.checked = True then
    frmMain.FormStyle := fsStayOnTop
  else
    frmMain.FormStyle := fsNormal;
  reg.Free;
end;

procedure TfrmMain.SetReg;
var
  reg: TRegIniFile;
begin
  // Write the chart end values to the registry
  reg := TRegIniFile.Create('software\mpc\weather');
  reg.WriteInteger('Form', 'Top', frmMain.Top);
  reg.WriteInteger('Form', 'Left', frmMain.Left);
  reg.WriteInteger('Form', 'Width', frmMain.Width);
  reg.WriteInteger('Form', 'Height', frmMain.Height);
  reg.WriteBool('Form', 'OnTop', actOnTop.checked);
  reg.WriteBool('Query', 'CompareToDate', cbCompareToDate.checked);
  reg.Free;
end;
{$ENDREGION}

{$REGION 'Chart Functions'}
procedure TfrmMain.AddHighLowSeriesToChart(iChartIndex: Integer;
  DBChart: TDBChart);
var
  spTempChart: array of TSimpleDataSet;
  aLineSeries: array of array [0 .. 1] of TLineSeries;
begin
  SetLength(spTempChart, nStationCount);
  SetLength(aLineSeries, nStationCount);
  // Set up the Simple Data Set to get High and Lows
  spTempChart[iChartIndex] := TSimpleDataSet.Create(nil);
  spTempChart[iChartIndex].Connection := conWeather;
  spTempChart[iChartIndex].Tag := iChartIndex;
  spTempChart[iChartIndex].DataSet.CommandType := ctQuery;
  spTempChart[iChartIndex].DataSet.CommandText := 'mpc_wx_WeatherChart ' +
                          IntToStr(aStationInfo[iChartIndex].idStation) + ', ' +
                          QuotedStr(DateToStr(Now() - iChartDays));
  // Set up the line series for Highs
  aLineSeries[iChartIndex, 0] := TLineSeries.Create(self);
  DBChart.AddSeries(aLineSeries[iChartIndex, 0]);
  with aLineSeries[iChartIndex, 0] do
  begin
    Title := 'High';
    LinePen.Width := 2;
    Marks.Arrow.Visible := True;
    Marks.Brush.Color := clBlack;
    Marks.Visible := False;
    DataSource := spTempChart[iChartIndex];
    SeriesColor := TColor(aStationInfo[iChartIndex].iChartColorHigh);
    XValues.DateTime := True;
    Pointer.InflateMargins := True;
    Pointer.Style := psRectangle;
    Pointer.Visible := False;
    XValues.DateTime := True;
    XValues.name := 'X';
    XValues.Order := loAscending;
    XValues.ValueSource := 'dtDate';
    YValues.name := 'Y';
    YValues.Order := loNone;
    YValues.ValueSource := 'iHigh';
  end;

  // Set up the line series for Lows
  aLineSeries[iChartIndex, 1] := TLineSeries.Create(self);
  DBChart.AddSeries(aLineSeries[iChartIndex, 1]);
  with aLineSeries[iChartIndex, 1] do
  begin
    Title := 'Low';
    LinePen.Width := 2;
    Marks.Arrow.Visible := True;
    Marks.Brush.Color := clBlack;
    Marks.Visible := False;
    DataSource := spTempChart[iChartIndex];
    SeriesColor := TColor(aStationInfo[iChartIndex].iChartColorLow);
    XValues.DateTime := True;
    Pointer.InflateMargins := True;
    Pointer.Style := psRectangle;
    Pointer.Visible := False;
    XValues.DateTime := True;
    XValues.name := 'X';
    XValues.Order := loAscending;
    XValues.ValueSource := 'dtDate';
    YValues.name := 'Y';
    YValues.Order := loNone;
    YValues.ValueSource := 'iLow';
  end;
  spTempChart[iChartIndex].Active := True;
end;

procedure TfrmMain.AddAverageSeriesToChart(iChartIndex: Integer;
  DBChart: TDBChart);
var
  spAverageChart: array of TSimpleDataSet;
  aLineSeries: array of TLineSeries;
begin
  SetLength(spAverageChart, nStationCount);
  SetLength(aLineSeries, nStationCount);
  // Set up the simple data set for the Average line
  spAverageChart[iChartIndex] := TSimpleDataSet.Create(self);
  spAverageChart[iChartIndex].Connection := conWeather;
  spAverageChart[iChartIndex].Tag := iChartIndex;
  spAverageChart[iChartIndex].DataSet.CommandText := 'mpc_wx_WeatherChart ' +
                          IntToStr(aStationInfo[iChartIndex].idStation) + ', ' +
                          QuotedStr(DateToStr(Now() - iChartDays));
  // Set up the line series for Average
  aLineSeries[iChartIndex] := TLineSeries.Create(self);
  DBChart.AddSeries(aLineSeries[iChartIndex]);
  with aLineSeries[iChartIndex] do
  begin
    LinePen.Width := 2;
    Marks.Arrow.Visible := True;
    Marks.Brush.Color := clBlack;
    Marks.Visible := False;
    DataSource := spAverageChart[iChartIndex];
    SeriesColor := TColor(aStationInfo[iChartIndex].iChartColorHigh);
    XValues.DateTime := True;
    Pointer.InflateMargins := True;
    Pointer.Style := psRectangle;
    Pointer.Visible := False;
    XValues.DateTime := True;
    XValues.name := 'X';
    XValues.Order := loAscending;
    XValues.ValueSource := 'dtDate';
    YValues.name := 'Y';
    YValues.Order := loNone;
    YValues.ValueSource := 'iAverage';
  end;
  spAverageChart[iChartIndex].Active := True;
end;

procedure TfrmMain.AddRainSeriesToChart(iChartIndex: Integer;
  DBChart: TDBChart);
var
  spRainChart: array of TSimpleDataSet;
  aRainSeries: array of TBarSeries;
begin
  SetLength(spRainChart, nStationCount);
  SetLength(aRainSeries, nStationCount);
  // Set up the Simple Data Set for the Rain chart
  spRainChart[iChartIndex] := TSimpleDataSet.Create(self);
  spRainChart[iChartIndex].Connection := conWeather;
  spRainChart[iChartIndex].Tag := iChartIndex;
  spRainChart[iChartIndex].DataSet.CommandText := 'mpc_wx_WeatherChart ' +
                          IntToStr(aStationInfo[iChartIndex].idStation) + ', ' +
                          QuotedStr(DateToStr(Now() - iChartDays));
  // Set up the Rain series for Rain
  aRainSeries[iChartIndex] := TBarSeries.Create(self);
  DBChart.AddSeries(aRainSeries[iChartIndex]);
  with aRainSeries[iChartIndex] do
  begin
    Marks.Arrow.Visible := True;
    Marks.Brush.Color := clBlack;
    Marks.Visible := False;
    DataSource := spRainChart[iChartIndex];
    SeriesColor := TColor(aStationInfo[iChartIndex].iChartColorRain);
    XValues.DateTime := True;
    XValues.DateTime := True;
    XValues.name := 'X';
    XValues.Order := loAscending;
    XValues.ValueSource := 'dtDate';
    YValues.name := 'Y';
    YValues.Order := loNone;
    YValues.ValueSource := 'fRain';
  end;
  spRainChart[iChartIndex].Active := True;
end;


{$ENDREGION}

end.
