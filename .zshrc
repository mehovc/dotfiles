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

#ENV
# ---------------------------------------------------------------------------------------------------------------------------------------------------------------- #

RPS1=""

export EDITOR=micro
 
go env -w GOPROXY="https://goproxy.io,direct"
go env -w GOSUMDB="off"
export GOPATH=$HOME/go

export PATH="/opt/homebrew/opt/postgresql@15/bin:$HOME/.local/bin:$HOME/.DevUtils/:/usr/local/go/bin:$PATH:$HOME/.cargo/bin"
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin

export HOMEBREW_NO_AUTO_UPDATE=1
export PGDATABASE="postgres"
export PGUSER="postgres"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"


export TIMEFMT="%E"

# FUNCTIONS
# ---------------------------------------------------------------------------------------------------------------------------------------------------------------- #
alias history='fc -il 1'
alias clear='clear && printf "\e[3J" clear && printf "\e[3J" && ls'
alias ls="exa --group-directories-first"
alias yt-dlp="yt-dlp --embed-metadata"
alias grep="rg"
alias sz='micro ~/.zshrc && source ~/.zshrc'
alias rm="trash"
alias psql="pgcli"
alias cd="z"
alias bat="bat --paging=never"
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'


function chpwd() {
    emulate -L zsh
    ls
}

function edit {
	open -a "CotEditor" $1
}

function finder {
  open -a Finder "$PWD"
}

function open_finder_widget {
  finder
  zle redisplay
}
zle -N open_finder_widget

bindkey '^F' open_finder_widget

function command_not_found_handler() {
  ~/.DevUtils/shell_method_missing $*
}

rga-fzf() {
	RG_PREFIX="rga --files-with-matches"
	local file
	file="$(
		FZF_DEFAULT_COMMAND="$RG_PREFIX '$1'" \
			fzf --sort --preview="[[ ! -z {} ]] && rga --pretty --context 5 {q} {}" \
				--phony -q "$1" \
				--bind "change:reload:$RG_PREFIX {q}" \
				--preview-window="70%:wrap"
	)" &&
	echo "opening $file" &&
	xdg-open "$file"
}

# START
# ---------------------------------------------------------------------------------------------------------------------------------------------------------------- #
eval $(/opt/homebrew/bin/brew shellenv)
eval "$(pyenv init -)"
eval "$(zoxide init zsh)"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

ls

