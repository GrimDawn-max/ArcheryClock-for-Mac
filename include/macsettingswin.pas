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
{ Development aid: started with AC_OPEN_SETTINGS set (a settings page's name, or "timing"), the app opens that
  window at start-up, so the layout can be checked without clicking. Does nothing otherwise. }
procedure MacOpenSettingsFromEnv;

implementation

uses
  Math, Classes, SysUtils, Types, IniFiles, Controls, StdCtrls, ExtCtrls, ComCtrls, Forms, Graphics, CocoaAll,
  Countdown, mactidy, macappearance, macpages;

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
    BottomBar: TPanel;
    SaveButton: TButton;
    procedure SaveClick(Sender: TObject);
    procedure WindowResize(Sender: TObject);
    procedure WindowHide(Sender: TObject);
    procedure LayOut;
  public
    constructor CreateWindow;
    destructor Destroy; override;
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
    procedure WindowHide(Sender: TObject);
    procedure ShowPage(Index: Integer);
    procedure LayOutPage;
  public
    constructor CreateWindow;
    destructor Destroy; override;
  end;

var
  TimingWin: TTimingWindow = nil;
  SettingsWin: TSettingsWindow = nil;

procedure StyleShownPage; forward;

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

{ Each window's size and place, kept between runs in windows.ini in the data folder. }
function BoundsFile: string;
begin
  Result := Datapath + 'windows.ini';
end;

procedure SaveBounds(W: TForm; const Name: string);
var
  Ini: TIniFile;
begin
  if Datapath = '' then Exit;
  Ini := TIniFile.Create(BoundsFile);
  try
    Ini.WriteInteger(Name, 'Left', W.Left);
    Ini.WriteInteger(Name, 'Top', W.Top);
    Ini.WriteInteger(Name, 'Width', W.Width);
    Ini.WriteInteger(Name, 'Height', W.Height);
  finally
    Ini.Free;
  end;
end;

{ The saved place, if there is one and it is still on a connected display; otherwise the window keeps the place
  SetUpWindow gave it. }
procedure LoadBounds(W: TForm; const Name: string);
var
  Ini: TIniFile;
  R: TRect;
  Middle: TPoint;
  I: Integer;
begin
  if (Datapath = '') or not FileExists(BoundsFile) then Exit;
  Ini := TIniFile.Create(BoundsFile);
  try
    if not Ini.SectionExists(Name) then Exit;
    R := Bounds(Ini.ReadInteger(Name, 'Left', W.Left), Ini.ReadInteger(Name, 'Top', W.Top),
      Ini.ReadInteger(Name, 'Width', W.Width), Ini.ReadInteger(Name, 'Height', W.Height));
  finally
    Ini.Free;
  end;
  Middle := Point((R.Left + R.Right) div 2, R.Top + 10); // the title bar must be reachable
  for I := 0 to Screen.MonitorCount - 1 do
    if PtInRect(Screen.Monitors[I].WorkareaRect, Middle) then
    begin
      W.SetBounds(R.Left, R.Top, R.Right - R.Left, R.Bottom - R.Top);
      Exit;
    end;
end;

const
  ScenarioGap = 8;
  ScenarioTop = 26; // the first row's titles sit above their boxes

{ The width a page is laid out at, for a scrolling area of this width. The scenario page may be wider: its
  boxes stand in columns, as many as fit. }
function PageWidth(Scroll: TScrollBox): Integer;
var
  Wide: Integer;
begin
  Wide := PageMaxWidth;
  if Countdownform.SettingsTabs.ActivePage = Countdownform.tabscen then
    Wide := Max(PageMaxWidth, 3 * (Countdownform.F1Group.Width + ScenarioGap) + 40);
  Result := EnsureRange(Scroll.ClientWidth, PageMinWidth, Wide);
end;

{ The 24 scenario boxes (F1 to F12, then shift-F1 to shift-F12) in columns, filled a row at a time
  (F1 F2 / F3 F4 ...), as many columns as the list is wide enough for. Upstream stacks them in one column for its
  narrow panel. Its names are the other way round: varF1Group is F1, F1Group is shift-F1. }
procedure ScenariosInColumns;
var
  F: TCountdownform;
  Box: TScrollBox;
  G: TControl;
  I, Cols, N: Integer;
begin
  F := Countdownform;
  Box := F.ScenarioScrollBox;
  // the page control's width: the page itself only takes it on when it is next laid out
  Box.Width := Max(F.F1Group.Width + 2 * ScenarioGap, F.SettingsTabs.ClientWidth - Box.Left - 8);
  // two across at most, so they read in pairs as in the clock's own order: F1 F2, F3 F4 ... shift-F11 shift-F12
  Cols := EnsureRange((Box.Width - 16 - ScenarioGap) div (F.F1Group.Width + ScenarioGap), 1, 2); // 16: its scroll bar
  N := 0;
  for I := 1 to 24 do
  begin
    if I <= 12 then
      G := TControl(F.FindComponent('varF' + IntToStr(I) + 'Group'))
    else
      G := TControl(F.FindComponent('F' + IntToStr(I - 12) + 'Group'));
    if (G = nil) or not G.Visible then Continue;
    G.SetBounds(ScenarioGap + (N mod Cols) * (G.Width + ScenarioGap),
      ScenarioTop + (N div Cols) * (G.Height + ScenarioGap) - Box.VertScrollBar.Position, G.Width, G.Height);
    Inc(N);
  end;
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
  SetUpWindow(Self, MacTimingTitle, PageMaxWidth + 20, TimingMinHeight + 30 + 48); // 48: the save bar
  Constraints.MinWidth := 300;
  Constraints.MinHeight := 300;

  // the timing system is part of the startup setting too, so this window saves as well as the settings window
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
  OnHide := @WindowHide;
  LoadBounds(Self, 'Timing');
end;

destructor TTimingWindow.Destroy;
begin
  SaveBounds(Self, 'Timing'); // still open when the app quits
  inherited Destroy;
end;

procedure TTimingWindow.WindowHide(Sender: TObject);
begin
  SaveBounds(Self, 'Timing');
end;

procedure TTimingWindow.LayOut;
begin
  Host.SetBounds(0, 0, PageWidth(Scroll), Max(Scroll.ClientHeight, TimingMinHeight));
  MacTidyTimingPage;
end;

procedure TTimingWindow.SaveClick(Sender: TObject);
begin
  Countdownform.saveClick(Countdownform.save);
end;

procedure TTimingWindow.WindowResize(Sender: TObject);
begin
  SaveButton.Left := (BottomBar.ClientWidth - SaveButton.Width) div 2;
  SaveButton.Top := (BottomBar.ClientHeight - SaveButton.Height) div 2;
  LayOut;
end;

{ The save button's caption, in the language chosen; a button needs no full stop ("Save as startup setting."). }
function SaveCaption: string;
begin
  Result := Trim(Countdownform.save.Caption);
  if (Result <> '') and (Result[Length(Result)] = '.') then SetLength(Result, Length(Result) - 1);
end;

procedure MacShowTiming;
begin
  if TimingWin = nil then TimingWin := TTimingWindow.CreateWindow;
  HidePanels;
  TimingWin.Caption := MacTimingTitle; // the language may have changed
  TimingWin.SaveButton.Caption := SaveCaption;
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
  MacAfterSettingsTidy := @StyleShownPage;
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

  Scroll := NewScroll(Self);

  // the settings pages: the page control moves in whole, without its row of tabs (the sidebar replaces it)
  F.SettingsTabs.Parent := Scroll;
  F.SettingsTabs.Align := alNone;
  F.SettingsTabs.ShowTabs := False;

  OnResize := @WindowResize;
  OnHide := @WindowHide;
  LoadBounds(Self, 'Settings');
end;

procedure TSettingsWindow.WindowHide(Sender: TObject);
begin
  SaveBounds(Self, 'Settings');
end;

destructor TSettingsWindow.Destroy;
begin
  SaveBounds(Self, 'Settings'); // still open when the app quits
  Pages.Free;
  inherited Destroy;
end;

{ One line per settings page that is shown on this system, in upstream's order, with the captions the language
  file gave them. }
procedure TSettingsWindow.FillSidebar;
var
  F: TCountdownform;
  I, W: Integer;
  Bmp: TBitmap;
begin
  F := Countdownform;
  Sidebar.Items.Clear;
  Pages.Clear;
  for I := 0 to F.SettingsTabs.PageCount - 1 do
    if F.SettingsTabs.Pages[I].TabVisible then
    begin
      Sidebar.Items.Add(MacCapitalised(Trim(F.SettingsTabs.Pages[I].Caption)));
      Pages.Add(F.SettingsTabs.Pages[I]);
    end;
  // wide enough for this language's longest section name, within reason
  Bmp := TBitmap.Create;
  try
    Bmp.Canvas.Font.Height := Sidebar.Font.Height;
    W := 220;
    for I := 0 to Sidebar.Items.Count - 1 do
      W := Max(W, Bmp.Canvas.TextWidth(Sidebar.Items[I]) + 40);
    Sidebar.Width := Min(W, 320);
  finally
    Bmp.Free;
  end;
end;

procedure TSettingsWindow.ShowPage(Index: Integer);
var
  I: Integer;
begin
  if (Index < 0) or (Index >= Pages.Count) then Index := 0;
  if Pages.Count = 0 then Exit;
  Sidebar.ItemIndex := Index;
  Countdownform.SettingsTabs.ActivePage := TTabSheet(Pages[Index]);
  LayOutPage;
  // a page opens at its top (its own scrolling list included)
  for I := 0 to Countdownform.SettingsTabs.ActivePage.ControlCount - 1 do
    if Countdownform.SettingsTabs.ActivePage.Controls[I] is TScrollBox then
      TScrollBox(Countdownform.SettingsTabs.ActivePage.Controls[I]).VertScrollBar.Position := 0;
  Scroll.VertScrollBar.Position := 0;
end;

{ The page at the window's width, laid out again for it, and as tall as what it shows: taller than the window,
  it scrolls. }
procedure TSettingsWindow.LayOutPage;
var
  F: TCountdownform;
  Tabs: TPageControl;
  Page: TTabSheet;
  I, Need: Integer;
  C: TControl;

  { A page's content in one box or text that scrolls itself (most pages, and the scenario, slideshow and screen
    colour lists): upstream sizes it from the clock window's height; here it ends at the bottom of this window,
    has no frame of its own, and doesn't make the page taller. }
  function SelfScrolling(C: TControl): Boolean;
  begin
    Result := (C is TScrollBox) or (C is TCustomMemo);
  end;

begin
  F := Countdownform;
  Tabs := F.SettingsTabs;
  Tabs.Constraints.MaxHeight := 0;
  Tabs.SetBounds(0, 0, PageWidth(Scroll), Max(Tabs.Height, Scroll.ClientHeight));
  MacTidySettings; // which styles the page shown too (StyleShownPage)
  Page := Tabs.ActivePage;
  Need := 0;
  if Page <> nil then
    for I := 0 to Page.ControlCount - 1 do
      if Page.Controls[I].Visible and not SelfScrolling(Page.Controls[I]) then
        Need := Max(Need, Page.Controls[I].Top + Page.Controls[I].Height);
  // (with its tabs hidden the page control adds only a thin border round the page)
  Tabs.Height := Max(Scroll.ClientHeight, Need + 24);
  // the clock's own resize code sets this height from the clock window's: keep it to what the page needs
  Tabs.Constraints.MaxHeight := Tabs.Height;
  if Page <> nil then
    for I := 0 to Page.ControlCount - 1 do
    begin
      C := Page.Controls[I];
      if not SelfScrolling(C) then Continue;
      C.Height := Max(120, Tabs.ClientHeight - C.Top - 12);
      if C is TScrollBox then
      begin
        TScrollBox(C).BorderStyle := bsNone;
        C.Width := Max(C.Width, Page.ClientWidth - C.Left);
        MacVisibleScrollBars(C);
      end;
    end;
  if Page = F.tabscen then ScenariosInColumns;
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
begin
  // save under the list of sections (shutting down the clients is on the Network page)
  SaveButton.Left := Max(8, (Sidebar.Width - SaveButton.Width) div 2);
  SaveButton.Top := (BottomBar.ClientHeight - SaveButton.Height) div 2;
  if Pages.Count > 0 then LayOutPage;
end;

procedure MacShowSettings;
var
  F: TCountdownform;
begin
  F := Countdownform;
  if SettingsWin = nil then SettingsWin := TSettingsWindow.CreateWindow;
  HidePanels;
  SettingsWin.Caption := MacSettingsTitle;
  SettingsWin.SaveButton.Caption := SaveCaption;
  SettingsWin.FillSidebar;
  SettingsWin.Show;
  Refresh(SettingsWin);
  SettingsWin.ShowPage(SettingsWin.Pages.IndexOf(F.SettingsTabs.ActivePage));
  SettingsWin.BringToFront;
end;

{ The page shown laid out the Mac way; run after every general layout of the pages (mactidy). }
procedure StyleShownPage;
begin
  if (SettingsWin <> nil) and SettingsWin.Visible then
    MacStylePage(Countdownform.SettingsTabs.ActivePage);
end;

procedure MacOpenSettingsFromEnv;
var
  Want: string;
  I: Integer;
  F: TCountdownform;
begin
  Want := GetEnvironmentVariable('AC_OPEN_SETTINGS');
  if Want = '' then Exit;
  F := Countdownform;
  if SameText(Want, 'timing') then
  begin
    MacShowTiming;
    Exit;
  end;
  for I := 0 to F.SettingsTabs.PageCount - 1 do
    if SameText(F.SettingsTabs.Pages[I].Name, Want) then
      F.SettingsTabs.ActivePage := F.SettingsTabs.Pages[I];
  MacShowSettings;
end;

end.
