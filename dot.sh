#!/bin/bash

BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# vim
rm ~/.vimrc
ln -s ${BASEDIR}/vim/vimrc ~/.vimrc
mkdir -p ~/.vim
rm -r ~/.vim/ftplugin
rm -r ~/.vim/snippets
rm -r ~/.vim/UltiSnips
ln -s ${BASEDIR}/vim/ftplugin ~/.vim/ftplugin
ln -s ${BASEDIR}/vim/snippets ~/.vim/snippets
ln -s ${BASEDIR}/vim/UltiSnips ~/.vim/UltiSnips
cp ${BASEDIR}/vim/autoload/*.* ~/.vim/autoload/
cp ${BASEDIR}/vim/vimrc.lang ~/.vimrc.lang
cp ${BASEDIR}/vim/vimrc.lang.plug ~/.vimrc.lang.plug

# git
rm ~/.gitconfig
rm ~/.gitignore
ln -s ${BASEDIR}/git/gitconfig ~/.gitconfig
ln -s ${BASEDIR}/git/gitignore ~/.gitignore

# tmux
rm ~/.tmux.conf
ln -s ${BASEDIR}/tmux/tmux.conf ~/.tmux.conf

# i3
rm -r ~/.i3
ln -s ${BASEDIR}/i3 ~/.i3

# Xresources
rm ~/.Xresources
ln -s ${BASEDIR}/Xresources ~/.Xresources

# zsh
SOURCE_LINE="source ${BASEDIR}/zsh/zshrc"
grep -q "$SOURCE_LINE" ~/.zshrc || echo "$SOURCE_LINE" >> ~/.zshrc
