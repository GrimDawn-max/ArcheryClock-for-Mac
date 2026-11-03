# Archery Clock for Mac

A Mac version of [Archery Clock](http://www.archeryclock.com), the countdown timer used at archery matches.

Archery Clock is written by Henk Jegers, who makes the Windows and Linux versions available at
[archeryclock.com](http://www.archeryclock.com). This Mac version is a separate derivative work, ported from his
2.6.18 source by a different developer. It runs natively on Apple silicon and Intel Macs (macOS 11 or later), with
no Wine, CrossOver or external monitor needed.

Archery Clock is free software under the GNU General Public License version 3 (`COPYING.txt`). This repository
holds the full source of the Mac version: Henk Jegers' 2.6.18 source plus the Mac changes. The changes are kept
apart (`{$IFDEF Darwin}` and the `include/mac*.pas` units), so the Windows and Linux builds are unchanged.

## Two versions

| App | Branch | What it is |
|---|---|---|
| Archery Clock Mac Modern | `mac-redesign` | Timing and Sequence, and Settings, in their own Mac windows; a sidebar of sections; pages laid out the Mac way |
| Archery Clock Mac Classic | `mac-tidy` | The author's single settings panel, as in the Windows version, tidied for the Mac |

Both run on Apple silicon and Intel Macs, and both read and save the same settings
(`~/Library/Application Support/Archery Clock`), so moving from one to the other keeps everything.

## Install

Download a disk image from Releases and drag the app to Applications. It is not signed with a paid
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
`mac/make-release.sh "Archery Clock Mac Modern" <bundle id> [<x86_64 build>]` packages the app and a disk image; given
the Intel build too, it makes one universal app.
