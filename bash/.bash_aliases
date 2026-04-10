alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -lA'
alias grep='rg --color=auto'
alias vi='vim'
alias nv='nvim'
alias gs='git status'
alias gl='git log'
alias gd='git diff'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'
alias gr='git restore'

ghostty-reload() {
    kill -s USR2 $(pgrep ghostty)
}
term-tp-set() {
    sed -i "s/background-opacity.*$/background-opacity = \"$1\"/" ~/.config/ghostty/config.ghostty && ghostty-reload
}

alias term-tp="term-tp-set 0.95"
alias term-op="term-tp-set 1.0"

