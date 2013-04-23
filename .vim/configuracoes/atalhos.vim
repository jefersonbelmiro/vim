
" abre arquivo
map <F9> <ESC><C-w>gf<CR>

" troca de abas
map tk :tabnext<CR>
map tj :tabprev<CR>

" fecha arquivo
map <F4> :q<CR>

" CTRL-F4 fecha a janela
noremap <C-F4> :q!<CR>

" identation
vmap <TAB> >gv
vmap <S-TAB> <gv

" toggle mouse no vim
map <silent><F5> :let &mouse=(&mouse == "a"?"":"a")<CR>:call ShowMouseMode()<CR>
imap <silent><F5><ESC> :let &mouse=(&mouse == "a"?"":"a")<CR>:call ShowMouseMode()<CR>

map K k

" Salvar com F2:w 
map  <F2> <ESC>:w<CR>
imap <F2> <ESC>:w<CR>

" Alterna entre Janelas Abertas
noremap <C-j> <C-W>j
noremap <C-k> <C-W>k
noremap <C-l> <C-W>l
noremap <C-h> <C-W>h

" Redimensiona Janela com ALT + Direcional 
nnoremap <A-Up>    <C-w>+
nnoremap <A-Down>  <C-w>-
nnoremap <A-Left>  <C-w><
nnoremap <A-Right> <C-w>>

" Ctrl-Space para AutoComplete Like Eclipse
if has("gui_running")
  inoremap <C-Space> <C-x><C-o>
else 
  if has("unix")
    inoremap <Nul> <C-x><C-o>
  endif
endif

" Movimentaçao entre janelas
noremap <C-j> <C-W>j
noremap <C-k> <C-W>k
noremap <C-l> <C-W>l
noremap <C-h> <C-W>h

" Redimensionando Janelas
noremap <A-Up> <C-w>+
noremap <A-Down> <C-w>-
noremap <A-Left> <C-w><
noremap <A-Right> <C-w>>

" Move linhas ou blocos usando ALT+SETA
nnoremap <A-j> mz:m+<CR>`z==
nnoremap <A-k> mz:m-2<CR>`z==
inoremap <A-j> <Esc>:m+<CR>==gi
inoremap <A-k> <Esc>:m-2<CR>==gi
vnoremap <A-j> :m'>+<CR>gv=`<my`>mzgv`yo`z
vnoremap <A-k> :m'<-2<CR>gv=`>my`<mzgv`yo`z
