call plug#begin('~/.nvim/plugged')

Plug 'rhysd/accelerated-jk'

call plug#end()

"accelerated-jk
let g:accelerated_jk_acceleration_table = [10,5,3]
nmap j <Plug>(accelerated_jk_gj)
nmap k <Plug>(accelerated_jk_gk)
