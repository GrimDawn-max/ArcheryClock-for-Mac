unit macerrorlog;

{ Mac build: errors the clock reports in a dialog are also written to ~/Library/Logs/ArcheryClock.log, so a
  problem seen at the range can be traced afterwards. FPC 3.2.2 can't read line info on macOS/arm64, so the log
  holds the load address and raw addresses; turn them into source lines with the build's dSYM:
    atos -o archeryclock26.dSYM/Contents/Resources/DWARF/archeryclock26 -arch arm64 -l <base> <addresses> }

{$mode objfpc}{$H+}

interface

implementation

uses
  SysUtils, Forms;

type
  TDlInfo = record
    FileName: PChar;
    Base: Pointer;
    SymbolName: PChar;
    SymbolAddress: Pointer;
  end;

function dladdr(Address: Pointer; out Info: TDlInfo): Integer; cdecl; external 'c';

type
  TErrorLogger = class
    procedure HandleException(Sender: TObject; E: Exception);
  end;

var
  Logger: TErrorLogger;

procedure TErrorLogger.HandleException(Sender: TObject; E: Exception);
var
  F: TextFile;
  Name: string;
  I: Integer;
  Frames: PCodePointer;
  Info: TDlInfo;
  Line: string;
begin
  Name := GetUserDir + 'Library/Logs/ArcheryClock.log';
  try
    AssignFile(F, Name);
    if FileExists(Name) then Append(F) else Rewrite(F);
    try
      WriteLn(F, FormatDateTime('yyyy-mm-dd hh:nn:ss', Now), '  ', E.ClassName, ': ', E.Message);
      Info.Base := nil;
      dladdr(ExceptAddr, Info);
      Line := 'base 0x' + HexStr(Info.Base) + '  at 0x' + HexStr(ExceptAddr);
      Frames := ExceptFrames;
      for I := 0 to ExceptFrameCount - 1 do
        Line := Line + ' 0x' + HexStr(Frames[I]);
      WriteLn(F, Line);
      WriteLn(F);
    finally
      CloseFile(F);
    end;
  except
    // logging must never take the clock down
  end;
  Application.ShowException(E);
end;

initialization
  Logger := TErrorLogger.Create;
  Application.OnException := @Logger.HandleException;

finalization
  Logger.Free;

end.
