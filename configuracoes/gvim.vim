
" remove todas as parafernalias visuais do gvim
" L - scroll da esquerda
" r - scroll da direita
" T - icones de opcoes(copiar, colar, voltar, bla bla)
set guioptions-=aegimrLtT
set guioptions+=ram

unlet g:airline_theme
color jellybeans
                         
" destaca linha atual do cursor
hi clear CursorLineNr
set cursorline

" desabilita nerdtree ao abrir gvim
let g:nerdtree_tabs_open_on_gui_startup = 0
