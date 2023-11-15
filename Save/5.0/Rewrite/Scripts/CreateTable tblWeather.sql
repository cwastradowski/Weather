--select * from weather
--select * from tblStation
--select * from tblWeather

Create table tblWeather
( [idTblWeather] integer identity,
  [idStation] integer Not Null,
  [dtDate] datetime Not Null,
  [iHigh] integer Not Null,
  [iLow] integer Not Null,
  [fRain] float Not Null  )