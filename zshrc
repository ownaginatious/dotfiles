export PATH="/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/sbin:/sbin:/usr/lib/jvm/default/bin:/bin"
export GOPATH="$HOME/git/.go/"
export EDITOR="vim"

venvwrapper_bin="$(command -v virtualenvwrapper.sh)"
if [ ! -z "${venvwrapper_bin}" ]
then
  # Location of virtualenvs for virtualenvwrapper.
  export WORKON_HOME=~/.virtualenvs
  source "${venvwrapper_bin}"
fi

setopt auto_cd  # Try interpreting the command as a directory if it doesn't exist.
setopt multios

# History settings
export HISTFILE=~/.zsh_history
export HISTSIZE=999999999
export SAVEHIST=$HISTSIZE
setopt share_history

bindkey -e # use emacs key bindings
# fix the "delete" button with ZSH
bindkey "^[[3~" delete-char

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

# Example aliases
alias zshconfig="vim ~/.zshrc"
alias reloadzsh=". ~/.zshrc && echo 'ZSH config reloaded from ~/.zshrc'"
alias dot-update="~/.dotfiles/install && reloadzsh"
alias dot-upgrade="cd ~/.dotfiles && git pull && cd - && dot-update"
alias archupdate="yay -Syu"
alias nano="vim" # ... it's for my own good

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
alias gbr="git branch -m"
alias gbd="git branch -d"
alias gbdf="git branch -D"
alias gl="git log"
alias gcm="git commit -m "

if [ -z "$(command -v memento)" ] && [ -z "$SSH_CLIENT" ] && [ -z "$SSH_TTY" ]; then
  # Evaluate SSH keys once and only once.
  eval $(keychain --eval --quiet ~/.ssh/id_rsa)
fi

