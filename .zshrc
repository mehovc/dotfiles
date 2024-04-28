# ZSH
# ---------------------------------------------------------------------------------------------------------------------------------------------------------------- #
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="af-magic"
 
HISTFILE=~/.zhistory
SAVEHIST=100000
HISTSIZE=100000
export REPORTTIME=2
export UPDATE_ZSH_DAYS=30

setopt INC_APPEND_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_BEEP
setopt AUTO_LIST
setopt AUTO_RESUME
setopt MULTIOS
setopt NO_CASE_GLOB
setopt CHASE_LINKS

plugins=(git zsh-autosuggestions zsh-syntax-highlighting fzf sudo)

source $ZSH/oh-my-zsh.sh

RPS1=""

#GO
# ---------------------------------------------------------------------------------------------------------------------------------------------------------------- #
 
go env -w GOPROXY="https://goproxy.io,direct"
go env -w GOSUMDB="off"
export GOPATH=$HOME/go

#ENV
# ---------------------------------------------------------------------------------------------------------------------------------------------------------------- #

export EDITOR=micro

export PATH="/opt/homebrew/opt/postgresql@15/bin:$HOME/.local/bin:$HOME/.DevUtils/:/usr/local/go/bin:$PATH:$HOME/.cargo/bin"
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin

export HOMEBREW_NO_AUTO_UPDATE=1
export PGDATABASE="postgres"
export PGUSER="postgres"

export TIMEFMT="%E"

# FUNCTIONS && ALIASES
# ---------------------------------------------------------------------------------------------------------------------------------------------------------------- #
alias history='fc -il 1'
alias clear='clear && printf "\e[3J" clear && printf "\e[3J" && ls'
alias ls="exa --group-directories-first"
alias grep="rg"
alias rm="trash"
alias psql="pgcli"
alias cd="z"
alias bat="bat --paging=never"
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

function chpwd() {
    emulate -L zsh
    ls
}

# EVALS && START
# ---------------------------------------------------------------------------------------------------------------------------------------------------------------- #
eval $(/opt/homebrew/bin/brew shellenv)
eval "$(pyenv init -)"
eval "$(zoxide init zsh)"
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

ls

