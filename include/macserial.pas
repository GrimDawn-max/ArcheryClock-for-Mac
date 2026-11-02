unit macserial;

{ Mac build: the serial port menus (Arduino 1 and 2 on the Hardware page) list the ports this Mac actually has.
  The Linux names the app offers (/dev/ttyACM0, /dev/ttyUSB0) never exist on a Mac; an Arduino or USB serial
  adapter shows up as /dev/cu.usbmodem<n> or /dev/cu.usbserial-<n>. The menus are refilled each time one opens,
  so a board plugged in after start-up appears without restarting. }

{$mode objfpc}{$H+}

interface

uses
  StdCtrls, SdpoSerial;

{ Fill Combo with the Mac's serial ports, and refill it whenever it is opened. }
procedure MacSerialPortMenu(Combo: TComboBox);
{ Open Port; False if its device can't be opened (unplugged, or a name from another computer). Windows lets
  that exception reach the user as an error box; the status line says it instead. }
function MacOpenPort(Port: TSdpoSerial): Boolean;
{ A saved port name as the Mac uses it: '' for a Windows name (COM1...), which can't exist here. }
function MacPortName(const Saved: string): string;

implementation

uses
  Classes, SysUtils;

type
  TPortMenu = class
    procedure Refill(Sender: TObject);
  end;

var
  PortMenu: TPortMenu;

{ The ports a clock could be on: the call-out devices (cu.*), USB ones first. Bluetooth-Incoming-Port and
  debug-console are always present and never a clock. }
procedure ListPorts(Ports: TStrings);
var
  Found: TSearchRec;
  Usb, Other: TStringList;
begin
  Usb := TStringList.Create;
  Other := TStringList.Create;
  try
    if FindFirst('/dev/cu.*', faAnyFile, Found) = 0 then
    try
      repeat
        if (Found.Name = 'cu.Bluetooth-Incoming-Port') or (Found.Name = 'cu.debug-console') then
          Continue;
        if Pos('usb', LowerCase(Found.Name)) > 0 then
          Usb.Add('/dev/' + Found.Name)
        else
          Other.Add('/dev/' + Found.Name);
      until FindNext(Found) <> 0;
    finally
      FindClose(Found);
    end;
    Usb.Sort;
    Other.Sort;
    Ports.Assign(Usb);
    Ports.AddStrings(Other);
  finally
    Usb.Free;
    Other.Free;
  end;
end;

procedure TPortMenu.Refill(Sender: TObject);
var
  Combo: TComboBox;
  Chosen: string;
begin
  Combo := TComboBox(Sender);
  Chosen := Combo.Text; // keep the saved choice even while that board is unplugged
  Combo.Items.BeginUpdate;
  try
    ListPorts(Combo.Items);
  finally
    Combo.Items.EndUpdate;
  end;
  Combo.Text := Chosen;
end;

procedure MacSerialPortMenu(Combo: TComboBox);
begin
  if PortMenu = nil then
    PortMenu := TPortMenu.Create;
  PortMenu.Refill(Combo);
  Combo.OnDropDown := @PortMenu.Refill;
end;

function MacOpenPort(Port: TSdpoSerial): Boolean;
begin
  try
    Port.Open;
    Result := True;
  except
    Result := False;
  end;
end;

function MacPortName(const Saved: string): string;
begin
  if Pos('COM', UpperCase(Saved)) = 1 then
    Result := ''
  else
    Result := Saved;
end;

finalization
  PortMenu.Free;
end.
