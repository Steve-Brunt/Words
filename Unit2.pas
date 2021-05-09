unit Unit2;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, FMX.Objects, FMX.Edit,
  FMX.ScrollBox, FMX.Memo;

type
  TForm2 = class(TForm)
    Layout1: TLayout;
    Rectangle1: TRectangle;
    Label1: TLabel;
    Layout2: TLayout;
    Label2: TLabel;
    Button1: TButton;
    Rectangle2: TRectangle;
    Edit1: TEdit;
    Layout3: TLayout;
    Rectangle3: TRectangle;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.fmx}
{$R *.LgXhdpiPh.fmx ANDROID}

procedure TForm2.Button1Click(Sender: TObject);
begin
ShowMessage('Hello World');
end;

end.
