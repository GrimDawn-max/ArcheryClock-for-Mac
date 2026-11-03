#!/bin/bash
# mac/make-release.sh APPNAME BUNDLEID: packages the clock built in this repository (lazbuild first)
# as dist/APPNAME.app and dist/APPNAME-2.6.18-mac-arm64.dmg, for other people's Macs.
# Signed ad hoc (no Apple developer certificate): people open it the first time with System Settings >
# Privacy & Security > Open Anyway, as the READ ME in the disk image explains.
# Nothing personal goes in: no debug symbols (they hold build paths), no settings but upstream's defaults.
set -euo pipefail
NAME=${1:?app name}; ID=${2:?bundle id}
ROOT=$(cd "$(dirname "$0")/.." && pwd)
SRC="$ROOT"; OUT="$ROOT/dist"; VER=2.6.18
APP="$OUT/$NAME.app"; M="$APP/Contents/MacOS"; R="$APP/Contents/Resources"
mkdir -p "$OUT"; rm -rf "$APP"
mkdir -p "$M" "$R"

# the program, without its symbols
cp "$SRC/archeryclock26" "$M/"
strip -S -x "$M/archeryclock26"
# what the program reads beside itself: upstream's default settings, languages, sounds and pictures
for f in settings accessp language scenarios backgroundimages sounds background1.png background2.png banner.png banner2.png; do
  cp -R "$SRC/$f" "$M/"
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
$NAME $VER for Mac (Apple silicon: M1 and later)

Install: drag $NAME to Applications.

First time you open it: macOS says it can't check the app for malicious software, because it is not
signed with a paid Apple developer certificate. Click Done (not Move to Bin), then open
System Settings > Privacy & Security, scroll down to "$NAME was blocked", click Open Anyway and
confirm. After that it opens normally.

If you link clocks over the network, allow "Local Network" when macOS asks.

Settings are kept in your Library/Application Support/Archery Clock folder.

Archery Clock is free software under the GNU General Public License version 3 (COPYING.txt).
More info and support: http://www.archeryclock.com
EOF
DMG="$OUT/$NAME-$VER-mac-arm64.dmg"; rm -f "$DMG"
hdiutil create -quiet -volname "$NAME" -srcfolder "$STAGE" -fs HFS+ -format UDZO "$DMG"
echo "$APP"; echo "$DMG"
