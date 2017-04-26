# git
alias g='git'
alias ga='git add'
alias gb='git branch'
alias gc='git commit -v'
alias gc!='git commit -v --amend'
alias gca='git commit -v -a'
alias gca!='git commit -v -a --amend'
alias gcan!='git commit -v -a --no-edit --amend'
alias gcb='git checkout -b'
alias gcm='git checkout master'
alias gco='git checkout'
alias gd='git diff'
alias gdca='git diff --cached'
alias gf='git fetch'
alias gfo='git fetch origin'
alias gignore='git update-index --assume-unchanged'
alias gl='git pull'
alias glg='git log --stat'
alias gp='git push'
alias gr='git remote'
alias gst='git status'
alias gsta='git stash save'
alias gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify -m "--wip-- [skip ci]"'

###

alias ls="ls --color=tty"
alias :q="exit"

alias zshrc="vim ~/.zshrc"
alias vimrc="vim ~/.vimrc"
alias vimrcl="vim ~/.vimrc.local"

alias be="bundle exec"
