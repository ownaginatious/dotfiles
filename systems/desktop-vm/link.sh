#!/usr/bin/env bash

# Include everything in the global config.
pushd ../_global > /dev/null
. link.sh
popd > /dev/null

link ./sway ~/.config/sway/config
link ./waybar ~/.config/waybar
link ../_shared/mako.conf ~/.config/mako/config
link ../_shared/kitty.conf ~/.config/kitty/kitty.conf
link ../_shared/env/nixos ~/.env/nixos
link ../_shared/env/flatpak ~/.env/flatpak
link ../_shared/env/kitty ~/.env/kitty

