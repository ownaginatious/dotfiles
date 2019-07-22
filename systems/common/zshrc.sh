export EDITOR="vim"

setopt auto_cd  # Try interpreting the command as a directory if it doesn't exist.
setopt multios

# History settings
export HISTFILE=~/.zsh_history
export HISTSIZE=999999999
export SAVEHIST=$HISTSIZE
setopt share_history

bindkey -v # use vim key bindings
bindkey '^R' history-incremental-search-backward

# Redefine FG and BG for all terminals so we can add *all* the colours.
typeset -AHg FG BG

autoload -U colors && colors
for color in {000..255}; do
    FG[$color]="%{[38;5;${color}m%}"
    BG[$color]="%{[48;5;${color}m%}"
done

# Awesome module for batch renaming files.
autoload -U zmv

function git_current_branch() {
  local ref
  ref=$(command git symbolic-ref --quiet HEAD 2> /dev/null)
  local ret=$?
  if [[ $ret != 0 ]]; then
    [[ $ret == 128 ]] && return  # no git repo.
    ref=$(command git rev-parse --short HEAD 2> /dev/null) || return
  fi
  echo ${ref#refs/heads/}
}

function git_check_dirty () {
  local STATUS=''
  local -a FLAGS
  FLAGS=('--porcelain')
  if [[ $POST_1_7_2_GIT -gt 0 ]]
  then
    FLAGS+='--ignore-submodules=dirty'
  fi
  if [[ "$DISABLE_UNTRACKED_FILES_DIRTY" == "true" ]]
  then
    FLAGS+='--untracked-files=no'
  fi
  STATUS=$(command git status ${FLAGS} 2> /dev/null | tail -n1)
  if [[ -n $STATUS ]]
  then
    echo " %{$fg[red]%}*%{$fg[green]%}"
  else
    echo ""
  fi
}

function git_prompt_info () {
  local branch
  branch=$(git_current_branch)
  if [ ! -z "${branch}" ]; then
    echo "%{$fg_bold[green]%}[${branch}$(git_check_dirty)]%{$reset_color%}"
  fi
}

setopt prompt_subst  # allow zsh evaluation and expansion within the prompt string
PROMPT='%{$fg_bold[yellow]%}%n%{$fg_bold[white]%}:%m%{$reset_color%}%{$fg[white]%}@$(date +"%H:%M:%S") $FG[209][%~]%{$reset_color%}  
%{$fg_bold[green]%}→%{$reset_color%} '
RPROMPT='$(git_prompt_info)'

if [[ "$(uname -s)" =~ 'Darwin.*' ]]; then
  alias ls='ls -G'
else
  alias ls='ls --color=auto'
fi

alias lsa='ls -a'

# Git aliases
alias ga="git add"
alias gr="git rm -r"
alias gd="git diff"
alias gpl="git pull origin \$(git_current_branch)"
alias gps="git push origin \$(git_current_branch)"
alias gst="git status"
alias gm="git checkout master"
alias gmu="_b=\$(git_current_branch); gm; gpl; git checkout \${_b}"
alias gmub="gmu; gm; git checkout -b"
alias gb="git branch"
alias gbm="git branch -m"
alias gbd="git branch -D"
alias gl="git log"
alias gcm="git commit -m "
alias gca="git commit --amend"
alias dd="dd status=progress "

# Update config

function dot-sync {
  ~/.dotfiles/install.sh "$@"
}

function dot-update {
  pushd ~/.dotfiles > /dev/null
  gmu
  dot-sync "$@"
  popd > /dev/null
}

# Example aliases
alias reloadzsh=". ~/.zshrc && echo 'ZSH config reloaded from ~/.zshrc'"

# Load any extra custom configuration for this machine.
if [ -d ~/.zshrc-extras ]; then
  find -L ~/.zshrc-extras -type f | while read file
  do
    source "$file"
  done
fi
