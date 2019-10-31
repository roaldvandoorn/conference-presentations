program Project1;

uses
  Vcl.Forms,
  Unit1 in 'src\Unit1.pas' {Form1},
  APRibbonBarAccessibility in 'src\APRibbonBarAccessibility.pas',
  APRibbonAccessibility in 'src\APRibbonAccessibility.pas',
  APBaseAccessibility in 'src\APBaseAccessibility.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
