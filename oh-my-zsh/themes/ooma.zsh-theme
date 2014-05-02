# color
RE=${reset_color}
W=$fg[white]
G=$fg[green]
Y=$fg[yellow]
R=$fg[red]
B=$fg[blue]
C=$fg[cyan]
M=$fg[magenta]

local git_branch='$(git_prompt_info)%{$RE%}$(custom_git_prompt_status)%{$RE%}$(custom_git_remote_status)%{$RE%}'

local perl_v='%{$RE%}%{$G%}$(get_perlbrew_list)%{$RE%}'

PROMPT="[%n] %{$Y%}%3F%~%f ${git_branch} %{$C%}bg:%{$R%}%j %{$C%}perl:${perl_v} %{$C%}ruby:%{$M%}$( rbenv_prompt_info )
%(?.%{$G%}.%{$W%})%(?!(*'-') <!(*;-;%)? <)%{$RE%}"

PROMPT2='[%n]> '

SPROMPT="%{$R%}%{$suggest%}(*'~'%)? < %B%r%b %{$R%}? [!(y), !(n),a,e]:$RE "

get_perlbrew_list(){
  STATUS=''
  if $(which perlbrew &> /dev/null);then
    LIB=$(perlbrew list 2> /dev/null | grep '*' | sed -e 's/.*perl-//')
    echo $LIB
  fi
}

ZSH_THEME_GIT_PROMPT_PREFIX="-[git]:%{$M%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$RE%}"

ZSH_THEME_GIT_PROMPT_DIRTY="%{$RE%}:%{$R%}(-_-)%{$RE%} "
ZSH_THEME_GIT_PROMPT_CLEAN="%{$RE%}:%{$G%}(^_^)"

ZSH_THEME_GIT_PROMPT_STAGED_PREFIX="%{$G%}["
ZSH_THEME_GIT_PROMPT_STAGED_SUFFIX=" ]%{$RE%}"
ZSH_THEME_GIT_PROMPT_STAGED_ADDED=" A"
ZSH_THEME_GIT_PROMPT_STAGED_MODIFIED=" M"
ZSH_THEME_GIT_PROMPT_STAGED_RENAMED=" R"
ZSH_THEME_GIT_PROMPT_STAGED_DELETED=" D"

ZSH_THEME_GIT_PROMPT_UNSTAGED_PREFIX="%{$Y%}["
ZSH_THEME_GIT_PROMPT_UNSTAGED_SUFFIX=" ]%{$RE%}"
ZSH_THEME_GIT_PROMPT_MODIFIED=" M"
ZSH_THEME_GIT_PROMPT_DELETED=" D"

ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$C%}??"
ZSH_THEME_GIT_PROMPT_STASHED="%{$G%}ST"
ZSH_THEME_GIT_PROMPT_UNMERGED=" N"

custom_git_prompt_status() {
  #INDEX=$(command git status --porcelain -b 2> /dev/null)
  # for git version 1.7.1
  INDEX=$(command git status --porcelain 2> /dev/null)
  STATUS=""
  if COUNT=$(echo "$INDEX" &> /dev/null | grep -E '^\?\? ' -c ) && [ $COUNT -gt 0 ]; then
    STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_UNTRACKED$COUNT"
  fi

  # Staged
  STAGED=""
  if COUNT=$(echo "$INDEX" &> /dev/null | grep '^A  ' -c ) && [ $COUNT -gt 0 ]; then
    STAGED="$STAGED$ZSH_THEME_GIT_PROMPT_STAGED_ADDED$COUNT"
  fi
  if COUNT=$(echo "$INDEX" &> /dev/null | grep '^M  ' -c ) && [ $COUNT -gt 0 ]; then
    STAGED="$STAGED$ZSH_THEME_GIT_PROMPT_STAGED_MODIFIED$COUNT"
  fi
  if COUNT=$(echo "$INDEX" &> /dev/null | grep '^R  ' -c ) && [ $COUNT -gt 0 ]; then
    STAGED="$STAGED$ZSH_THEME_GIT_PROMPT_STAGED_RENAMED$COUNT"
  fi
  if COUNT=$(echo "$INDEX" &> /dev/null | grep '^D  ' -c ) && [ $COUNT -gt 0 ]; then
    STAGED="$STAGED$ZSH_THEME_GIT_PROMPT_STAGED_DELETED$COUNT"
  fi

  if [ "$STAGED" != "" ];then
    STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_STAGED_PREFIX$STAGED$ZSH_THEME_GIT_PROMPT_STAGED_SUFFIX"
  fi

  # Unstaged
  UNSTAGED=""
  if COUNT=$(echo "$INDEX" &> /dev/null | grep '^AM \|^ T \|^ M ' -c ) && [ $COUNT -gt 0 ]; then
    UNSTAGED="$UNSTAGED$ZSH_THEME_GIT_PROMPT_MODIFIED$COUNT"
  fi
  if COUNT=$(echo "$INDEX" &> /dev/null | grep '^AD ' -c ) && [ $COUNT -gt 0 ]; then
    UNSTAGED="$UNSTAGED$ZSH_THEME_GIT_PROMPT_DELETED$COUNT"
  fi

  if [ "$UNSTAGED" != "" ];then
    STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_UNSTAGED_PREFIX$UNSTAGED$ZSH_THEME_GIT_PROMPT_UNSTAGED_SUFFIX"
  fi

  if $(command git rev-parse --verify refs/stash >/dev/null 2>&1); then
    STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_STASHED"
  fi
  if $(echo "$INDEX" | grep '^UU ' &> /dev/null); then
    STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_UNMERGED"
  fi
  if $(echo "$INDEX" | grep '^## .*ahead' &> /dev/null); then
    STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_AHEAD"
  fi
  if $(echo "$INDEX" | grep '^## .*behind' &> /dev/null); then
    STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_BEHIND"
  fi
  if $(echo "$INDEX" | grep '^## .*diverged' &> /dev/null); then
    STATUS="$STATUS$ZSH_THEME_GIT_PROMPT_DIVERGED"
  fi

  echo $STATUS
}

ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE=" %{$G%}<-"
ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE=" %{$M%}->"
ZSH_THEME_GIT_PROMPT_DIVERGED_REMOTE=">><<"

custom_git_remote_status() {
  remote=${$(command git rev-parse --verify ${hook_com[branch]}@{upstream} --symbolic-full-name 2>/dev/null)/refs\/remotes\/}
  if [ -n ${remote} ] ; then
    ahead=$(command git rev-list ${hook_com[branch]}@{upstream}..HEAD 2>/dev/null | wc -l)
    behind=$(command git rev-list HEAD..${hook_com[branch]}@{upstream} 2>/dev/null | wc -l)

    if [ $ahead -eq 0 ] && [ $behind -gt 0 ]
    then
      echo "$ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE$behind"
    elif [ $ahead -gt 0 ] && [ $behind -eq 0 ]
    then
      echo "$ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE$ahead"
    elif [ $ahead -gt 0 ] && [ $behind -gt 0 ]
    then
      echo "$ZSH_THEME_GIT_PROMPT_DIVERGED_REMOTE"
    fi
  fi
}
