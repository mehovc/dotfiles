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

#go env -w GOPROXY="https://goproxy.io,direct"
#go env -w GOSUMDB="off"
export GOPATH=$HOME/go

export GOPRIVATE=git.uzum.io*

#ENV
# ---------------------------------------------------------------------------------------------------------------------------------------------------------------- #

eval "$(/opt/homebrew/bin/brew shellenv)"

export EDITOR=micro

export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin
export PATH=$PATH:"$HOME/.DevUtils"
export PATH=$PATH:"$HOME/.local/bin"
export PATH=$PATH:"/usr/local/go/bin"

export HOMEBREW_NO_AUTO_UPDATE=1
export PGDATABASE="postgres"
export PGUSER="postgres"
export PGPASSWORD='postgres'

export AWS_PROFILE=Developer-570318669348

export ZOEKT_URL="http://localhost:6070"

export TIMEFMT="%E"

# FUNCTIONS
# ---------------------------------------------------------------------------------------------------------------------------------------------------------------- #
alias history='fc -il 1'
alias clear='clear && printf "\e[3J" clear && printf "\e[3J" && ls'
alias ls="eza --group-directories-first"
alias grep="rg"
alias cd="z"
alias ctags="`brew --prefix`/bin/ctags"
alias project="cd $(go list -m -e -json | jq -r .Dir)"
alias psql="pgcli"
alias rm="trash"
alias bat="bat --paging=never"
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'

function chpwd() {
    emulate -L zsh
    ls
}

# WORK RELATED
# ---------------------------------------------------------------------------------------------------------------------------------------------------------------- #

get_secrets_dev() {
  SERVICE_NAME=$(echo $1 | tr '-' '_')

  NAMESPACE="dev"

  SECRET_NAME=$(echo $1 | tr '_' '-')
  SECRET_PREFIX="postgres.ufood-${SECRET_NAME}-psql.credentials.postgresql.acid.zalan.do"

  PASSWORD=$(kubectl -n $NAMESPACE get secret $SECRET_PREFIX --template={{.data.password}} | base64 --decode)

  USER=$(kubectl -n $NAMESPACE get secret $SECRET_PREFIX --template={{.data.username}} | base64 --decode)

  HOST="ufood-${SECRET_NAME}-psql-pooler.dev.svc.cluster.local"
  PORT="5432"

  JDBC_URL="jdbc:postgresql://${HOST}:${PORT}/${SERVICE_NAME}?user=${USER}&password=${PASSWORD}"

  printf "%s" "$JDBC_URL" | pbcopy
}

get_secrets_stable() {
  SERVICE_NAME=$(echo $1 | tr '-' '_')

  NAMESPACE="stable"

  SECRET_NAME=$(echo $1 | tr '_' '-')
  SECRET_PREFIX="postgres.ufood-${SECRET_NAME}-psql.credentials.postgresql.acid.zalan.do"

  PASSWORD=$(kubectl -n $NAMESPACE get secret $SECRET_PREFIX --template={{.data.password}} | base64 --decode)

  USER=$(kubectl -n $NAMESPACE get secret $SECRET_PREFIX --template={{.data.username}} | base64 --decode)

  HOST="ufood-${SECRET_NAME}-psql-pooler.stable.svc.cluster.local"
  PORT="5432"

  JDBC_URL="jdbc:postgresql://${HOST}:${PORT}/${SERVICE_NAME}?user=${USER}&password=${PASSWORD}"

  printf "%s" "$JDBC_URL" | pbcopy
}

# START
# ---------------------------------------------------------------------------------------------------------------------------------------------------------------- #
#eval $(/opt/homebrew/bin/brew shellenv)
#eval "$(pyenv init -)"

eval "$(zoxide init zsh)"
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh" || true


ls
