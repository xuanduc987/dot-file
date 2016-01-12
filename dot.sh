#!/bin/bash

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# vim
ln -s ${BASEDIR}/vim/vimrc ~/.vimrc
mkdir -p ~/.vim
ln -s ${BASEDIR}/vim/ftplugin ~/.vim/ftplugin

# git
ln -s ${BASEDIR}/git/gitconfig ~/.gitconfig
ln -s ${BASEDIR}/git/gitignore ~/.gitignore

# tmux
ln -s ${BASEDIR}/tmux/tmux.conf ~/.tmux.conf

# i3
ln -s ${BASEDIR}/i3 ~/.i3

# mutt
cp ${BASEDIR}/mutt/muttrc ~/.muttrc
cp -r ${BASEDIR}/mutt ~/.mutt

# zsh
echo "source ${BASEDIR}/zsh/zshrc" >> ~/.zshrc
