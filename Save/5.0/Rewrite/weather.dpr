PROGRAM Weather;



uses
  Forms,
  Main in 'Main.pas' {frmMain},
  MPCABOUT in '..\..\OBJREPOSITORY\ABOUTBOX\MPCABOUT.pas' {frmAboutBox},
  unitMPCpad in '..\..\MPCCommonUnits\unitMPCpad.pas',
  mpcCSV in '..\..\MPCCommonUnits\mpcCSV.pas',
  unitWebBrowser in 'unitWebBrowser.pas' {frmWeb},
  MPCdatetime in '..\..\MPCCommonUnits\MPCdatetime.pas',
  mpcSQL in '..\..\MPCCommonUnits\mpcSQL.pas',
  unitSetup in 'unitSetup.pas' {frmSetup},
  unitImport in 'unitImport.pas' {frmImport},
  unitStats in 'unitStats.pas';

{$R *.RES}

BEGIN
 Application.Initialize;
 Application.Title := 'Weather';
 Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
END.

