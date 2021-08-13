#!/usr/bin/env bash

# Include everything in the global config.
pushd ../_global > /dev/null
. link.sh
popd > /dev/null

# arch-vm config starts here.
mkdir -p ~/.config/{sway,terminator}/

link ./sway/config ~/.config/sway/config
link ./sway/i3status.conf ~/.config/sway/i3status.conf
link ../_shared/terminator.conf ~/.config/terminator/config
link ../_shared/keychain.sh ~/.zshrc-extras/keychain.sh
link ../_shared/mako.conf ~/.config/mako/config
link ./env ~/.env/vm
link ../_shared/sway_env ~/.env/sway_fixes

