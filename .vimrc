"------------------------------------------------------------
"
"------------------------------------------------------------
"row number
set number
"if tab clicked is white space 4
set tabstop=2
set shiftwidth=2
set expandtab
"コマンド補完
set wildmenu
"括弧の対応の表示
set showmatch

"カーソル強制
nnoremap <Left> :echoe "行かせねーよ"<CR>
nnoremap <Right> :echoe "いつから右に行けると思った？"<CR>
nnoremap <Up> :echoe "お前は一生下だ"<CR>
nnoremap <Down> :echoe "おいおいどこへいく？"<CR>

"Tab、行末の半角スペースを明示的に表示する。
set list
set listchars=tab:^\ ,trail:~

"
inoremap <C-d> $
inoremap <C-a> @
inoremap <C-s> %
inoremap {} {}<LEFT>
inoremap [] []<LEFT>
inoremap () ()<LEFT>
inoremap "" ""<LEFT>
inoremap '' ''<LEFT>
inoremap <> <><LEFT>
inoremap %% %%<LEFT>

"Escの2回押しでハイライト消去
nmap <ESC><ESC> ;nohlsearch<CR><ESC>
nmap <Nul> i<Space><ESC>

"tab
nmap <C-c> <ESC>:tabnew<CR><ESC>
nmap <C-n> <ESC>:tabnext<CR><ESC>
nmap <C-p> <ESC>:tabprevious<CR><ESC>

"perltudy
map ,ny <Esc>:%! perltidy -se<CR>
map ,nyv <Esc>:'<,'>! perltidy -se<CR>
"------------------------------------------------------------
"NeoBundle
"------------------------------------------------------------
set nocompatible
filetype off
if has('vim_starting')
    set runtimepath+=~/.vim/neobundle
    call neobundle#rc(expand('~/.vim/bundle'))
endif

"file manager
NeoBundle "https://github.com/Shougo/unite.vim.git"
"Code suport
NeoBundle 'https://github.com/Shougo/neocomplcache.vim.git'
NeoBundle 'https://github.com/Shougo/neosnippet.vim.git'
"Color
NeoBundle 'https://github.com/altercation/vim-colors-solarized.git'
NeoBundle 'https://github.com/tpope/vim-vividchalk.git'
NeoBundle 'https://github.com/Lokaltog/vim-distinguished.git'
NeoBundle 'https://github.com/nanotech/jellybeans.vim.git'
NeoBundle 'https://github.com/vim-scripts/candy.vim.git'
NeoBundle 'https://github.com/dandorman/vim-colors.git'
NeoBundle 'https://github.com/jpo/vim-railscasts-theme.git'

"zencoding
NeoBundle 'https://github.com/mattn/zencoding-vim.git'
"quickrun
NeoBundle 'https://github.com/thinca/vim-quickrun.git'
"file
NeoBundle 'https://github.com/wesleyche/SrcExpl.git'
NeoBundle 'https://github.com/wesleyche/Trinity.git'
NeoBundle 'https://github.com/vim-scripts/taglist.vim.git'
"file
NeoBundle 'https://github.com/scrooloose/nerdtree.git'

"html , js syntack
"javascript auto indent
NeoBundle 'https://github.com/pangloss/vim-javascript'
"syntastic make command
NeoBundle 'https://github.com/scrooloose/syntastic.git'
"syntastic
NeoBundle 'https://github.com/jelera/vim-javascript-syntax.git'
"補完
NeoBundle 'https://github.com/teramako/jscomplete-vim.git'

"code align
NeoBundle 'https://github.com/vim-scripts/Align.git'
"git
NeoBundle 'https://github.com/tpope/vim-fugitive.git'
NeoBundle 'https://github.com/gregsexton/gitv.git'

"browser
NeoBundle 'https://github.com/tyru/open-browser.vim.git'

"font
NeoBundle 'https://github.com/vim-scripts/fontzoom.vim.git'

"lightline
NeoBundle 'https://github.com/itchyny/lightline.vim.git'

"powerline
NeoBundle 'https://github.com/Lokaltog/powerline.git', { 'rtp' : 'powerline/bindings/vim'}
NeoBundle 'https://github.com/taichouchou2/alpaca_powertabline.git'

"Unite thema
NeoBundle 'https://github.com/osyo-manga/vim-powerline-unite-theme.git'

"非同期処理
NeoBundle 'https://github.com/Shougo/vimproc.vim.git', {
      \ 'build' : {
      \     'windows' : 'make -f make_mingw32.mak',
      \     'cygwin' : 'make -f make_cygwin.mak',
      \     'mac' : 'make -f make_mac.mak',
      \     'unix' : 'make -f make_unix.mak',
      \    },
      \ }

filetype plugin indent on

""------------------------------------------------------------
"neocomplcache
"------------------------------------------------------------
let g:neocomplcache_enable_at_startup = 1

let g:neocomplcache_ctags_arguments_list = {
    \ 'perl' : '-R -h ".pm"',
    \ }
" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
	\ 'default'    : '',
	\ 'perl'       : $HOME . '/.vim/dict/perl.dict',
    \ 'javascript' : $HOME . '/.vim/dict/javascript.dict',
    \ 'html'       : $HOME . '/.vim/dict/javascript.dict'
    \ }
" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
     let g:neocomplcache_keyword_patterns = {}
endif
     let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

"------------------------------------------------------------
"neosnippet
"------------------------------------------------------------
" Plugin key-mappings.
imap <C-k>    <Plug>(neosnippet_expand_or_jump)
smap <C-k>    <Plug>(neosnippet_expand_or_jump)
" For snippet_complete marker.
if has('conceal')
	set conceallevel=2 concealcursor=i
endif
" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/.vim/snippets'

"------------------------------------------------------------
"molokai
"------------------------------------------------------------
syntax on
set t_Co=256
let g:solarized_termtrans=1
color Zenburn

"------------------------------------------------------------
"Zencoding <C-y> and [,] 
"------------------------------------------------------------
let g:user_zen_settings = { 'indentation':'    ' }

"------------------------------------------------------------
"unite.vim 
"------------------------------------------------------------
" 入力モードで開始する
" let g:unite_enable_start_insert=1
" バッファ一覧
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
" ファイル一覧
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" レジスタ一覧
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
" 最近使用したファイル一覧
nnoremap <silent> ,um :<C-u>Unite file_mru<CR>
" 常用セット
nnoremap <silent> ,uu :<C-u>Unite buffer file_mru<CR>
" 全部乗せ
nnoremap <silent> ,ua :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>

" ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
" ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> q
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>q

"テーマ適用
let g:Powerline_theme="unite_status"
let g:Powerline_colorscheme="unite_status"

"------------------------------------------------------------
"taglist
"------------------------------------------------------------
let Tlist_Show_One_File = 1
let Tlist_Use_Right_Window = 1
let Tlist_Exit_OnlyWindow = 1

"------------------------------------------------------------
"Srcexpl
"------------------------------------------------------------
let g:SrcExpl_UpdateTags = 1

"------------------------------------------------------------
"vim-fugitive 
"------------------------------------------------------------
"statuslinenにbranch 表示

"------------------------------------------------------------
"NERDTreeToggle 
"------------------------------------------------------------
nmap <silent> nd :NERDTreeToggle<Enter>

"------------------------------------------------------------
"syntastic
"------------------------------------------------------------

" syntastic
 let g:syntastic_mode_map = { 'mode': 'active',
   \ 'active_filetypes': [],
   \ 'passive_filetypes': ['html', 'javascript'] }
   let g:syntastic_javascript_checker = 'gjslint'

"------------------------------------------------------------
"open browser
"------------------------------------------------------------
let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)

"------------------------------------------------------------
"javascript
"------------------------------------------------------------
let g:html_indent_inctags = "html,body,head,tbody"
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"

"------------------------------------------------------------
"gjslint
"------------------------------------------------------------
"autocmd FileType javascript :compiler gjslint
"autocmd QuickfixCmdPost make copen

"------------------------------------------------------------
"jscomplete-vim
"------------------------------------------------------------
autocmd FileType javascript setlocal omnifunc=jscomplete#CompleteJS
autocmd FileType html setlocal omnifunc=jscomplete#CompleteJS
let g:jscomplete_use = ['dom', 'moz', 'es6th']

"------------------------------------------------------------
"vim-javascript-syntax
"------------------------------------------------------------
au FileType javascript call JavaScriptFold()
au FileType html call JavaScriptFold()

"------------------------------------------------------------
"vim-javascript-syntax
"------------------------------------------------------------
vnoremap <silent> => :Align @1 =><CR>
vnoremap <silent> = :Align @1 =<CR>
vnoremap <silent> == =

"------------------------------------------------------------
"powerline
"------------------------------------------------------------
set laststatus=2
let g:Powerline_symbols = 'fancy'
"lightline
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ }

"------------------------------------------------------------
"ColorRoller
"------------------------------------------------------------
let ColorRoller = {}
let ColorRoller.colors = [
      \ 'molokai',
      \ 'vividchalk',
      \ 'distinguished',
      \ 'jellybeans',
      \ 'Mustang',
      \ 'Zenburn',
      \ 'Wombat',
      \ 'Tomorrow',
      \ 'github',
      \ 'grb256',
      \ 'ir_black',
      \ 'railscasts',
      \ 'twilight',
      \ ]

function! ColorRoller.change()
  let color = get(self.colors, 0)
  silent exe "colorscheme " . color
  redraw
  echo self.colors
endfunction

function! ColorRoller.roll()
  let item = remove(self.colors, 0)
  call insert(self.colors, item, len(self.colors))
  call self.change()
endfunction

function! ColorRoller.unroll()
  let item = remove(self.colors, -1)
  call insert(self.colors, item, 0)
  call self.change()
endfunction

nnoremap <silent><S-C>   :<C-u>call ColorRoller.roll()<CR>
nnoremap <silent><S-F9> :<C-u>call ColorRoller.unroll()<CR>


"------------------------------------------------------------
"文字コード
"------------------------------------------------------------

"------------------------------------------------------------
" 日本語対応のための設定:
"------------------------------------------------------------
" 文字コードの自動認識
" from http://www.kawaz.jp/pukiwiki/?vim#cb691f26
if !(has('win32'))
  set termencoding=utf-8
  set encoding=utf-8
  set fileencoding=utf-8
  set fileencodings=utf-8,cp932
endif

if &encoding !=# 'utf-8'
  set encoding=japan
  set fileencoding=japan
endif
if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  " iconvがeucJP-msに対応しているかをチェック
  if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'eucjp-ms'
    let s:enc_jis = 'iso-2022-jp-3'
  " iconvがJISX0213に対応しているかをチェック
  elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
  " fileencodingsを構築
  if &encoding ==# 'utf-8'
    let s:fileencodings_default = &fileencodings

    " from http://d.hatena.ne.jp/heavenshell/20080105/1199536148
    if !(has('win32'))
      let &fileencodings = s:enc_jis .','. s:enc_euc
      let &fileencodings = &fileencodings .','. s:fileencodings_default
    else
      let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
      let &fileencodings = &fileencodings .','. s:fileencodings_default
    endif

    unlet s:fileencodings_default
  else
    let &fileencodings = &fileencodings .','. s:enc_jis
    set fileencodings+=utf-8,ucs-2le,ucs-2
    if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
      set fileencodings+=cp932
      set fileencodings-=euc-jp
      set fileencodings-=euc-jisx0213
      set fileencodings-=eucjp-ms
      let &encoding = s:enc_euc
      let &fileencoding = s:enc_euc
    else
      let &fileencodings = &fileencodings .','. s:enc_euc
    endif
  endif
  " 定数を処分
  unlet s:enc_euc
  unlet s:enc_jis
endif
" 日本語を含まない場合は fileencoding に encoding を使うようにする
if has('autocmd')
  func! AU_ReCheck_FENC()
    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
      let &fileencoding=&encoding
    endif
  endf
  autocmd BufReadPost * call AU_ReCheck_FENC()
endif
" 改行コードの自動認識
set fileformats=unix,dos,mac
" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
  set ambiwidth=double
endif


" メッセージを日本語にする (Windowsでは自動的に判断・設定されている)
if !(has('win32') || has('mac')) && has('multi_lang')
  if !exists('$LANG') || $LANG.'X' ==# 'X'
    if !exists('$LC_CTYPE') || $LC_CTYPE.'X' ==# 'X'
      language ctype ja_JP.eucJP
    endif
    if !exists('$LC_MESSAGES') || $LC_MESSAGES.'X' ==# 'X'
      language messages ja_JP.eucJP
    endif
  endif
endif

" for utf8
set encoding=utf-8
set fileencodings=iso-2022-jp,cp932,euc-jp,utf-8,ucs-2le,ucs-2

" ファイルを開くとき、改行コードを指定。
set ff=unix

" 改行コードと文字コードを取得
func! GetStatusEx()
let str = ''
let str = str . '' . &fileformat . ''
if has('multi_byte') && &fileencoding != ''
    let str = '' . &fileencoding . '' . str . ''
endif
return str
endf


"------------------------------------------------------------
"vim statusline
"------------------------------------------------------------
"set laststatus=2
"
"set statusline+=%F    " バッファ内のファイルのフルパス
"set statusline+=%=    " 左寄せ項目と右寄せ項目の区切り
"set statusline+=%1l   " 何行目にカーソルがあるか
"set statusline+=- 
"set statusline+=%L    " バッファ内の総行数
"set statusline+=,
"set statusline+=%c   " 何列目にカーソルがあるか
"set statusline+=--
"set statusline+=%V    " 画面上の何列目にカーソルがあるか
"set statusline+=%P    " ファイル内の何％の位置にあるか
"
"set statusline+=%{fugitive#statusline()} " Gitのブランチ名を表示
"set statusline+=%y%{GetStatusEx()} " ステータスラインに改行コードと文字コードを表示
"
"set statusline+=\ \ 
"

"------------------------------------------------------------
" load_or remove chef_dict
"------------------------------------------------------------
command ChefDicAdd set dictionary+=~/.vim/dict/opscode_chef.dict/*.dict
command ChefDicRem set dictionary-=~/.vim/dict/opscode_chef.dict/*.dict
