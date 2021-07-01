
if [ -f /etc/zshrc ]; then
    . /etc/zshrc
fi

case ${OSTYPE} in
  # Mac
  darwin*)
    source ~/.oh-my-zsh/custom/custom.darwin
    ;;
  linux*)
    source ~/.oh-my-zsh/custom/custom.linux
    ;;
esac

#-----------------------------------------------------------
# basic
#-----------------------------------------------------------
export EDITOR='vim'
export SVN_EDITOR='vim'
export LANG=ja_JP.UTF-8
export PATH="${PATH}:/usr/local/bin/"

# User specific aliases and functions
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
alias la='ls -la'
alias grep='grep --color=auto -n'
alias rmysql='mysql -u root -p'
alias sudo='nocorrect sudo'
alias tmux='tmux'
alias stmux='ssh-agent tmux -2'
alias ssh='TERM=xterm ssh'

# |

alias V='| vim -R -'
alias G='| grep'
alias L='| less'

# docker
#alias docker='sudo docker'
#alias docrm='sudo docker ps -l -q | xargs sudo docker kill | xargs sudo docker rm'
#alias docip='sudo docker inspect --format "{{ .NetworkSettings.IPAddress }}"'

# svn
alias svndv='svn diff | vim -R -'
function svn_diff_stop_on_copy {
  local revision_by_stop_on_copy=`svn log --stop-on-copy -q --incremental | tail -1 | sed 's/^r\([0-9]\+\).*$/\1/' | tr -d '\n'`
  svn diff -r $revision_by_stop_on_copy:HEAD | vim -R -
}

# rbenv
export PATH="${RBENV_ROOT}/bin:${PATH}"
eval "$(rbenv init -)"

# peco
#function peco-select-history() {
#    local tac
#    if which tac > /dev/null; then
#        tac="tac"
#    else
#        tac="tail -r"
#    fi
#    BUFFER=$(\history -n 1 | \
#        eval $tac | \
#        peco --query "$LBUFFER")
#    CURSOR=$#BUFFER
#    zle clear-screen
#}
#zle -N peco-select-history
#bindkey '^r' peco-select-history

function agvi() {
  vim $(ag $@ | peco --query "$LBUFFER" | awk -F : '{print "-c " $2 " " $1}')
}

function e2sh() {
  # aws-cli, jq, peco
  profile=${1:-default}
  ssh_prefix=${2:-default}
  # Tgas[]? = タグが一つもの存在しないものは除外する
  hosts=(`aws ec2 describe-instances --profile $profile --filter "Name=instance-state-name,Values=running" | \
      jq -r '.Reservations[].Instances[] | .PrivateIpAddress as $p | .Tags[]? | { ip: $p, name: select(.Key == "Name").Value } | flatten | join("\t") ' | \
      sort -t$'\t' -k 2 | peco --query "$LBUFFER" | awk -F '\t' '{print $1}' ` )
  cnt=0
  # 一番上のパネルに移動してsshしていく
  tmux select-pane -t 0
  for host in $hosts; do
    if [[ $cnt -gt 0 ]]; then
      tmux split-window
    fi
    tmux send-keys -t $cnt "ssh $ssh_prefix-$host" C-m
    tmux send-keys -t $cnt "clear" C-m
    ((cnt++))
  done
  tmux select-pane -t 0
  # デザイン修正
  tmux select-layout even-vertical
}

function peco-tmux {
  local f='#{window_index}: #{window_name}#{window_flags} #{pane_current_path}'

  tmux lsw -F "$f" \
      | peco --query "$LBUFFER" \
      | cut -d ':' -f 1 \
      | xargs tmux select-window -t
}

zle -N peco-tmux
bindkey '^et' peco-tmux

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
if [ -f ~/.oh-my-zsh/custom/dircolors.ansi-universal ]; then
    if type dircolors > /dev/null 2>&1; then
        eval $(dircolors ~/.oh-my-zsh/custom/dircolors.ansi-universal)
    elif type gdircolors > /dev/null 2>&1; then
        eval $(gdircolors ~/.oh-my-zsh/custom/dircolors.ansi-universal)
    fi
fi
#export LS_COLORS="di=38;05;21:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:su=37;41:sg=30;43:tw=30;42:ow=34;42:st=37;44:ex=01;32";
zstyle ':completion:*:default*' list- ${(s.:.)LS_COLORS}

local RE=${reset_color}
local W=$fg[white]
local G=$fg[green]
local Y=$fg[yellow]
local R=$fg[red]
local B=$fg[blue]
local C=$fg[cyan]
local M=$fg[magenta]


#-----------------------------------------------------------
# completion
#-----------------------------------------------------------

# 補完オン
autoload -U compinit
compinit

# 選択状態をハイライト表示
zstyle ':completion:*:default' menu select=2

# 一覧表示でグループ化を行う
zstyle ':completion:*' group-name ''
# グループ化での説明を追加出来る %dに説明が入る
zstyle ':completion:*:descriptions' format $'\e[00;34m%d'
zstyle ':completion:*:messages' format $'\e[00;31m%d'

# オプションの補完時のデザイン
zstyle ':completion:*' list-separator '-->'
zstyle ':completion:*:manuals' separate-sections true

# 補完の選択を行うことができる
zstyle ':completion:*:setopt:*' menu true select

#-----------------------------------------------------------
# custom
#-----------------------------------------------------------
source ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
# change color
export AUTOSUGGESTION_HIGHLIGHT_COLOR='fg=10'

# for emacs mode
#function zle-line-init zle-keymap-select {
#  zle autosuggest-start # about zsh-autosuggestions
#}

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
