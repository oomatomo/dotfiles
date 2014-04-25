
#-----------------------------------------------------------
# basic
#-----------------------------------------------------------
export EDITOR='vim'
export SVN_EDITOR='vim'
export LANG=ja_JP.UTF-8

# User specific aliases and functions
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias la='ls -la'
alias grep='grep --color=auto -n'
alias rmysql='mysql -u root -p'
alias sudo='nocorrect sudo'
alias tmux='tmux -2'

alias perlv='echo "perl -MTest::More -e print \$Test::More::VERSION"'

if [ -f /etc/zshrc ]; then
    . /etc/zshrc
fi

# perlbrew
source $HOME/.perl5/etc/bashrc

# rbenv
export LD_LIBRARY_PATH=/usr/local/lib
export RBENV_ROOT="${HOME}/.rbenv"
export PATH="${RBENV_ROOT}/bin:${PATH}"
eval "$(rbenv init -)"

# nodebrew
export PATH=$HOME/.nodebrew/current/bin:$PATH

#-----------------------------------------------------------
# setopt
#-----------------------------------------------------------

setopt auto_menu            # タブで補完候補を表示する
setopt auto_cd              # ディレクトリ名のみ入力時、cdを適応させる
setopt auto_list            # 補完候補が複数ある時に、一覧表示
setopt auto_pushd           # cd実行時、ディレクトリスタックにpushされる
setopt auto_param_keys      # カッコの対応などを自動的に補完
setopt auto_param_slash     # ディレクトリ名の補完で末尾に/を自動的に付加
setopt correct              # コマンドのスペルを訂正する
setopt equals               # =commandを`which command`と同じ処理
setopt globdots             # ドットの指定なしでドットファイルも候補に入る
setopt interactive_comments # コマンドラインでの#以降をコメントと見なす
setopt list_types           # 候補にファイルの種別を表示(ls -F)
setopt list_packed          # 補完結果をできるだけ詰める
setopt no_beep              # ビープ音を鳴らさない
setopt nolistbeep           # 補完候補表示時にビープ音を鳴らさない
setopt no_tify              # バックグランドジョブが終了時知らせてくれる
setopt magic_equal_subst    # 引数での=以降も補完(--prefix=/usrなど)
setopt mark_dirs            # ファイル名の展開でディレクトリにマッチした場合末尾に / を付加する
setopt prompt_subst         # プロンプト定義内で変数置換やコマンド置換を扱う
setopt print_exit_value     # 戻り値が 0 以外の場合終了コードを表示
setopt pushd_ignore_dups    # ディレクトリスタックに重複する物は古い方を削除

#-----------------------------------------------------------
# histroy
#-----------------------------------------------------------
HISTFILE=~/.zsh_history     # ヒストリファイルを指定
HISTSIZE=10000              # ヒストリに保存するコマンド数
SAVEHIST=10000              # ヒストリファイルに保存するコマンド数
#autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
#zle -N up-line-or-beginning-search
#zle -N down-line-or-beginning-search
#bindkey -M viins '^P' up-line-or-beginning-search
#bindkey -M viins '^N' down-line-or-beginning-search
#bindkey -M vicmd 'k' up-line-or-beginning-search
#bindkey -M vicmd 'j' down-line-or-beginning-search

# 履歴のシェルオプション

setopt bang_hist            # !を使った履歴展開を行う(d)
setopt extended_history     # 履歴に実行時間も保存する
setopt hist_ignore_dups     # 直前と同じコマンドは履歴に追加しない
setopt hist_reduce_blanks   # 余分なスペースを削除して履歴に保存する
setopt hist_no_store        # historyコマンドは履歴に登録しない
setopt hist_expand          # 補完時に履歴を自動的に展開
setopt hist_ignore_dups     # 入力したコマンドが直前のものと同一なら履歴に登録しない
setopt hist_save_no_dups    # 古いコマンドと同じものは無視
setopt hist_find_no_dups    # ラインエディタでヒストリ検索し、ヒットし場合重複したものとみなす
setopt hist_ignore_all_dups # 入力したコマンドを履歴に登録する時、同一がすでに存在した場合登録しない
setopt hist_no_functions    # 関数定義のためのコマンドは履歴から削除する
setopt hist_no_store        # 履歴参照のコマンドは履歴に登録しない
setopt hist_reduce_blanks   # コマンド中の余分な空白を削除する
setopt inc_append_history   # 履歴をインクリメンタルに追加
setopt share_history        # 他のシェルのヒストリをリアルタイムで共有する

#-----------------------------------------------------------
# color
#-----------------------------------------------------------
autoload -U colors; colors
eval $(dircolors ~/.oh-my-zsh/custom/dircolors.ansi-universal)
#export LS_COLORS="di=38;05;21:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32";
zstyle ':completion:*:default*' list- ${(s.:.)LS_COLORS}

#-----------------------------------------------------------
# completion
#-----------------------------------------------------------

# 一覧表示でグループ化を行う
zstyle ':completion:*' group-name ''
# グループ化での説明を追加出来る %dに説明が入る
zstyle ':completion:*:descriptions' format 'Completing %d'

# オプションの補完時のデザイン
zstyle ':completion:*' list-separator '-->'
zstyle ':completion:*:manuals' separate-sections true

# 補完の選択を行うことができる
zstyle ':completion:*:setopt:*' menu true select

#-----------------------------------------------------------
# custom
#-----------------------------------------------------------
source ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions/autosuggestions.zsh
# change color
export AUTOSUGGESTION_HIGHLIGHT_COLOR='fg=10'

# for emacs mode
function zle-line-init zle-keymap-select {
  zle autosuggest-start # about zsh-autosuggestions
}

zle -N zle-line-init

# for vi mode
#function zle-line-init zle-keymap-select {
#  VIM_NORMAL="%K{208}%F{black}%k%f%K{208}%F{white} % NORMAL %k%f%K{black}%F{208}%k%f"
#  VIM_INSERT="%K{075}%F{black}%k%f%K{075}%F{white} % INSERT %k%f%K{black}%F{075}%k%f"
#  RPROMPT="${${KEYMAP/vicmd/$VIM_NORMAL}/(main|viins)/$VIM_INSERT}"
#  RPROMPT2=$RPROMPT
#  zle reset-prompt
#  zle autosuggest-start # about zsh-autosuggestions
#}
#
#zle -N zle-line-init
#zle -N zle-keymap-select


#-----------------------------------------------------------
# bindkey
#-----------------------------------------------------------

#bindkey -v # viモード
#
#bindkey -M viins '^k' vi-cmd-mode # ctrl+k

# 補完候補を h j k lで選択できる
zmodload zsh/complist
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

## for zsh-autosuggestions
bindkey '^T' autosuggest-toggle
bindkey '^f' vi-forward-word
bindkey '^f' vi-forward-blank-word
