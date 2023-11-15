unit unitImport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ActnList, StdCtrls, HTTPApp, HTTPProd, Grids, ExtCtrls,
  DBCtrls, DB, DBTables, DBGrids, mpcCSV, ADODB,Registry, FMTBcd, DBClient,
  Provider, SqlExpr, DateUtils,unitMPCPad;

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
    procedure readFile(fnFileName : String; iStation : integer);
    function compareFile():boolean;
    procedure fixFile();
    function nMonth(month : string) : integer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure closeform(Sender : TObject);
    procedure CreateFrmImportMainMenu;
    procedure OnClickFrmImportMainMenuItem(Sender : TObject);
    procedure btnCompareClick(Sender: TObject);
    procedure btnFixClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmImport: TfrmImport;
  month, year : string;
  sMonth, sYear : string;
  spCompareGrid : TADOStoredProc;
  dsCompareGrid : TDataSource;

//  fnFileName : TFileName;
implementation

uses Main;

{$R *.dfm}


procedure TfrmImport.readFile(fnFileName: string; iStation : Integer);
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
//This seems to be the new National Weather Service standard file adopted by both
//Phoenix and LA.  LA for a long time and Phoenix as of February 2003
const
 cFirstLine = 1;
 cDay = 2;
 cMax = 3;
 cMin = 4;
 cRain = 5;
 cStation = 6;
 cMonth = 7;
 cYear = 8;
var
 qry : TADOQuery;
 iDaysInMonth : integer;
 iFirstLine : integer;
 iMaxStart,iMaxEnd,iMaxLength : integer;
 iMinStart,iMinEnd,iMinLength : integer;
 iRainStart,iRainEnd,iRainLength : integer;
 iStationFirstLine,iStationStart,iStationEnd : integer;
 iMonthFirstLine,iMonthStart,iMonthEnd : integer;
 iYearFirstLine,iYearStart,iYearEnd : integer;
 sl : TStringList;
 buffer, sStation: String;
 f : textfile;
 i : integer;
begin
 //Grab the coordinates of the elements in the import file
 qry := TADOQuery.Create(frmImport);
 qry.Connection := frmMain.connWeather;
 qry.SQL.Clear;
 qry.SQL.Add('Select idElement Element, iFirstLine FirstLine, iLastLine LastLine,' +
             'iFirstPosition FirstPosition, iLastPosition LastPosition ' +
             'from tbl_ImportData where idImportType = 1');
 qry.Active := True;
 qry.Locate('Element',cFirstLine,[]);
 iFirstLine := qry.FieldByName('FirstLine').AsInteger;
 qry.Locate('Element',cMax,[]);
 iMaxStart := qry.FieldByName('FirstPosition').AsInteger;
 iMaxEnd := qry.FieldByName('LastPosition').AsInteger;
 iMaxLength := iMaxEnd - iMaxStart + 1;
 qry.Locate('Element',cMin,[]);
 iMinStart := qry.FieldByName('FirstPosition').AsInteger;
 iMinEnd := qry.FieldByName('LastPosition').AsInteger;
 iMinLength := iMinEnd - iMinStart + 1;
 qry.Locate('Element',cRain,[]);
 iRainStart := qry.FieldByName('FirstPosition').AsInteger;
 iRainEnd := qry.FieldByName('LastPosition').AsInteger;
 iRainLength := iRainEnd - iRainStart + 1;
 qry.Locate('Element',cStation,[]);
 iStationFirstLine := qry.FieldByName('FirstLine').AsInteger;
 iStationStart := qry.FieldByName('FirstPosition').AsInteger;
 iStationEnd := qry.FieldByName('LastPosition').AsInteger;
 qry.Locate('Element',cMonth,[]);
 iMonthFirstLine := qry.FieldByName('FirstLine').AsInteger;
 iMonthStart := qry.FieldByName('FirstPosition').AsInteger;
 iMonthEnd := qry.FieldByName('LastPosition').AsInteger;
 qry.Locate('Element',cYear,[]);
 iYearFirstLine := qry.FieldByName('FirstLine').AsInteger;
 iYearStart := qry.FieldByName('FirstPosition').AsInteger;
 iYearEnd := qry.FieldByName('LastPosition').AsInteger;
 qry.Active := False;
 qry.Free;

 //Read the file
 sl := TStringList.Create;
 AssignFile(f,fnFileName);
 Reset(f);
 while not eof(f) do
 begin
  ReadLn(F,Buffer);
  sl.Add(buffer);
 end;
 CloseFile(f);
 //Done Reading

 //Show the Station, Month and Year on the label
 sStation := Copy(sl.Strings[iStationFirstLine - 1],iStationStart -1,
                             iStationEnd-iStationStart + 1);
 sMonth := Copy(sl.Strings[iMonthFirstLine - 1],iMonthStart -1,
                             iMonthEnd-iMonthStart + 1);
 sYear := Copy(sl.Strings[iYearFirstLine - 1],iYearStart -1,
                             iYearEnd-iYearStart + 1);
 lblFileInfo.Caption := sMonth + ', ' + sYear + ' at ' + sStation;

 //Determine Row Count by how many days in the month
 iDaysInMonth := DaysInAMonth(StrToInt(sYear),(nMonth(sMonth)));
 //Set the Number of Rows
 sgridData.RowCount := iDaysInMonth + 1;
 //Populate the Grid Headers in row 1
 sgridData.Cells[1,0] := 'Max';
 sgridData.Cells[2,0] := 'Min';
 sgridData.Cells[3,0] := 'Rain';

 //Set the grid height to account for the number of rows
 sgridData.Height := 613 - ((32 - sgridData.RowCount) * 19);

 //Populate the grid with the data values
 for i := 1 to iDaysInMonth do
 begin
  sgridData.Cells[0,i] := IntToStr(i);
  //Maximum
  sgridData.Cells[1,i] := Trim(copy(sl.Strings[iFirstLine + i - 2],iMaxStart, iMaxLength));
  //Minimum
  sgridData.Cells[2,i] := Trim(copy(sl.Strings[iFirstLine + i - 2],iMinStart,iMinLength));
  //Rain
  If UpperCase(Trim(copy(sl.Strings[iFirstLine + i - 2],iRainStart,iRainLength))) = 'T' then
   sgridData.Cells[3,i] := '0.00' else
   sgridData.Cells[3,i] := Trim(copy(sl.Strings[iFirstLine + i - 2],iRainStart,iRainLength));
 end;
 sl.Free;

 //set up the comparison dbgrid
 //Initialize the Stored Procedure
 spCompareGrid := TADOStoredProc.Create(frmImport);
 spCompareGrid.Connection := frmMain.connWeather;
 spCompareGrid.ProcedureName := 'mpc_wx_WeatherGrid';
 spCompareGrid.Parameters.CreateParameter('@idStation',ftInteger,pdInput,4,iStation);

 //initialize the Database connections
 dsCompareGrid := TDataSource.Create(self);
 dsCompareGrid.DataSet := spCompareGrid;
 dbGridImport.DataSource := dsCompareGrid;
 dbNavImport.DataSource := dsCompareGrid;

 //Clear the grid columns and add 4 fresh ones
 dbGridImport.Columns.Clear;
 for i := 0 to 3 do dbGridImport.Columns.Add;
 //Set up the fresh columns
 dbGridImport.Columns[0].Title.Caption := 'Date';
 dbGridImport.Columns[0].Width := 76;
 dbGridImport.Columns[0].FieldName := 'dtDate';
 dbGridImport.Columns[1].FieldName := 'iHigh';
 dbGridImport.Columns[1].Title.Caption := 'High';
 dbGridImport.Columns[2].FieldName := 'iLow';
 dbGridImport.Columns[2].Title.Caption := 'Low';
 dbGridImport.Columns[3].FieldName := 'fRain';
 dbGridImport.Columns[3].Title.Caption := 'Rain';

 //Populate the grid
 spCompareGrid.Active := True;

 //Move the visible grid to the same date range as the imported file
 spCompareGrid.Locate(('dtDate'), StrToDate(IntToStr(nMonth(sMonth)) + '/1/' +
                       sYear),[loCaseInsensitive]);
end;
////////////////////////////////////////////////////////////////////////////////
function TfrmImport.nMonth(month : string) : integer;
begin
 if Trim(UpperCase(month)) = 'JANUARY' then result := 1 else
 if Trim(UpperCase(month)) = 'FEBRUARY' then result := 2 else
 if Trim(UpperCase(month)) = 'MARCH' then result := 3 else
 if Trim(UpperCase(month)) = 'APRIL' then result := 4 else
 if Trim(UpperCase(month)) = 'MAY' then result := 5 else
 if Trim(UpperCase(month)) = 'JUNE' then result := 6 else
 if Trim(UpperCase(month)) = 'JULY' then result := 7 else
 if Trim(UpperCase(month)) = 'AUGUST' then result := 8 else
 if Trim(UpperCase(month)) = 'SEPTEMBER' then result := 9 else
 if Trim(UpperCase(month)) = 'OCTOBER' then result := 10 else
 if Trim(UpperCase(month)) = 'NOVEMBER' then result := 11 else result := 12;
end;
////////////////////////////////////////////////////////////////////////////////
procedure TfrmImport.btnCompareClick(Sender: TObject);
begin
  btnCompare.Visible := False;
  btnFix.Visible := CompareFile();
end;
////////////////////////////////////////////////////////////////////////////////
procedure TfrmImport.btnFixClick(Sender: TObject);
begin
  fixFile();
  btnFix.Visible := False;
end;
////////////////////////////////////////////////////////////////////////////////
function TfrmImport.compareFile(): boolean;
var
 i : integer;
 bError : boolean;
 bAnyError : boolean;
begin
 bError := False;
 bAnyError := False;
 for i := 1 to sgridData.RowCount - 1 do
 begin
  spCompareGrid.Locate(('dtDate'), StrToDateTime(IntToStr(nMonth(sMonth)) + '/' +
                               IntToStr(i) + '/' + sYear),[loCaseInsensitive]);
  if sgridData.Cells[1,i] <> spCompareGrid.FieldByName('iHigh').AsString then
  begin
   bError := True;
   bAnyError := True;
  end;
  if sgridData.Cells[2,i] <> spCompareGrid.FieldByName('iLow').AsString then
  begin
   bError := True;
   bAnyError := True;
  end;
  if StrToCurr(sgridData.Cells[3,i]) <> spCompareGrid.FieldByName('fRain').AsCurrency then
  begin
   bError := True;
   bAnyError := True;
  end;
  if bError then
  begin
   sgridData.Cells[0,i] := sgridData.Cells[0,i] + '  =>';
   bError := False;
  end;
 end;
 if bAnyError then lblPassFail.Caption := 'Failed' else
                   lblPassFail.Caption := 'Passed';
 result := bAnyError;
end;
////////////////////////////////////////////////////////////////////////////////
procedure TfrmImport.fixFile();
var
 i : integer;
begin
 for i := 1 to sgridData.RowCount - 1 do
 begin
  spCompareGrid.Locate(('dtDate'), StrToDateTime(IntToStr(nMonth(sMonth)) + '/' +
                               IntToStr(i) + '/' + sYear),[loCaseInsensitive]);
  if sgridData.Cells[1,i] <> spCompareGrid.FieldByName('iHigh').AsString then
  begin
   spCompareGrid.Edit;
   spCompareGrid.FieldByName('iHigh').AsInteger :=  StrToInt(sgridData.Cells[1,i]);
  end;
  if sgridData.Cells[2,i] <> spCompareGrid.FieldByName('iLow').AsString then
  begin
   spCompareGrid.Edit;
   spCompareGrid.FieldByName('iLow').AsInteger :=  StrToInt(sgridData.Cells[2,i]);
  end;
  if StrToCurr(sgridData.Cells[3,i]) <> spCompareGrid.FieldByName('fRain').AsCurrency then
  begin
   spCompareGrid.Edit;
   spCompareGrid.FieldByName('fRain').AsFloat :=  StrToFloat(sgridData.Cells[3,i]);
  end;
 end;
 spCompareGrid.Post;
 lblpassfail.Visible := False;
end;
////////////////////////////////////////////////////////////////////////////////
procedure TfrmImport.FormCreate(Sender: TObject);
var
 reg : TRegIniFile;
begin
 //Read the registry
 reg := TRegIniFile.Create('software\mpc\weather');
 frmImport.Top:= reg.ReadInteger('ImportForm','Top',0);
 frmImport.Left := reg.ReadInteger('ImportForm','Left',0);
 frmImport.Height := reg.ReadInteger('ImportForm','Height',150);
 frmImport.Width := reg.ReadInteger('ImportForm','Width',900);
  //registry done
  //Create the Main Menu for frmImport
 CreateFrmImportMainMenu;
end;
////////////////////////////////////////////////////////////////////////////////
procedure TfrmImport.FormDestroy(Sender: TObject);
var
 reg : TRegIniFile;
begin
 //Write the registry
 reg := TRegIniFile.Create('software\mpc\weather');
 reg.WriteInteger('ImportForm','Top',frmImport.Top);
 reg.WriteInteger('ImportForm','Left',frmImport.Left);
 reg.WriteInteger('ImportForm','Height',frmImport.Height);
 reg.WriteInteger('ImportForm','Width',frmImport.Width);
end;
////////////////////////////////////////////////////////////////////////////////
procedure TfrmImport.closeform(Sender: TObject);
begin
  //Close event for the main menu CLOSE FORM item
  frmImport.Close;
end;
////////////////////////////////////////////////////////////////////////////////
procedure TfrmImport.CreateFrmImportMainMenu;
var
 i : integer;
 aFrmImportFileMenuItem : array of TMenuItem;
 miFileClose : TMenuItem;
begin
 //Add the Menu options for the File menu item
 setlength(aFrmImportFileMenuItem,nStationCount);
 for i := 0 to nStationCount - 1 do
 begin
   aFrmImportFileMenuItem[i] := TMenuItem.Create(aFrmImportFileMenuItem[i]);
   aFrmImportFileMenuItem[i].Tag := i;
   aFrmImportFileMenuItem[i].Caption := 'Open ' + Trim(aStationInfo[i].sStation) + ' File';
   aFrmImportFileMenuItem[i].OnClick := OnClickFrmImportMainMenuItem;
   menuFile.Add(aFrmImportFileMenuItem[i]);
 end;
 //Add one more choice -- To Close this form
 miFileClose := TMenuItem.Create(self);
 miFileClose.Caption := 'Close Form';
 miFileClose.OnClick := closeform;
 menuFile.Add(miFileClose);
end;
////////////////////////////////////////////////////////////////////////////////
procedure TfrmImport.OnClickFrmImportMainMenuItem(Sender: TObject);
var
  diaFileOpenRawData : TOpenDialog;
begin
 //This is troubling.  I can't get the InitialDir to work.  Need to do more research
 //on this.  I have had this issue before but don't remember how to solve it.
 diaFileOpenRawData := TOpenDialog.Create(frmImport);
 diaFileOpenRawData.InitialDir := aStationInfo[TMenuItem(Sender).Tag].sNWSFilePath;
 //Set Current Dir is an attempt to get the initial dir value to work.  No success
 SetCurrentDir(aStationInfo[TMenuItem(Sender).Tag].sNWSFilePath);
 diaFileOpenRawData.FileName := '';
 diaFileOpenRawData.Filter := aStationInfo[TMenuItem(Sender).Tag].sStation + ' Data Files|*.txt|All Files|*.*';
 diaFileOpenRawData.Execute;

 //Make sure the pass fail label is blank
 lblPassFail.Caption := '';

 //if the user didn't pick a file then get out of here
 if diaFileOpenRawData.FileName = '' then exit;

 //If the user did pick a file then set everything in motion by first reading the file selected
 readFile(diaFileOpenRawData.FileName,aStationInfo[TMenuItem(Sender).Tag].idStation);

 //Show the compare button
 btnCompare.Visible := True;
end;
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
end.
