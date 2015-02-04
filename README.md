## Install janus
```
curl -Lo- https://bit.ly/janus-bootstrap | bash
```

For more information go to janus [repo](http://github.com/carlhuda/janus)

## Additional plugins
[Vim-ruby](https://github.com/vim-ruby/vim-ruby.git)
[Lightline](https://github.com/itchyny/lightline.vim)

## Notice when use base16 theme
Have to install
[base16-shell](https://github.com/chriskempson/base16-shell) if use
gnome-terminal or iTerms or urxvt

### Installation
```
git clone https://github.com/chriskempson/base16-shell.git \
~/.config/base16-shell
```

### Bash/Zsh
```
# Base16 Shell
BASE16_SHELL="$HOME/.config/base16-shell/base16-default.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL
```

## For ubuntu
Install urxvt: package rxvt-unicode-256color
[base16-color-xresources](https://github.com/chriskempson/base16-xresources)
