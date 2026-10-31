program archeryclock25;

{$MODE Delphi}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}

  Forms, Interfaces,
  {$IFDEF Darwin} macerrorlog, macdisplaychooser, {$ENDIF}
  Countdown in 'Countdown.pas' {Countdownform};

{$R *.res}

{$IFDEF Darwin}
var
  ClockDisplay: Integer;
{$ENDIF}
begin
  Application.Initialize;
  Application.Title := 'Countdown Archery Clock';
  {$IFDEF Darwin}
  // Mac: ask which display shows the clock when more than one is connected
  ClockDisplay := MacChooseDisplay;
  if ClockDisplay < 0 then
    Exit;
  {$ENDIF}
  Application.CreateForm(TCountdownform, Countdownform);
  {$IFDEF Darwin}
  MacPlaceOnDisplay(Countdownform, ClockDisplay);
  {$ENDIF}
  Application.Run;
end.
