#!/usr/bin/env bash

source ../../link.sh

link ./gitignore ~/.gitignore
link ./mux-gitconfig ~/.gitconfig
link ./personal-gitconfig ~/git/personal/.gitconfig
link ./nanorc ~/.nanorc
link ./tmux.conf ~/.tmux.conf
link ./vimrc ~/.vimrc
link ./../.. ~/.dotfiles
link ./zshrc.sh ~/.zshrc
mkdir -p ~/.zshrc-extras
