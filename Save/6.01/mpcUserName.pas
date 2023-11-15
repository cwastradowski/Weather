unit mpcUserName;

interface

uses
 Windows, sysUtils;

 function mpcGetUserName : String;
 function mpcGetComputerName : String;

implementation

Function mpcGetUserName:String;
var
  wUserNameLength: DWord;
begin
  wUserNameLength:=254;
  setLength(result, wUserNameLength);
  getUserName(pChar(result),wUserNameLength);
  setLength(result,strLen(pChar(result)));
end;


Function mpcGetComputerName:String;
var
  wComputerNameLength: DWord;
begin
  wComputerNameLength:=254;
  setLength(result, wComputerNameLength);
  getComputerName(pChar(result),wComputerNameLength);
  setLength(result,strLen(pChar(result)));
end;

end.
