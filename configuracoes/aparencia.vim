
syntax enable                   "Habilita coloração por syntax
set t_Co               =256
set textwidth          =110

set showtabline        =2
" Sempre mostra barra de Mensagens 
set laststatus         =2

" Formata Barra de Status
"set statusline         =%<%f\ \ %h%m%r%Y%=\www.dbseller.com.br\ linha:\ %l,total\ :%L,%c%V\ %P 
"set statusline         =%<%f\ \ %h%m%r%Y\ \ \%{tagbar#currenttag('%s','','sf')}\%=\ \ linha:\ %l,total\ :%L,%c%V\ %P 
set statusline =%<%f\ \ %h%m%r%Y%=\ \ linha:\ %l,total\ :%L,%c%V\ %P 
"set cursorline                                         " destaca linha  atual
"set cursorcolumn                                       " destaca coluna atual
set number

let g:tagbar_width = 25
let g:tagbar_autofocus = 1
let g:tagbar_compact = 1
let g:tagbar_foldlevel = 1
let g:tagbar_autoshowtag = 1
let g:tagbar_type_php = {
\ 'ctagstype' : 'php',
\ 'kinds' : [
\ 'i:interfaces',
\ 'c:classes',
\ 'd:constant definitions',
\ 'f:functions',
\ 'j:javascript functions:1'
\ ]
\ }
