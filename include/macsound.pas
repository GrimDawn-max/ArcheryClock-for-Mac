unit macsound;

{ macOS sound playback for Archery Clock, replacing SDL_mixer on Darwin.
  Uses AppKit's NSSound, so the Mac build needs no SDL libraries. }

{$mode objfpc}{$H+}
{$modeswitch objectivec1}

interface

function MacPlayWav(const FileName: string): Boolean;

implementation

uses
  CocoaAll;

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

end.
