unit macappearance;

{ Mac build: keep the clock's colours the same in light and dark mode.
  The settings pages put option buttons on two kinds of ground: the light grey menu and the black timing panels.
  Windows draws those buttons' captions in the colour the app asks for (silver on black). Cocoa ignores that
  colour for check boxes and radio buttons and uses the system text colour instead, so in light mode the captions
  on the black panels vanish (black on black) and in dark mode those on the grey menu turn white on light grey.
  Fix: the app always uses the light appearance, and every container the app paints dark uses the dark one, so
  each caption contrasts with its own ground whatever the system setting. }

{$mode objfpc}{$H+}
{$modeswitch objectivec1}

interface

uses
  Forms;

{ The whole app in the light appearance; call before any window is shown. }
procedure MacUseLightAppearance;
{ Containers of AForm with a dark background of their own get the dark appearance (their children inherit it). }
procedure MacDarkenDarkPanels(AForm: TForm);
{ No focus ring on C (a blue outline that otherwise lingers on whichever button the app last focused). }
procedure MacNoFocusRing(C: TObject);
{ Scroll bars on the scroll box C that show whenever its contents don't fit (macOS otherwise hides them until
  you scroll, so nothing tells you there is more). }
procedure MacVisibleScrollBars(C: TObject);

implementation

uses
  Classes, Controls, Graphics, CocoaAll;

type
  TControlAccess = class(TControl); // ParentColor is protected

function AppearanceNamed(const Name: string): NSAppearance;
begin
  Result := NSAppearance.appearanceNamed(NSString.stringWithUTF8String(PChar(Name)));
end;

procedure SetAppearance(Target: NSObject; const Name: string);
begin
  // 'appearance' is newer than FPC 3.2.2's headers on NSApplication, so set it by key
  Target.setValue_forKey(AppearanceNamed(Name), NSString.stringWithUTF8String('appearance'));
end;

function IsDark(Color: TColor): Boolean;
var
  RGB: LongInt;
begin
  RGB := ColorToRGB(Color);
  Result := (0.299 * Red(RGB) + 0.587 * Green(RGB) + 0.114 * Blue(RGB)) < 96;
end;

procedure MacUseLightAppearance;
begin
  SetAppearance(NSApplication.sharedApplication, 'NSAppearanceNameAqua');
end;

procedure MacNoFocusRing(C: TObject);
begin
  if (C is TWinControl) and TWinControl(C).HandleAllocated then
    NSView(TWinControl(C).Handle).setFocusRingType(NSFocusRingTypeNone);
end;

procedure MacVisibleScrollBars(C: TObject);
begin
  if not (C is TWinControl) then Exit;
  TWinControl(C).HandleNeeded;
  if NSObject(TWinControl(C).Handle).isKindOfClass(NSScrollView) then
  begin
    NSScrollView(TWinControl(C).Handle).setScrollerStyle(NSScrollerStyleLegacy);
    NSScrollView(TWinControl(C).Handle).setAutohidesScrollers(True);
  end;
end;

procedure MacDarkenDarkPanels(AForm: TForm);
var
  I: Integer;
  C: TWinControl;
begin
  for I := 0 to AForm.ComponentCount - 1 do
    if AForm.Components[I] is TWinControl then
    begin
      C := TWinControl(AForm.Components[I]);
      if (csAcceptsControls in C.ControlStyle) and not TControlAccess(C).ParentColor
        and (C.Color <> clDefault) and IsDark(C.Color) then
      begin
        C.HandleNeeded;
        SetAppearance(NSObject(C.Handle), 'NSAppearanceNameDarkAqua');
      end;
    end;
end;

end.
