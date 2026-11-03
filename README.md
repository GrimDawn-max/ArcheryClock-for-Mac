# Archery Clock for Mac

A native macOS build of [Archery Clock](http://www.archeryclock.com) 2.6.18 by Henk Jegers: the countdown
timer used at archery matches. It runs natively on Apple silicon and Intel Macs (macOS 11 or later), with no Wine,
CrossOver or external monitor needed.

Archery Clock is free software under the GNU General Public License version 3 (`COPYING.txt`). This repository
holds the full source of the Mac build: the author's 2.6.18 source, plus the Mac changes, made with
`{$IFDEF Darwin}` and the `include/mac*.pas` units so that the Windows and Linux builds are unchanged.

## Two versions

| Branch | What it is |
|---|---|
| `mac-redesign` (version 2) | Timing and Sequence, and Settings, in their own Mac windows; a sidebar of sections; pages laid out the Mac way |
| `mac-tidy` (version 1) | The author's single settings panel, tidied for the Mac |

Both read and save the same settings (`~/Library/Application Support/Archery Clock`).

## Install

Download the disk image from Releases and drag Archery Clock to Applications. It is not signed with a paid
Apple developer certificate, so the first time: open it, click Done, then System Settings > Privacy &
Security > Open Anyway.

Support: the feedback address on [archeryclock.com](http://www.archeryclock.com).

## Languages

The clock's own text comes from the author's `language/` files. The few words the Mac code adds (section
headings, hints, the display question) are in `language/mac/<language>`, one `Key=text` line each; a missing
file or key falls back to English.

## Building

- Free Pascal 3.2.2 (`brew install fpc`).
- Lazarus (fixes_4 branch), built from source, with the two LCL Cocoa fixes in `mac/lazarus-patches/`:
  - `lcl-cocoa-fullscreen-mask.patch`: AppKit throws when a window's full-screen bit is cleared outside a
    full-screen transition (leaving full screen crashed the app).
  - `lcl-cocoa-tab-arrows.patch`: the tab row's scroll arrows did nothing.
- Packages LNet, Synapse 40.1 and Sdpo (Lazarus Online Package Manager).

```
lazbuild --ws=cocoa --cpu=aarch64 --os=darwin --opt=-k-ld_classic archeryclock26.lpi
```

`-k-ld_classic`: Apple's current linker rejects FPC 3.2.2's Objective-C method lists.

For Intel, build the same source with the x86_64 compiler from the official Free Pascal 3.2.2 Mac installer
(`--cpu=x86_64 --compiler=<ppcx64>`, with `-XR<macOS SDK>` and `-WM11.0` in its `fpc.cfg`).
`mac/make-release.sh "Archery Clock" <bundle id> [<x86_64 build>]` packages the app and a disk image; given
the Intel build too, it makes one universal app.
