unit unitSetup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,Registry, StdCtrls, ComCtrls, Grids,
  DirOutln,strUtils, FileCtrl, ADODB, Db, ExtCtrls, DBCtrls, DBGrids, Mask;

type
  TfrmSetup = class(TForm)
    editChartDays: TEdit;
    Label5: TLabel;
    dsStations: TDataSource;
    spStations: TADOStoredProc;
    dbGridStations: TDBGrid;
    DBNavigator1: TDBNavigator;
    dbEditStation: TDBEdit;
    dbEditShortName: TDBEdit;
    dbEditURl: TDBEdit;
    dbEditWebCaption: TDBEdit;
    dbEditFilePath: TDBEdit;
    dbEditTemp2: TDBEdit;
    dbEditTemp3: TDBEdit;
    dbEditTemp1: TDBEdit;
    dbEditTemp4: TDBEdit;
    dbEditTemp5: TDBEdit;
    dbEditTemp6: TDBEdit;
    dbcbActive: TDBCheckBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    dbEditSortOrder: TDBEdit;
    Label13: TLabel;
    dbTextStationName: TDBText;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSetup: TfrmSetup;

implementation
uses
 Main;
{$R *.dfm}
////////////////////////////////////////////////////////////////////////////////
procedure TfrmSetup.FormCreate(Sender: TObject);
var
 reg : TRegIniFile;
begin
 //Read the registry
 reg := TRegIniFile.Create('software\mpc\weather');
 editChartDays.Text := IntToStr(reg.ReadInteger('Chart','Days',730));
 reg.Free;
 spStations.Active := True;
end;
////////////////////////////////////////////////////////////////////////////////
procedure TfrmSetup.FormDestroy(Sender: TObject);
var
 reg : TRegIniFile;
begin
 //Update the registry
 reg := TRegIniFile.Create('software\mpc\weather');
 reg.WriteInteger('Chart','Days',StrToInt(editChartDays.Text));
 reg.Free;
end;
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
end.
