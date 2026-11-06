#!/bin/bash
# mac/make-release.sh APPNAME BUNDLEID [INTEL]: packages the clock built in this repository (lazbuild first)
# as dist/APPNAME.app and a disk image, for other people's Macs. INTEL, an x86_64 build of the same source
# (lazbuild --cpu=x86_64 with an Intel Free Pascal), makes it one app for Apple silicon and Intel Macs.
# Signed ad hoc (no Apple developer certificate): people open it the first time with System Settings >
# Privacy & Security > Open Anyway, as the READ ME in the disk image explains.
# Nothing personal goes in: no debug symbols (they hold build paths), no settings but upstream's defaults.
set -euo pipefail
NAME=${1:?app name}; ID=${2:?bundle id}; INTEL=${3:-}
ROOT=$(cd "$(dirname "$0")/.." && pwd)
SRC="$ROOT"; OUT="$ROOT/dist"; VER=2.6.1.8
APP="$OUT/$NAME.app"; M="$APP/Contents/MacOS"; R="$APP/Contents/Resources"
mkdir -p "$OUT"; rm -rf "$APP"
mkdir -p "$M" "$R"

# the program, without its symbols
cp "$SRC/archeryclock26" "$M/"
strip -S -x "$M/archeryclock26"
KIND=arm64
if [ -n "$INTEL" ]; then
  # FPC's aarch64 link records SDK 10.21, which keeps AppKit's classic control metrics the layouts were made
  # for; the x86_64 link records the real SDK, and macOS 26 then draws larger controls. Same record for both.
  X=$(mktemp -d)/x86_64
  xcrun vtool -set-build-version macos 11.0 10.21 -replace -output "$X" "$INTEL"
  strip -S -x "$X"
  lipo -create "$M/archeryclock26" "$X" -output "$M/archeryclock26.u"
  mv "$M/archeryclock26.u" "$M/archeryclock26"
  KIND=universal
fi
# what the program reads beside itself: upstream's default settings, languages, sounds and pictures
for f in settings accessp language scenarios backgroundimages sounds background1.png background2.png banner.png banner2.png; do
  if [ -e "$SRC/$f" ]; then cp -R "$SRC/$f" "$M/"; else mkdir -p "$M/$f"; fi # git keeps no empty folders
done
find "$APP" -name .DS_Store -delete
cp "$SRC/COPYING.txt" "$R/"

# the icon: the Windows one is 64 pixels, scaled up for the larger sizes
SET=$(mktemp -d)/clock.iconset; mkdir -p "$SET"
for s in 16 32 64 128 256 512; do
  sips -s format png -z $s $s "$SRC/archeryclock26.ico" --out "$SET/icon_${s}x${s}.png" >/dev/null
  sips -s format png -z $((s*2)) $((s*2)) "$SRC/archeryclock26.ico" --out "$SET/icon_${s}x${s}@2x.png" >/dev/null
done
iconutil -c icns "$SET" -o "$R/clock.icns"

cat > "$APP/Contents/Info.plist" <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
	<key>CFBundleDisplayName</key>
	<string>$NAME</string>
	<key>CFBundleExecutable</key>
	<string>archeryclock26</string>
	<key>CFBundleIconFile</key>
	<string>clock</string>
	<key>CFBundleIdentifier</key>
	<string>$ID</string>
	<key>CFBundleName</key>
	<string>$NAME</string>
	<key>CFBundlePackageType</key>
	<string>APPL</string>
	<key>CFBundleShortVersionString</key>
	<string>$VER</string>
	<key>CFBundleVersion</key>
	<string>$VER</string>
	<key>LSMinimumSystemVersion</key>
	<string>11.0</string>
	<key>NSHighResolutionCapable</key>
	<true/>
	<key>NSLocalNetworkUsageDescription</key>
	<string>Archery Clock links clocks on the local network so they show the same time.</string>
</dict>
</plist>
EOF
xattr -cr "$APP"
codesign --force --deep -s - "$APP"
codesign --verify --deep --strict "$APP"

# the disk image: the app, a link to Applications, the licence and how to open it the first time
STAGE=$(mktemp -d)/stage; mkdir -p "$STAGE"
cp -R "$APP" "$STAGE/"
ln -s /Applications "$STAGE/Applications"
cp "$SRC/COPYING.txt" "$STAGE/COPYING.txt"
cat > "$STAGE/READ ME.txt" <<EOF
$NAME $VER for Mac ($( [ $KIND = universal ] && echo "Apple silicon and Intel" || echo "Apple silicon: M1 and later"))

Install: drag $NAME to Applications.

First time you open it: macOS says it can't check the app for malicious software, because it is not
signed with a paid Apple developer certificate. Click Done (not Move to Bin or Move to Trash), then open
System Settings > Privacy & Security, scroll down to "$NAME was blocked", click Open Anyway and
confirm. After that it opens normally.

If you link clocks over the network, allow "Local Network" when macOS asks.

Displays: with more than one display connected (a projector or TV for the archers, say), the clock
asks at start which one to show the clock on. Tick "Remember my choice" and it opens there without
asking whenever that display is connected; if it isn't, the clock asks again. Hold Option while
opening the clock to be asked again. With a single display there is no question.

Settings: everything the clock saves is in the folder
  ~/Library/Application Support/Archery Clock
To open it, in Finder choose Go > Go to Folder (Shift-Command-G) and paste that path.

Problems: email the feedback address on http://www.archeryclock.com, say what you did and what
happened, and attach this file if it exists (it lists the errors the clock reported; it is plain text):
  ~/Library/Logs/ArcheryClock.log

Starting over: quit the clock and move the "Archery Clock" folder in Application Support to the Bin (Trash).
The next time it opens it starts with the default settings (saved scenarios and the slide list go
too, so keep a copy if you may want them back). To be asked again which display to use, hold Option
while opening the clock.

Archery Clock is free software under the GNU General Public License version 3 (COPYING.txt).
More info: http://www.archeryclock.com
EOF
DMG="$OUT/${NAME// /-}-$VER-$KIND.dmg" # dashes: file names with spaces break in links and mail; rm -f "$DMG"
hdiutil create -quiet -volname "$NAME" -srcfolder "$STAGE" -fs HFS+ -format UDZO "$DMG"
echo "$APP"; echo "$DMG"
