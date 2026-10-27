program archeryclock25;

{$MODE Delphi}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}

  Forms, Interfaces,
  Countdown in 'Countdown.pas' {Countdownform};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Countdown Archery Clock';
  Application.CreateForm(TCountdownform, Countdownform);
  Application.Run;
end.
