#-----------------------------------------------------------
# SetOpt
#-----------------------------------------------------------
setopt correct
setopt re_match_pcre
setopt prompt_subst
setopt auto_menu

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

# 色設定
autoload -U colors; colors

# for perlbrew
source ~/.perl5/perlbrew/etc/bashrc
# for rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
