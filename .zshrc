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

# prompt configuration mostly borrowed from oh-my-zsh geoffgarside theme
PROMPT='[%*] %{$fg[cyan]%}%n@%m%{$reset_color%}:%{$fg[green]%}%~%{$reset_color%}$(git_prompt_info) %(!.#.$) '
ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[yellow]%}git:("
ZSH_THEME_GIT_PROMPT_SUFFIX=")%{$reset_color%}"

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
source /usr/local/bin/virtualenvwrapper.sh

# }}}
# Misc {{{

# permit command line editing in the default EDITOR
autoload edit-command-line
zle -N edit-command-line
bindkey '^Xe' edit-command-line

# make gruvbox look pretty in vim
source "$HOME/.vim/bundle/gruvbox/gruvbox_256palette.sh"

# change the default cookiecutter config location
export COOKIECUTTER_CONFIG="$HOME/.config/cookiecutter/cookiecutter.yml"

# }}}

# vim:foldmethod=marker:foldlevel=0
