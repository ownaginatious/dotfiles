#!/usr/bin/env bash

# Include everything in the global config.
pushd ../_global > /dev/null
. link.sh
popd > /dev/null

# Personal laptop config starts here.
mkdir -p ~/.config/{sway,terminator}/

link ./sway/config ~/.config/sway/config
link ./sway/py3status.conf ~/.config/sway/py3status.conf
link ../_shared/terminator.conf ~/.config/terminator/config
link ../_shared/keychain.sh ~/.zshrc-extras/keychain.sh
link ../_shared/mako.conf ~/.config/mako/config
link ./env ~/.env/personal-laptop

for f in ./scripts/*; do
  link "${f}" "~/.scripts/${f#./scripts/}"
done
