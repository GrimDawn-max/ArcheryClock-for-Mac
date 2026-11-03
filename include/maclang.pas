unit maclang;

{ Mac build: the few words the Mac code adds itself (section headings, hints, the display question), in the
  language chosen. Upstream's language files are read line by line in a fixed order, and the author adds lines at
  their end, so these sit in files of their own, language/mac/<language file name>, as Key=text lines. A missing
  file or key gives the English. }

{$mode objfpc}{$H+}

interface

{ Name as the language list shows it ('Español', 'Ελληνικά') or as its file is named ('Espanol', 'Greek'). }
procedure MacSetLanguage(const Name: string);
{ Before the clock is up (the display question): the language the settings were last saved in. }
procedure MacLanguageFromSettings;
function MacText(const Key, English: string): string;

implementation

uses
  Classes, SysUtils;

var
  Texts: TStringList = nil;

{ The language list's names that can't be file names, as setlanguage maps them. }
function FileNameOf(const Name: string): string;
begin
  if Name = 'Español' then Result := 'Espanol'
  else if Name = 'Ελληνικά' then Result := 'Greek'
  else if Name = 'Slovenský' then Result := 'Slovensky'
  else if Name = 'Português' then Result := 'Portugues'
  else if Name = 'русский' then Result := 'Russian'
  else if Name = 'Česky' then Result := 'Cesky'
  else if Name = '中文' then Result := 'Chinese'
  else Result := Name;
end;

procedure MacSetLanguage(const Name: string);
var
  Path: string;
begin
  if Texts = nil then Texts := TStringList.Create;
  Texts.Clear;
  Path := ExtractFilePath(ParamStr(0)) + 'language/mac/' + FileNameOf(Trim(Name));
  if FileExists(Path) then
  try
    Texts.LoadFromFile(Path);
  except
    Texts.Clear; // unreadable: English
  end;
end;

procedure MacLanguageFromSettings;
var
  Path: string;
  Lines: TStringList;
begin
  Path := GetUserDir + 'Library/Application Support/Archery Clock/settings';
  if not FileExists(Path) then Path := ExtractFilePath(ParamStr(0)) + 'settings';
  if not FileExists(Path) then Exit;
  Lines := TStringList.Create;
  try
    try
      Lines.LoadFromFile(Path);
      if Lines.Count > 0 then MacSetLanguage(Lines[0]); // the settings file starts with the language
    except
      // no language: English
    end;
  finally
    Lines.Free;
  end;
end;

function MacText(const Key, English: string): string;
begin
  Result := '';
  if Texts <> nil then Result := Trim(Texts.Values[Key]);
  if Result = '' then Result := English;
end;

finalization
  Texts.Free;
end.
