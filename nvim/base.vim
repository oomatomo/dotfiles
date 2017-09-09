
" 全角スペースの表示
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=darkgray
match ZenkakuSpace /　/

set tabstop=2 shiftwidth=2 softtabstop=0

" 検索
" 最後まで検索したら先頭へ戻る
set wrapscan
" 大文字小文字無視
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
" インクリメンタルサーチ
set incsearch
" 検索文字をハイライト
set hlsearch
"Escの2回押しでハイライト消去
nmap <ESC><ESC> :nohlsearch<CR><ESC>


