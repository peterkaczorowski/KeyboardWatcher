# KeyboardWatcher

## Keyboard Mapping Error Report and Workaround

In June 2024, I reported a keyboard mapping error from Polish Programmers to Polish between a MacOS Host and Ubuntu Guest VM to Parallels.
Despite the error being mentioned on various forums for several years, **Parallels support refused to correct the error** because I am working on a cMP 5,1 with OpenCore ML - the real Apple hardware running MacOS Monterey. 
In this situation, I had to write my own workaround.

## Diagnosis
In MacOS, there are two Polish keyboards available: Polish (aka PolishPro) and Polish QWERTZ. In Ubuntu (this error also occurs in other Linux distributions under Parallels), several keyboard layouts are available, including Polish (PolishPro), which is the most commonly used in Poland (I think 99.9%). The Parallels program confuses the two keyboard layouts on the MacOS Host side. When setting to PolishPro, it maps Polish QWERTZ to Polish in Ubuntu.

## Solution
I wrote a simple AppleScript that checks the active window under MacOS. If it is a window whose name starts with Ubuntu, it sets the keyboard layout to Polish QWERTZ so that Parallels maps the second one (PolishPro). For other windows, the script sets the keyboard to Polish (aka PolishPro).

## Requirements
1. Both Polish and Polish QWERTZ keyboards must be available in MacOS.
2. The InputSourceSelector program must be installed and should be available in the `/usr/local/bin` directory.
3. The AppleScript KeyboardWatcher must be downloaded and installed, e.g., in the `/usr/local/Cellar/KeyboardWatcher/KeyboardWatcher.scpt` directory. If it is in another directory, the plist must be adjusted later to allow the script to run in the background.
4. The Parallels Ubuntu VM should have a name like 'UbuntuVM 22.04'. KeyboardWatcher detects windows named 'UbuntuVM*'.

## Files in the package of workaround
1. **InputSourceSelector** - a program that allows changing the keyboard layout.
2. **KeyboardWatcher** - an active window watcher that changes the keyboard layout for windows whose names start with "Ubuntu."
3. **keyboardwatcher.plist** - an XML plist script for a launch daemon to run the KeyboardWatcher in the background.
4. **start.sh, stop.sh** - scripts to load and unload the KeyboardWatcher as a background job.

## References

[Ubuntu/Fedora: Tilde switched to angle bracket - Parallels Forum](https://forum.parallels.com/threads/ubuntu-fedora-tilde-switched-to-angle-bracket.358480/)
