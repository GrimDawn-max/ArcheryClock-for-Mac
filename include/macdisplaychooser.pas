unit macdisplaychooser;

{ Mac build: choose which display shows the clock.
  One display: use it, no question. Several: ask, listing each display by its macOS name, with the first external
  display selected. "Remember my choice" skips the question next time while that display is connected; holding
  Option while the app opens asks again. The choice is kept in
  ~/Library/Application Support/Archery Clock/display.ini, apart from the clock's own settings file. }

{$mode objfpc}{$H+}
{$modeswitch objectivec1}
{$linkframework CoreGraphics}

interface

uses
  Forms;

{ Returns the index into Screen.Monitors to use, or -1 if the user chose Quit. }
function MacChooseDisplay: Integer;
{ Moves the form onto that display; the form then maximises there as usual. }
procedure MacPlaceOnDisplay(AForm: TForm; AIndex: Integer);

implementation

uses
  SysUtils, Classes, Controls, StdCtrls, Graphics, IniFiles, CocoaAll, maclang;

function CGDisplayIsBuiltin(Display: UInt32): UInt32; cdecl; external name 'CGDisplayIsBuiltin';
function CGDisplayPixelsWide(Display: UInt32): PtrUInt; cdecl; external name 'CGDisplayPixelsWide';
function CGDisplayPixelsHigh(Display: UInt32): PtrUInt; cdecl; external name 'CGDisplayPixelsHigh';
function CGEventSourceFlagsState(StateID: Int32): UInt64; cdecl; external name 'CGEventSourceFlagsState';

const
  CombinedSessionState = 0;      // kCGEventSourceStateCombinedSessionState
  OptionKeyFlag = $00080000;     // kCGEventFlagMaskAlternate

type
  TDisplay = record
    Name: string;
    Builtin: Boolean;
    PixelWidth, PixelHeight: Integer;
  end;

function ListDisplays: specialize TArray<TDisplay>;
var
  Screens: NSArray;
  S: NSScreen;
  Number: NSNumber;
  LocalName: NSString;
  ID: UInt32;
  I: Integer;
begin
  Screens := NSScreen.screens;
  SetLength(Result, Screens.count);
  for I := 0 to Screens.count - 1 do
  begin
    S := NSScreen(Screens.objectAtIndex(I));
    Number := NSNumber(S.deviceDescription.objectForKey(NSString.stringWithUTF8String('NSScreenNumber')));
    ID := Number.unsignedIntValue;
    // localizedName is macOS 10.15+ and newer than FPC 3.2.2's headers, so ask for it by key
    LocalName := NSString(S.valueForKey(NSString.stringWithUTF8String('localizedName')));
    if LocalName <> nil then
      Result[I].Name := LocalName.UTF8String
    else
      Result[I].Name := 'Display ' + IntToStr(I + 1);
    Result[I].Builtin := CGDisplayIsBuiltin(ID) <> 0;
    Result[I].PixelWidth := CGDisplayPixelsWide(ID);
    Result[I].PixelHeight := CGDisplayPixelsHigh(ID);
  end;
end;

function SettingsFileName: string;
begin
  Result := GetUserDir + 'Library/Application Support/Archery Clock/display.ini';
end;

function OptionKeyDown: Boolean;
begin
  Result := (CGEventSourceFlagsState(CombinedSessionState) and OptionKeyFlag) <> 0;
end;

function AskForDisplay(const Displays: array of TDisplay; Selected: Integer; out Remember: Boolean): Integer;
var
  Dlg: TForm;
  Prompt: TLabel;
  List: TListBox;
  RememberBox: TCheckBox;
  AgainNote: TLabel;
  OpenButton, QuitButton: TButton;
  I: Integer;
  Kind: string;
begin
  MacLanguageFromSettings; // the clock isn't up yet: the language its settings were saved in
  Dlg := TForm.CreateNew(nil);
  try
    Dlg.Caption := 'Archery Clock';
    Dlg.BorderStyle := bsDialog;
    Dlg.Position := poScreenCenter;
    Dlg.ClientWidth := 440;
    Dlg.ClientHeight := 274;

    Prompt := TLabel.Create(Dlg);
    Prompt.Parent := Dlg;
    Prompt.SetBounds(20, 16, 400, 20);
    Prompt.Caption := MacText('ShowClockOn', 'Show the clock on:');

    List := TListBox.Create(Dlg);
    List.Parent := Dlg;
    List.SetBounds(20, 42, 400, 110);
    for I := 0 to High(Displays) do
    begin
      if Displays[I].Builtin then Kind := MacText('BuiltIn', 'built-in') else Kind := MacText('External', 'external');
      List.Items.Add(Format('%s  (%s, %d × %d)',
        [Displays[I].Name, Kind, Displays[I].PixelWidth, Displays[I].PixelHeight]));
    end;
    List.ItemIndex := Selected;

    RememberBox := TCheckBox.Create(Dlg);
    RememberBox.Parent := Dlg;
    RememberBox.SetBounds(20, 162, 400, 22);
    RememberBox.Caption := MacText('RememberChoice', 'Remember my choice');
    // how to get this question back, in small type under the box; it wraps, as some languages need two lines
    AgainNote := TLabel.Create(Dlg);
    AgainNote.Parent := Dlg;
    AgainNote.AutoSize := False;
    AgainNote.WordWrap := True;
    AgainNote.SetBounds(42, 186, 378, 32);
    AgainNote.Font.Height := -11;
    AgainNote.Font.Color := clGrayText;
    AgainNote.Caption := MacText('ChooseAgain', 'Hold Option ⌥ while opening to choose again');

    QuitButton := TButton.Create(Dlg);
    QuitButton.Parent := Dlg;
    QuitButton.SetBounds(200, 226, 100, 30);
    QuitButton.Caption := MacText('Quit', 'Quit');
    QuitButton.ModalResult := mrCancel;
    QuitButton.Cancel := True;

    OpenButton := TButton.Create(Dlg);
    OpenButton.Parent := Dlg;
    OpenButton.SetBounds(310, 226, 110, 30);
    OpenButton.Caption := MacText('OpenClock', 'Open Clock');
    OpenButton.ModalResult := mrOK;
    OpenButton.Default := True;

    if (Dlg.ShowModal = mrOK) and (List.ItemIndex >= 0) then
      Result := List.ItemIndex
    else
      Result := -1;
    Remember := RememberBox.Checked;
  finally
    Dlg.Free;
  end;
end;

function MacChooseDisplay: Integer;
var
  Displays: specialize TArray<TDisplay>;
  Ini: TIniFile;
  SavedName: string;
  Remember: Boolean;
  I, Selected: Integer;
begin
  Displays := ListDisplays;
  if Length(Displays) <= 1 then
    Exit(0);

  ForceDirectories(ExtractFileDir(SettingsFileName));
  Ini := TIniFile.Create(SettingsFileName);
  try
    SavedName := Ini.ReadString('Display', 'Name', '');

    // a remembered display that is connected now: use it without asking
    if (SavedName <> '') and not OptionKeyDown then
      for I := 0 to High(Displays) do
        if Displays[I].Name = SavedName then
          Exit(I);

    // otherwise preselect the last choice if it's there, else the first external display
    Selected := -1;
    for I := 0 to High(Displays) do
      if (SavedName <> '') and (Displays[I].Name = SavedName) then
        Selected := I;
    if Selected < 0 then
      for I := High(Displays) downto 0 do
        if not Displays[I].Builtin then
          Selected := I;
    if Selected < 0 then
      Selected := 0;

    Result := AskForDisplay(Displays, Selected, Remember);
    if Result >= 0 then
      if Remember then
        Ini.WriteString('Display', 'Name', Displays[Result].Name)
      else
        Ini.DeleteKey('Display', 'Name');
  finally
    Ini.Free;
  end;
end;

procedure MacPlaceOnDisplay(AForm: TForm; AIndex: Integer);
var
  R: TRect;
begin
  if (AIndex < 0) or (AIndex >= Screen.MonitorCount) then
    Exit;
  R := Screen.Monitors[AIndex].WorkareaRect;
  AForm.WindowState := wsNormal;
  AForm.Position := poDesigned;
  AForm.SetBounds(R.Left + 40, R.Top + 40, 640, 480);
  AForm.WindowState := wsMaximized;
end;

end.
