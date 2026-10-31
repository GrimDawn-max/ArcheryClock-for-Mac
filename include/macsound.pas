unit macsound;

{ macOS helpers for Archery Clock.
  Sound playback replaces SDL_mixer on Darwin: AppKit's NSSound, so the Mac build needs no SDL libraries.
  MacKeepDisplayAwake replaces the Linux 'xset' calls: caffeinate keeps the display on until the clock quits. }

{$mode objfpc}{$H+}
{$modeswitch objectivec1}

interface

function MacPlayWav(const FileName: string): Boolean;
procedure MacKeepDisplayAwake;

implementation

uses
  CocoaAll, SysUtils, Process;

const
  KeepCount = 8; // sounds may overlap; keep the last few alive until they finish

var
  Playing: array[0..KeepCount - 1] of NSSound;
  NextSlot: Integer = 0;

function MacPlayWav(const FileName: string): Boolean;
var
  Sound: NSSound;
begin
  Result := False;
  Sound := NSSound.alloc.initWithContentsOfFile_byReference(
    NSString.stringWithUTF8String(PChar(FileName)), True);
  if Sound = nil then
    Exit;
  if Playing[NextSlot] <> nil then
  begin
    Playing[NextSlot].stop;
    Playing[NextSlot].release;
  end;
  Playing[NextSlot] := Sound;
  NextSlot := (NextSlot + 1) mod KeepCount;
  Result := Sound.play;
end;

var
  Caffeinate: TProcess = nil;

procedure MacKeepDisplayAwake;
begin
  if Caffeinate <> nil then
    Exit;
  // -w: caffeinate exits by itself when this process ends, even after a crash
  Caffeinate := TProcess.Create(nil);
  Caffeinate.Executable := '/usr/bin/caffeinate';
  Caffeinate.Parameters.Add('-di');
  Caffeinate.Parameters.Add('-w');
  Caffeinate.Parameters.Add(IntToStr(GetProcessID));
  try
    Caffeinate.Execute;
  except
    FreeAndNil(Caffeinate);
  end;
end;

end.
