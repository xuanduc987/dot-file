#!/bin/sh

dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

# vim
echo "linking vim config..."
rm ~/.vimrc
ln -s "${dir}/config/vim/vimrc" ~/.vimrc
mkdir -p ~/.vim
rm ~/.vim/coc-settings.json
ln -s "${dir}/config/vim/coc-settings.json" ~/.vim/coc-settings.json
rm ~/.vim/compiler
ln -s "${dir}/config/vim/compiler" ~/.vim/compiler

# git
echo "linking git config..."
rm ~/.gitconfig
rm ~/.gitignore
ln -s "${dir}/config/git/gitconfig" ~/.gitconfig
ln -s "${dir}/config/git/gitignore" ~/.gitignore

# kitty
echo "linking kitty config..."
mkdir -p ~/.config/kitty
rm ~/.config/kitty/kitty.conf
ln -s "${dir}/config/kitty/kitty.conf" ~/.config/kitty/kitty.conf

# direnv
echo "linking direnv config..."
rm ~/.direnvrc
ln -s "${dir}/config/direnv/direnvrc" ~/.direnvrc

darwin-rebuild switch --flake "$dir"
