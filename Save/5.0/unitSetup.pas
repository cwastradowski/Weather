unit unitSetup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Registry, StdCtrls, ComCtrls, Grids,
  DirOutln, strUtils, DBCtrls, DBGrids, Mask,
  SimpleDS, Datasnap.DBClient, Data.DB, Vcl.ExtCtrls;

type
  TfrmSetup = class(TForm)
    dsStations: TDataSource;
    dbGridStations: TDBGrid;
    DBNavigator1: TDBNavigator;
    diaColor1: TColorDialog;
    groupBoxChartSetup: TGroupBox;
    dbEditChartLineHighColor: TDBEdit;
    dbEditChartLineLowColor: TDBEdit;
    Label14: TLabel;
    Label15: TLabel;
    editChartDays: TEdit;
    Label5: TLabel;
    dbEditChartLineRainColor: TDBEdit;
    Label16: TLabel;
    dsImportData: TDataSource;
    dsImportType: TDataSource;
    gbImport: TGroupBox;
    DBGrid1: TDBGrid;
    btnCloneType: TButton;
    editNewImportTypeName: TEdit;
    Label19: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    DBGrid2: TDBGrid;
    gbStationData: TGroupBox;
    dbTextStationName: TDBText;
    dbEditTemp4: TDBEdit;
    Label10: TLabel;
    dbEditTemp1: TDBEdit;
    Label7: TLabel;
    dbEditFilePath: TDBEdit;
    Label13: TLabel;
    dbEditWebCaption: TDBEdit;
    Label6: TLabel;
    dbEditURl: TDBEdit;
    Label4: TLabel;
    dbEditStation: TDBEdit;
    Label1: TLabel;
    dbEditShortName: TDBEdit;
    Label2: TLabel;
    dbEditSortOrder: TDBEdit;
    Label3: TLabel;
    dbEditTemp2: TDBEdit;
    Label8: TLabel;
    dbEditTemp5: TDBEdit;
    Label11: TLabel;
    dbEditTemp3: TDBEdit;
    Label9: TLabel;
    Label12: TLabel;
    dbEditTemp6: TDBEdit;
    dbcbActive: TDBCheckBox;
    simpleDSlImportType: TSimpleDataSet;
    simpleDSlImportData: TSimpleDataSet;
    simpleDSStations: TSimpleDataSet;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    Label20: TLabel;
    Label21: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure dbEditChartLineHighColorDblClick(Sender: TObject);
    procedure dbEditChartLineLowColorDblClick(Sender: TObject);
    procedure dbEditChartLineHighColorChange(Sender: TObject);
    procedure dbEditChartLineLowColorChange(Sender: TObject);
    procedure dbEditChartLineRainColorChange(Sender: TObject);
    procedure dbEditChartLineRainColorDblClick(Sender: TObject);
    procedure editNewImportTypeNameChange(Sender: TObject);
    procedure btnCloneTypeClick(Sender: TObject);
    procedure simpleDSlImportDataAfterPost(DataSet: TDataSet);
    procedure simpleDSlImportDataAfterDelete(DataSet: TDataSet);
    procedure FormHide(Sender: TObject);
    procedure simpleDSlImportTypeAfterDelete(DataSet: TDataSet);
    procedure simpleDSlImportTypeAfterPost(DataSet: TDataSet);
    procedure simpleDSStationsAfterPost(DataSet: TDataSet);
    procedure simpleDSStationsAfterDelete(DataSet: TDataSet);
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

procedure TfrmSetup.btnCloneTypeClick(Sender: TObject);
var
  spCloneImportType : TSimpleDataSet;
begin
  spCloneImportType := TSimpleDataSet.Create(nil);
  spCloneImportType.Connection := frmMain.conWeather;
  spCloneImportType.DataSet.CommandType := ctQuery;
  spCloneImportType.DataSet.CommandText := 'mpc_wx_CloneImportType ' +
                                           quotedStr(editNewImportTypeName.Text) + ',' +
                                           quotedStr(simpleDSlImportType.FieldByName('sName').AsString);
  spCloneImportType.Execute;
  //refresh the data grids to show the new ImportType
  simpleDSlImportType.Active := False;
  simpleDSlImportData.Active := False;
  simpleDSlImportType.Active := True;
  simpleDSlImportData.Active := True;
  spCloneImportType.Destroy;
end;

procedure TfrmSetup.dbEditChartLineHighColorChange(Sender: TObject);
begin
  dbEditChartLineHighColor.Font.Color := TColor(StrToInt(dbEditChartLineHighColor.Text));
end;

procedure TfrmSetup.dbEditChartLineHighColorDblClick(Sender: TObject);
begin
  if diaColor1.Execute() then //OK Button Pressed
  begin
    simpleDSStations.Edit;
    dbEditChartLineHighColor.Text := IntToStr(diaColor1.Color);
    simpleDSStations.Post;
  end;
end;

procedure TfrmSetup.dbEditChartLineLowColorChange(Sender: TObject);
begin
  dbEditChartLineLowColor.Font.Color := TColor(StrToInt(dbEditChartLineLowColor.Text));
end;

procedure TfrmSetup.dbEditChartLineLowColorDblClick(Sender: TObject);
begin
  if diaColor1.Execute()then
  begin
    simpleDSStations.Edit;
    dbEditChartLineLowColor.Text := IntToStr(diaColor1.Color);
    simpleDSStations.Post;
  end;
end;

procedure TfrmSetup.dbEditChartLineRainColorChange(Sender: TObject);
begin
  dbEditChartLineRainColor.Font.Color := TColor(StrToInt(dbEditChartLineRainColor.Text));
end;

procedure TfrmSetup.dbEditChartLineRainColorDblClick(Sender: TObject);
begin
  if diaColor1.Execute()then
  begin
    simpleDSStations.Edit;
    dbEditChartLineRainColor.Text := IntToStr(diaColor1.Color);
    simpleDSStations.Post;
  end;
end;

procedure TfrmSetup.editNewImportTypeNameChange(Sender: TObject);
var
  spImportType : TSimpleDataSet;
begin
  spImportType := TSimpleDataSet.Create(nil);
  spImportType.Connection := frmMain.conWeather;
  spImportType.DataSet.CommandType := ctQuery;
  spImportType.DataSet.CommandText := 'mpc_wx_GetCloneImportTypeName ' +
                                      quotedStr(editNewImportTypeName.Text);
  spImportType.Active := True;
  btnCloneType.Enabled := (spImportType.RecordCount = 0);
  spImportType.Active := False;
  spImportType.Destroy;
end;

procedure TfrmSetup.FormCreate(Sender: TObject);
var
  reg: TRegIniFile;
begin
  // Read the registry
  reg := TRegIniFile.Create('software\mpc\weather');
  editChartDays.Text := IntToStr(reg.ReadInteger('Chart', 'Days', 730));
  reg.Free;
  simpleDSStations.Active := True;
  simpleDSlImportType.Active := True;
  simpleDSlImportData.Active := True;
end;

procedure TfrmSetup.FormDestroy(Sender: TObject);
var
  reg: TRegIniFile;
begin
  // Update the registry
  reg := TRegIniFile.Create('software\mpc\weather');
  reg.WriteInteger('Chart', 'Days', StrToInt(editChartDays.Text));
  reg.Free;
end;

procedure TfrmSetup.FormHide(Sender: TObject);
begin
  simpleDSlImportData.ApplyUpdates(0);
  simpleDSlImportType.ApplyUpdates(0);
  simpleDSStations.ApplyUpdates(0);
end;

procedure TfrmSetup.simpleDSStationsAfterDelete(DataSet: TDataSet);
begin
  simpleDSStations.ApplyUpdates(0);
end;

procedure TfrmSetup.simpleDSStationsAfterPost(DataSet: TDataSet);
begin
  simpleDSStations.ApplyUpdates(0);
end;

procedure TfrmSetup.simpleDSlImportDataAfterDelete(DataSet: TDataSet);
begin
  simpleDSlImportData.ApplyUpdates(0);
end;

procedure TfrmSetup.simpleDSlImportDataAfterPost(DataSet: TDataSet);
begin
  simpleDSlImportData.ApplyUpdates(0);
end;

procedure TfrmSetup.simpleDSlImportTypeAfterDelete(DataSet: TDataSet);
begin
  simpleDSlImportType.ApplyUpdates(0);
end;

procedure TfrmSetup.simpleDSlImportTypeAfterPost(DataSet: TDataSet);
begin
  simpleDSlImportType.ApplyUpdates(0);
end;

end.
