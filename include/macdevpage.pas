unit macdevpage;

{ Mac build, for development only: AC_DEVPAGE=<page> opens that settings page once the clock is up and keeps it
  open, so the page can be screenshotted without anyone clicking through the menus. 'timing' opens Timing and
  sequence; anything else names a settings tab (tablang, tabscr, screencolor, tabsound, TabNetwork, tabprecnt,
  tabEmergency, tabscen, hardwaretab, Touchscreentab, abouttab, controltab).
  AC_DEVSYSTEM selects a shooting system first. AC_DEVCLICK presses buttons on the timing page
  (name,name,...) or, on a settings tab, opens a menu and prints its items.
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
  Page, Name: string;
  Tab: TComponent;
begin
  Page := GetEnvironmentVariable('AC_DEVPAGE');
  // AC_DEVSYSTEM names a shooting system's button (FITA, FITAFIN, onepijl, follow, Manual) to select first
  Tab := Countdownform.FindComponent(GetEnvironmentVariable('AC_DEVSYSTEM'));
  if Tab is TRadioButton then
    TRadioButton(Tab).Checked := True;
  if SameText(Page, 'timing') then
  begin
    Countdownform.timingsettingsClick(nil);
    // AC_DEVCLICK names buttons on the page to press in turn once it is open, separated by commas
    // (e.g. reamfindefbutton,indfindefbutton: team round, then back to individual)
    for Name in GetEnvironmentVariable('AC_DEVCLICK').Split(',') do
    begin
      Tab := Countdownform.FindComponent(Name);
      if Tab is TButton then
        TButton(Tab).Click;
    end;
  end
  else
  begin
    Tab := Countdownform.FindComponent(Page);
    if not (Tab is TTabSheet) then
      Exit;
    Countdownform.settingsClick(nil);
    Countdownform.SettingsTabs.ActivePage := TTabSheet(Tab);
    // on a settings tab AC_DEVCLICK names a menu to open (e.g. serialport1: the Arduino port list)
    Tab := Countdownform.FindComponent(GetEnvironmentVariable('AC_DEVCLICK'));
    if Tab is TComboBox then
    begin
      TComboBox(Tab).OnDropDown(Tab); // what opening it would do; then list it, since a capture can't show it
      WriteLn(Tab.Name, ': ', TComboBox(Tab).Items.CommaText);
      TComboBox(Tab).DroppedDown := True;
    end;
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
