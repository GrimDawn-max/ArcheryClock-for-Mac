unit macdevpage;

{ Mac build, for development only: AC_DEVPAGE=<page> opens that settings page once the clock is up and keeps it
  open, so the page can be screenshotted without anyone clicking through the menus. 'timing' opens Timing and
  sequence; anything else names a settings tab (tablang, tabscr, screencolor, tabsound, TabNetwork, tabprecnt,
  tabEmergency, tabscen, hardwaretab, Touchscreentab, abouttab, controltab).
  Without AC_DEVPAGE nothing happens. }

{$mode objfpc}{$H+}

interface

procedure MacDevShowPage;

implementation

uses
  SysUtils, Classes, Forms, ComCtrls, StdCtrls, ExtCtrls, Countdown;

type
  TDevPage = class
    Timer: TTimer;
    procedure Show(Sender: TObject);
  end;

procedure TDevPage.Show(Sender: TObject);
var
  Page: string;
  Tab: TComponent;
begin
  Page := GetEnvironmentVariable('AC_DEVPAGE');
  // AC_DEVSYSTEM names a shooting system's button (FITA, FITAFIN, onepijl, follow, Manual) to select first
  Tab := Countdownform.FindComponent(GetEnvironmentVariable('AC_DEVSYSTEM'));
  if Tab is TRadioButton then
    TRadioButton(Tab).Checked := True;
  if SameText(Page, 'timing') then
    Countdownform.timingsettingsClick(nil)
  else
  begin
    Tab := Countdownform.FindComponent(Page);
    if not (Tab is TTabSheet) then
      Exit;
    Countdownform.settingsClick(nil);
    Countdownform.SettingsTabs.ActivePage := TTabSheet(Tab);
  end;
  menuremovesec := MaxInt div 2; // the menus normally close themselves after 10 s
  Timer.Enabled := False; // once only; freeing a timer inside its own event is unsafe, and this is dev-only
end;

procedure MacDevShowPage;
begin
  // wait until start-up has finished: the form's first activation sets up the network, which changing the
  // shooting system uses
  if GetEnvironmentVariable('AC_DEVPAGE') <> '' then
    with TDevPage.Create do
    begin
      Timer := TTimer.Create(nil);
      Timer.Interval := 2000;
      Timer.OnTimer := @Show;
    end;
end;

end.
