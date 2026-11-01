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
  SysUtils, Classes, Forms, ComCtrls, Countdown;

type
  TDevPage = class
    procedure Show(Data: PtrInt);
  end;

procedure TDevPage.Show(Data: PtrInt);
var
  Page: string;
  Tab: TComponent;
begin
  Page := GetEnvironmentVariable('AC_DEVPAGE');
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
  Free;
end;

procedure MacDevShowPage;
begin
  if GetEnvironmentVariable('AC_DEVPAGE') <> '' then
    Application.QueueAsyncCall(@TDevPage.Create.Show, 0);
end;

end.
