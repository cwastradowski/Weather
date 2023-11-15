UNIT Main;

INTERFACE

USES
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, Db, DBTables, ExtCtrls, DBCtrls, TeEngine,
  Series, TeeProcs, Chart, DBChart, StdCtrls, TeeFunci, ComCtrls, Registry,
  ActnList, Menus, ADODB, mpcSQL,
  mpcUserName, DBClient, Provider, unitStats, DateUtils, WideStrings, FMTBcd,
  SqlExpr;

TYPE
  TfrmMain = CLASS(TForm)
    btnReset: TButton;
    menuMain: TMainMenu;
    ActionList1: TActionList;
    actFileExit: TAction;
    actReportsSummaryMonthly: TAction;
    File1: TMenuItem;
    FileExit: TMenuItem;
    Reports1: TMenuItem;
    ReportsSummaryMonthly: TMenuItem;
    actHelpAbout: TAction;
    Help1: TMenuItem;
    HelpAbout: TMenuItem;
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
    pgcontrolChart: TPageControl;
    tsHighLow: TTabSheet;
    chartHighLow: TDBChart;
    cbLAHigh: TCheckBox;
    cbLALow: TCheckBox;
    cbPhxHigh: TCheckBox;
    cbPhxLow: TCheckBox;
    seriesHighLowLow: TLineSeries;
    seriesHighLA: TLineSeries;
    seriesLowLA: TLineSeries;
    tsAverage: TTabSheet;
    chartAverage: TDBChart;
    cbPhxAvg: TCheckBox;
    cbLAAvg: TCheckBox;
    seriesAverageAverage: TLineSeries;
    seriesAvgLA: TLineSeries;
    cbCompareToDate: TCheckBox;
    dsRecordCount: TDataSource;
    lblRecordCount: TLabel;
    StatusBar1: TStatusBar;
    connWeather: TADOConnection;
    spRecordCount: TADOStoredProc;
    qryForChart: TADOStoredProc;
    adoStProcLastDate: TADOStoredProc;
    seriesHighLowHigh: TLineSeries;
    actBtnSNA: TAction;
    pnlWxGrid: TPanel;
    pgCtrTempGrid: TPageControl;
    pnlAllStats: TPanel;
    pgCtrAllStats: TPageControl;



    procedure FormShow(Sender: TObject);
    PROCEDURE FormCreate(Sender: TObject);
    FUNCTION max(a, b: Integer): Integer;
    FUNCTION min(a, b: Integer): Integer;
    FUNCTION maxFloat(a, b: single): single;
    PROCEDURE btnRefreshStatsClick(Sender: TObject);
    procedure cbLAHighClick(Sender: TObject);
    procedure cbLALowClick(Sender: TObject);
    procedure cbPhxHighClick(Sender: TObject);
    procedure cbPhxLowClick(Sender: TObject);
    procedure cbPhxAvgClick(Sender: TObject);
    procedure cbLAAvgClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnResetClick(Sender: TObject);
    procedure actFileExitExecute(Sender: TObject);
    procedure actHelpAboutExecute(Sender: TObject);
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
    procedure OnNewWxRecord(DataSet: TDataSet);
    procedure OnURLBtnClick(Sender : TObject);
    procedure dbTempgridColors(Sender: TObject; CONST Rect: TRect;
              DataCol: Integer; Column: TColumn; State: TGridDrawState);

  private
    { Private declarations }


    procedure GetReg;
    procedure SetReg;
    procedure InitializeDefaultsArray;
    procedure InitializeStationInfo;


  public
    { Public declarations }
    bStatsControlsCreated : boolean;
    aPGCTRStatsPages : array of TPageControl;
    aTabSheetTemp,aTabSheetStats : array of TTabSheet;
    aTabSheetStatsPage1,aTabSheetStatsPage2,aTabSheetStatsPage3,
         aTabSheetStatsPage4 : array of TTabSheet;
    aDBGridTemp : array of TDBGrid;
    aStringGridStatsPage1,aStringGridStatsPage2,aStringGridStatsPage3,
         aStringGridStatsPage4 : array of TStringGrid;
    aSPTempGrid : array of TADOStoredProc;
    aDBGridDataSource : array of TDataSource;
    aDBNav : array of TDBNavigator;
    aURLBtn : array of TButton;

  END;

TYPE
  TDefaultValues = record
    IndexNo: Integer;
    UserName: String;
    KeyName: String;
    SubKeyName: String;
    Value: String;
    Datatype: String;
  end;

TYPE
  TStationInfo = record
    idStation : Integer;
    sStation : String;
    sShortName : String;
    sNWSUrl : String;
    sNWSUrlFormCaption : String;
    sNWSFilePath : String;
    iTemp1 : integer;
    iTemp2 : integer;
    iTemp3 : integer;
    iTemp4 : integer;
    iTemp5 : integer;
    iTemp6 : integer;
    iSortOrder : Integer;
  end;

VAR
  frmMain: TfrmMain;
  bViewStats: Boolean;
  Present, FirstDate: TDateTime;
  LA_URL, PHX_URL, SNA_URL: String;
  Year, Month, Day: Word;
  clOrange: TColor;
  Headers1LA, Headers2LA, Headers1Px, Headers2Px, Headers1, Headers2,
    Headers3: ARRAY [1 .. 7] of Integer;
  sPhxRawDataPath, sLARawDataPath, sSNARawDataPath, sXMLPath: string;
  wQueryBeginYear, wQueryBeginMonth, wQueryBeginDay: Word;
  wQueryEndYear, wQueryEndMonth, wQueryEndDay: Word;
  iChartDays: Integer;
  dtLastDate: TDateTime;
  bDataChanged: Boolean;
  sServerName: String;
  sUserName: String;
  sDefaultUserName: String;
  aLAPage2Temps: array [0 .. 5] of Integer;
  aPhxPage2Temps: array [0 .. 5] of Integer;
  iDefaultArrayLength: Integer;
  aDefaults1, aDefaults2, aDefaults3: array [0 .. 11] of string;
  aDefaults: array [0 .. 11] of TDefaultValues;
  aStationInfo : array of TStationInfo;
  clColor: TColor = clBtnFace;
  nStationCount : integer;
  // clColor : TColor = 15987153;

IMPLEMENTATION

uses unitWebBrowser, unitSetup, mpcAbout, unitImport;
{$R *.DFM}
////////////////////////////////////////////////////////////////////////////////
{$REGION 'Initialize Stuff'}
procedure TfrmMain.FormCreate(Sender: TObject);
BEGIN
  bStatsControlsCreated := False;
  bDataChanged := False;

  // Connection String
  sServerName := mpcGetComputerName;
  sUserName := mpcGetUserName;
  sDefaultUserName := '   ' + sServerName + '\' + sUserName;
  StatusBar1.Panels[0].Text := sDefaultUserName;

  Present := Now;
  DecodeDate(Present, Year, Month, Day);
  // Read the Registry
  GetReg;
  InitializeDefaultsArray;

  qryForChart.ProcedureName := 'mpc_ChartData';
  qryForChart.Parameters.Clear;
  qryForChart.Prepared := True;
  qryForChart.Parameters.CreateParameter('@NumOfDays', ftInteger, pdInput, 4,
    iChartDays);
  qryForChart.Active := True;

  spRecordCount.Active := True;
  lblRecordCount.Caption := 'Record Count: ' + IntToStr
    (spRecordCount.FieldValues['RecCount']);
  spRecordCount.Active := False;



  // Define the color orange
  clOrange := RGB(255, 128, 0);

  // Default values for the query year
  calQueryStartDate.Date := FirstDate;
  calQueryEndDate.Date := Now - 1;
  DecodeDate(calQueryStartDate.Date, wQueryBeginYear, wQueryBeginMonth,
    wQueryBeginDay);
  DecodeDate(Now - 1, wQueryEndYear, wQueryEndMonth, wQueryEndDay);

  lblQueryRange.Caption := 'Stats for dates from ' + DateToStr
    (calQueryStartDate.Date) + ' to ' + DateToStr(calQueryEndDate.Date) + '.';


  InitializeStationInfo;
  initializePGCTRTempGrid;

END;
////////////////////////////////////////////////////////////////////////////////
procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  SetReg;
end;
////////////////////////////////////////////////////////////////////////////////
procedure TfrmMain.FormShow(Sender: TObject);
begin
  chartHighLow.Visible := True;
  chartAverage.Visible := True;
end;
////////////////////////////////////////////////////////////////////////////////
procedure TfrmMain.InitializeDefaultsArray;
begin
  iDefaultArrayLength := 12;

  aDefaults[0].KeyName := 'Chart';
  aDefaults[0].SubKeyName := 'LAHigh';
  aDefaults[0].Value := '1';
  aDefaults[0].Datatype := 'Bool';

  aDefaults[1].KeyName := 'Chart';
  aDefaults[1].SubKeyName := 'LALow';
  aDefaults[1].Value := '1';
  aDefaults[1].Datatype := 'Bool';

  aDefaults[2].KeyName := 'Chart';
  aDefaults[2].SubKeyName := 'PhxHigh';
  aDefaults[2].Value := '1';
  aDefaults[2].Datatype := 'Bool';

  aDefaults[3].KeyName := 'Chart';
  aDefaults[3].SubKeyName := 'PhxLow';
  aDefaults[3].Value := '1';
  aDefaults[3].Datatype := 'Bool';

  aDefaults[4].KeyName := 'Chart';
  aDefaults[4].SubKeyName := 'LAAvg';
  aDefaults[4].Value := '1';
  aDefaults[4].Datatype := 'Bool';

  aDefaults[5].KeyName := 'Chart';
  aDefaults[5].SubKeyName := 'PhxAvg';
  aDefaults[5].Value := '1';
  aDefaults[5].Datatype := 'Bool';

  aDefaults[6].KeyName := 'Form';
  aDefaults[6].SubKeyName := 'Top';
  aDefaults[6].Value := '160';
  aDefaults[6].Datatype := 'Integer';

  aDefaults[7].KeyName := 'Form';
  aDefaults[7].SubKeyName := 'Left';
  aDefaults[7].Value := '336';
  aDefaults[7].Datatype := 'Integer';

  aDefaults[8].KeyName := 'Form';
  aDefaults[8].SubKeyName := 'Width';
  aDefaults[8].Value := '1016';
  aDefaults[8].Datatype := 'Integer';

  aDefaults[9].KeyName := 'Form';
  aDefaults[9].SubKeyName := 'Heigth';
  aDefaults[9].Value := '721';
  aDefaults[9].Datatype := 'Integer';

  aDefaults[10].KeyName := 'Form';
  aDefaults[10].SubKeyName := 'OnTop';
  aDefaults[10].Value := '0';
  aDefaults[10].Datatype := 'Bool';

  aDefaults[11].KeyName := 'Query';
  aDefaults[11].SubKeyName := 'CompareTo';
  aDefaults[11].Value := '1';
  aDefaults[11].Datatype := 'Bool';
end;
////////////////////////////////////////////////////////////////////////////////
procedure TfrmMain.dbTempgridColors(Sender: TObject; CONST Rect: TRect;DataCol: Integer;
                                Column: TColumn; State: TGridDrawState);
begin
  if (Column.FieldName = 'fRain') then
  begin
    if Column.Field.Value > 0 then
    begin
      aDBGridTemp[TDBGrid(sender).Tag].Canvas.Font.Color := clBlue;
      aDBGridTemp[TDBGrid(sender).Tag].DefaultDrawColumnCell(Rect, DataCol, Column, State);
    end;
  end;
  if Column.FieldName = 'iHigh' then
  begin
    if Column.Field.Value >= 80 then
    begin
      aDBGridTemp[TDBGrid(sender).Tag].Canvas.Font.Color := clOrange;
      aDBGridTemp[TDBGrid(sender).Tag].DefaultDrawColumnCell(Rect, DataCol, Column, State);
    end
  end;
end;
////////////////////////////////////////////////////////////////////////////////
procedure TfrmMain.initializePGCTRTempGrid;
var
  i : integer;
begin
  SetLength(aTabSheetTemp,nStationCount);
  SetLength(aDBGridTemp,nStationCount);
  SetLength(aSPTempGrid,nStationCount);
  SetLength(aDBGridDataSource,nStationCount);
  SetLength(aDBNav,nStationCount);
  SetLength(aURLBtn,nStationCount);

  for i := 0 to nStationCount - 1 do
  begin
    aTabSheetTemp[i] := TTabSheet.Create(self);
    aTabSheetTemp[i].PageControl := pgCtrTempGrid;
    aTabSheetTemp[i].Caption := aStationInfo[i].sShortName;

    aDBGridTemp[i] := TDBGrid.Create(self);
    aDBGridTemp[i].Parent := aTabSheetTemp[i];
    aDBGridTemp[i].Top := 0;
    aDBGridTemp[i].Left := 0;
    aDBGridTemp[i].Width := 232;
    aDBGridTemp[i].Height := 150;
    aDBGridTemp[i].Tag := i;
    aDBGridTemp[i].OnDrawColumnCell := dbTempgridColors;

    aSPTempGrid[i] := TADOStoredProc.Create(self);
    aSPTempGrid[i].Connection := connWeather;
    aSPTempGrid[i].ProcedureName := 'mpc_wx_WeatherGrid';
    aSPTempGrid[i].Tag := aStationInfo[i].idStation;
    aSPTempGrid[i].OnNewRecord := OnNewWxRecord;
    aSPTempGrid[i].Parameters.CreateParameter('@idStation',ftInteger,pdInput,4,aStationInfo[i].idStation);

    aDBGridDataSource[i] := TDataSource.Create(self);
    aDBGridDataSource[i].DataSet := aSPTempGrid[i];

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
    aDBNav[i].VisibleButtons := [nbFirst,nbPrior,nbNext,nbLast,nbPost];
    aDBNav[i].DataSource := aDBGridDataSource[i];

    aURLBtn[i] := TButton.Create(self);
    aURLBtn[i].Parent := aTabSheetTemp[i];
    aURLBtn[i].Tag := i;
    aURLBtn[i].Caption := aStationInfo[i].sShortName + ' &URL';
    aURLBtn[i].OnClick := OnURLBtnClick;
    aURLBtn[i].Top := 30;
    aURLBtn[i].Left := 240;
    aURLBtn[i].Width := 80;


    aSPTempGrid[i].Active := True;
    aSPTempGrid[i].Last;





  end;

end;
////////////////////////////////////////////////////////////////////////////////
procedure TFrmMain.initializePGCTRAllStats;
var
  i : integer;

begin
  bStatsControlsCreated := True;
  SetLength(aTabSheetStats,nStationCount);
  SetLength(aTabSheetStatsPage1,nStationCount);
  SetLength(aTabSheetStatsPage2,nStationCount);
  SetLength(aTabSheetStatsPage3,nStationCount);
  SetLength(aTabSheetStatsPage4,nStationCount);
  SetLength(aStringGridStatsPage1,nStationCount);
  SetLength(aStringGridStatsPage2,nStationCount);
  SetLength(aStringGridStatsPage3,nStationCount);
  SetLength(aStringGridStatsPage4,nStationCount);
  SetLength(aPGCTRStatsPages,nStationCount);
   for i := 0 to nStationCount - 1 do
  begin

    aTabSheetStats[i] := TTabSheet.Create(self);
    aTabSheetStats[i].PageControl := pgCtrAllStats;
    aTabSheetStats[i].Caption := aStationInfo[i].sShortName;

    aPGCTRStatsPages[i] := TPageControl.Create(self);
    aPGCTRStatsPages[i].TabPosition := tpBottom;
    aPGCTRStatsPages[i].Parent := aTabSheetStats[i];
    aPgCtrStatsPages[i].Top := 0;
    aPgCtrStatsPages[i].Left := 0;
    aPgCtrStatsPages[i].Width := aTabSheetStats[i].Width;
    aPgCtrStatsPages[i].Height := aTabSheetStats[i].Height;

    aTabSheetStatsPage1[i] := TTabSheet.Create(self);
    aTabSheetStatsPage1[i].PageControl := aPgCtrStatsPages[i];
    aTabSheetStatsPage1[i].Caption := 'Page 1';

    aTabSheetStatsPage2[i] := TTabSheet.Create(self);
    aTabSheetStatsPage2[i].PageControl := aPgCtrStatsPages[i];
    aTabSheetStatsPage2[i].Caption := 'Page 2';

    aTabSheetStatsPage3[i] := TTabSheet.Create(self);
    aTabSheetStatsPage3[i].PageControl := aPgCtrStatsPages[i];
    aTabSheetStatsPage3[i].Caption := 'Page 3';

    aTabSheetStatsPage4[i] := TTabSheet.Create(self);
    aTabSheetStatsPage4[i].PageControl := aPgCtrStatsPages[i];
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
////////////////////////////////////////////////////////////////////////////////
procedure TFrmMain.InitializeStationInfo;
var
  sp : TADOStoredProc;

  I: Integer;
begin
  sp := TADOStoredProc.Create(self);
  sp.Connection := connWeather;
  sp.ProcedureName := 'mpc_wx_GetActiveStations';
  sp.Active := True;
  nStationCount := sp.RecordCount;
  SetLength(aStationInfo,nStationCount);
  sp.First;
  for i := 0 to nStationCount -1  do
  begin
    aStationInfo[i].idStation := sp.FieldByName('idStation').AsInteger;
    aStationInfo[i].sStation := sp.FieldByName('sStation').AsString;
    aStationInfo[i].sShortName := sp.FieldByName('sShortName').AsString;
    aStationInfo[i].sNWSUrl := sp.FieldByName('sNWSUrl').AsString;
    aStationInfo[i].sNWSUrlFormCaption := sp.FieldByName('sNWSUrlFormCaption').AsString;
    aStationInfo[i].sNWSFilePath := sp.FieldByName('sNWSFilePath').AsString;
    aStationInfo[i].iTemp1 := sp.FieldByName('iTemp1').AsInteger;
    aStationInfo[i].iTemp2 := sp.FieldByName('iTemp2').AsInteger;
    aStationInfo[i].iTemp3 := sp.FieldByName('iTemp3').AsInteger;
    aStationInfo[i].iTemp4 := sp.FieldByName('iTemp4').AsInteger;
    aStationInfo[i].iTemp5 := sp.FieldByName('iTemp5').AsInteger;
    aStationInfo[i].iTemp6 := sp.FieldByName('iTemp6').AsInteger;
    aStationInfo[i].iSortOrder := sp.FieldByName('iSortOrder').AsInteger;
    sp.Next;
  end;
  sp.Active := False;
  sp.Free;
end;
////////////////////////////////////////////////////////////////////////////////
{$ENDREGION}
////////////////////////////////////////////////////////////////////////////////
{$REGION 'Misc Functions'}
FUNCTION TfrmMain.max(a, b: Integer): Integer;
BEGIN
  IF a > b THEN
    result := a
  ELSE
    result := b;
END;
/// /////////////////////////////////////////////////////////////////////////////
FUNCTION TfrmMain.min(a, b: Integer): Integer;
BEGIN
  IF a < b THEN
    result := a
  ELSE
    result := b;
END;
/// /////////////////////////////////////////////////////////////////////////////
FUNCTION TfrmMain.maxFloat(a, b: single): single;
BEGIN
  IF a > b THEN
    result := a
  ELSE
    result := b;
END;
/// /////////////////////////////////////////////////////////////////////////////

{$ENDREGION}
////////////////////////////////////////////////////////////////////////////////
{$REGION 'Check Box Clicks'}

procedure TfrmMain.cbLAHighClick(Sender: TObject);
begin
  seriesHighLA.Active := cbLAHigh.checked;
end;

////////////////////////////////////////////////////////////////////////////////
procedure TfrmMain.cbLALowClick(Sender: TObject);
begin
  seriesLowLA.Active := cbLALow.checked;
end;

////////////////////////////////////////////////////////////////////////////////
procedure TfrmMain.cbPhxHighClick(Sender: TObject);
begin
  seriesHighLowLow.Active := cbPhxHigh.checked;
end;

////////////////////////////////////////////////////////////////////////////////
procedure TfrmMain.cbPhxLowClick(Sender: TObject);
begin
  seriesHighLowHigh.Active := cbPhxLow.checked;
end;

////////////////////////////////////////////////////////////////////////////////
procedure TfrmMain.cbPhxAvgClick(Sender: TObject);
begin
  seriesAverageAverage.Active := cbPhxAvg.checked;
end;

////////////////////////////////////////////////////////////////////////////////
procedure TfrmMain.cbLAAvgClick(Sender: TObject);
begin
  seriesAvgLA.Active := cbLAAvg.checked;
end;
/// /////////////////////////////////////////////////////////////////////////////
{$ENDREGION}
////////////////////////////////////////////////////////////////////////////////
{$REGION 'Weather Events'}
////////////////////////////////////////////////////////////////////////////////
procedure TfrmMain.OnNewWxRecord(DataSet: TDataSet);
var
  spLastDate : TADOStoredProc;
begin
  spLastDate := TADOStoredProc.Create(self);
  spLastDate.Connection := connWeather;
  spLastDate.ProcedureName := 'mpc_wx_LastDate';
  spLastDate.Parameters.CreateParameter('@idStation',ftInteger,pdInput,4,DataSet.Tag);
  spLastDate.Active := True;
  DataSet.FieldByName('dtDate').AsDateTime := spLastDate.FieldByName('LastDate').AsDateTime + 1;
  spLastDate.Active := False;
  spLastDate.Free;
  DataSet.FieldByName('idStation').AsInteger := DataSet.Tag;
  DataSet.FieldByName('iHigh').AsInteger := 0;
  DataSet.FieldByName('iLow').AsInteger := 0;
  DataSet.FieldByName('fRain').AsFloat := 0;
end;
////////////////////////////////////////////////////////////////////////////////
procedure TfrmMain.OnURLBtnClick(Sender : TObject);
var
  bExists: Boolean;
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
  frmWeb.Caption := aStationInfo[TButton(sender).Tag].sNWSUrlFormCaption;
  frmWeb.webBro.Navigate(aStationInfo[TButton(sender).Tag].sNWSUrl);
  frmWeb.Show;
end;
////////////////////////////////////////////////////////////////////////////////
{$ENDREGION}
////////////////////////////////////////////////////////////////////////////////
{$REGION 'Calendar Clicks'}
procedure TfrmMain.calQueryStartDateClick(Sender: TObject);
begin
  DecodeDate(calQueryStartDate.Date, wQueryBeginYear, wQueryBeginMonth,
    wQueryBeginDay);
  lblQueryRange.Caption := 'Stats for dates from ' + DateToStr
    (calQueryStartDate.Date) + ' to ' + DateToStr(calQueryEndDate.Date) + '.';
  lblQueryRange.Refresh;
end;
////////////////////////////////////////////////////////////////////////////////
procedure TfrmMain.calQueryEndDateClick(Sender: TObject);
begin
  DecodeDate(calQueryEndDate.Date, wQueryEndYear, wQueryEndMonth, wQueryEndDay);
  lblQueryRange.Caption := 'Stats for dates from ' + DateToStr
    (calQueryStartDate.Date) + ' to ' + DateToStr(calQueryEndDate.Date) + '.';
  lblQueryRange.Refresh;
end;
////////////////////////////////////////////////////////////////////////////////
{$ENDREGION}
////////////////////////////////////////////////////////////////////////////////
{$REGION 'Button clicks'}
procedure TfrmMain.btnStatsClick(Sender: TObject);
begin
  panelStats.Visible := True;
  pnlAllStats.Visible := False;
  lblQueryRange.Visible := True;
end;
////////////////////////////////////////////////////////////////////////////////
procedure TfrmMain.btnCancelRefreshClick(Sender: TObject);
begin
  panelStats.Visible := False;
end;
////////////////////////////////////////////////////////////////////////////////
procedure TfrmMain.btnMidYearClick(Sender: TObject);
Var
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
////////////////////////////////////////////////////////////////////////////////
procedure TfrmMain.btnCurrentYearClick(Sender: TObject);
Var
  wYear, wMonth, wDay: Word;
begin
  DecodeDate(Now, wYear, wMonth, wDay);
  calQueryStartDate.Date := StrToDate('01/01/' + IntToStr(wYear));
  calQueryStartDateClick(self);
end;
////////////////////////////////////////////////////////////////////////////////
procedure TfrmMain.btnDefaultStatsClick(Sender: TObject);
begin
  calQueryStartDate.Date := FirstDate;
  calQueryEndDate.Date := Now - 1;
  lblQueryRange.Caption := 'Stats for dates from ' + DateToStr
    (calQueryStartDate.Date) + ' to ' + DateToStr(calQueryEndDate.Date) + '.';
  lblQueryRange.Refresh;
  btnRefreshStatsClick(self);
end;
////////////////////////////////////////////////////////////////////////////////
procedure TfrmMain.btnFullDatabaseClick(Sender: TObject);
begin
  calQueryStartDate.Date := FirstDate;
  calQueryEndDate.Date := Now - 1;
  calQueryStartDateClick(self);
  calQueryEndDateClick(self);
end;
////////////////////////////////////////////////////////////////////////////////
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
////////////////////////////////////////////////////////////////////////////////
PROCEDURE TfrmMain.btnRefreshStatsClick(Sender: TObject);
BEGIN
  //Create the stats controls only if they haven't already been created
  if bStatsControlsCreated = False then initializePGCTRAllStats;

  // Hide the button and calander
  panelStats.Visible := False;
  // Show the label
  lblQueryRange.Visible := True;
  // Fill the grid with the statistics
  // but first turn off the string grid with data
  btnReset.Visible := False;

  // Compute and Populate the Grids
  ComputeAllStats;

  //Show the Grids
  pnlAllStats.Visible := True;

END;
////////////////////////////////////////////////////////////////////////////////
{$ENDREGION}
/// /////////////////////////////////////////////////////////////////////////////
{$REGION 'Actions'}
////////////////////////////////////////////////////////////////////////////////
procedure TfrmMain.actFileExitExecute(Sender: TObject);
begin
  Application.Terminate;
end;
////////////////////////////////////////////////////////////////////////////////
procedure TfrmMain.actHelpAboutExecute(Sender: TObject);
var
  bExists: Boolean;
  i: Integer;
begin
  bExists := False;
  for i := 0 to Screen.FormCount - 1 do
  begin
    if Screen.Forms[i].Name = 'frmMPCAbout' then
      bExists := True;
  end;
  if not bExists then
  begin
    Application.CreateForm(TfrmAboutBox, frmMPCAbout);
  end;

  frmMPCAbout.ShowModal;
end;
////////////////////////////////////////////////////////////////////////////////
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
////////////////////////////////////////////////////////////////////////////////
procedure TfrmMain.actImportExecute(Sender: TObject);
var
  bExists: Boolean;
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
  //Bug??? I started getting an error when I called show module as the program
  //though the form was already showing????  Hiding it first solved this problem.
  frmImport.Hide;
  frmImport.ShowModal;
end;
////////////////////////////////////////////////////////////////////////////////
procedure TfrmMain.actCloseWebFrmExecute(Sender: TObject);
var
  bExists: Boolean;
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
////////////////////////////////////////////////////////////////////////////////
procedure TfrmMain.actSetupExecute(Sender: TObject);
var
  bExists: Boolean;
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
////////////////////////////////////////////////////////////////////////////////
{$ENDREGION}
////////////////////////////////////////////////////////////////////////////////
{$REGION 'Registry Functions'}
procedure TfrmMain.GetReg;
var
  reg: TRegIniFile;
begin
  reg := TRegIniFile.Create('software\mpc\weather');
  cbLAHigh.checked := reg.ReadBool('Chart', 'LAHigh', True);
  cbLALow.checked := reg.ReadBool('Chart', 'LALow', True);
  cbPhxHigh.checked := reg.ReadBool('Chart', 'PhxHigh', False);
  cbPhxLow.checked := reg.ReadBool('Chart', 'PhxLow', False);
  cbLAAvg.checked := reg.ReadBool('Chart', 'LAAvg', True);
  cbPhxAvg.checked := reg.ReadBool('Chart', 'PhxAvg', False);
  iChartDays := reg.ReadInteger('Chart', 'Days', 50);
  frmMain.Top := reg.ReadInteger('Form', 'Top', frmMain.Top);
  frmMain.Left := reg.ReadInteger('Form', 'Left', frmMain.Left);
  frmMain.Width := reg.ReadInteger('Form', 'Width', frmMain.Width);
  frmMain.Height := reg.ReadInteger('Form', 'Height', frmMain.Height);
  actOnTop.checked := reg.ReadBool('Form', 'OnTop', False);
  cbCompareToDate.checked := reg.ReadBool('Query', 'CompareToDate', False);
  If actOnTop.checked = True then
    frmMain.FormStyle := fsStayOnTop
  else
    frmMain.FormStyle := fsNormal;
  chartHighLow.Title.Text.Clear;
  chartAverage.Title.Text.Clear;
  chartHighLow.Title.Text.Add
    ('High and Low Temperatures for the past ' + IntToStr(iChartDays)
      + ' Days.');
  chartAverage.Title.Text.Add('Average Temperatures for the past ' + IntToStr
      (iChartDays) + ' Days.');
  reg.Free;
end;
////////////////////////////////////////////////////////////////////////////////
procedure TfrmMain.SetReg;
var
  reg: TRegIniFile;
begin
  // Write the chart end values to the registry
  reg := TRegIniFile.Create('software\mpc\weather');
  reg.WriteBool('Chart', 'LAHigh', cbLAHigh.checked);
  reg.WriteBool('Chart', 'LALow', cbLALow.checked);
  reg.WriteBool('Chart', 'PhxHigh', cbPhxHigh.checked);
  reg.WriteBool('Chart', 'PhxLow', cbPhxLow.checked);
  reg.WriteBool('Chart', 'LAAvg', cbLAAvg.checked);
  reg.WriteBool('Chart', 'PhxAvg', cbPhxAvg.checked);
  reg.WriteInteger('Form', 'Top', frmMain.Top);
  reg.WriteInteger('Form', 'Left', frmMain.Left);
  reg.WriteInteger('Form', 'Width', frmMain.Width);
  reg.WriteInteger('Form', 'Height', frmMain.Height);
  reg.WriteBool('Form', 'OnTop', actOnTop.checked);
  reg.WriteBool('Query', 'CompareToDate', cbCompareToDate.checked);
  reg.Free;
end;
////////////////////////////////////////////////////////////////////////////////
{$ENDREGION}
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
END.
