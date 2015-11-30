PROMPT=$'%{$fg_bold[yellow]%}%n%{$fg_bold[white]%}:%m%{$reset_color%}%{$fg[white]%}@$(date +"%H:%M:%S") $FG[209][%~]%{$reset_color%}\
%{$fg_bold[green]%}→%{$reset_color%} '
RPROMPT='$(git_prompt_info)'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[green]%}["
ZSH_THEME_GIT_PROMPT_SUFFIX="]%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}*%{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""
