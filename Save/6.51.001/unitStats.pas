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
 iStationNo,iGridYearA,iGridYearB : integer;
 wStartMonth,wEndMonth, wStartDay,wEndDay, wStartYear,wEndYear : word;
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
 for iStationNo := 0 to nStationCount - 1 do
 begin
   sp.DataSet.CommandType := ctQuery;
   sp.DataSet.CommandText := 'mpc_wx_DateRange ' + IntToStr(aStationInfo[iStationNo].idStation);
   SP.Active := True;
   dStatsStart := SP.FieldByName('FirstDate').AsDateTime;
   dStatsEnd := SP.FieldByName('LastDate').AsDateTime;
   SP.Active := False;
   DecodeDate(dStatsStart, wStartYear, wStartMonth, wStartDay);
   DecodeDate(dStatsEnd,wEndYear,wEndMonth,wEndDay);
   frmMain.aStringGridStatsPage1[iStationNo].RowCount := wEndYear - wStartYear + 2;
   frmMain.aStringGridStatsPage2[iStationNo].RowCount := wEndYear - wStartYear + 2;
   frmMain.aStringGridStatsPage3[iStationNo].RowCount := wEndYear - wStartYear + 2;
   frmMain.aStringGridStatsPage4[iStationNo].RowCount := wEndYear - wStartYear + 2;
   //Populate the fixed values in all Grid Pages
   for iGridYearB := 1 to frmMain.aStringGridStatsPage1[iStationNo].RowCount do
   begin
     //Populate the year in column 1 for all Grid Pages
     frmMain.aStringGridStatsPage1[iStationNo].Cells[0,iGridYearB] := IntToStr(wEndYear - iGridYearB + 1);
     frmMain.aStringGridStatsPage2[iStationNo].Cells[0,iGridYearB] := IntToStr(wEndYear - iGridYearB + 1);
     frmMain.aStringGridStatsPage3[iStationNo].Cells[0,iGridYearB] := IntToStr(wEndYear - iGridYearB + 1);
     frmMain.aStringGridStatsPage4[iStationNo].Cells[0,iGridYearB] := IntToStr(wEndYear - iGridYearB + 1);
   end;

   //Populate Row 1 Headers for Grid Page 1
   frmMain.aStringGridStatsPage1[iStationNo].Cells[0,0] := 'Year';
   frmMain.aStringGridStatsPage1[iStationNo].Cells[1,0] := 'Max High';
   frmMain.aStringGridStatsPage1[iStationNo].Cells[2,0] := 'Min Low';
   frmMain.aStringGridStatsPage1[iStationNo].Cells[3,0] := 'Min High';
   frmMain.aStringGridStatsPage1[iStationNo].Cells[4,0] := 'Max Low';
   frmMain.aStringGridStatsPage1[iStationNo].Cells[5,0] := 'Total Rain';
   frmMain.aStringGridStatsPage1[iStationNo].Cells[6,0] := 'Max Rain';
   frmMain.aStringGridStatsPage1[iStationNo].Cells[7,0] := 'Rain Days';

   //Populate Row 1 in Headers for Grid Page 2
   frmMain.aStringGridStatsPage2[iStationNo].Cells[0,0] := 'Year';
   frmMain.aStringGridStatsPage2[iStationNo].Cells[1,0] := 'No of ' + IntToStr(aStationInfo[iStationNo].iTemp1) + 's';
   frmMain.aStringGridStatsPage2[iStationNo].Cells[2,0] := 'No of ' + IntToStr(aStationInfo[iStationNo].iTemp2) + 's';
   frmMain.aStringGridStatsPage2[iStationNo].Cells[3,0] := 'No of ' + IntToStr(aStationInfo[iStationNo].iTemp3) + 's';
   frmMain.aStringGridStatsPage2[iStationNo].Cells[4,0] := 'No of ' + IntToStr(aStationInfo[iStationNo].iTemp4) + 's';
   frmMain.aStringGridStatsPage2[iStationNo].Cells[5,0] := 'No of ' + IntToStr(aStationInfo[iStationNo].iTemp5) + 's';
   frmMain.aStringGridStatsPage2[iStationNo].Cells[6,0] := 'No of ' + IntToStr(aStationInfo[iStationNo].iTemp6) + 's';

   //Populate Row 1 in Headers for Grid Page 3
   frmMain.aStringGridStatsPage3[iStationNo].Cells[0,0] := 'Year';
   frmMain.aStringGridStatsPage3[iStationNo].Cells[1,0] := 'First ' + IntToStr(aStationInfo[iStationNo].iTemp1);
   frmMain.aStringGridStatsPage3[iStationNo].Cells[2,0] := 'First ' + IntToStr(aStationInfo[iStationNo].iTemp2);
   frmMain.aStringGridStatsPage3[iStationNo].Cells[3,0] := 'First ' + IntToStr(aStationInfo[iStationNo].iTemp3);
   frmMain.aStringGridStatsPage3[iStationNo].Cells[4,0] := 'First ' + IntToStr(aStationInfo[iStationNo].iTemp4);
   frmMain.aStringGridStatsPage3[iStationNo].Cells[5,0] := 'First ' + IntToStr(aStationInfo[iStationNo].iTemp5);
   frmMain.aStringGridStatsPage3[iStationNo].Cells[6,0] := 'First ' + IntToStr(aStationInfo[iStationNo].iTemp6);

   //Populate Row 1 in Headers for Grid Page 4
   frmMain.aStringGridStatsPage4[iStationNo].Cells[0,0] := 'Year';
   frmMain.aStringGridStatsPage4[iStationNo].Cells[1,0] := 'Last ' + IntToStr(aStationInfo[iStationNo].iTemp1);
   frmMain.aStringGridStatsPage4[iStationNo].Cells[2,0] := 'Last ' + IntToStr(aStationInfo[iStationNo].iTemp2);
   frmMain.aStringGridStatsPage4[iStationNo].Cells[3,0] := 'Last ' + IntToStr(aStationInfo[iStationNo].iTemp3);
   frmMain.aStringGridStatsPage4[iStationNo].Cells[4,0] := 'Last ' + IntToStr(aStationInfo[iStationNo].iTemp4);
   frmMain.aStringGridStatsPage4[iStationNo].Cells[5,0] := 'Last ' + IntToStr(aStationInfo[iStationNo].iTemp5);
   frmMain.aStringGridStatsPage4[iStationNo].Cells[6,0] := 'Last ' + IntToStr(aStationInfo[iStationNo].iTemp6);

   //Populate the Grids with the values
   for iGridYearA := 1 to frmMain.aStringGridStatsPage1[iStationNo].RowCount - 1 do //Loop for the different years
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
     dStatsStart := StrToDate('01/01/' + frmMain.aStringGridStatsPage1[iStationNo].Cells[0,iGridYearA]);
     dStatsEnd := StrToDate(sQueryendMonthDay + frmMain.aStringGridStatsPage1[iStationNo].Cells[0,iGridYearA]);

     //GRID Page 1
     //Set up the Stored Procedure for a portion of Grid 1
     SP1.Active := False;
     SP1.DataSet.CommandType := ctQuery;
     SP1.DataSet.CommandText := 'mpc_wx_MaxMinbyDateRange ' +
                                QuotedStr(DateToStr(dStatsStart)) + ',' +
                                QuotedStr(DateToStr(dStatsEnd)) + ',' +
                                IntToStr(aStationInfo[iStationNo].idStation);
     SP1.Active := True;

     //Populate the Grid Page 1
     if SP1.FieldByName('MaxHigh').IsNull then
       frmMain.aStringGridStatsPage1[iStationNo].Cells[1, iGridYearA] := '' else
       frmMain.aStringGridStatsPage1[iStationNo].Cells[1, iGridYearA] := IntToStr(SP1.FieldValues['MaxHigh']);
     if SP1.FieldByName('MinLow').IsNull then
       frmMain.aStringGridStatsPage1[iStationNo].Cells[2, iGridYearA] := '' else
       frmMain.aStringGridStatsPage1[iStationNo].Cells[2, iGridYearA] := IntToStr(SP1.FieldValues['MinLow']);
     if SP1.FieldByName('MinHigh').IsNull then
       frmMain.aStringGridStatsPage1[iStationNo].Cells[3, iGridYearA] := '' else
       frmMain.aStringGridStatsPage1[iStationNo].Cells[3, iGridYearA] := IntToStr(SP1.FieldValues['MinHigh']);
     if SP1.FieldByName('MaxLow').IsNull then
       frmMain.aStringGridStatsPage1[iStationNo].Cells[4, iGridYearA] := '' else
       frmMain.aStringGridStatsPage1[iStationNo].Cells[4, iGridYearA] := IntToStr(SP1.FieldValues['MaxLow']);
     if SP1.FieldByName('SumRain').IsNull then
       frmMain.aStringGridStatsPage1[iStationNo].Cells[5, iGridYearA] := '' else
       frmMain.aStringGridStatsPage1[iStationNo].Cells[5, iGridYearA] := FloatToStrf(SP1.FieldValues['SumRain'], ffGeneral, 5, 2);
     if SP1.FieldByName('MaxRain').IsNull then
       frmMain.aStringGridStatsPage1[iStationNo].Cells[6, iGridYearA] := '' else
       frmMain.aStringGridStatsPage1[iStationNo].Cells[6, iGridYearA] := FloatToStrf(SP1.FieldValues['MaxRain'], ffGeneral, 5, 2);

     SP1.Active := False;
     SP1.DataSet.CommandType := ctQuery;
     SP1.DataSet.CommandText := 'mpc_wx_RainDays ' +
                                QuotedStr(DateToStr(dStatsStart)) + ',' +
                                QuotedStr(DateToStr(dStatsEnd)) + ',' +
                                IntToStr(aStationInfo[iStationNo].idStation);
     SP1.Active := True;
     frmMain.aStringGridStatsPage1[iStationNo].Cells[7, iGridYearA] := IntToStr(SP1.FieldValues['RainDays']);
     SP1.Active := False;

     //GRID Pages 2, 3 and 4
     SP1.DataSet.CommandText := 'mpc_wx_TempDays ' +
                                QuotedStr(DateToStr(dStatsStart)) + ',' +
                                QuotedStr(DateToStr(dStatsEnd)) + ',' +
                                IntToStr(aStationInfo[iStationNo].iTemp1) + ',' +
                                IntToStr(aStationInfo[iStationNo].idStation);
     SP1.Active := True;
     //Page 2
     frmMain.aStringGridStatsPage2[iStationNo].Cells[1, iGridYearA] := IntToStr(SP1.FieldValues['TempDays']);
     //Page 3
     if SP1.FieldByName('FirstDate').IsNull  then
       frmMain.aStringGridStatsPage3[iStationNo].Cells[1, iGridYearA] := '' else
       frmMain.aStringGridStatsPage3[iStationNo].Cells[1, iGridYearA] := DateToStr(SP1.FieldValues['FirstDate']);
     //Page 4
     if SP1.FieldByName('LastDate').IsNull  then
       frmMain.aStringGridStatsPage4[iStationNo].Cells[1, iGridYearA] := '' else
       frmMain.aStringGridStatsPage4[iStationNo].Cells[1, iGridYearA] := DateToStr(SP1.FieldValues['LastDate']);
     SP1.Active := False;

     //Temp2 code
     SP1.DataSet.CommandText := 'mpc_wx_TempDays ' +
                                QuotedStr(DateToStr(dStatsStart)) + ',' +
                                QuotedStr(DateToStr(dStatsEnd)) + ',' +
                                IntToStr(aStationInfo[iStationNo].iTemp2) + ',' +
                                IntToStr(aStationInfo[iStationNo].idStation);
     SP1.Active := True;
     //Page 2
     frmMain.aStringGridStatsPage2[iStationNo].Cells[2, iGridYearA] := IntToStr(SP1.FieldValues['TempDays']);
     //Page 3
     if SP1.FieldByName('FirstDate').IsNull  then
       frmMain.aStringGridStatsPage3[iStationNo].Cells[2, iGridYearA] := '' else
       frmMain.aStringGridStatsPage3[iStationNo].Cells[2, iGridYearA] := DateToStr(SP1.FieldValues['FirstDate']);
     //Page 4
     if SP1.FieldByName('LastDate').IsNull  then
       frmMain.aStringGridStatsPage4[iStationNo].Cells[2, iGridYearA] := '' else
       frmMain.aStringGridStatsPage4[iStationNo].Cells[2, iGridYearA] := DateToStr(SP1.FieldValues['LastDate']);
     SP1.Active := False;

     //Temp3 code
     SP1.DataSet.CommandText := 'mpc_wx_TempDays ' +
                                QuotedStr(DateToStr(dStatsStart)) + ',' +
                                QuotedStr(DateToStr(dStatsEnd)) + ',' +
                                IntToStr(aStationInfo[iStationNo].iTemp3) + ',' +
                                IntToStr(aStationInfo[iStationNo].idStation);
     SP1.Active := True;
     //Page 2
     frmMain.aStringGridStatsPage2[iStationNo].Cells[3, iGridYearA] := IntToStr(SP1.FieldValues['TempDays']);
     //Page 3
     if SP1.FieldByName('FirstDate').IsNull  then
       frmMain.aStringGridStatsPage3[iStationNo].Cells[3, iGridYearA] := '' else
       frmMain.aStringGridStatsPage3[iStationNo].Cells[3, iGridYearA] := DateToStr(SP1.FieldValues['FirstDate']);
     //Page 4
     if SP1.FieldByName('LastDate').IsNull  then
       frmMain.aStringGridStatsPage4[iStationNo].Cells[3, iGridYearA] := '' else
       frmMain.aStringGridStatsPage4[iStationNo].Cells[3, iGridYearA] := DateToStr(SP1.FieldValues['LastDate']);
     SP1.Active := False;

     //Temp4 code
     SP1.DataSet.CommandText := 'mpc_wx_TempDays ' +
                                QuotedStr(DateToStr(dStatsStart)) + ',' +
                                QuotedStr(DateToStr(dStatsEnd)) + ',' +
                                IntToStr(aStationInfo[iStationNo].iTemp4) + ',' +
                                IntToStr(aStationInfo[iStationNo].idStation);
     SP1.Active := True;
     //Page 2
     frmMain.aStringGridStatsPage2[iStationNo].Cells[4, iGridYearA] := IntToStr(SP1.FieldValues['TempDays']);
     //Page 3
     if SP1.FieldByName('FirstDate').IsNull  then
       frmMain.aStringGridStatsPage3[iStationNo].Cells[4, iGridYearA] := '' else
       frmMain.aStringGridStatsPage3[iStationNo].Cells[4, iGridYearA] := DateToStr(SP1.FieldValues['FirstDate']);
     //Page 4
     if SP1.FieldByName('LastDate').IsNull  then
       frmMain.aStringGridStatsPage4[iStationNo].Cells[4, iGridYearA] := '' else
       frmMain.aStringGridStatsPage4[iStationNo].Cells[4, iGridYearA] := DateToStr(SP1.FieldValues['LastDate']);
     SP1.Active := False;

    //Temp5 code
     SP1.DataSet.CommandText := 'mpc_wx_TempDays ' +
                                QuotedStr(DateToStr(dStatsStart)) + ',' +
                                QuotedStr(DateToStr(dStatsEnd)) + ',' +
                                IntToStr(aStationInfo[iStationNo].iTemp5) + ',' +
                                IntToStr(aStationInfo[iStationNo].idStation);
     SP1.Active := True;
     //Page 2
     frmMain.aStringGridStatsPage2[iStationNo].Cells[5, iGridYearA] := IntToStr(SP1.FieldValues['TempDays']);
     //Page 3
     if SP1.FieldByName('FirstDate').IsNull  then
       frmMain.aStringGridStatsPage3[iStationNo].Cells[5, iGridYearA] := '' else
       frmMain.aStringGridStatsPage3[iStationNo].Cells[5, iGridYearA] := DateToStr(SP1.FieldValues['FirstDate']);
     //Page 4
     if SP1.FieldByName('LastDate').IsNull  then
       frmMain.aStringGridStatsPage4[iStationNo].Cells[5, iGridYearA] := '' else
       frmMain.aStringGridStatsPage4[iStationNo].Cells[5, iGridYearA] := DateToStr(SP1.FieldValues['LastDate']);
     SP1.Active := False;

    //Temp6 code
     SP1.DataSet.CommandText := 'mpc_wx_TempDays ' +
                                QuotedStr(DateToStr(dStatsStart)) + ',' +
                                QuotedStr(DateToStr(dStatsEnd)) + ',' +
                                IntToStr(aStationInfo[iStationNo].iTemp6) + ',' +
                                IntToStr(aStationInfo[iStationNo].idStation);
     SP1.Active := True;
     //Page 2
     frmMain.aStringGridStatsPage2[iStationNo].Cells[6, iGridYearA] := IntToStr(SP1.FieldValues['TempDays']);
     //Page 3
     if SP1.FieldByName('FirstDate').IsNull  then
       frmMain.aStringGridStatsPage3[iStationNo].Cells[6, iGridYearA] := '' else
       frmMain.aStringGridStatsPage3[iStationNo].Cells[6, iGridYearA] := DateToStr(SP1.FieldValues['FirstDate']);
     //Page 4
     if SP1.FieldByName('LastDate').IsNull  then
       frmMain.aStringGridStatsPage4[iStationNo].Cells[6, iGridYearA] := '' else
       frmMain.aStringGridStatsPage4[iStationNo].Cells[6, iGridYearA] := DateToStr(SP1.FieldValues['LastDate']);
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
