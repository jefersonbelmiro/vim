
" remove todas as parafernalias visuais do gvim
" L - scroll da esquerda
" r - scroll da direita
" T - icones de opcoes(copiar, colar, voltar, bla bla)
set guioptions-=aegimrLtT
set guioptions=amr

" unlet g:airline_theme
colorscheme Tomorrow-Night
                         
" destaca linha atual do cursor
hi clear CursorLineNr
hi CursorLineNr guifg=#999999
hi clear Search guifg
hi Search guibg=#444444
" set cursorline

" desabilita nerdtree ao abrir gvim
let g:nerdtree_tabs_open_on_gui_startup = 0

" + - ctrl+c clipboard
" * - select clipboard
cnoremap <C-V>      	<C-R>+
cnoremap <S-Insert>		<C-R>*
inoremap <S-Insert>		<C-R>*
