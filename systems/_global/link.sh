#!/usr/bin/env bash

source ../../link.sh

link ./gitignore ~/.gitignore
link ./nanorc ~/.nanorc
link ./tmux.conf ~/.tmux.conf
link ./vimrc ~/.vimrc
link ./../.. ~/.dotfiles
link ./zshrc.sh ~/.zshrc
mkdir -p ~/.scripts
mkdir -p ~/.env
link ./env/ ~/.env/global

