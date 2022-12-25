#!/bin/sh

dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

# vim
echo "linking vim config..."
rm ~/.vimrc
ln -s "${dir}/config/vim/vimrc" ~/.vimrc
mkdir -p ~/.vim
rm ~/.vim/coc-settings.json
ln -s "${dir}/config/vim/coc-settings.json" ~/.vim/coc-settings.json

# git
echo "linking git config..."
rm ~/.gitconfig
rm ~/.gitignore
ln -s "${dir}/config/git/gitconfig" ~/.gitconfig
ln -s "${dir}/config/git/gitignore" ~/.gitignore

darwin-rebuild switch --flake "$dir"
