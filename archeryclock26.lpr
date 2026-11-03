program archeryclock25;

{$MODE Delphi}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}

  Forms, Interfaces,
  {$IFDEF Darwin} macerrorlog, macdisplaychooser, macappearance, machints, {$ENDIF}
  Countdown in 'Countdown.pas' {Countdownform}{$IFDEF Darwin}, macdevpage{$ENDIF};

{$R *.res}

{$IFDEF Darwin}
var
  ClockDisplay: Integer;
{$ENDIF}
begin
  Application.Initialize;
  Application.Title := 'Countdown Archery Clock';
  {$IFDEF Darwin}
  MacUseLightAppearance; // same colours as Windows whatever the system's light/dark setting
  // Mac: ask which display shows the clock when more than one is connected
  ClockDisplay := MacChooseDisplay;
  if ClockDisplay < 0 then
    Exit;
  {$ENDIF}
  Application.CreateForm(TCountdownform, Countdownform);
  {$IFDEF Darwin}
  MacPlaceOnDisplay(Countdownform, ClockDisplay);
  MacDarkenDarkPanels(Countdownform);
  MacDevShowPage; // development only: AC_DEVPAGE opens a settings page for screenshots
  {$ENDIF}
  Application.Run;
end.
