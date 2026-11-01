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

implementation

uses
  SysUtils, Classes, Controls, StdCtrls, ExtCtrls, Spin, Graphics, Countdown;

const
  TextHeight = -14;  // pixels; Windows used -9 and -11, which reads as tiny on a Mac
  SpinW = 64;        // number fields: wide and tall enough for three digits at that size
  SpinH = 26;
  RowGap = 5;        // between rows of the same group
  GroupGap = 12;     // between groups
  Margin = 8;

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
    else if C is TGroupBox then
    begin
      C.Font.Height := TextHeight;
      if C.Caption <> '' then
        C.Caption := UpperCase(Copy(C.Caption, 1, 1)) + Copy(C.Caption, 2, MaxInt);
    end;
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

procedure MacTidyTimingPage;
begin
  TidyPanels(TidyShootingSystems);
  TidyFitaPanel;
end;

end.
