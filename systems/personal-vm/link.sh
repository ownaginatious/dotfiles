#!/usr/bin/env bash

# Include everything in the global config.
pushd ../_global > /dev/null
. link.sh
popd > /dev/null

link ../_shared/sway ~/.config/sway/config
link ./waybar ~/.config/waybar
link ../_shared/mako.conf ~/.config/mako/config
link ../_shared/foot.ini ~/.config/foot/foot.ini
link ../_shared/env/nixos ~/.env/nixos

