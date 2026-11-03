unit machints;

{ Mac build: hover hints. LCL starts a hint from mouse-move messages, but on the Mac the clock's window only gets
  those while a button is held, so no hint ever appeared. A timer passes the pointer position to LCL's hint code
  whenever it moves, as a mouse move would. Hints for controls in the lower half of a window open above the
  control instead of below it, where the icon row sits at the screen's bottom edge, and their text is half as
  large again as the system's, to be read from a distance. }

{$mode objfpc}{$H+}
{$modeswitch objectivec1}

interface

implementation

uses
  Classes, SysUtils, Types, Forms, Controls, Graphics, ExtCtrls, LCLIntf, CocoaAll;

type
  THintFeeder = class
    LastPos: TPoint;
    FontSet: Boolean;
    procedure Tick(Sender: TObject);
    procedure ShowHint(var HintStr: string; var CanShow: Boolean; var HintInfo: THintInfo);
  end;

var
  Feeder: THintFeeder;
  Timer: TTimer;

procedure THintFeeder.Tick(Sender: TObject);
var
  P: TPoint;
begin
  if not FontSet then
  begin
    // set here, not at start-up: the widgetset fills in the hint font once the application is initialised
    Screen.HintFont.Size := Round(NSFont.toolTipsFontOfSize(0).pointSize * 1.5);
    FontSet := True;
  end;
  // NSApp, not Application.Active: after the window switches between full screen and a window, LCL no longer
  // notices the app coming to the front
  if not NSApp.isActive or not GetCursorPos(P) then Exit;
  // only when it moved: each call restarts the hint's wait
  if (P.X <> LastPos.X) or (P.Y <> LastPos.Y) then
    Application.ActivateHint(P, True);
  LastPos := P;
end;

procedure THintFeeder.ShowHint(var HintStr: string; var CanShow: Boolean; var HintInfo: THintInfo);
var
  C: TControl;
  F: TCustomForm;
  B: TBitmap;
  H: Integer;
  Top: TPoint;
begin
  C := HintInfo.HintControl;
  if C = nil then Exit;
  F := GetParentForm(C);
  if (F = nil) or (C.Parent = nil) then Exit;
  Top := C.Parent.ClientToScreen(Point(C.Left, C.Top));
  if Top.Y - F.ClientOrigin.Y < F.ClientHeight div 2 then Exit;
  // the hint's height from its text, measured on a bitmap: a hint window made just to measure (CalcHintRect)
  // and freed again crashed a moment later on the Mac
  B := TBitmap.Create;
  try
    B.Canvas.Font.Assign(Screen.HintFont);
    H := B.Canvas.TextHeight(HintStr) + 12; // the hint window's border and margins
  finally
    B.Free;
  end;
  HintInfo.HintPos.Y := Top.Y - H - 4;
end;

initialization
  Feeder := THintFeeder.Create;
  Application.OnShowHint := @Feeder.ShowHint;
  Timer := TTimer.Create(nil);
  Timer.Interval := 100;
  Timer.OnTimer := @Feeder.Tick;
finalization
  Timer.Free;
  Feeder.Free;
end.
