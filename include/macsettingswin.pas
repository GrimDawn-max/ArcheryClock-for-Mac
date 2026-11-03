unit macsettingswin;

{ Mac build, "redesign" version: the menus in windows of their own.
  Upstream shows its two menus (timing and sequence; settings) as panels on the right of the clock screen, which
  shrink the clock while they are open and squeeze every page into 420 pixels. Here each is a standard Mac window:
  the timing icon opens the timing window, the gear icon the settings window, which has a sidebar of sections in
  place of tabs. The clock keeps its full size, and a window can sit on another display (the operator's laptop)
  while the clock shows on the big screen.
  Nothing is rebuilt: the settings pages (the SettingsTabs page control) and the contents of the timing panel are
  moved into the windows, so every control keeps the code behind it. The panels themselves stay hidden on the
  clock screen, so the clock's own rules for an open menu (a smaller clock, its keyboard shortcuts switched off)
  never apply. }

{$mode objfpc}{$H+}
{$modeswitch objectivec1}

interface

{ Opens the timing and sequence window. }
procedure MacShowTiming;
{ Opens the settings window at the page last shown. }
procedure MacShowSettings;

implementation

uses
  Math, Classes, SysUtils, Controls, StdCtrls, ExtCtrls, ComCtrls, Forms, Graphics, CocoaAll, Countdown, mactidy,
  macappearance;

const
  { A page is laid out at the window's width, but not wider than a comfortable column, nor narrower than the
    panel upstream designed it for (below that the window scrolls sideways). }
  PageMinWidth = 420;
  PageMaxWidth = 600;
  TimingMinHeight = 1000; // the timing panel's layout fills the height it gets; below this the window scrolls

type
  { Timing and sequence: the timing panel's contents, filling the window. }
  TTimingWindow = class(TForm)
  private
    Scroll: TScrollBox;
    Host: TPanel;
    procedure WindowResize(Sender: TObject);
    procedure LayOut;
  public
    constructor CreateWindow;
  end;

  { Settings: a sidebar of sections, the page for the one chosen, and the buttons along the bottom. }
  TSettingsWindow = class(TForm)
  private
    Sidebar: TListBox;
    Scroll: TScrollBox;
    BottomBar: TPanel;
    SaveButton: TButton;
    Pages: TList; // the settings page shown for each sidebar line
    procedure FillSidebar;
    procedure SidebarClick(Sender: TObject);
    procedure SaveClick(Sender: TObject);
    procedure WindowResize(Sender: TObject);
    procedure ShowPage(Index: Integer);
    procedure LayOutPage;
  public
    constructor CreateWindow;
    destructor Destroy; override;
  end;

var
  TimingWin: TTimingWindow = nil;
  SettingsWin: TSettingsWindow = nil;

{ A menu window: floats in front of the full-screen clock, opens centred and large enough for its contents. }
procedure SetUpWindow(W: TForm; const Title: string; AWidth, AHeight: Integer);
var
  Area: TRect;
begin
  W.Caption := Title;
  W.BorderStyle := bsSizeable;
  W.FormStyle := fsStayOnTop;
  // on the clock's display, within it
  Area := Countdownform.Monitor.WorkareaRect;
  W.Width := Min(AWidth, Area.Right - Area.Left - 40);
  W.Height := Min(AHeight, Area.Bottom - Area.Top - 40);
  W.Left := Area.Left + (Area.Right - Area.Left - W.Width) div 2;
  W.Top := Area.Top + (Area.Bottom - Area.Top - W.Height) div 2;
end;

{ A scrolling area whose scroll bars show whenever its contents don't fit (macOS otherwise hides them until you
  scroll, so nothing tells you there is more below). }
function NewScroll(AOwner: TForm): TScrollBox;
begin
  Result := TScrollBox.Create(AOwner);
  Result.Parent := AOwner;
  Result.Align := alClient;
  Result.BorderStyle := bsNone;
  Result.AutoScroll := True;
  Result.HandleNeeded;
  if NSObject(Result.Handle).isKindOfClass(NSScrollView) then
  begin
    NSScrollView(Result.Handle).setScrollerStyle(NSScrollerStyleLegacy);
    NSScrollView(Result.Handle).setAutohidesScrollers(True);
  end;
end;

{ The width a page is laid out at, for a scrolling area of this width. }
function PageWidth(Scroll: TScrollBox): Integer;
begin
  Result := EnsureRange(Scroll.ClientWidth, PageMinWidth, PageMaxWidth);
end;

{ The clock-screen panels never show in this version. }
procedure HidePanels;
begin
  Countdownform.savesettings.Visible := False;
  Countdownform.timeseqpanel.Visible := False;
end;

{ Moving controls into another window gives them new native views, which lose the dark appearance that keeps
  captions light on the black panels: apply it again once the window is on screen. }
procedure Refresh(W: TForm);
begin
  MacDarkenDarkPanels(Countdownform);
  Application.ProcessMessages; // let the window settle its sizes before laying it out
  if Assigned(W.OnResize) then W.OnResize(W);
end;

{ ---- timing and sequence ---- }

constructor TTimingWindow.CreateWindow;
var
  F: TCountdownform;
  I: Integer;
  Kids: array of TControl;
begin
  inherited CreateNew(Application);
  F := Countdownform;
  SetUpWindow(Self, MacTimingTitle, PageMaxWidth + 20, TimingMinHeight + 30);
  Constraints.MinWidth := 300;
  Constraints.MinHeight := 300;
  Scroll := NewScroll(Self);
  Scroll.Color := F.timeseqpanel.Color;

  // the panel's controls move into a panel of this window. The panel itself stays on the clock screen, hidden,
  // and is kept the size of this one, because the layout code measures it.
  Host := TPanel.Create(Self);
  Host.Parent := Scroll;
  Host.BevelOuter := bvNone;
  Host.Color := F.timeseqpanel.Color;
  SetLength(Kids, F.timeseqpanel.ControlCount);
  for I := 0 to F.timeseqpanel.ControlCount - 1 do
    Kids[I] := F.timeseqpanel.Controls[I];
  for I := 0 to High(Kids) do
    Kids[I].Parent := Host;
  MacTimingHost := Host;
  F.closeimage1.Visible := False; // the window's own close button does this
  OnResize := @WindowResize;
end;

procedure TTimingWindow.LayOut;
begin
  Host.SetBounds(0, 0, PageWidth(Scroll), Max(Scroll.ClientHeight, TimingMinHeight));
  MacTidyTimingPage;
end;

procedure TTimingWindow.WindowResize(Sender: TObject);
begin
  LayOut;
end;

procedure MacShowTiming;
begin
  if TimingWin = nil then TimingWin := TTimingWindow.CreateWindow;
  HidePanels;
  TimingWin.Caption := MacTimingTitle; // the language may have changed
  TimingWin.Show;
  Refresh(TimingWin);
  TimingWin.BringToFront;
end;

{ ---- settings ---- }

constructor TSettingsWindow.CreateWindow;
var
  F: TCountdownform;
begin
  inherited CreateNew(Application);
  F := Countdownform;
  SetUpWindow(Self, MacSettingsTitle, 220 + PageMaxWidth + 20, 1240);
  Constraints.MinWidth := 420;
  Constraints.MinHeight := 300;
  MacSettingsWindowed := True;
  Pages := TList.Create;

  Sidebar := TListBox.Create(Self);
  Sidebar.Parent := Self;
  Sidebar.Align := alLeft;
  Sidebar.Width := 220;
  Sidebar.Font.Height := -14;
  Sidebar.ItemHeight := 26;
  Sidebar.OnClick := @SidebarClick;

  BottomBar := TPanel.Create(Self);
  BottomBar.Parent := Self;
  BottomBar.Align := alBottom;
  BottomBar.Height := 48;
  BottomBar.BevelOuter := bvNone;

  SaveButton := TButton.Create(Self);
  SaveButton.Parent := BottomBar;
  SaveButton.Font.Height := -14;
  SaveButton.AutoSize := True;
  SaveButton.OnClick := @SaveClick;

  // the "shut down the client systems" button belongs to the network settings, but upstream kept it at the
  // bottom of the panel; keep it at the bottom of the window, beside the save button
  F.ShutdownremoteButton.Parent := BottomBar;
  F.ShutdownremoteButton.Font.Height := -14;
  F.ShutdownremoteButton.AutoSize := True;

  Scroll := NewScroll(Self);

  // the settings pages: the page control moves in whole, without its row of tabs (the sidebar replaces it)
  F.SettingsTabs.Parent := Scroll;
  F.SettingsTabs.Align := alNone;
  F.SettingsTabs.ShowTabs := False;

  OnResize := @WindowResize;
end;

destructor TSettingsWindow.Destroy;
begin
  Pages.Free;
  inherited Destroy;
end;

{ One line per settings page that is shown on this system, in upstream's order, with the captions the language
  file gave them. }
procedure TSettingsWindow.FillSidebar;
var
  F: TCountdownform;
  I: Integer;
begin
  F := Countdownform;
  Sidebar.Items.Clear;
  Pages.Clear;
  for I := 0 to F.SettingsTabs.PageCount - 1 do
    if F.SettingsTabs.Pages[I].TabVisible then
    begin
      Sidebar.Items.Add(Trim(F.SettingsTabs.Pages[I].Caption));
      Pages.Add(F.SettingsTabs.Pages[I]);
    end;
end;

procedure TSettingsWindow.ShowPage(Index: Integer);
begin
  if (Index < 0) or (Index >= Pages.Count) then Index := 0;
  if Pages.Count = 0 then Exit;
  Sidebar.ItemIndex := Index;
  Countdownform.SettingsTabs.ActivePage := TTabSheet(Pages[Index]);
  LayOutPage;
end;

{ The page at the window's width, laid out again for it, and as tall as what it shows: taller than the window,
  it scrolls. }
procedure TSettingsWindow.LayOutPage;
var
  Tabs: TPageControl;
  Page: TTabSheet;
  I, Need: Integer;
begin
  Tabs := Countdownform.SettingsTabs;
  Tabs.SetBounds(0, 0, PageWidth(Scroll), Max(Tabs.Height, Scroll.ClientHeight));
  MacTidySettings;
  Page := Tabs.ActivePage;
  Need := 0;
  // the scenario page scrolls its own list: it just fits the window
  if Page = Countdownform.tabscen then Page := nil;
  if Page <> nil then
    for I := 0 to Page.ControlCount - 1 do
      if Page.Controls[I].Visible then
        Need := Max(Need, Page.Controls[I].Top + Page.Controls[I].Height);
  Tabs.Height := Max(Scroll.ClientHeight, Need + 24 + (Tabs.Height - Tabs.ClientHeight));
end;

procedure TSettingsWindow.SidebarClick(Sender: TObject);
begin
  ShowPage(Sidebar.ItemIndex);
end;

procedure TSettingsWindow.SaveClick(Sender: TObject);
begin
  Countdownform.saveClick(Countdownform.save);
end;

procedure TSettingsWindow.WindowResize(Sender: TObject);
var
  Shutdown: TButton;
begin
  // save under the list of sections, shutting down the clients beside it
  SaveButton.Left := Max(8, (Sidebar.Width - SaveButton.Width) div 2);
  SaveButton.Top := (BottomBar.ClientHeight - SaveButton.Height) div 2;
  Shutdown := Countdownform.ShutdownremoteButton;
  Shutdown.Left := Sidebar.Width + 16;
  Shutdown.Top := (BottomBar.ClientHeight - Shutdown.Height) div 2;
  if Pages.Count > 0 then LayOutPage;
end;

procedure MacShowSettings;
var
  F: TCountdownform;
  Cap: string;
begin
  F := Countdownform;
  if SettingsWin = nil then SettingsWin := TSettingsWindow.CreateWindow;
  HidePanels;
  SettingsWin.Caption := MacSettingsTitle;
  // a button needs no full stop ("Save as startup setting.")
  Cap := Trim(F.save.Caption);
  if (Cap <> '') and (Cap[Length(Cap)] = '.') then SetLength(Cap, Length(Cap) - 1);
  SettingsWin.SaveButton.Caption := Cap;
  SettingsWin.FillSidebar;
  SettingsWin.Show;
  Refresh(SettingsWin);
  SettingsWin.ShowPage(SettingsWin.Pages.IndexOf(F.SettingsTabs.ActivePage));
  SettingsWin.BringToFront;
end;

end.
