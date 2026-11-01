unit mactidy;

{ Mac build, "tidy" version: lays the settings pages out again at startup.
  The form was laid out by hand, in pixels, for Windows' small Tahoma; Cocoa's controls and fonts are a little
  bigger, so on the Mac things overlap, clip or sit off-line. Rather than edit the 60,000-line .lfm (and lose easy
  merges with the author's updates), this unit moves the existing controls after the form is created. Nothing
  here changes what any control does. }

{$mode objfpc}{$H+}

interface

procedure MacTidyTimingPage;

implementation

uses
  Classes, Controls, StdCtrls, ExtCtrls, Spin, Graphics, Countdown;

const
  TextHeight = -12; // pixels; Windows used -9 and -11, which reads as tiny on a Mac
  RowGap = 4;       // between rows of the same group
  GroupGap = 10;    // between groups

{ Readable text everywhere under Root; captions size themselves so nothing clips. }
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
        C.AutoSize := True;
    end
    else if C is TGroupBox then
      C.Font.Height := TextHeight - 1;
    if C is TWinControl then
      SetTextSize(TWinControl(C));
  end;
end;

{ A label beside a spin edit, centred on it vertically. }
procedure BesideSpin(Spin: TSpinEdit; Lbl: TLabel);
begin
  Lbl.Left := Spin.Left + Spin.Width + 8;
  Lbl.Top := Spin.Top + (Spin.Height - Lbl.Height) div 2;
end;

{ One column of timing rows: green, orange, total, red; each value beside its label. }
procedure TimingRows(Green, Orange, Red: TSpinEdit; Total: TLabel; LGreen, LOrange, LTotal, LRed: TLabel);
var
  Y: Integer;
begin
  Y := 4;
  Green.SetBounds(4, Y, 50, 24);   Inc(Y, 24 + RowGap);
  Orange.SetBounds(4, Y, 50, 24);  Inc(Y, 24 + RowGap);
  Total.Left := 8; Total.Top := Y + 2; Inc(Y, 22 + RowGap);
  Red.SetBounds(4, Y, 50, 24);
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

{ Size a control to its caption now; Cocoa only reports the new size after the next layout pass otherwise. }
procedure FitToText(C: TControl);
var
  W, H: Integer;
begin
  W := 0; H := 0;
  C.GetPreferredSize(W, H);
  if (C is TLabel) and TLabel(C).WordWrap then
    C.Height := H
  else
    C.SetBounds(C.Left, C.Top, W, H);
end;

function Bottom(C: TControl): Integer;
begin
  Result := C.Top + C.Height;
end;

procedure TidyShootingSystems;
{ Five shooting systems, each a picture with its radio button underneath. The captions are wider than the
  pictures, so lay the buttons out first, spread evenly over the full width, then centre each picture over its
  button. }
const
  PicW = 66; PicH = 38; Y0 = 8;
var
  F: TCountdownform;
  Icons, Radios: array[0..4] of TControl;
  I, X, Sum, Gap, Avail: Integer;
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
  Avail := F.timeseqpanel.ClientWidth - 8;
  Sum := 0;
  for I := 0 to 4 do
  begin
    Radios[I].Font.Height := -10;
    FitToText(Radios[I]);
    Inc(Sum, Radios[I].Width);
    TImage(Icons[I]).Proportional := True; // keep each picture's shape in the smaller box
  end;
  Gap := (Avail - Sum) div 4;
  if Gap < 2 then Gap := 2;
  X := 4;
  for I := 0 to 4 do
  begin
    Radios[I].Left := X;
    Radios[I].Top := Y0 + PicH + 4;
    Icons[I].SetBounds(X + Radios[I].Width div 2 - PicW div 2, Y0, PicW, PicH);
    if Icons[I].Left < 2 then Icons[I].Left := 2;
    if Icons[I].Left + PicW > Avail + 4 then Icons[I].Left := Avail + 4 - PicW;
    Inc(X, Radios[I].Width + Gap);
  end;
end;

{ "Blink red light during": its two options stacked, the box tall enough for them and kept at the bottom of
  the panel; the shooting-system panels above stop short of it. }
procedure TidyBlinkBox;
var
  F: TCountdownform;
  Room: Integer;
begin
  F := Countdownform;
  F.Blinkphase2CheckBox.Font.Height := TextHeight;
  F.Blinkphase1CheckBox.Font.Height := TextHeight;
  FitToText(F.Blinkphase2CheckBox);
  FitToText(F.Blinkphase1CheckBox);
  F.Blinkphase2CheckBox.SetBounds(8, 2, F.Blinkphase2CheckBox.Width, F.Blinkphase2CheckBox.Height);
  F.Blinkphase1CheckBox.SetBounds(8, Bottom(F.Blinkphase2CheckBox) + RowGap,
    F.Blinkphase1CheckBox.Width, F.Blinkphase1CheckBox.Height);
  F.blinkredgroupbox.ClientHeight := Bottom(F.Blinkphase1CheckBox) + 4;
  F.blinkredgroupbox.Top := F.timeseqpanel.ClientHeight - F.blinkredgroupbox.Height - 4;
  Room := F.blinkredgroupbox.Top - F.FITAScrollBox.Top - 6;
  F.FITAScrollBox.Height := Room;
  F.FitaFinScrollBox.Height := Room;
  F.onearrowScrollBox.Height := Room;
  F.manualScrollBox.Height := Room;
  F.FollowScrollBox.Height := Room;
end;

procedure MacTidyTimingPage;
var
  F: TCountdownform;
  Y: Integer;
begin
  F := Countdownform;
  SetTextSize(F.FITAScrollBox);
  TidyShootingSystems;

  // Sequence: the radio list, then double ends, then practice and repeat settings, evenly spaced
  Y := 2;
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

  // Double ends: its two choices only appear when it is ticked; leave room for them, no more
  F.doubleturnslabel.WordWrap := True;
  F.doubleturnslabel.AutoSize := True;
  F.doubleturnslabel.Width := 290;
  F.doubleturnslabel.Left := 24;
  F.doubleturnslabel.Top := 2;
  FitToText(F.doubleturnslabel);
  F.doubleturns.Top := 2;
  F.dbltime.Left := 24;
  F.dblturn.Left := 24;
  F.dbltime.Top := Bottom(F.doubleturnslabel) + RowGap;
  F.dblturn.Top := Bottom(F.dbltime) + RowGap;
  F.doubleseq.Visible := False;  // the old '}' bracket labels don't line up with the new spacing
  F.doubletime.Visible := False;
  F.groupsign.Visible := False;
  F.doubleturnslabel.Height := F.doubleturnslabel.Height + 3; // room for the last line's descenders
  F.doubleturnpanel.Top := Y;
  if F.dbltime.Visible then        // its two choices only show while Double ends is ticked
    F.doubleturnpanel.Height := Bottom(F.dblturn) + 4
  else
    F.doubleturnpanel.Height := Bottom(F.doubleturnslabel) + 4;
  Y := Bottom(F.doubleturnpanel) + GroupGap;

  F.practiseturns.SetBounds(8, Y, 50, 24);
  BesideSpin(F.practiseturns, F.practiselabel);  Inc(Y, 24 + RowGap);
  F.PABCDperEND.Left := 6; F.PABCDperEND.Top := Y; Inc(Y, F.PABCDperEND.Height + RowGap);
  F.ABCDperEND.Left := 6;  F.ABCDperEND.Top := Y;  Inc(Y, F.ABCDperEND.Height + RowGap);
  F.repeatsequence.SetBounds(8, Y, 50, 24);
  BesideSpin(F.repeatsequence, F.repeatsequencelabel); Inc(Y, 24);
  F.fitasequence.ClientHeight := Y + 10;

  // Timing: the two columns of values, then the two options under them
  TimingRows(F.greentime, F.orangetime, F.redtime, F.totaltime,
    F.secgrnlabel5, F.secorlabel5, F.sectotlabel5, F.secredlabel5);
  TimingRows(F.greentimeso, F.orangetimeso, F.redtimeso, F.totaltimeso,
    F.secgrnlabel4, F.secorlabel4, F.sectotlabel4, F.secredlabel4);
  F.fitatimingbox.ClientHeight := Bottom(F.redtime) + 6;
  F.so.Top := Bottom(F.fitatimingbox) + GroupGap;
  F.so.ClientHeight := Bottom(F.redtimeso) + 6;
  F.timingfitabox.Top := Bottom(F.fitasequence) + GroupGap;
  F.timingfitabox.ClientHeight := Bottom(F.so) + 6;
  F.orangebeepfitacheckbox.Top := Bottom(F.timingfitabox) + GroupGap;
  F.stopinbetweenturnsfitacheckbox.Top := Bottom(F.orangebeepfitacheckbox) + RowGap;

  TidyBlinkBox;
  // the black panel ends under its last option instead of running down to the blink box
  if Bottom(F.stopinbetweenturnsfitacheckbox) + 10 < F.FITAScrollBox.ClientHeight then
    F.FITAScrollBox.Height := Bottom(F.stopinbetweenturnsfitacheckbox) + 10
      + F.FITAScrollBox.Height - F.FITAScrollBox.ClientHeight;
end;

end.
