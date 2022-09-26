#!/bin/sh

cp ./kitty-icon/kitty-light.icns /Applications/kitty.app/Contents/Resources/kitty.icns
/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -f

rm /var/folders/*/*/*/com.apple.dock.iconcache; killall Dock
