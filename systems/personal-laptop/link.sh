#!/bin/bash

# Include everything in the common config
pushd ../common > /dev/null
. link.sh
popd > /dev/null

# Personal laptop config starts here.
mkdir -p ~/.zshrc-extras
mkdir -p ~/.config/{sway,terminator}/

link ./sway/config ~/.config/sway/config
link ./sway/py3status.conf ~/.config/sway/py3status.conf
link ./sway/background.png ~/.config/sway/background.png
link ./terminator.conf ~/.config/terminator/config
link ./keychain.sh ~/.zshrc-extras/keychain.sh
link ./env-scripts ~/.env-scripts
link ./env-scripts-hook.sh ~/.zshrc-extras/env-scripts-hook.sh
