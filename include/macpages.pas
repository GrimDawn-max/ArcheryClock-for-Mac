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
  else if Page = F.tabscr then StyleScreenLayout;
end;

end.
