unit unitImport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ActnList, StdCtrls, HTTPApp, HTTPProd, Grids, ExtCtrls,
  DBCtrls, DB,  DBGrids, mpcCSV, ADODB, Registry, FMTBcd, DBClient,
  Provider, SqlExpr, DateUtils, unitMPCPad, SimpleDS, Data.DBXMSSQL;
  //DBTables,
type
  TfrmImport = class(TForm)
    mmFrmImportMainMenu: TMainMenu;
    menuFile: TMenuItem;
    lblFileInfo: TLabel;
    sgridData: TStringGrid;
    dbGridImport: TDBGrid;
    dbNavImport: TDBNavigator;
    btnCompare: TButton;
    lblPassFail: TLabel;
    btnFix: TButton;
    cbImportType: TComboBox;
   // procedure readFile(fnFileName: string; iStation: integer);
    function compareFile(): boolean;
    procedure fixFile();
 //   function nMonth(month: string): integer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure closeform(Sender: TObject);
    procedure CreateFrmImportMainMenu;
    procedure OnClickFrmImportMainMenuItem(Sender: TObject);
    procedure btnCompareClick(Sender: TObject);
    procedure btnFixClick(Sender: TObject);
   // procedure FormShow(Sender: TObject);
    //procedure GetImportElements;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

Type TImportElementsItem = Record
  FirstLine : Integer;
  LastLine : Integer;
  FirstPosition : Integer;
  LastPosition : Integer
End;

type TImportElements = Record
  DataBegins : TImportElementsItem;
  Day : TImportElementsItem;
  Max : TImportElementsItem;
  Min : TImportElementsItem;
  Rain : TImportElementsItem;
  StationName : TImportElementsItem;
  Month : TImportElementsItem;
  Year : TImportElementsItem;
End;

var
  frmImport: TfrmImport;
  month, year: string;
  sMonth, sYear: string;
  sdsCompareGrid : TSQLDataSet;
  dspCompareGrid : TDataSetProvider;
  cdsCompareGrid : TClientDataSet;
  dsCompareGrid: TDataSource;
  ImportElements : TImportElements;
  idStationSelected : Integer;

  // fnFileName : TFileName;
implementation

uses Main;

{$R *.dfm}

//procedure TfrmImport.readFile(fnFileName: string; iStation: integer);
///// /////////////////////////////////////////////////////////////////////////////
///// /////////////////////////////////////////////////////////////////////////////
///// /////////////////////////////////////////////////////////////////////////////
//// This seems to be the new National Weather Service standard file adopted by both
//// Phoenix and LA.  LA for a long time and Phoenix as of February 2003
//const
//  cFirstLine = 1;
//  cDay = 2;
//  cMax = 3;
//  cMin = 4;
//  cRain = 5;
//  cStation = 6;
//  cMonth = 7;
//  cYear = 8;
//var
//  iDaysInMonth: integer;
//  iFirstLine: integer;
//  iMaxStart, iMaxEnd, iMaxLength: integer;
//  iMinStart, iMinEnd, iMinLength: integer;
//  iRainStart, iRainEnd, iRainLength: integer;
//  iStationFirstLine, iStationStart, iStationEnd: integer;
//  iMonthFirstLine, iMonthStart, iMonthEnd: integer;
//  iYearFirstLine, iYearStart, iYearEnd: integer;
//  sl: TStringList;
//  buffer, sStation: string;
//  f: textfile;
//  i: integer;
//begin
//  // Grab the coordinates of the elements in the import file
//  //First Get the element values
//  GetImportElements;
//  iFirstLine := ImportElements.DataBegins.FirstLine;
//  iMaxStart := ImportElements.Max.FirstPosition;
//  iMaxEnd := ImportElements.Max.LastPosition;
//  iMaxLength := iMaxEnd - iMaxStart + 1;
//  iMinStart := ImportElements.Min.FirstPosition;
//  iMinEnd := ImportElements.Min.LastPosition;
//  iMinLength := iMinEnd - iMinStart + 1;
//  iRainStart := ImportElements.Rain.FirstPosition;
//  iRainEnd := ImportElements.Rain.LastPosition;
//  iRainLength := iRainEnd - iRainStart + 1;
//  iStationFirstLine := ImportElements.StationName.FirstLine;
//  iStationStart := ImportElements.StationName.FirstPosition;
//  iStationEnd := ImportElements.StationName.LastPosition;
//  iMonthFirstLine := ImportElements.Month.FirstLine;
//  iMonthStart := ImportElements.Month.FirstPosition;
//  iMonthEnd := ImportElements.Month.LastPosition;
//  iYearFirstLine := ImportElements.Year.FirstLine;
//  iYearStart := ImportElements.Year.FirstPosition;
//  iYearEnd := ImportElements.Year.LastPosition;
//
//  // Read the file
//  sl := TStringList.Create;
//  AssignFile(f, fnFileName);
//  Reset(f);
//  while not eof(f) do
//  begin
//    ReadLn(f, buffer);
//    sl.Add(buffer);
//  end;
//  CloseFile(f);
//  // Done Reading
//
//  // Show the Station, Month and Year on the label
//  sStation := Copy(sl.Strings[iStationFirstLine - 1], iStationStart - 1,
//    iStationEnd - iStationStart + 1);
//  sMonth := Copy(sl.Strings[iMonthFirstLine - 1], iMonthStart - 1,
//    iMonthEnd - iMonthStart + 1);
//  sYear := Copy(sl.Strings[iYearFirstLine - 1], iYearStart - 1,
//    iYearEnd - iYearStart + 1);
//  lblFileInfo.Caption := sMonth + ', ' + sYear + ' at ' + sStation;
//
//  // Determine Row Count by how many days in the month
//  iDaysInMonth := DaysInAMonth(StrToInt(sYear), (nMonth(sMonth)));
//  // Set the Number of Rows
//  sgridData.RowCount := iDaysInMonth + 1;
//  // Populate the Grid Headers in row 1
//  sgridData.Cells[0,0] := 'Date';
//  sgridData.Cells[1, 0] := 'Max';
//  sgridData.Cells[2, 0] := 'Min';
//  sgridData.Cells[3, 0] := 'Rain';
//
//  // Set the grid height to account for the number of rows
//  sgridData.Height := 613 - ((32 - sgridData.RowCount) * 19);
//
//  // Populate the grid with the data values
//  for i := 1 to iDaysInMonth do
//  begin
//    sgridData.Cells[0, i] := IntToStr(i);
//    // Maximum
//    sgridData.Cells[1, i] := Trim(Copy(sl.Strings[iFirstLine + i - 2],
//        iMaxStart, iMaxLength));
//    // Minimum
//    sgridData.Cells[2, i] := Trim(Copy(sl.Strings[iFirstLine + i - 2],
//        iMinStart, iMinLength));
//    // Rain
//    if UpperCase(Trim(Copy(sl.Strings[iFirstLine + i - 2], iRainStart,
//          iRainLength))) = 'T' then
//      sgridData.Cells[3, i] := '0.00'
//    else
//      sgridData.Cells[3, i] := Trim(Copy(sl.Strings[iFirstLine + i - 2],
//          iRainStart, iRainLength));
//  end;
//  sl.Free;
//
//  // set up the comparison dbgrid
//  // Initialize the SQL DataSet
//  sdsCompareGrid := TSQLDataSet.Create(frmImport);
//  sdsCompareGrid.SQLConnection := frmMain.conWeather;
//  sdsCompareGrid.CommandType := ctQuery;
//  sdsCompareGrid.CommandText := 'select * from tblWeather where idStation = ' +
//                                IntToStr(iStation) + ' order by dtDate';
//
//  //Initialize the Data Provider
//  dspCompareGrid := TDataSetProvider.Create(nil);
//  dspCompareGrid.DataSet := sdsCompareGrid;
//
//  //Initialize the Client Data Set
//  cdsCompareGrid := TClientDataSet.Create(nil);
//  cdsCompareGrid.SetProvider(dspCompareGrid);
//
//
//  // initialize the Database connections
//  dsCompareGrid := TDataSource.Create(self);
//  dsCompareGrid.DataSet := cdsCompareGrid;
//  dbGridImport.DataSource := dsCompareGrid;
//  dbNavImport.DataSource := dsCompareGrid;
//
//  // Clear the grid columns and add 4 fresh ones
//  dbGridImport.Columns.Clear;
//  for i := 0 to 3 do
//    dbGridImport.Columns.Add;
//  // Set up the fresh columns
//  dbGridImport.Columns[0].Title.Caption := 'Date';
//  dbGridImport.Columns[0].Width := 76;
//  dbGridImport.Columns[0].FieldName := 'dtDate';
//  dbGridImport.Columns[1].FieldName := 'iHigh';
//  dbGridImport.Columns[1].Title.Caption := 'High';
//  dbGridImport.Columns[2].FieldName := 'iLow';
//  dbGridImport.Columns[2].Title.Caption := 'Low';
//  dbGridImport.Columns[3].FieldName := 'fRain';
//  dbGridImport.Columns[3].Title.Caption := 'Rain';
//
//  // Populate the grid
//  cdsCompareGrid.Active := True;
//
//  // Move the visible grid to the same date range as the imported file
//  cdsCompareGrid.Locate(('dtDate'),
//    StrToDate(IntToStr(nMonth(sMonth)) + '/1/' + sYear), [loCaseInsensitive]);
//end;

//function TfrmImport.nMonth(month: string): integer;
//begin
//  if Trim(UpperCase(month)) = 'JANUARY' then
//    result := 1
//  else if Trim(UpperCase(month)) = 'FEBRUARY' then
//    result := 2
//  else if Trim(UpperCase(month)) = 'MARCH' then
//    result := 3
//  else if Trim(UpperCase(month)) = 'APRIL' then
//    result := 4
//  else if Trim(UpperCase(month)) = 'MAY' then
//    result := 5
//  else if Trim(UpperCase(month)) = 'JUNE' then
//    result := 6
//  else if Trim(UpperCase(month)) = 'JULY' then
//    result := 7
//  else if Trim(UpperCase(month)) = 'AUGUST' then
//    result := 8
//  else if Trim(UpperCase(month)) = 'SEPTEMBER' then
//    result := 9
//  else if Trim(UpperCase(month)) = 'OCTOBER' then
//    result := 10
//  else if Trim(UpperCase(month)) = 'NOVEMBER' then
//    result := 11
//  else
//    result := 12;
//end;

procedure TfrmImport.btnCompareClick(Sender: TObject);
begin
  btnCompare.Visible := not compareFile();
  btnFix.Visible := compareFile();
end;

procedure TfrmImport.btnFixClick(Sender: TObject);
begin
  fixFile();
end;

//function TfrmImport.compareFile(): boolean;
//var
//  i: integer;
//  bError: boolean;
//  bAnyError: boolean;
//begin
//  bError := False;
//  bAnyError := False;
//  for i := 1 to sgridData.RowCount - 1 do
//  begin
//    cdsCompareGrid.Locate(('dtDate'),
//      StrToDateTime(IntToStr(nMonth(sMonth)) + '/' + IntToStr(i)
//          + '/' + sYear), [loCaseInsensitive]);
//    if sgridData.Cells[1, i] <> cdsCompareGrid.FieldByName('iHigh').AsString then
//    begin
//      bError := True;
//      bAnyError := True;
//    end;
//    if sgridData.Cells[2, i] <> cdsCompareGrid.FieldByName('iLow').AsString then
//    begin
//      bError := True;
//      bAnyError := True;
//    end;
//    if StrToCurr(sgridData.Cells[3, i]) <> cdsCompareGrid.FieldByName('fRain')
//      .AsCurrency then
//    begin
//      bError := True;
//      bAnyError := True;
//    end;
//    if bError then
//    begin
//      sgridData.Cells[0, i] := sgridData.Cells[0, i] + '  =>';
//      bError := False;
//    end;
//  end;
//  if bAnyError then
//    lblPassFail.Caption := 'Failed'
//  else
//    lblPassFail.Caption := 'Passed';
//  lblPassFail.Visible := True;
//  result := bAnyError;
//end;

procedure TfrmImport.fixFile();
var
  i: integer;
begin
  for i := 1 to sgridData.RowCount - 1 do
  begin
    cdsCompareGrid.Locate(('dtDate'),
      StrToDateTime(IntToStr(nMonth(sMonth)) + '/' + IntToStr(i)
          + '/' + sYear), [loCaseInsensitive]);
    if sgridData.Cells[1, i] <> cdsCompareGrid.FieldByName('iHigh').AsString then
    begin
      cdsCompareGrid.Edit;
      cdsCompareGrid.FieldByName('iHigh').AsInteger := StrToInt
        (sgridData.Cells[1, i]);
    end;
    if sgridData.Cells[2, i] <> cdsCompareGrid.FieldByName('iLow').AsString then
    begin
      cdsCompareGrid.Edit;
      cdsCompareGrid.FieldByName('iLow').AsInteger := StrToInt
        (sgridData.Cells[2, i]);
    end;
    if StrToCurr(sgridData.Cells[3, i]) <> cdsCompareGrid.FieldByName('fRain')
      .AsCurrency then
    begin
      cdsCompareGrid.Edit;
      cdsCompareGrid.FieldByName('fRain').AsFloat := StrToFloat
        (sgridData.Cells[3, i]);
    end;
  end;
  cdsCompareGrid.Edit;
  cdsCompareGrid.Post;
  cdsCompareGrid.ApplyUpdates(0);
  lblPassFail.Visible := False;
  btnFix.Visible := False;
  btnCompare.Visible := True;
  //Refresh the data on the main form and goto the last record
  for i := 0 to length(frmMain.aDataSource) - 1 do
  begin
    frmMain.aQry[i].Refresh;
    frmMain.aQry[i].Last;
  end;
end;

procedure TfrmImport.FormCreate(Sender: TObject);
var
  reg: TRegIniFile;
begin
  // Read the registry
  reg := TRegIniFile.Create('software\mpc\weather');
  frmImport.Top := reg.ReadInteger('ImportForm', 'Top', 0);
  frmImport.Left := reg.ReadInteger('ImportForm', 'Left', 0);
  frmImport.Height := reg.ReadInteger('ImportForm', 'Height', 150);
  frmImport.Width := reg.ReadInteger('ImportForm', 'Width', 900);
  // registry done
  // Create the Main Menu for frmImport
  CreateFrmImportMainMenu;
end;

procedure TfrmImport.FormDestroy(Sender: TObject);
var
  reg: TRegIniFile;
begin
  // Write the registry
  reg := TRegIniFile.Create('software\mpc\weather');
  reg.WriteInteger('ImportForm', 'Top', frmImport.Top);
  reg.WriteInteger('ImportForm', 'Left', frmImport.Left);
  reg.WriteInteger('ImportForm', 'Height', frmImport.Height);
  reg.WriteInteger('ImportForm', 'Width', frmImport.Width);
end;
//
//procedure TfrmImport.FormShow(Sender: TObject);
//var
//  simpleDSImportTypes : TSimpleDataSet;
//  NullDataSet : TDataSource;
//  i : integer;
//begin
//  //make sure buttons and labels are not visible
//  btnCompare.Visible := False;
//  btnFix.Visible := False;
//  lblPassFail.Visible := False;
//  lblFileInfo.Caption := '';
//  //clear the form grids
//  sgridData.RowCount := 2;
//  NullDataSet := TDataSource.Create(nil);
//  dbGridImport.DataSource := NullDataSet;
//
//  for i := 0 to 3 do
//  begin
//    sgridData.Cells[i,0] := '';
//    sgridData.Cells[i,1] := '';
//  end;
//  simpleDSImportTypes := TSimpleDataSet.Create(self);
//  simpleDSImportTypes.Connection := frmMain.conWeather;
//  simpleDSImportTypes.DataSet.CommandType := ctQuery;
//  simpleDSImportTypes.DataSet.CommandText := 'mpc_wx_GetImportTypes';
//  simpleDSImportTypes.Active := True;
//  cbImportType.Clear;
//  while not simpleDSImportTypes.Eof do
//  begin
//    cbImportType.AddItem(simpleDSImportTypes.FieldByName('sName').AsString,self);
//    simpleDSImportTypes.Next;
//  end;
//  simpleDSImportTypes.Active := False;
//  simpleDSImportTypes.Free;
//  cbImportType.ItemIndex := 0;
//end;

procedure TfrmImport.closeform(Sender: TObject);
begin
  // Close event for the main menu CLOSE FORM item
  frmImport.Close;
end;

procedure TfrmImport.CreateFrmImportMainMenu;
var
  i: integer;
  aFrmImportFileMenuItem: array of TMenuItem;
  miFileClose: TMenuItem;
begin
  // Add the Menu options for the File menu item
  setlength(aFrmImportFileMenuItem, nStationCount);
  for i := 0 to nStationCount - 1 do
  begin
    aFrmImportFileMenuItem[i] := TMenuItem.Create(aFrmImportFileMenuItem[i]);
    aFrmImportFileMenuItem[i].Tag := i;
    aFrmImportFileMenuItem[i].Caption := 'Open ' + Trim
      (aStationInfo[i].sStation) + ' File';
    aFrmImportFileMenuItem[i].OnClick := OnClickFrmImportMainMenuItem;
    menuFile.Add(aFrmImportFileMenuItem[i]);
  end;
  // Add one more choice -- To Close this form
  miFileClose := TMenuItem.Create(self);
  miFileClose.Caption := 'Close Form';
  miFileClose.OnClick := closeform;
  menuFile.Add(miFileClose);
end;

procedure TfrmImport.OnClickFrmImportMainMenuItem(Sender: TObject);
var
  diaFileOpenRawData: TOpenDialog;
begin
  idStationSelected := TMenuItem(Sender).Tag;
  diaFileOpenRawData := TOpenDialog.Create(frmImport);
  diaFileOpenRawData.FileName := '';
  diaFileOpenRawData.InitialDir := extractFilePath(aStationInfo[idStationSelected].sNWSFilePath);
  diaFileOpenRawData.Filter := aStationInfo[idStationSelected].sStation +
    ' Data Files|*.txt|All Files|*.*';
  diaFileOpenRawData.Execute;

  // Make sure the pass fail label is blank
  lblPassFail.Caption := '';

  // if the user didn't pick a file then get out of here
  if diaFileOpenRawData.FileName = '' then
  begin
    diaFileOpenRawData.Free;
    exit;
  end;

//
//  // If the user did pick a file then set everything in motion by first reading the file selected
//  readFile(diaFileOpenRawData.FileName,
//    aStationInfo[idStationSelected].idStation);

  // Show the compare button
  btnCompare.Visible := True;

  //free the dialog box
  diaFileOpenRawData.Free;
end;
//
//procedure TfrmImport.GetImportElements;
//var
//  simpleDSGetImportElements : TSimpleDataSet;
//begin
//  simpleDSGetImportElements := TSimpleDataSet.Create(self);
//  simpleDSGetImportElements.Connection := frmMain.conWeather;
//  simpleDSGetImportElements.DataSet.CommandType := ctQuery;
//  simpleDSGetImportElements.DataSet.CommandText := 'mpc_wx_GetImportElements ' +
//                                                    quotedStr(cbImportType.Text);
//  simpleDSGetImportElements.Active := True;
//  //1 - Data begins
//  simpleDSGetImportElements.Locate('idElement',1,[loCaseInsensitive]);
//  ImportElements.DataBegins.FirstLine := simpleDSGetImportElements.FieldByName('iFirstLine').AsInteger;
//  // 2 - Day
//  simpleDSGetImportElements.Locate('idElement',2,[loCaseInsensitive]);
//  ImportElements.Day.FirstPosition := simpleDSGetImportElements.FieldByName('iFirstPosition').AsInteger;
//  ImportElements.Day.LastPosition := simpleDSGetImportElements.FieldByName('iLastPosition').AsInteger;
//  // 3 - Max
//  simpleDSGetImportElements.Locate('idElement',3,[loCaseInsensitive]);
//  ImportElements.Max.FirstPosition := simpleDSGetImportElements.FieldByName('iFirstPosition').AsInteger;
//  ImportElements.Max.LastPosition := simpleDSGetImportElements.FieldByName('iLastPosition').AsInteger;
//  // 4 - Min
//  simpleDSGetImportElements.Locate('idElement',4,[loCaseInsensitive]);
//  ImportElements.Min.FirstPosition := simpleDSGetImportElements.FieldByName('iFirstPosition').AsInteger;
//  ImportElements.Min.LastPosition := simpleDSGetImportElements.FieldByName('iLastPosition').AsInteger;
//  // 5 - Rain
//  simpleDSGetImportElements.Locate('idElement',5,[loCaseInsensitive]);
//  ImportElements.Rain.FirstPosition := simpleDSGetImportElements.FieldByName('iFirstPosition').AsInteger;
//  ImportElements.Rain.LastPosition := simpleDSGetImportElements.FieldByName('iLastPosition').AsInteger;
//  // 6 - Station Name
//  simpleDSGetImportElements.Locate('idElement',6,[loCaseInsensitive]);
//  ImportElements.StationName.FirstLine := simpleDSGetImportElements.FieldByName('iFirstLine').AsInteger;
//  ImportElements.StationName.FirstPosition := simpleDSGetImportElements.FieldByName('iFirstPosition').AsInteger;
//  ImportElements.StationName.LastPosition := simpleDSGetImportElements.FieldByName('iLastPosition').AsInteger;
//  // 7 - Month
//  simpleDSGetImportElements.Locate('idElement',7,[loCaseInsensitive]);
//  ImportElements.Month.FirstLine := simpleDSGetImportElements.FieldByName('iFirstLine').AsInteger;
//  ImportElements.Month.FirstPosition := simpleDSGetImportElements.FieldByName('iFirstPosition').AsInteger;
//  ImportElements.Month.LastPosition := simpleDSGetImportElements.FieldByName('iLastPosition').AsInteger;
//  // 8 - Year
//  simpleDSGetImportElements.Locate('idElement',8,[loCaseInsensitive]);
//  ImportElements.Year.FirstLine := simpleDSGetImportElements.FieldByName('iFirstLine').AsInteger;
//  ImportElements.Year.FirstPosition := simpleDSGetImportElements.FieldByName('iFirstPosition').AsInteger;
//  ImportElements.Year.LastPosition := simpleDSGetImportElements.FieldByName('iLastPosition').AsInteger;
//  //Clean Up
//  simpleDSGetImportElements.Active := False;
//  simpleDSGetImportElements.Free;
//end;

end.
