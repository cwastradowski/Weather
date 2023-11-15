unit unitWebBrowser;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleCtrls, SHDocVw, Registry;

type
  TfrmWeb = class(TForm)
    webBro: TWebBrowser;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmWeb: TfrmWeb;

implementation

{$R *.dfm}
////////////////////////////////////////////////////////////////////////////////
procedure TfrmWeb.FormCreate(Sender: TObject);
var
 reg : TRegIniFile;
begin
 //Read the registry
 reg := TRegIniFile.Create('software\mpc\weather');
 frmWeb.Top :=  reg.ReadInteger('WebForm','Top',0);
 frmWeb.Left := reg.ReadInteger('WebForm','Left',0);
 frmWeb.Height := reg.ReadInteger('WebForm','Height',900);
 frmWeb.Width := reg.ReadInteger('WebForm','Width',900);
 reg.Free;
end;
////////////////////////////////////////////////////////////////////////////////
procedure TfrmWeb.FormDestroy(Sender: TObject);
var
 reg : TRegIniFile;
begin
 reg := TRegIniFile.Create('software\mpc\weather');
 reg.WriteInteger('WebForm','Top',frmWeb.Top);
 reg.WriteInteger('WebForm','Left',frmWeb.Left);
 reg.WriteInteger('WebForm','Height',frmWeb.Height);
 reg.WriteInteger('WebForm','Width',frmWeb.Width);
 reg.Free;
end;
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
end.
