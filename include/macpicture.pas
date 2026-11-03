unit macpicture;

{ Mac build: where a slideshow picture's own content starts. Many of the pictures have a plain border (a black
  background, for instance), so the picture's edge is not where anything visible begins; the hint line is
  placed against what the viewer actually sees. }

{$mode objfpc}{$H+}

interface

uses
  Graphics;

{ The first row of Graphic, from the top, with a pixel that shows against Background: one neither transparent
  nor clearly Background's colour. A band in any other colour is part of the picture. 0 if Graphic can't be
  read. }
function PictureContentTop(Graphic: TGraphic; Background: TColor): Integer;

implementation

uses
  IntfGraphics, FPImage;

function PictureContentTop(Graphic: TGraphic; Background: TColor): Integer;
const
  Tolerance = $0800; // per channel, out of $FFFF: ignores compression noise in a plain border
var
  Img: TLazIntfImage;
  Back, C: TFPColor;
  X, Y, StepX: Integer;
begin
  Result := 0;
  if not (Graphic is TRasterImage) or (Graphic.Width = 0) or (Graphic.Height = 0) then Exit;
  Img := TRasterImage(Graphic).CreateIntfImage;
  try
    Back := TColorToFPColor(ColorToRGB(Background));
    StepX := Img.Width div 200 + 1;
    for Y := 0 to Img.Height - 1 do
    begin
      X := 0;
      while X < Img.Width do
      begin
        C := Img.Colors[X, Y];
        if (C.Alpha > Tolerance) and ((Abs(C.Red - Back.Red) > Tolerance) or
           (Abs(C.Green - Back.Green) > Tolerance) or (Abs(C.Blue - Back.Blue) > Tolerance)) then
          Exit(Y);
        Inc(X, StepX);
      end;
    end;
  finally
    Img.Free;
  end;
end;

end.
