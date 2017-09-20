
"基本設定
"キーマップリーダー
let mapleader = ","
"スクロール時の余白確保
set scrolloff=5
"一行に長い文章を書いていても自動折り返しをしない
set textwidth=0
"他で書き換えられたら自動で読み直す
set autoread
"編集中でも他のファイルを開けるようにする
set hidden
"バックスペースでなんでも消せるように
set backspace=indent,eol,start
"テキスト整形オプション，マルチバイト系を追加
set formatoptions=lmoq
"ビープをならさない
set vb t_vb=
"コマンドをステータス行に表示
set showcmd
"現在のモードを表示
set showmode
"viminfoファイルの設定
set viminfo='50,<1000,s100,\"50
"モードラインは無効
set modelines=0
"vimを使ってくれてありがとう
set notitle
"バックアップ取らない
set nobackup
"スワップファイル作らない
set noswapfile
"ファイルタイプ判定をon
filetype plugin on

"表示設定
"括弧の対応をハイライト
set showmatch
"対応する括弧や部レース「% 」で移動
set matchpairs=(:),{:},[:],<:>
"ウィンドウの幅を超える行の折り返し設定"
set nowrap
"行番号表示
set number
"不可視文字表示
set list
"不可視文字の表示形式
set listchars=tab:>.,trail:_,extends:>,precedes:<
"印字不可能文字を16進数で表示
set display=uhex
"全角スペースの表示
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
match ZenkakuSpace /　/
"カーソル行をハイライト
set cursorline
"コマンド実行中は再描画しない
set lazyredraw
"高速ターミナル接続を行う
set ttyfast

"インデント
"自動でインデント
set autoindent
"新しい行を開始したときに、新しい行のインデントを現在行と同じ量にする。
set smartindent

set tabstop=2 shiftwidth=2 softtabstop=0

if has("autocmd")
  "ファイルタイプの検索を有効にする
  filetype plugin on
  "そのファイルタイプにあわせたインデントを利用する
  filetype indent on
  " これらのftではインデントを無効に
  "autocmd FileType php filetype indent off

  autocmd FileType apache     setlocal sw=4 sts=4 ts=4 et
  autocmd FileType aspvbs     setlocal sw=4 sts=4 ts=4 et
  autocmd FileType c          setlocal sw=4 sts=4 ts=4 et
  autocmd FileType cpp        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType cs         setlocal sw=4 sts=4 ts=4 et
  autocmd FileType css        setlocal sw=2 sts=2 ts=2 et
  autocmd FileType diff       setlocal sw=4 sts=4 ts=4 et
  autocmd FileType eruby      setlocal sw=4 sts=4 ts=4 et
  autocmd FileType html       setlocal sw=2 sts=2 ts=2 et
  autocmd FileType java       setlocal sw=4 sts=4 ts=4 et
  autocmd FileType javascript setlocal sw=2 sts=2 ts=2 et
  autocmd FileType coppffee   setlocal sw=2 sts=2 ts=2 et
  autocmd FileType perl       setlocal sw=2 sts=2 ts=2 et
  autocmd FileType php        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType python     setlocal sw=2 sts=2 ts=2 et
  autocmd FileType ruby       setlocal sw=2 sts=2 ts=2 et
  autocmd FileType haml       setlocal sw=2 sts=2 ts=2 et
  autocmd FileType sh         setlocal sw=2 sts=2 ts=2 et
  autocmd FileType sql        setlocal sw=2 sts=2 ts=2 et
  autocmd FileType vb         setlocal sw=4 sts=4 ts=4 et
  autocmd FileType vim        setlocal sw=2 sts=2 ts=2 et
  autocmd FileType wsh        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType xhtml      setlocal sw=4 sts=4 ts=4 et
  autocmd FileType xml        setlocal sw=4 sts=4 ts=4 et
  autocmd FileType yaml       setlocal sw=2 sts=2 ts=2 et
  autocmd FileType zsh        setlocal sw=2 sts=2 ts=2 et
  autocmd FileType scala      setlocal sw=2 sts=2 ts=2 et
endif

"検索
"最後まで検索したら先頭へ戻る
set wrapscan
"大文字小文字無視
set ignorecase
"検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
"インクリメンタルサーチ
set incsearch
"検索文字をハイライト
set hlsearch
"Escの2回押しでハイライト消去
nmap <ESC><ESC> :nohlsearch<CR><ESC>

"カラー
"カラーの256色対応
if &term =~ "xterm-256color" || "screen-256color"
  " 256色
  set t_Co=256
  set t_Sf=[3%dm
  set t_Sf=[4%dm
elseif &term =~ "xterm-debian" || &term =~ "xterm-xfree86"
  set t_Co=16
  set t_Sf=[3%dm
  set t_Sf=[4%dm
elseif &term =~ "xterm-color"
  set t_Co=8
  set t_Sf=[3%dm
  set t_Sf=[4%dm
endif

"補完と履歴
"コマンド補完を強化
set wildmenu
"コマンド補完を開始するキー
set wildchar=<tab>
"コマンド・検索パターンの履歴数
set history=1000
"補完に辞書ファイル追加
set complete+=k
