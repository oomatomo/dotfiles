call plug#begin('~/.nvim/plugged')

"スクロールの高速化
Plug 'rhysd/accelerated-jk'
"ステータス行をリッチにする
Plug 'itchyny/lightline.vim'
"カラースキーマ
Plug 'mhartington/oceanic-next'

call plug#end()

"accelerated-jk
let g:accelerated_jk_acceleration_table = [10,5,3]
nmap j <Plug>(accelerated_jk_gj)
nmap k <Plug>(accelerated_jk_gk)

"lightline
set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'fugitive', 'readonly', 'filename', 'modified' ] ],
      \   'right': [ [ 'lineinfo' ],
      \              [ 'percent' ],
      \              [ 'fileformat', 'fileencoding', 'filetype' ],
      \              [ 'syntastic' ] ]
      \ },
      \ 'component_function': {
      \   'fugitive': 'CustomFugitive',
      \   'filename': 'CustomFilename'
      \ },
      \ 'component_type': {
      \   'syntastic': 'error'
      \ }
      \ }

"ブランチをステータスラインに表示する
function! CustomFugitive()
  return exists('*fugitive#head') ? fugitive#head() : ''
endfunction

"変更されたかどうかの判断
function! CustomModified()
  return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction
"ファイルのReadOnlyチェック
function! CustomReadonly()
  return &ft !~? 'help' && &readonly ? 'RO' : ''
endfunction
"ファイルのステータスを表示する
function! CustomFilename()
  return ('' != CustomReadonly() ? CustomReadonly() . ' ' : '') .
        \ ('' != expand('%:F') ? expand('%:F') : '[No Name]') .
        \ ('' != CustomModified() ? ' ' . CustomModified() : '')
endfunction

"カラースキーマを指定
set termguicolors
syntax enable
colorscheme OceanicNext
