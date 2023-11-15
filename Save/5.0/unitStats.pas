unit unitStats;

interface
uses
 DB,sysUtils,Grids,Forms,SqlExpr,classes, Data.DBXMSSQL, SimpleDS;

 procedure ComputeAllStats;

implementation
uses
 Main;

PROCEDURE ComputeAllStats;
VAR
 i,j,k : integer;
 wMonth,wEndMonth, wDay,wEndDay, wYear,wEndYear : word;
 sQueryEndMonthDay : String;
 dStatsStart, dStatsEnd : TDateTime;
 SP,SP1 : TSimpleDataSet;
BEGIN
//////////////////////////////
 //Initialize the Grid.........
 SP := TSimpleDataSet.Create(frmMain);
 SP.Connection := frmMain.conWeather;
 SP1 := TSimpleDataSet.Create(frmMain);
 SP1.Connection := frmMain.conWeather;


//determine the first year of data and the number of rows to be displayed
 for i := 0 to nStationCount - 1 do
 begin
   sp.DataSet.CommandType := ctQuery;
   sp.DataSet.CommandText := 'mpc_wx_DateRange ' + IntToStr(aStationInfo[i].idStation);
   SP.Active := True;
   dStatsStart := SP.FieldByName('FirstDate').AsDateTime;
   dStatsEnd := SP.FieldByName('LastDate').AsDateTime;
   SP.Active := False;
   DecodeDate(dStatsStart, wYear, wMonth, wDay);
   DecodeDate(dStatsEnd,wEndYear,wEndMonth,wEndDay);
   frmMain.aStringGridStatsPage1[i].RowCount := wEndYear - wYear + 2;
   frmMain.aStringGridStatsPage2[i].RowCount := wEndYear - wYear + 2;
   frmMain.aStringGridStatsPage3[i].RowCount := wEndYear - wYear + 2;
   frmMain.aStringGridStatsPage4[i].RowCount := wEndYear - wYear + 2;
   //Populate the fixed values in all Grid Pages
   for j := 1 to frmMain.aStringGridStatsPage1[i].RowCount do
   begin
     //Populate the year in column 1 for all Grid Pages
     frmMain.aStringGridStatsPage1[i].Cells[0,j] := IntToStr(wEndYear - j + 1);
     frmMain.aStringGridStatsPage2[i].Cells[0,j] := IntToStr(wEndYear - j + 1);
     frmMain.aStringGridStatsPage3[i].Cells[0,j] := IntToStr(wEndYear - j + 1);
     frmMain.aStringGridStatsPage4[i].Cells[0,j] := IntToStr(wEndYear - j + 1);
   end;

   //Populate Row 1 Headers for Grid Page 1
   frmMain.aStringGridStatsPage1[i].Cells[0,0] := 'Year';
   frmMain.aStringGridStatsPage1[i].Cells[1,0] := 'Max High';
   frmMain.aStringGridStatsPage1[i].Cells[2,0] := 'Min Low';
   frmMain.aStringGridStatsPage1[i].Cells[3,0] := 'Min High';
   frmMain.aStringGridStatsPage1[i].Cells[4,0] := 'Max Low';
   frmMain.aStringGridStatsPage1[i].Cells[5,0] := 'Total Rain';
   frmMain.aStringGridStatsPage1[i].Cells[6,0] := 'Max Rain';
   frmMain.aStringGridStatsPage1[i].Cells[7,0] := 'Rain Days';

   //Populate Row 1 in Headers for Grid Page 2
   frmMain.aStringGridStatsPage2[i].Cells[0,0] := 'Year';
   frmMain.aStringGridStatsPage2[i].Cells[1,0] := 'No of ' + IntToStr(aStationInfo[i].iTemp1) + 's';
   frmMain.aStringGridStatsPage2[i].Cells[2,0] := 'No of ' + IntToStr(aStationInfo[i].iTemp2) + 's';
   frmMain.aStringGridStatsPage2[i].Cells[3,0] := 'No of ' + IntToStr(aStationInfo[i].iTemp3) + 's';
   frmMain.aStringGridStatsPage2[i].Cells[4,0] := 'No of ' + IntToStr(aStationInfo[i].iTemp4) + 's';
   frmMain.aStringGridStatsPage2[i].Cells[5,0] := 'No of ' + IntToStr(aStationInfo[i].iTemp5) + 's';
   frmMain.aStringGridStatsPage2[i].Cells[6,0] := 'No of ' + IntToStr(aStationInfo[i].iTemp6) + 's';

   //Populate Row 1 in Headers for Grid Page 3
   frmMain.aStringGridStatsPage3[i].Cells[0,0] := 'Year';
   frmMain.aStringGridStatsPage3[i].Cells[1,0] := 'First ' + IntToStr(aStationInfo[i].iTemp1);
   frmMain.aStringGridStatsPage3[i].Cells[2,0] := 'First ' + IntToStr(aStationInfo[i].iTemp2);
   frmMain.aStringGridStatsPage3[i].Cells[3,0] := 'First ' + IntToStr(aStationInfo[i].iTemp3);
   frmMain.aStringGridStatsPage3[i].Cells[4,0] := 'First ' + IntToStr(aStationInfo[i].iTemp4);
   frmMain.aStringGridStatsPage3[i].Cells[5,0] := 'First ' + IntToStr(aStationInfo[i].iTemp5);
   frmMain.aStringGridStatsPage3[i].Cells[6,0] := 'First ' + IntToStr(aStationInfo[i].iTemp6);

   //Populate Row 1 in Headers for Grid Page 4
   frmMain.aStringGridStatsPage4[i].Cells[0,0] := 'Year';
   frmMain.aStringGridStatsPage4[i].Cells[1,0] := 'Last ' + IntToStr(aStationInfo[i].iTemp1);
   frmMain.aStringGridStatsPage4[i].Cells[2,0] := 'Last ' + IntToStr(aStationInfo[i].iTemp2);
   frmMain.aStringGridStatsPage4[i].Cells[3,0] := 'Last ' + IntToStr(aStationInfo[i].iTemp3);
   frmMain.aStringGridStatsPage4[i].Cells[4,0] := 'Last ' + IntToStr(aStationInfo[i].iTemp4);
   frmMain.aStringGridStatsPage4[i].Cells[5,0] := 'Last ' + IntToStr(aStationInfo[i].iTemp5);
   frmMain.aStringGridStatsPage4[i].Cells[6,0] := 'Last ' + IntToStr(aStationInfo[i].iTemp6);

   //Populate the Grids with the values
   for k := 1 to frmMain.aStringGridStatsPage1[i].RowCount - 1 do //Loop for the different years
   begin
     //If the cbCompareToDate is checked, then each year should go to the query date
     //If not checked, then each year should go to 12/31
     //sQueryEndMonthDay is the variable used to control this
     if frmMain.cbCompareToDate.Checked then
       sQueryEndMonthDay := IntToStr(wQueryEndMonth) + '/' + IntToStr(wQueryEndDay)
                            + '/' //stop at the query date
     else
       sQueryEndMonthDay := '12/31/';  //Use the full year
     //Set the query start and stop dates
     dStatsStart := StrToDate('01/01/' + frmMain.aStringGridStatsPage1[i].Cells[0,k]);
     dStatsEnd := StrToDate(sQueryendMonthDay + frmMain.aStringGridStatsPage1[i].Cells[0,k]);

     //GRID Page 1
     //Set up the Stored Procedure for a portion of Grid 1
     SP1.Active := False;
     SP1.DataSet.CommandType := ctQuery;
     SP1.DataSet.CommandText := 'mpc_wx_MaxMinbyDateRange ' +
                                QuotedStr(DateToStr(dStatsStart)) + ',' +
                                QuotedStr(DateToStr(dStatsEnd)) + ',' +
                                IntToStr(aStationInfo[i].idStation);
     SP1.Active := True;

     //Populate the Grid Page 1
     if SP1.FieldByName('MaxHigh').IsNull then
       frmMain.aStringGridStatsPage1[i].Cells[1, k] := '' else
       frmMain.aStringGridStatsPage1[i].Cells[1, k] := IntToStr(SP1.FieldValues['MaxHigh']);
     if SP1.FieldByName('MinLow').IsNull then
       frmMain.aStringGridStatsPage1[i].Cells[2, k] := '' else
       frmMain.aStringGridStatsPage1[i].Cells[2, k] := IntToStr(SP1.FieldValues['MinLow']);
     if SP1.FieldByName('MinHigh').IsNull then
       frmMain.aStringGridStatsPage1[i].Cells[3, k] := '' else
       frmMain.aStringGridStatsPage1[i].Cells[3, k] := IntToStr(SP1.FieldValues['MinHigh']);
     if SP1.FieldByName('MaxLow').IsNull then
       frmMain.aStringGridStatsPage1[i].Cells[4, k] := '' else
       frmMain.aStringGridStatsPage1[i].Cells[4, k] := IntToStr(SP1.FieldValues['MaxLow']);
     if SP1.FieldByName('SumRain').IsNull then
       frmMain.aStringGridStatsPage1[i].Cells[5, k] := '' else
       frmMain.aStringGridStatsPage1[i].Cells[5, k] := FloatToStrf(SP1.FieldValues['SumRain'], ffGeneral, 5, 2);
     if SP1.FieldByName('MaxRain').IsNull then
       frmMain.aStringGridStatsPage1[i].Cells[6, k] := '' else
       frmMain.aStringGridStatsPage1[i].Cells[6, k] := FloatToStrf(SP1.FieldValues['MaxRain'], ffGeneral, 5, 2);

     SP1.Active := False;
     SP1.DataSet.CommandType := ctQuery;
     SP1.DataSet.CommandText := 'mpc_wx_RainDays ' +
                                QuotedStr(DateToStr(dStatsStart)) + ',' +
                                QuotedStr(DateToStr(dStatsEnd)) + ',' +
                                IntToStr(aStationInfo[i].idStation);
     SP1.Active := True;
     frmMain.aStringGridStatsPage1[i].Cells[7, k] := IntToStr(SP1.FieldValues['RainDays']);
     SP1.Active := False;

     //GRID Pages 2, 3 and 4
     SP1.DataSet.CommandText := 'mpc_wx_TempDays ' +
                                QuotedStr(DateToStr(dStatsStart)) + ',' +
                                QuotedStr(DateToStr(dStatsEnd)) + ',' +
                                IntToStr(aStationInfo[i].iTemp1) + ',' +
                                IntToStr(aStationInfo[i].idStation);
     SP1.Active := True;
     //Page 2
     frmMain.aStringGridStatsPage2[i].Cells[1, k] := IntToStr(SP1.FieldValues['TempDays']);
     //Page 3
     if SP1.FieldByName('FirstDate').IsNull  then
       frmMain.aStringGridStatsPage3[i].Cells[1, k] := '' else
       frmMain.aStringGridStatsPage3[i].Cells[1, k] := DateToStr(SP1.FieldValues['FirstDate']);
     //Page 4
     if SP1.FieldByName('LastDate').IsNull  then
       frmMain.aStringGridStatsPage4[i].Cells[1, k] := '' else
       frmMain.aStringGridStatsPage4[i].Cells[1, k] := DateToStr(SP1.FieldValues['LastDate']);
     SP1.Active := False;

     //Temp2 code
     SP1.DataSet.CommandText := 'mpc_wx_TempDays ' +
                                QuotedStr(DateToStr(dStatsStart)) + ',' +
                                QuotedStr(DateToStr(dStatsEnd)) + ',' +
                                IntToStr(aStationInfo[i].iTemp2) + ',' +
                                IntToStr(aStationInfo[i].idStation);
     SP1.Active := True;
     //Page 2
     frmMain.aStringGridStatsPage2[i].Cells[2, k] := IntToStr(SP1.FieldValues['TempDays']);
     //Page 3
     if SP1.FieldByName('FirstDate').IsNull  then
       frmMain.aStringGridStatsPage3[i].Cells[2, k] := '' else
       frmMain.aStringGridStatsPage3[i].Cells[2, k] := DateToStr(SP1.FieldValues['FirstDate']);
     //Page 4
     if SP1.FieldByName('LastDate').IsNull  then
       frmMain.aStringGridStatsPage4[i].Cells[2, k] := '' else
       frmMain.aStringGridStatsPage4[i].Cells[2, k] := DateToStr(SP1.FieldValues['LastDate']);
     SP1.Active := False;

     //Temp3 code
     SP1.DataSet.CommandText := 'mpc_wx_TempDays ' +
                                QuotedStr(DateToStr(dStatsStart)) + ',' +
                                QuotedStr(DateToStr(dStatsEnd)) + ',' +
                                IntToStr(aStationInfo[i].iTemp3) + ',' +
                                IntToStr(aStationInfo[i].idStation);
     SP1.Active := True;
     //Page 2
     frmMain.aStringGridStatsPage2[i].Cells[3, k] := IntToStr(SP1.FieldValues['TempDays']);
     //Page 3
     if SP1.FieldByName('FirstDate').IsNull  then
       frmMain.aStringGridStatsPage3[i].Cells[3, k] := '' else
       frmMain.aStringGridStatsPage3[i].Cells[3, k] := DateToStr(SP1.FieldValues['FirstDate']);
     //Page 4
     if SP1.FieldByName('LastDate').IsNull  then
       frmMain.aStringGridStatsPage4[i].Cells[3, k] := '' else
       frmMain.aStringGridStatsPage4[i].Cells[3, k] := DateToStr(SP1.FieldValues['LastDate']);
     SP1.Active := False;

     //Temp4 code
     SP1.DataSet.CommandText := 'mpc_wx_TempDays ' +
                                QuotedStr(DateToStr(dStatsStart)) + ',' +
                                QuotedStr(DateToStr(dStatsEnd)) + ',' +
                                IntToStr(aStationInfo[i].iTemp4) + ',' +
                                IntToStr(aStationInfo[i].idStation);
     SP1.Active := True;
     //Page 2
     frmMain.aStringGridStatsPage2[i].Cells[4, k] := IntToStr(SP1.FieldValues['TempDays']);
     //Page 3
     if SP1.FieldByName('FirstDate').IsNull  then
       frmMain.aStringGridStatsPage3[i].Cells[4, k] := '' else
       frmMain.aStringGridStatsPage3[i].Cells[4, k] := DateToStr(SP1.FieldValues['FirstDate']);
     //Page 4
     if SP1.FieldByName('LastDate').IsNull  then
       frmMain.aStringGridStatsPage4[i].Cells[4, k] := '' else
       frmMain.aStringGridStatsPage4[i].Cells[4, k] := DateToStr(SP1.FieldValues['LastDate']);
     SP1.Active := False;

    //Temp5 code
     SP1.DataSet.CommandText := 'mpc_wx_TempDays ' +
                                QuotedStr(DateToStr(dStatsStart)) + ',' +
                                QuotedStr(DateToStr(dStatsEnd)) + ',' +
                                IntToStr(aStationInfo[i].iTemp5) + ',' +
                                IntToStr(aStationInfo[i].idStation);
     SP1.Active := True;
     //Page 2
     frmMain.aStringGridStatsPage2[i].Cells[5, k] := IntToStr(SP1.FieldValues['TempDays']);
     //Page 3
     if SP1.FieldByName('FirstDate').IsNull  then
       frmMain.aStringGridStatsPage3[i].Cells[5, k] := '' else
       frmMain.aStringGridStatsPage3[i].Cells[5, k] := DateToStr(SP1.FieldValues['FirstDate']);
     //Page 4
     if SP1.FieldByName('LastDate').IsNull  then
       frmMain.aStringGridStatsPage4[i].Cells[5, k] := '' else
       frmMain.aStringGridStatsPage4[i].Cells[5, k] := DateToStr(SP1.FieldValues['LastDate']);
     SP1.Active := False;

    //Temp6 code
     SP1.DataSet.CommandText := 'mpc_wx_TempDays ' +
                                QuotedStr(DateToStr(dStatsStart)) + ',' +
                                QuotedStr(DateToStr(dStatsEnd)) + ',' +
                                IntToStr(aStationInfo[i].iTemp6) + ',' +
                                IntToStr(aStationInfo[i].idStation);
     SP1.Active := True;
     //Page 2
     frmMain.aStringGridStatsPage2[i].Cells[6, k] := IntToStr(SP1.FieldValues['TempDays']);
     //Page 3
     if SP1.FieldByName('FirstDate').IsNull  then
       frmMain.aStringGridStatsPage3[i].Cells[6, k] := '' else
       frmMain.aStringGridStatsPage3[i].Cells[6, k] := DateToStr(SP1.FieldValues['FirstDate']);
     //Page 4
     if SP1.FieldByName('LastDate').IsNull  then
       frmMain.aStringGridStatsPage4[i].Cells[6, k] := '' else
       frmMain.aStringGridStatsPage4[i].Cells[6, k] := DateToStr(SP1.FieldValues['LastDate']);
     SP1.Active := False;
   end;
 end;
 //Kill the query
 SP.Free;
END;
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
end.
