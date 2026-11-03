unit macpages;

{ Mac build, "redesign" version: the settings pages laid out the Mac way inside the settings window.
  Runs after the general tidy (mactidy), on the page being shown. Pages are laid out as a column of sections,
  each a box with a bold heading, all the same width with even gaps between them; option buttons and tick boxes
  read as labels (no full stops). Only positions, sizes and captions change: every control keeps what it does. }

{$mode objfpc}{$H+}

interface

uses
  Controls;

{ Lay out Page (one of the settings window's pages) for the width it has now. }
procedure MacStylePage(Page: TWinControl);

implementation

uses
  Classes, SysUtils, Math, StdCtrls, ExtCtrls, ComCtrls, Forms, Graphics, Countdown, mactidy;

const
  Pad = 16;          // page margin
  SectionGap = 18;   // between sections
  SectionMax = 560;  // widest a section gets
  RowH = 26;         // one option in a group of options

var
  GeneralBox: TGroupBox = nil; // Screen layout's "General" section (the loose tick boxes)
  BuzzerBox: TGroupBox = nil;  // Sound's "Buzzer" section

{ A tick box or option button reads as a label: no full stop at the end (Mac style). }
procedure NoFullStops(Root: TWinControl);
var
  I: Integer;
  C: TControl;
  S: string;
begin
  for I := 0 to Root.ControlCount - 1 do
  begin
    C := Root.Controls[I];
    if C is TCustomCheckBox then
    begin
      S := C.Caption;
      if (Length(S) > 1) and (S[Length(S)] = '.') and (Copy(S, Length(S) - 2, 3) <> '...') then
        C.Caption := Copy(S, 1, Length(S) - 1);
    end;
    if C is TWinControl then NoFullStops(TWinControl(C));
  end;
end;

{ A group of options, one per row: the group spreads its options over whatever height it has and squeezes them
  together when that comes out short, so they are placed in fixed rows instead. }
procedure RoomyOptions(G: TRadioGroup);
var
  I: Integer;
begin
  G.ChildSizing.Layout := cclNone;
  G.ClientHeight := G.Items.Count * RowH + 10; // inside: a group box keeps a strip for a title even with none
  for I := 0 to G.ControlCount - 1 do
    G.Controls[I].SetBounds(8, 6 + I * RowH, G.ClientWidth - 12, RowH);
end;

{ Sections one under another at the left of Area, Width wide, each laid out again for that width. Returns the
  bottom of the last. }
function Stack(Area: TWinControl; const Sections: array of TWinControl; Width: Integer): Integer;
var
  I: Integer;
  Y: Integer;
begin
  Y := Pad div 2;
  for I := 0 to High(Sections) do
  begin
    if (Sections[I] = nil) or not Sections[I].Visible then Continue;
    Sections[I].SetBounds(Pad, Y, Width, Sections[I].Height);
    if Sections[I] is TGroupBox then
      Sections[I].Font.Style := [fsBold]; // its heading; the controls inside keep their own font
    Y := Y + Sections[I].Height + SectionGap;
  end;
  Result := Y;
end;

{ Bold headings only: a group box passes its font to what's inside it, so put the plain font back there. }
procedure PlainInside(Box: TWinControl);
var
  I: Integer;
begin
  for I := 0 to Box.ControlCount - 1 do
    if Box.Controls[I].Font.Style = [fsBold] then
      if not (Box.Controls[I] is TGroupBox) then
        Box.Controls[I].Font.Style := [];
end;

{ ---- Screen layout ---- }

procedure StyleScreenLayout;
var
  F: TCountdownform;
  Area: TScrollBox;
  W, X, Y: Integer;
begin
  F := Countdownform;
  Area := F.BGScrollBox;
  Area.BorderStyle := bsNone; // the page is the frame; a second one inside it only adds a stray line
  W := Min(Area.ClientWidth - 2 * Pad, SectionMax);

  // "General": the tick boxes that sat loose under the last section, with the time's 12/24 choice beside its box
  if GeneralBox = nil then
  begin
    GeneralBox := TGroupBox.Create(F);
    GeneralBox.Parent := Area;
    GeneralBox.Caption := 'General';
    F.hideicons.Parent := GeneralBox;
    F.showhints.Parent := GeneralBox;
    F.timecheckbox.Parent := GeneralBox;
    F.am24.Parent := GeneralBox;
  end;

  RoomyOptions(F.minsec);
  RoomyOptions(F.am24);
  RoomyOptions(F.am24_2);

  // each section laid out for the new width, then the parts the general layout can't place
  F.TLgroup.Width := W; MacReflow(F.TLgroup);
  F.Bannerbox.Width := W; MacReflow(F.Bannerbox);
  // the caption of "show end number ..." is a label of its own beside its tick box
  if (F.showendnrlabel.Caption <> '') and (F.showendnrlabel.Caption[Length(F.showendnrlabel.Caption)] = '.') then
    F.showendnrlabel.Caption := Copy(F.showendnrlabel.Caption, 1, Length(F.showendnrlabel.Caption) - 1);
  // its 12/24 choice belongs on the same row as "Actual time / date"
  F.am24_2.Top := F.Actualtimecheckbox.Top;
  F.BGGroupBox.Width := W; MacReflow(F.BGGroupBox);
  F.am24_2.Left := Max(F.am24_2.Left, F.Actualtimecheckbox.Left + F.Actualtimecheckbox.Width + 24);
  // the picture list as wide as the two buttons under it
  F.imagesListBox.Width := F.Removeimagebutton.Left + F.Removeimagebutton.Width - F.imagesListBox.Left;

  // Minutes / seconds: the two ways of counting on the left; beside them the two ways of writing small numbers
  // (005 or 5), one level with each line
  F.newminsecbox.Width := W;
  // a section title, not a question
  if (F.newminsecbox.Caption <> '') and (F.newminsecbox.Caption[Length(F.newminsecbox.Caption)] = '?') then
    F.newminsecbox.Caption := Trim(Copy(F.newminsecbox.Caption, 1, Length(F.newminsecbox.Caption) - 1));
  F.minsec.SetBounds(8, 8, 200, F.minsec.Height);
  F.zerosec.Caption := Trim(F.zerosec.Caption);
  F.nonzerosec.Caption := Trim(F.nonzerosec.Caption); // upstream padded it with spaces to line up on Windows
  X := F.minsec.Left + F.minsec.Width + 24;
  Y := 8 + 27; // level with the group's first option (the group is placed at 8 just above; its options start
                // below its own border)
  F.zerosec.SetBounds(X, Y, 120, RowH);
  F.nonzerosec.SetBounds(X, Y + RowH, 120, RowH);
  F.newminsecbox.ClientHeight := F.minsec.Top + F.minsec.Height + 8;

  // General
  GeneralBox.Width := W;
  Y := 6;
  F.hideicons.SetBounds(10, Y, W - 20, RowH);           Inc(Y, RowH + 4);
  F.showhints.SetBounds(10, Y, W - 20, RowH);           Inc(Y, RowH + 4);
  // the 12/24 choice beside "Time on screen", its first option level with the tick box (a group's options start
  // well below its top, under its border)
  F.timecheckbox.SetBounds(10, Y + 28, 220, RowH);
  F.am24.SetBounds(240, Y, 160, F.am24.Height);
  GeneralBox.ClientHeight := Y + F.am24.Height + 8;

  Stack(Area, [F.TLgroup, F.newminsecbox, F.Bannerbox, F.BGGroupBox, GeneralBox], W);
  PlainInside(F.TLgroup); PlainInside(F.newminsecbox); PlainInside(F.Bannerbox);
  PlainInside(F.BGGroupBox); PlainInside(GeneralBox);
end;

{ ---- Screen colours ---- }

{ The eight colour schemes as a grid of pictures, each with its button beside it, as many across as fit; then
  "Adjust colors" and the colour boxes it shows. }
procedure StyleScreenColours;
const
  CellW = 200;
  CellH = 92;
var
  F: TCountdownform;
  Box: TScrollBox;
  I, Cols, X, Y: Integer;
  Pic, Btn: TControl;
begin
  F := Countdownform;
  Box := F.SCRcolScrollBox;
  Box.BorderStyle := bsNone;
  Box.VertScrollBar.Position := 0; // laid out from its top
  Box.Width := Max(2 * CellW + Pad, F.screencolor.ClientWidth - Box.Left);
  Cols := EnsureRange((Box.Width - Pad - 16) div CellW, 2, 4);
  for I := 1 to 8 do
  begin
    Pic := TControl(F.FindComponent('Image' + IntToStr(I)));
    Btn := TControl(F.FindComponent('colorscheme' + IntToStr(I)));
    if (Pic = nil) or (Btn = nil) then Continue;
    X := Pad + ((I - 1) mod Cols) * CellW;
    Y := Pad div 2 + ((I - 1) div Cols) * CellH;
    Btn.SetBounds(X, Y + (Pic.Height - Btn.Height) div 2, Btn.Width, Btn.Height);
    Pic.SetBounds(X + 28, Y, Pic.Width, Pic.Height);
  end;
  Y := Pad div 2 + ((8 + Cols - 1) div Cols) * CellH;
  F.colorscheme9.Font.Height := -14;
  F.colorscheme9.AutoSize := True;
  F.colorscheme9.SetBounds(Pad, Y, F.colorscheme9.Width, F.colorscheme9.Height);
  F.manualcolorpanel.Top := Y + F.colorscheme9.Height + 8;
  F.manualcolorpanel.Left := Pad div 2;
  F.Bevel1.Visible := False; // a divider far below everything, which only lengthened the list
end;

{ ---- Sound ---- }

{ A label and its field on one row: the label in a column of LabelW, the field after it, both centred on the
  row. }
procedure LabelledRow(Lbl: TLabel; Field: TControl; X, Y, LabelW, FieldW: Integer);
begin
  Lbl.AutoSize := True;
  Lbl.Font.Height := -14;
  Field.SetBounds(X + LabelW, Y, FieldW, Field.Height);
  Lbl.SetBounds(X, Y + (Field.Height - Lbl.Height) div 2, Lbl.Width, Lbl.Height);
end;

procedure StyleSound;
const
  PhaseGap = 12;
var
  F: TCountdownform;
  Area: TScrollBox;
  W, Y, I, ColW: Integer;
  Phases: array[0..5] of TControl;
begin
  F := Countdownform;
  Area := F.soundScrollBox;
  Area.BorderStyle := bsNone;
  W := Min(Area.ClientWidth - 2 * Pad, SectionMax);

  // "Buzzer": the PC speaker tick box, then the sound it makes and its test button on one row
  if BuzzerBox = nil then
  begin
    BuzzerBox := TGroupBox.Create(F);
    BuzzerBox.Parent := Area;
    BuzzerBox.Caption := 'Buzzer';
    F.speaker.Parent := BuzzerBox;
    F.selectsoundlabel.Parent := BuzzerBox;
    F.soundselect.Parent := BuzzerBox;
    F.testsound.Parent := BuzzerBox;
  end;
  BuzzerBox.SetBounds(Pad, Pad div 2, W, BuzzerBox.Height);
  F.speaker.SetBounds(10, 6, W - 20, RowH);
  LabelledRow(F.selectsoundlabel, F.soundselect, 10, 6 + RowH + 8, 180, 160);
  F.testsound.AutoSize := True;
  F.testsound.SetBounds(F.soundselect.Left + F.soundselect.Width + 12, F.soundselect.Top, F.testsound.Width,
    F.testsound.Height);
  BuzzerBox.ClientHeight := F.soundselect.Top + F.soundselect.Height + 10;
  BuzzerBox.Font.Style := [fsBold];
  PlainInside(BuzzerBox);

  // "Control audio" switches the music settings on; they follow it as a section of their own
  Y := BuzzerBox.Top + BuzzerBox.Height + SectionGap;
  F.Controlaudiocheckbox.SetBounds(Pad, Y, W, RowH);
  Inc(Y, RowH + 8);
  if F.audiovolumebox.Visible then
  begin
    if F.audiovolumebox.Caption = '' then F.audiovolumebox.Caption := 'Music';
    F.audiovolumebox.Font.Style := [fsBold];
    PlainInside(F.audiovolumebox);
    F.audiovolumebox.SetBounds(Pad, Y, W, F.audiovolumebox.Height);
    F.VLCradiobutton.SetBounds(10, 6, 200, RowH);
    LabelledRow(F.AudioIPlabel, F.AudioIPedit, 10, 6 + RowH + 8, 200, 180);
    LabelledRow(F.audioportlabel, F.Audioportnumber, 10, F.AudioIPedit.Top + F.AudioIPedit.Height + 8, 200, 100);
    F.reconnectbutton.AutoSize := True;
    F.reconnectbutton.SetBounds(10 + 200, F.Audioportnumber.Top + F.Audioportnumber.Height + 8,
      F.reconnectbutton.Width, F.reconnectbutton.Height);
    // the six phases two across, in the order they happen (the emergency last)
    Phases[0] := F.Audioboxstate5; // before the match starts
    Phases[1] := F.Audioboxstate1; // retrieving arrows
    Phases[2] := F.Audioboxstate2; // preparing to shoot
    Phases[3] := F.Audioboxstate3; // shooting, green
    Phases[4] := F.Audioboxstate4; // shooting, yellow
    Phases[5] := F.Audioboxstate6; // emergency stop
    ColW := (W - 20 - PhaseGap) div 2;
    Y := F.reconnectbutton.Top + F.reconnectbutton.Height + 16;
    for I := 0 to 5 do
      Phases[I].SetBounds(10 + (I mod 2) * (ColW + PhaseGap), Y + (I div 2) * (Phases[I].Height + PhaseGap),
        Max(ColW, Phases[I].Width), Phases[I].Height);
    F.audiovolumebox.ClientHeight := Y + 3 * (Phases[0].Height + PhaseGap);
  end;
end;

{ ---- Language ---- }

procedure StyleLanguage;
var
  F: TCountdownform;
begin
  F := Countdownform;
  F.selectlanguagelabel.Font.Height := -14;
  F.selectlanguagelabel.AutoSize := True;
  F.selectlanguagelabel.SetBounds(Pad + 8, Pad + 4, F.selectlanguagelabel.Width, F.selectlanguagelabel.Height);
  F.Lang.Font.Height := -14;
  F.Lang.SetBounds(F.selectlanguagelabel.Left + F.selectlanguagelabel.Width + 12, Pad, 220, F.Lang.Height);
  F.selectlanguagelabel.Top := F.Lang.Top + (F.Lang.Height - F.selectlanguagelabel.Height) div 2;
end;

procedure MacStylePage(Page: TWinControl);
var
  F: TCountdownform;
begin
  F := Countdownform;
  if Page = nil then Exit;
  NoFullStops(Page);
  if Page = F.tablang then StyleLanguage
  else if Page = F.tabscr then StyleScreenLayout
  else if Page = F.screencolor then StyleScreenColours
  else if Page = F.tabsound then StyleSound;
end;

end.
