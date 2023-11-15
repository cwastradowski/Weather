PROGRAM Weather;



uses
  Forms,
  Main in 'Main.pas' {frmMain},
  unitMPCpad in '..\..\MPC Common Files\MPCCommonUnits\unitMPCpad.pas',
  mpcCSV in '..\..\MPC Common Files\MPCCommonUnits\mpcCSV.pas',
  unitWebBrowser in 'unitWebBrowser.pas' {frmWeb},
  MPCdatetime in '..\..\MPC Common Files\MPCCommonUnits\MPCdatetime.pas',
  mpcSQL in '..\..\MPC Common Files\MPCCommonUnits\mpcSQL.pas',
  unitImport in 'unitImport.pas' {frmImport},
  unitSetup in 'unitSetup.pas' {frmSetup},
  MPCABOUT in '..\ObjRepository\MPC About Box\MPCABOUT.pas' {frmAboutBox},
  unitStats in 'unitStats.pas';

{$R *.RES}

BEGIN
 Application.Initialize;
 Application.Title := 'Weather';
 Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmSetup, frmSetup);
  //Application.CreateForm(TfrmSetup, frmMPCAboutBox);
  Application.Run;
END.

