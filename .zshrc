###############################################################################
#               _                
#     ____ ___ | |__   _ __  ___ 
#    |_  // __|| '_ \ | '__|/ __|
#  _  / / \__ \| | | || |  | (__ 
# (_)/___||___/|_| |_||_|   \___|
#                                
###############################################################################
# Oh My Zsh {{{

ZSH=$HOME/.oh-my-zsh

# source aliases from ~/.zsh_aliases
source ~/.zsh_aliases

# source functions from ~/.zsh_functions
source ~/.zsh_functions

# use sane history stamps
HIST_STAMPS="yyyy-mm-dd"

# use oh-my-zsh and some of its plugins
plugins=(git)
source $ZSH/oh-my-zsh.sh

# don't AUTO_CD, 'cuz it's lame
unsetopt AUTO_CD

# }}}
# Prompt {{{

# define prompt expansions
PROMPT='[%*]$(venv_info) %F{cyan}%n@%m%f:%F{green}%~%f$(git_prompt_info) § '
NORMAL_PROMPT="${PROMPT}"
VI_PROMPT=${PROMPT/'§'/'%{%F{125}%}§%f'}
ZSH_THEME_VENV_PROMPT_PREFIX=" %F{105}venv:("
ZSH_THEME_VENV_PROMPT_SUFFIX=")%f"
ZSH_THEME_GIT_PROMPT_PREFIX=" %F{yellow}git:("
ZSH_THEME_GIT_PROMPT_SUFFIX=")%f"

# }}}
# Environment Variables {{{

# all your binaries are belong to my PATH
export PATH="/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin:$HOME/.local/bin"

# set preferred EDITOR to vim
export EDITOR='vim'

# keep it secret, keep it safe https://j.mp/1Mrj1op
source $HOME/.secrets

# }}}
# Language-Specific Configuration {{{

# make Go go
export GOROOT="$HOME/.local/go"
export GOPATH="$HOME/Projects/go"
export PATH="$PATH:$GOROOT/bin:$GOPATH/bin"

# make Rust rusty
source "$HOME/.cargo/env"

# make virtualenvwrapper work
export VIRTUALENVWRAPPER_PYTHON="$(which python3)"
export WORKON_HOME="$HOME/.virtualenvs"
source $(which virtualenvwrapper.sh)

# make poetry poetic
export PATH="$HOME/.poetry/bin:$PATH"

# make volta electric
export VOLTA_HOME="$HOME/.volta"
[ -s "$VOLTA_HOME/load.sh" ] && . "$VOLTA_HOME/load.sh"

export PATH="$VOLTA_HOME/bin:$PATH"

# }}}
# Line Editing {{{

# An enormous thank you to Doug Black for their excellent vi-mode blog post!
# https://dougblack.io/words/zsh-vi-mode.html

# use vi-mode for line editing
bindkey -v

# use ctrl-p and ctrl-n to cycle history
bindkey '^P' up-history
bindkey '^N' down-history

# use hjkl to navigate tab completion
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history

# retain shift-tab as reverse menu completion
bindkey -M menuselect '^[[Z' reverse-menu-complete

# make backspace and ctrl-h work even after returning from command mode
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char

# use ctrl-w to remove words backwards
bindkey '^w' backward-kill-word

# use ctrl-r for reverse history search
bindkey '^r' history-incremental-search-backward

# use ctrl-e to edit the current line in the default $EDITOR
autoload edit-command-line
zle -N edit-command-line
bindkey '^e' edit-command-line

# switch between normal and vi-mode prompt when changing keymaps
function zle-line-init zle-keymap-select {
    PROMPT="${${KEYMAP/vicmd/$VI_PROMPT}/(main|viins)/${NORMAL_PROMPT}}"
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

# use a mode change delay of 0.1s
export KEYTIMEOUT=1

# }}}

# vim:foldmethod=marker:foldlevel=0
