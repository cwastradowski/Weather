PROGRAM Weather;



uses
  Forms,
  Main in 'Main.pas' {frmMain},
  unitMPCpad in '..\..\MPC Common Files\MPCCommonUnits\unitMPCpad.pas',
  mpcCSV in '..\..\MPC Common Files\MPCCommonUnits\mpcCSV.pas',
  unitWebBrowser in 'unitWebBrowser.pas' {frmWeb},
  MPCdatetime in '..\..\MPC Common Files\MPCCommonUnits\MPCdatetime.pas',
  mpcSQL in '..\..\MPC Common Files\MPCCommonUnits\mpcSQL.pas',
  unitStats in 'unitStats.pas',
  unitImport in 'unitImport.pas' {frmImport},
  unitSetup in 'unitSetup.pas' {frmSetup};

{$R *.RES}

BEGIN
 Application.Initialize;
 Application.Title := 'Weather';
 Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
END.

