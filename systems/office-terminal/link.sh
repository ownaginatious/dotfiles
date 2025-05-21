#!/usr/bin/env bash

# Include everything in the global config.
pushd ../_global > /dev/null
. link.sh
popd > /dev/null

link ./sway ~/.config/sway/config
link ./waybar ~/.config/waybar
link ../_shared/mako.conf ~/.config/mako/config
link ./foot.ini ~/.config/foot/foot.ini
link ./env/export_flatpak ~/.env/export_flatpak
link ./env/nixos ~/.env/nixos
