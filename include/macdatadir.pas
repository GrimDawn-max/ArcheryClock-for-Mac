unit macdatadir;

{ Mac build: the files the app writes (settings, saved scenarios F1-F12, the slideshow list) live in
  ~/Library/Application Support/Archery Clock, not next to the program. On other systems they sit beside the
  program, but inside a Mac app that is the app bundle, which a signed app can't change and an update replaces.
  The bundle keeps the default copies; the first start copies them across, so existing settings carry over.
  The display chooser's display.ini is kept in the same folder. }

{$mode objfpc}{$H+}

interface

{ The data folder, with a trailing '/'; created (with its scenarios folder) if missing, and filled from the
  bundle's copies of any file not there yet. BundleDir is the folder the program runs from. }
function MacDataFolder(const BundleDir: string): string;

implementation

uses
  Classes, SysUtils, FileUtil;

procedure CopyIfMissing(const Src, Dst: string);
begin
  if FileExists(Src) and not FileExists(Dst) then
    CopyFile(Src, Dst);
end;

function MacDataFolder(const BundleDir: string): string;
var
  Found: TSearchRec;
begin
  Result := GetUserDir + 'Library/Application Support/Archery Clock/';
  ForceDirectories(Result + 'scenarios');
  CopyIfMissing(BundleDir + 'settings', Result + 'settings');
  CopyIfMissing(BundleDir + 'backgroundimages', Result + 'backgroundimages');
  if FindFirst(BundleDir + 'scenarios/*', faAnyFile, Found) = 0 then
  try
    repeat
      if (Found.Attr and faDirectory) = 0 then
        CopyIfMissing(BundleDir + 'scenarios/' + Found.Name, Result + 'scenarios/' + Found.Name);
    until FindNext(Found) <> 0;
  finally
    FindClose(Found);
  end;
end;

end.
