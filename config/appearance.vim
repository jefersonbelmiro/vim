
"Habilita coloração por syntax 
syntax enable 

set t_Co=256
set textwidth=110

" 1 - mostra abas somente se tiver 2 arquivos 
" 2 - sempre mostra abas 
set showtabline=1

" Sempre mostra barra de Mensagens 
set laststatus=2

" Formata Barra de Status
"set statusline =%<%f\ \ %h%m%r%Y%=\ \ linha:\ %l,total\ :%L,%c%V\ %P 

if !has("gui_running")                       

  " ---------------------------------------------------------------
  " VIM
  " ---------------------------------------------------------------

  set background=dark
  colorscheme womprat

  let g:airline_theme = 'ubaryd'

  hi StatusLine   ctermfg=0   ctermbg=254 cterm=none
  hi StatusLineNC ctermfg=244 ctermbg=254 cterm=none

  " Remove background das abas
  hi TabLineFill ctermfg=none ctermbg=none cterm=none
  hi TabLine ctermbg=238 cterm=none

  " status line
  hi StatusLineNC ctermbg=238 ctermfg=245 
  hi StatusLine ctermbg=238 ctermfg=251 

  " busca 
  hi Search ctermbg=238 ctermfg=250 cterm=none

else 

  " ---------------------------------------------------------------
  " GVIM
  " ---------------------------------------------------------------

  colorscheme Tomorrow-Night

  " remove todas as parafernalias visuais do gvim
  " L - scroll da esquerda
  " r - scroll da direita
  " T - icones de opcoes(copiar, colar, voltar, bla bla)
  set guioptions-=aegimrLtT
  "set guioptions=amr

  " destaca linha atual do cursor
  hi clear CursorLineNr
  hi CursorLineNr guifg=#999999
  hi clear Search guifg
  hi Search guibg=#444444

  " + - ctrl+c clipboard
  " * - select clipboard
  cnoremap <C-V>      	<C-R>+
  cnoremap <S-Insert>		<C-R>*
  inoremap <S-Insert>		<C-R>*

endif
