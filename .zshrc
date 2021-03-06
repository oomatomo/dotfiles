
#-----------------------------------------------------------
# SetOpt
#-----------------------------------------------------------
setopt correct
setopt re_match_pcre
setopt prompt_subst
setopt auto_menu
PROMPT="[%n] %3F%~%f%1v
%(?.%{$fg[green]%}.%{$fg[white]%}) %(?.(^o^).(>_<%)) <%{${reset_color}%}"
PROMPT2='[%n]> '
SPROMPT="%{$fg[red]%}%{$suggest%}(*_ _)? < %B%r%b %{$fg[red]%}? [!(y), !(n),a,e]:${reset_color} "

# .zshrc
export SVN_EDITOR='vim'
# User specific aliases and functions
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias la='ls -la'
alias grep='grep --color=auto -n'
alias rmysql='mysql -u root -p'

#tmuxの256色モード
alias tmux='tmux -2'
alias perlv='echo "perl -Mモジュール名 -e print $モジュール名::VERSION"'

export NYTPROF=sigexit=1:file=/tmp/nytprof/nytprof.out
export DBIC_TRACE=1

if [ -f /etc/zshrc ]; then
    . /etc/zshrc
fi
source ~/perl5/perlbrew/etc/bashrc 

# show git branch
fpath=(~/.zsh $fpath)

autoload -U compinit
compinit -u

GIT_PS1_SHOWDIRTYSTATE=true
# show git branch
# VCS settings
autoload -Uz vcs_info
precmd() {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    psvar[1]=$vcs_info_msg_0_
}

# 色設定
autoload -U colors; colors

#
# for Mac
#
export PATH=/usr/local/bin:$PATH
# for Ruby 
export PATH=/usr/local/opt/ruby/bin:$PATH
# for MySQL
export PATH=$PATH:/usr/local/mysql/bin
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
# for perlbrew
source ~/perl5/perlbrew/etc/bashrc
# for rbenv
eval "$(rbenv init -)"
fpath=(/usr/local/share/zsh-completions $fpath)
# zsh-completions
fpath=(~/.zsh-completions $fpath)
