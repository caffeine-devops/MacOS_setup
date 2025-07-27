#!/usr/bin/env bash

# Run fastfetch
fastfetch

# Bash completion (brew-installed)
source /opt/homebrew/etc/bash_completion

# History settings
export HISTFILESIZE=10000
export HISTSIZE=500
export HISTTIMEFORMAT="%F %T"
export HISTCONTROL=erasedups:ignoredups:ignorespace
shopt -s checkwinsize
shopt -s histappend
PROMPT_COMMAND='history -a'

# Set up XDG paths
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"

# Disable Ctrl-S terminal freeze
stty -ixon

# Completion behavior
bind "set bell-style visible"
bind "set completion-ignore-case on"
bind "set show-all-if-ambiguous On"

# Editor config
export EDITOR=nvim
export VISUAL=nvim
alias vi='nvim'
alias vim='nvim'
alias svi='sudo nvim'
alias vis='nvim "+set si"'
alias spico='sudo pico'
alias snano='sudo nano'

# Grep
alias grep='rg'

# Basic aliases
alias cls='clear'
alias ll='ls -Fls'
alias la='ls -Alh'
alias cp='cp -i'
alias mv='mv -i'
alias mkdir='mkdir -p'
alias h='history | grep '
alias p='ps aux | grep '
alias da='date "+%d-%m-%Y %A %T %Z"'
alias home='cd ~'
alias ..='cd ..'
alias ...='cd ../..'
alias bd='cd "$OLDPWD"'
alias rmd='rm -rfv'
alias diskspace="du -S | sort -n -r | more"
alias mountedinfo='df -h'
alias multitail='multitail --no-repeat -c'
alias tree='tree -CAhF --dirsfirst'
alias openports='lsof -i -P'
alias whatismyip="ipconfig getifaddr en0 && curl -s ifconfig.me"

# Utility functions
extract() {
  for archive in "$@"; do
    case "$archive" in
      *.tar.bz2) tar xvjf "$archive" ;;
      *.tar.gz)  tar xvzf "$archive" ;;
      *.bz2)     bunzip2 "$archive" ;;
      *.gz)      gunzip "$archive" ;;
      *.tar)     tar xvf "$archive" ;;
      *.zip)     unzip "$archive" ;;
      *.7z)      7z x "$archive" ;;
      *)         echo "Don't know how to extract '$archive'" ;;
    esac
  done
}

ftext() {
  grep -iIHrn --color=always "$1" . | less -r
}

mkdirg() {
  mkdir -p "$1" && cd "$1"
}

up() {
  cd "$(printf '../%.0s' $(seq 1 "$1"))" || return
}

pwdtail() {
  pwd | awk -F/ '{print $(NF-1) "/" $NF}'
}

# PATH
export PATH="$HOME/.local/bin:$HOME/.cargo/bin:/opt/homebrew/bin:$PATH"

# Prompt and tools
eval "$(starship init bash)"
source /opt/homebrew/opt/fzf/shell/key-bindings.bash
[ -f /opt/homebrew/etc/profile.d/autojump.sh ] && . /opt/homebrew/etc/profile.d/autojump.sh

# Reload and edit
alias sbrc='source ~/.bashrc'
alias ebrc='nvim ~/.bashrc'

# yazi y shell weapper
function y() {
        local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
        yazi "$@" --cwd-file="$tmp"
        IFS= read -r -d '' cwd < "$tmp"
        [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
        rm -f -- "$tmp"
}
