unit mactidy;

{ Mac build, "tidy" version: lays the settings pages out again at startup.
  The form was laid out by hand, in pixels, for Windows' small Tahoma; Cocoa's controls and fonts are a little
  bigger, so on the Mac things overlap, clip or sit off-line. Rather than edit the 60,000-line .lfm (and lose easy
  merges with the author's updates), this unit moves the existing controls after the form is created. Nothing
  here changes what any control does.
  Called after initialize (which sets fonts), after each resize (which sets the Windows sizes again) and when
  Double ends is ticked or unticked. }

{$mode objfpc}{$H+}

interface

procedure MacTidyTimingPage;
{ The shut-down button usable only when this clock leads others over the network. }
procedure MacShutdownButtonState;

implementation

uses
  SysUtils, Classes, Controls, StdCtrls, ExtCtrls, ComCtrls, Forms, Spin, Graphics, Math, macappearance, Countdown;

var
  PagesScrollable: Boolean = False; // ScrollablePages has run

var
  TimingTitle: TLabel = nil;   // the timing panel's title (TidyShootingSystems)
  SettingsTitle: TLabel = nil; // the settings panel's title (TidySettingsPages)

const
  TextHeight = -14;  // pixels; Windows used -9 and -11, which reads as tiny on a Mac
  SpinW = 64;        // number fields: wide and tall enough for three digits at that size
  SpinH = 26;
  RowGap = 5;        // between rows of the same group
  GroupGap = 12;     // between groups
  Margin = 8;

function IsDarkish(Color: TColor): Boolean;
var
  RGB: LongInt;
begin
  RGB := ColorToRGB(Color);
  Result := (0.299 * Red(RGB) + 0.587 * Green(RGB) + 0.114 * Blue(RGB)) < 150;
end;

function TextWidth(const S: string; Font: TFont): Integer;
var
  B: TBitmap;
begin
  B := TBitmap.Create;
  try
    B.Canvas.Font := Font;
    Result := B.Canvas.TextWidth(S);
  finally
    B.Free;
  end;
end;

function Bottom(C: TControl): Integer;
begin
  Result := C.Top + C.Height;
end;

{ Size a control to its caption now; Cocoa only reports the new size after the next layout pass otherwise. }
procedure FitToText(C: TControl);
var
  W, H: Integer;
begin
  W := 0; H := 0;
  C.GetPreferredSize(W, H);
  if (C is TLabel) and TLabel(C).WordWrap then
    C.Height := H + 3 // room for the last line's descenders
  else
    C.SetBounds(C.Left, C.Top, W, H);
end;

function Capitalised(const S: string): string;
begin
  Result := S;
  if Copy(Result, 1, 5) = 'am/pm' then Exit; // written in lower case, as a clock shows it
  if (Result <> '') and (Result[1] in ['a'..'z']) then
    Result[1] := UpCase(Result[1]);
end;

function TitleCase(const S: string): string;
var
  I: Integer;
begin
  Result := S;
  for I := 1 to Length(Result) do
    if ((I = 1) or (Result[I - 1] = ' ')) and (Result[I] in ['a'..'z']) then
      Result[I] := UpCase(Result[I]);
end;

{ Readable text everywhere under Root; captions size themselves so nothing clips; headings start with a capital. }
procedure SetTextSize(Root: TWinControl);
var
  I: Integer;
  C: TControl;
begin
  for I := 0 to Root.ControlCount - 1 do
  begin
    C := Root.Controls[I];
    if (C is TLabel) or (C is TCustomCheckBox) or (C is TSpinEdit) then
    begin
      C.Font.Height := TextHeight;
      if not ((C is TLabel) and TLabel(C).WordWrap) and not (C is TSpinEdit) then
        FitToText(C);
    end
    else if (C is TGroupBox) or (C is TButton) then
      C.Font.Height := TextHeight;
    // every caption starts with a capital ("left screen", "in follow mode, ..." read as unfinished otherwise)
    if (C is TLabel) or (C is TCustomCheckBox) or (C is TGroupBox) or (C is TButton) then
      C.Caption := Capitalised(C.Caption);
    if C is TWinControl then
      SetTextSize(TWinControl(C));
  end;
end;

{ A label beside a number field, centred on it vertically. }
procedure BesideSpin(Spin: TSpinEdit; Lbl: TLabel);
begin
  Lbl.Left := Spin.Left + Spin.Width + 8;
  Lbl.Top := Spin.Top + (Spin.Height - Lbl.Height) div 2;
end;

{ The general tidy for a panel laid out by hand: keeps its order and its rows (controls whose tops were within
  a few pixels of each other share a row), sizes text and fields consistently, spaces the rows evenly, stretches
  boxes that were meant to span the panel, and fits each box's height to what's in it. Hidden controls take no
  room, so it is run again whenever what shows can change. }
procedure Reflow(Box: TWinControl; Top: Integer);
const
  SameRow = 8;
var
  Kids: TFPList;
  I, J, Y, RowStart, RowSpan, RowH, Right, W: Integer;
  AllButtons, AfterParagraph: Boolean;
  C, Prev: TControl;
  Row: array of TControl;

  function Before(A, B: Pointer): Integer;
  begin
    Result := TControl(A).Top - TControl(B).Top;
    if Abs(Result) <= SameRow then Result := TControl(A).Left - TControl(B).Left;
  end;

  procedure Size(C: TControl);
  var
    W, H: Integer;
  begin
    if C is TSpinEdit then
    begin
      C.SetBounds(C.Left, C.Top, Max(C.Width, 56), SpinH);
      // light digits on the dark green/olive/maroon timing fields; the Windows black is hard to read on them
      if (C.Color <> clDefault) and (C.Color <> clWhite) and IsDarkish(C.Color) then
        C.Font.Color := clWhite;
    end
    else if C is TCustomEdit then
      C.Font.Height := TextHeight
    else if C is TScrollBox then
    begin
      C.SetBounds(0, C.Top, Box.ClientWidth, C.Height);
      Reflow(TWinControl(C), 6);
    end
    else if C is TCustomComboBox then
    begin
      C.Font.Height := TextHeight;
      // as wide as the panel allows, so the choice isn't cut off
      if C.Left + C.Width < Box.ClientWidth - Margin then
        C.Width := Box.ClientWidth - C.Left - Margin;
    end
    else if (C is TLabel) and (TLabel(C).Alignment <> taLeftJustify) then
    begin
      // centred or right-aligned text keeps its width (that's what positions it); only its height fits
      W := 0; H := 0;
      C.GetPreferredSize(W, H);
      C.Height := H;
    end
    else if (C is TLabel) and TLabel(C).WordWrap then
    begin
      C.Width := Box.ClientWidth - C.Left - Margin;
      FitToText(C);
    end
    else if (C is TLabel) or (C is TCustomCheckBox) then
    begin
      FitToText(C);
      // a caption longer than the panel is set smaller, rather than cut off
      while (C is TCustomCheckBox) and (C.Font.Height < -10) and (C.Left + C.Width > Box.ClientWidth - 4) do
      begin
        C.Font.Height := C.Font.Height + 1;
        FitToText(C);
      end;
    end
    else if (C is TGroupBox) or (C is TPanel) then
    begin
      // a heading longer than its box is set smaller, rather than cut off
      while (C is TGroupBox) and (C.Font.Height < -10)
        and (TextWidth(C.Caption, C.Font) > Box.ClientWidth - C.Left - 24) do
        C.Font.Height := C.Font.Height + 1;
      // a box that spanned most of its parent starts at the margin and spans all of it now
      if C.Width >= Box.ClientWidth * 6 div 10 then
        C.SetBounds(6, C.Top, Box.ClientWidth - 6 - Margin, C.Height);
      Reflow(TWinControl(C), 4);
    end;
  end;

begin
  Kids := TFPList.Create;
  try
    for I := 0 to Box.ControlCount - 1 do
      if Box.Controls[I].Visible then
        Kids.Add(Box.Controls[I]);
    // a check box with no caption of its own and a label just beside it are one row: the label is its caption
    for I := 0 to Kids.Count - 1 do
      if (TControl(Kids[I]) is TCustomCheckBox) and (TControl(Kids[I]).Caption = '') then
        for J := 0 to Kids.Count - 1 do
          if (TControl(Kids[J]) is TLabel) and (Abs(TControl(Kids[J]).Top - TControl(Kids[I]).Top) <= 24)
            and (TControl(Kids[J]).Left > TControl(Kids[I]).Left) then
            TControl(Kids[J]).Top := TControl(Kids[I]).Top;
    // simple insertion sort by row, then left to right
    for I := 1 to Kids.Count - 1 do
    begin
      J := I;
      while (J > 0) and (Before(Kids[J], Kids[J - 1]) < 0) do
      begin
        Kids.Exchange(J, J - 1);
        Dec(J);
      end;
    end;

    Y := Top;
    AfterParagraph := False;
    I := 0;
    while I < Kids.Count do
    begin
      // gather one row: the controls that start beside the first one (within its first line or so)
      RowStart := TControl(Kids[I]).Top;
      RowSpan := Max(SameRow, Min(TControl(Kids[I]).Height - 6, 30));
      SetLength(Row, 0);
      while (I < Kids.Count) and (TControl(Kids[I]).Top - RowStart <= RowSpan) do
      begin
        SetLength(Row, Length(Row) + 1);
        Row[High(Row)] := TControl(Kids[I]);
        Inc(I);
      end;
      for J := 1 to High(Row) do
        for W := J downto 1 do
          if Row[W].Left < Row[W - 1].Left then
          begin
            C := Row[W]; Row[W] := Row[W - 1]; Row[W - 1] := C;
          end;
      RowH := 0;
      for C in Row do
      begin
        Size(C);
        RowH := Max(RowH, C.Height);
      end;
      // a row of buttons only: share the full width equally
      AllButtons := Length(Row) > 1;
      for C in Row do
        if not (C is TButton) then AllButtons := False;
      if AllButtons then
      begin
        W := (Box.ClientWidth - 2 * 6 - (Length(Row) - 1) * 6) div Length(Row);
        for J := 0 to High(Row) do
        begin
          Row[J].Font.Height := -12; // three captions across one panel: a size that fits "Mixed Team Round"
          Row[J].Caption := TitleCase(Row[J].Caption); // side-by-side choices read alike: "Individual Round"
          Row[J].SetBounds(6 + J * (W + 6), Row[J].Top, W, 28);
        end;
        RowH := 28;
      end;
      // a box gets a clear gap above it, as below it; a wider one after a paragraph of text
      if (Y > Top) and ((Row[0] is TGroupBox) or (Row[0] is TPanel)) then
      begin
        Inc(Y, GroupGap - RowGap);
        if AfterParagraph then Inc(Y, GroupGap);
      end;
      // centre the row's controls on one line, and keep them from overlapping sideways
      Prev := nil;
      for C in Row do
      begin
        C.Top := Y + (RowH - C.Height) div 2;
        if (Prev <> nil) and not AllButtons then
        begin
          Right := Prev.Left + Prev.Width + 6;
          if C.Left < Right then C.Left := Right;
        end;
        Prev := C;
      end;
      // a row that now runs past the right edge moves left, as far as the margin allows
      Right := Row[High(Row)].Left + Row[High(Row)].Width - (Box.ClientWidth - 4);
      if Right > 0 then
      begin
        Right := Min(Right, Row[0].Left - 6);
        if Right > 0 then
          for C in Row do C.Left := C.Left - Right;
      end;
      if (Row[0] is TGroupBox) or (Row[0] is TPanel) then
        Inc(Y, RowH + GroupGap)
      else
        Inc(Y, RowH + RowGap);
      AfterParagraph := (Length(Row) = 1) and (Row[0] is TLabel) and TLabel(Row[0]).WordWrap;
    end;
    if (Box is TGroupBox) or (Box is TPanel) then
      Box.ClientHeight := Y + 4;
  finally
    Kids.Free;
  end;
end;

{ Drop-down lists on a dark panel: Cocoa draws the app's black text on the dark button; use the system's. }
procedure SystemTextOnCombos(Root: TWinControl);
var
  I: Integer;
begin
  for I := 0 to Root.ControlCount - 1 do
  begin
    if Root.Controls[I] is TCustomComboBox then
    begin
      Root.Controls[I].Font.Color := clDefault;
      Root.Controls[I].Font.Height := TextHeight;
    end;
    if Root.Controls[I] is TWinControl then
      SystemTextOnCombos(TWinControl(Root.Controls[I]));
  end;
end;

{ One column of timing rows: green, orange, total, red; each value beside its label. }
procedure TimingRows(Green, Orange, Red: TSpinEdit; Total: TLabel; LGreen, LOrange, LTotal, LRed: TLabel);
var
  Y: Integer;
begin
  Y := 4;
  Green.SetBounds(Margin, Y, SpinW, SpinH);   Inc(Y, SpinH + RowGap);
  Orange.SetBounds(Margin, Y, SpinW, SpinH);  Inc(Y, SpinH + RowGap);
  Total.Left := Margin + 4; Total.Top := Y + 2; Inc(Y, SpinH + RowGap);
  Red.SetBounds(Margin, Y, SpinW, SpinH);
  BesideSpin(Green, LGreen);
  BesideSpin(Orange, LOrange);
  BesideSpin(Red, LRed);
  LTotal.Left := LGreen.Left;
  LTotal.Top := Total.Top + (Total.Height - LTotal.Height) div 2;
  // light digits on the dark green/olive/maroon fields; the Windows black is hard to read on them
  Green.Font.Color := clWhite;
  Orange.Font.Color := clWhite;
  Red.Font.Color := clWhite;
end;

{ A menu panel's title. A group box's caption is drawn faint and see-through on the Mac, over whatever the clock
  shows behind it, so it moves into a bold label on the panel's own ground, level with the close cross. The
  caption is taken each time, as the language file sets it. }
procedure PanelTitle(Box: TGroupBox; var Title: TLabel; Cross: TControl);
begin
  if Title = nil then
  begin
    Title := TLabel.Create(Box.Owner);
    Title.Parent := Box;
  end;
  if Box.Caption <> '' then
  begin
    Title.Caption := Box.Caption;
    Box.Caption := '';
  end;
  Title.Font.Height := TextHeight - 3;
  Title.Font.Style := [fsBold];
  Title.Font.Color := clBlack;
  Title.AutoSize := True;
  Title.Left := Margin;
  Title.Top := Cross.Top + (Cross.Height - Title.Height) div 2;
end;

{ The top of the timing panel: the close cross alone in the top right corner, then the five shooting systems
  as a list, one under the other, each picture with its button and caption beside it. Returns the first free
  line below them. }
function TidyShootingSystems: Integer;
const
  PicW = 66; PicH = 38; Pitch = PicH + 6;
var
  F: TCountdownform;
  Icons, Radios: array[0..4] of TControl;
  I, Y: Integer;
begin
  F := Countdownform;
  Icons[0] := F.fitaicon;    Radios[0] := F.FITA;
  Icons[1] := F.fitafinicon; Radios[1] := F.FITAFIN;
  Icons[2] := F.icon25m1p;   Radios[2] := F.onepijl;
  Icons[3] := F.followicon;  Radios[3] := F.follow;
  Icons[4] := F.manualicon;  Radios[4] := F.Manual;
  // Alternating Finals' button has a placeholder caption and a separate label; give the button the label's text
  F.FITAFIN.Caption := F.FITAFINlabel.Caption;
  F.FITAFINlabel.Visible := False;

  F.closeimage1.SetBounds(F.timeseqpanel.ClientWidth - 29 - 4, 2, 29, 29);
  PanelTitle(F.timeseqpanel, TimingTitle, F.closeimage1);
  Y := Bottom(F.closeimage1) + 4;
  for I := 0 to 4 do
  begin
    TImage(Icons[I]).Proportional := True; // keep each picture's shape in the common box
    Icons[I].SetBounds(Margin, Y, PicW, PicH);
    Radios[I].Font.Height := TextHeight;
    FitToText(Radios[I]);
    Radios[I].Left := Margin + PicW + 12;
    Radios[I].Top := Y + (PicH - Radios[I].Height) div 2;
    Inc(Y, Pitch);
  end;
  Result := Y + 4;
end;

{ Everything below the shooting systems: the system's own panel (one of five, only one shows), then the
  "Blink red light during" box at the bottom. The panels start below the list and are as wide as the menu. }
procedure TidyPanels(Top: Integer);
var
  F: TCountdownform;
  Room, W: Integer;

  procedure Place(Box: TControl);
  begin
    Box.SetBounds(Margin, Top, W, Room);
  end;

begin
  F := Countdownform;
  // the "menu disappears after .. seconds" line sits just above the panels when it shows
  F.menudisap2.Top := Top - 2; F.cdmenu2.Top := Top - 2; F.disapsec2.Top := Top - 2;

  F.Blinkphase2CheckBox.Font.Height := TextHeight;
  F.Blinkphase1CheckBox.Font.Height := TextHeight;
  FitToText(F.Blinkphase2CheckBox);
  FitToText(F.Blinkphase1CheckBox);
  F.Blinkphase2CheckBox.SetBounds(Margin, 2, F.Blinkphase2CheckBox.Width, F.Blinkphase2CheckBox.Height);
  F.Blinkphase1CheckBox.SetBounds(Margin, Bottom(F.Blinkphase2CheckBox) + RowGap,
    F.Blinkphase1CheckBox.Width, F.Blinkphase1CheckBox.Height);
  F.blinkredgroupbox.Font.Height := TextHeight;
  F.blinkredgroupbox.ClientHeight := Bottom(F.Blinkphase1CheckBox) + 4;
  F.blinkredgroupbox.Width := F.timeseqpanel.ClientWidth - 2 * Margin;
  F.blinkredgroupbox.Left := Margin;
  F.blinkredgroupbox.Top := F.timeseqpanel.ClientHeight - F.blinkredgroupbox.Height - 4;

  Inc(Top, 18);
  Room := F.blinkredgroupbox.Top - Top - 6;
  W := F.timeseqpanel.ClientWidth - 2 * Margin;
  Place(F.FITAScrollBox);
  Place(F.FitaFinScrollBox);
  Place(F.onearrowScrollBox);
  Place(F.manualScrollBox);
  Place(F.FollowScrollBox);
end;

{ Indoor/Outdoor ("FITA") panel: Sequence, then Timing, then its two options. }
procedure TidyFitaPanel;
var
  F: TCountdownform;
  Y, Inner: Integer;
begin
  F := Countdownform;
  SetTextSize(F.FITAScrollBox);
  Inner := F.FITAScrollBox.ClientWidth - 2 * 6;

  // Sequence: the radio list, then double ends, then practice and repeat settings, evenly spaced
  F.fitasequence.SetBounds(6, 6, Inner, F.fitasequence.Height);
  Y := 4;
  F.topbot.Top := Y;   Inc(Y, F.topbot.Height + RowGap);
  F.oneone.Top := Y;   Inc(Y, F.oneone.Height + RowGap);
  F.onetwo.Top := Y;   Inc(Y, F.onetwo.Height + RowGap);
  F.onethree.Top := Y; Inc(Y, F.onethree.Height + RowGap);
  F.onefour.Top := Y;  Inc(Y, F.onefour.Height + RowGap);
  F.onefive.Top := Y;  Inc(Y, F.onefive.Height + RowGap);
  F.onesix.Top := Y;   Inc(Y, F.onesix.Height + RowGap);
  F.twotwo.Top := Y;   Inc(Y, F.twotwo.Height + RowGap);
  F.twothree.Top := Y; Inc(Y, F.twothree.Height + RowGap);
  F.threetwo.Top := Y; Inc(Y, F.threetwo.Height + GroupGap);

  // Double ends: its two choices only show while it is ticked; leave room for them only then
  F.doubleturnpanel.SetBounds(0, Y, F.fitasequence.ClientWidth, F.doubleturnpanel.Height);
  F.doubleturns.Top := 2;
  F.doubleturnslabel.WordWrap := True;
  F.doubleturnslabel.AutoSize := False;
  F.doubleturnslabel.SetBounds(26, 2, F.doubleturnpanel.ClientWidth - 30, 20);
  FitToText(F.doubleturnslabel);
  F.dbltime.Left := 26;
  F.dblturn.Left := 26;
  F.dbltime.Top := Bottom(F.doubleturnslabel) + RowGap;
  F.dblturn.Top := Bottom(F.dbltime) + RowGap;
  F.doubleseq.Visible := False;  // the old '}' bracket labels don't line up with the new spacing
  F.doubletime.Visible := False;
  F.groupsign.Visible := False;
  if F.dbltime.Visible then
    F.doubleturnpanel.Height := Bottom(F.dblturn) + 4
  else
    F.doubleturnpanel.Height := Bottom(F.doubleturnslabel) + 4;
  Y := Bottom(F.doubleturnpanel) + GroupGap;

  F.practiseturns.SetBounds(Margin, Y, SpinW, SpinH);
  BesideSpin(F.practiseturns, F.practiselabel);  Inc(Y, SpinH + RowGap);
  F.PABCDperEND.Left := 6; F.PABCDperEND.Top := Y; Inc(Y, F.PABCDperEND.Height + RowGap);
  F.ABCDperEND.Left := 6;  F.ABCDperEND.Top := Y;  Inc(Y, F.ABCDperEND.Height + RowGap);
  F.repeatsequence.SetBounds(Margin, Y, SpinW, SpinH);
  BesideSpin(F.repeatsequence, F.repeatsequencelabel); Inc(Y, SpinH);
  F.fitasequence.ClientHeight := Y + 10;

  // Timing: the two columns of values, then the two options under them
  TimingRows(F.greentime, F.orangetime, F.redtime, F.totaltime,
    F.secgrnlabel5, F.secorlabel5, F.sectotlabel5, F.secredlabel5);
  TimingRows(F.greentimeso, F.orangetimeso, F.redtimeso, F.totaltimeso,
    F.secgrnlabel4, F.secorlabel4, F.sectotlabel4, F.secredlabel4);
  F.timingfitabox.SetBounds(6, Bottom(F.fitasequence) + GroupGap, Inner, F.timingfitabox.Height);
  F.fitatimingbox.SetBounds(Margin, 0, F.timingfitabox.ClientWidth - 2 * Margin, F.fitatimingbox.Height);
  F.fitatimingbox.ClientHeight := Bottom(F.redtime) + 6;
  F.so.SetBounds(Margin, Bottom(F.fitatimingbox) + GroupGap, F.fitatimingbox.Width, F.so.Height);
  F.so.ClientHeight := Bottom(F.redtimeso) + 6;
  F.timingfitabox.ClientHeight := Bottom(F.so) + 8;
  F.orangebeepfitacheckbox.Left := 8;
  F.stopinbetweenturnsfitacheckbox.Left := 8;
  F.orangebeepfitacheckbox.Top := Bottom(F.timingfitabox) + GroupGap;
  F.stopinbetweenturnsfitacheckbox.Top := Bottom(F.orangebeepfitacheckbox) + RowGap;
end;

procedure TidyOtherPanel(Panel: TWinControl);
begin
  SetTextSize(Panel);
  SystemTextOnCombos(Panel);
  Reflow(Panel, 6);
end;

{ Captions only, for pages whose layout is built around pictures and must not move. }
procedure CapitaliseAll(Root: TWinControl);
var
  I: Integer;
  C: TControl;
begin
  for I := 0 to Root.ControlCount - 1 do
  begin
    C := Root.Controls[I];
    if (C is TLabel) or (C is TCustomCheckBox) or (C is TGroupBox) or (C is TButton) then
      C.Caption := Capitalised(C.Caption);
    if C is TWinControl then
      CapitaliseAll(TWinControl(C));
  end;
end;

{ The settings pages (the menu behind the gear icon). Pages that are forms get the general tidy; pages built
  around pictures (laser pointer diagram, scenarios, screen colours, touch screen) keep their layout. Sections
  for hardware a Mac can't have are hidden. }
{ C ends at the bottom of what holds it. }
procedure FitDown(C: TControl);
begin
  if (C.Parent <> nil) and (C.Top + C.Height > C.Parent.ClientHeight - 4) then
    C.Height := Max(60, C.Parent.ClientHeight - C.Top - 4);
end;

{ Each settings page's controls in a scrolling area of the page, so a page taller than the panel (on a short
  display, or in the small window) can be scrolled instead of being cut off. Done once; the layout code below
  then lays the controls out inside it as it did on the page. }
procedure ScrollablePages;
var
  F: TCountdownform;
  I, J: Integer;
  Page: TTabSheet;
  Area: TScrollBox;
  Kids: array of TControl;
begin
  F := Countdownform;
  for I := 0 to F.SettingsTabs.PageCount - 1 do
  begin
    Page := F.SettingsTabs.Pages[I];
    if Page = F.tabscen then Continue; // the scenario page is one scrolling list of its own
    SetLength(Kids, Page.ControlCount);
    for J := 0 to Page.ControlCount - 1 do
      Kids[J] := Page.Controls[J];
    Area := TScrollBox.Create(F);
    Area.Parent := Page;
    Area.Align := alClient;
    Area.BorderStyle := bsNone;
    Area.AutoScroll := True;
    Area.ParentColor := True;
    for J := 0 to High(Kids) do
      Kids[J].Parent := Area;
    MacVisibleScrollBars(Area);
  end;
end;

procedure TidySettingsPages;
var
  F: TCountdownform;
  AudioShown: Boolean;
begin
  F := Countdownform;
  if not PagesScrollable then
  begin
    PagesScrollable := True;
    ScrollablePages;
  end;
  // lists that scroll themselves were sized a little taller than the space they sit in, which hid the end of
  // their scroll bar: fit each to what holds it
  FitDown(F.ScenarioScrollBox);
  FitDown(F.BGScrollBox);
  FitDown(F.SCRcolScrollBox);
  F.AccesspointGroupBox.Visible := False; // Raspberry Pi access point
  F.RPIinputbox.Visible := False;         // Raspberry Pi GPIO inputs
  F.K8055select.Visible := False;         // Velleman K8055 relay board: Windows-only driver
  F.MP3_2VLCradiobutton.Visible := False; // a greyed-out "....." placeholder under VLC: no second player exists
  PanelTitle(F.savesettings, SettingsTitle, F.closeimage2);
  // the "Save as startup setting." button sat at the very top, where the title now is: just below it
  F.save.Top := SettingsTitle.Top + SettingsTitle.Height + 2;
  // "005" and "5" are examples of how a seconds countdown is written; say so (Windows has no hint here either)
  F.zerosec.Hint := 'Show leading zeros: 5 seconds shows as 005';
  F.nonzerosec.Hint := 'No leading zeros: 5 seconds shows as 5';
  F.zerosec.ShowHint := True;
  F.nonzerosec.ShowHint := True;
  // the pages end where the icon column starts; on Windows they ran on underneath it
  F.SettingsTabs.Width := F.iconpanel.Left - F.SettingsTabs.Left - 4;
  F.am24.Top := F.timecheckbox.Top; // its 12/24 choice belongs beside "Time on screen", not "Show hints"
  TidyOtherPanel(F.tabscr);
  // the music settings (shown by Control audio) are rows of pictures and buttons that must keep their layout;
  // they are left out the same way whether Control audio was on at start-up or ticked later
  AudioShown := F.audiovolumebox.Visible;
  F.audiovolumebox.Visible := False;
  TidyOtherPanel(F.tabsound);
  F.audiovolumebox.Visible := AudioShown;
  // upstream kept "shut down the client systems" at the bottom of the settings panel, far from the save button at
  // its top; it only reaches the clocks that follow this one over the network, so it goes on the network page,
  // under the box that lets this clock be shut down
  F.ShutdownremoteButton.Parent := F.RemshutdownCheckBox.Parent;
  F.ShutdownremoteButton.Left := F.RemshutdownCheckBox.Left;
  F.ShutdownremoteButton.Top := F.RemshutdownCheckBox.Top + F.RemshutdownCheckBox.Height + 4;
  F.ShutdownremoteButton.AutoSize := True;
  MacShutdownButtonState;
  TidyOtherPanel(F.TabNetwork);
  TidyOtherPanel(F.tabprecnt);
  TidyOtherPanel(F.tabEmergency);
  TidyOtherPanel(F.hardwaretab);
  CapitaliseAll(F.controltab);
  CapitaliseAll(F.tabscen);
  CapitaliseAll(F.screencolor);
  // the AB and CD colour lists start at the left edge like the lists above them (upstream indented them)
  F.ABGroupBox.Left := F.OrColGroupBox.Left;
  F.CDGroupBox.Left := F.ABGroupBox.Left + F.ABGroupBox.Width + 16;
  // the touch screen page was set in large type for fingers; in the settings panel it reads like the other pages
  F.Fbutonscreenbox.Font.Height := TextHeight;
  F.Fbutonscreenbox.SetBounds(Margin, Margin, F.Fbutonscreenbox.Width, 24);
  F.MagText.Font.Height := TextHeight;
  F.MagText.AutoSize := True;
  F.magnification.Font.Height := TextHeight;
  F.magnification.SetBounds(F.MagText.Left, F.Fbutonscreenbox.Top + 24 + 12, 70, SpinH);
  F.MagText.Left := Margin;
  F.magnification.Left := F.MagText.Left + Max(F.MagText.Width, 120) + 12;
  F.MagText.Top := F.magnification.Top + (SpinH - F.MagText.Height) div 2;
  CapitaliseAll(F.tablang);
end;



{ The shut-down signal goes out only in the network broadcast of a clock that leads. }
procedure MacShutdownButtonState;
var
  F: TCountdownform;
begin
  F := Countdownform;
  F.ShutdownremoteButton.Enabled := F.LANselect.Checked and (archerysystem <> 'follow');
end;

procedure MacTidyTimingPage;
var
  F: TCountdownform;
begin
  F := Countdownform;
  // each shooting system's panel already scrolls: show its scroll bars when it doesn't fit
  MacVisibleScrollBars(F.FITAScrollBox); MacVisibleScrollBars(F.FitaFinScrollBox);
  MacVisibleScrollBars(F.onearrowScrollBox); MacVisibleScrollBars(F.manualScrollBox);
  MacVisibleScrollBars(F.FollowScrollBox);
  // Alternating Finals: the individual round's "Timing" box title was bold, the team rounds' plain; plain for all
  F.groupfinarrow.Font.Style := [];
  // Follow: "At start up" introduces the Left Side / Right Side buttons, so it goes above them, at the left
  F.atstartuplabel.Alignment := taLeftJustify;
  F.atstartuplabel.Top := F.leftsideclientbutton.Top - 20;
  MacNoFocusRing(F.FITA); MacNoFocusRing(F.FITAFIN); MacNoFocusRing(F.onepijl);
  MacNoFocusRing(F.follow); MacNoFocusRing(F.Manual);
  TidyPanels(TidyShootingSystems);
  TidyFitaPanel;
  TidyOtherPanel(F.FitaFinScrollBox);
  TidyOtherPanel(F.onearrowScrollBox);
  TidyOtherPanel(F.manualScrollBox);
  TidyOtherPanel(F.FollowScrollBox);
  TidySettingsPages;
end;

end.
