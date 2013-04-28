
" abre arquivo
map <F9> <ESC><C-w>gf<CR>

" troca de abas
map tk :tabnext<CR>
map tj :tabprev<CR>

" fecha arquivo
map <F4> :q<CR>

" identation
vmap <TAB> >gv
vmap <S-TAB> <gv

" toggle mouse no vim
map <silent><F5> :let &mouse=(&mouse == "a"?"":"a")<CR>:call ShowMouseMode()<CR>
imap <silent><F5><ESC> :let &mouse=(&mouse == "a"?"":"a")<CR>:call ShowMouseMode()<CR>

map K k

" Salvar com F
map  <F2> <ESC>:w<CR>
imap <F2> <ESC>:w<CR>

" Alterna entre Janelas Abertas
noremap <C-j> <C-W>j
noremap <C-k> <C-W>k
noremap <C-l> <C-W>l
noremap <C-h> <C-W>h

" Redimensiona Janela com ALT + Direcional 
"nnoremap <A-Up>    <C-w>+
"nnoremap <A-Down>  <C-w>-
"nnoremap <A-Left>  <C-w><
"nnoremap <A-Right> <C-w>>

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

" Move linhas ou blocos usando ALT+SETA
nnoremap <A-DOWN> mz:m+<CR>`z==
nnoremap <A-UP> mz:m-2<CR>`z==
inoremap <A-DOWN> <Esc>:m+<CR>==gi
inoremap <A-UP> <Esc>:m-2<CR>==gi
vnoremap <A-UP> :m'<-2<CR>gv=`>my`<mzgv`yo`z
vnoremap <A-DOWN> :m'>+<CR>gv=`<my`>mzgv`yo`z

" tagbar
nnoremap <silent> tg :TagbarToggle<CR>

"                                                                                 
" Atalhos de Plugins : {{{
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_user_command = 'find %s -type f'
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(CVS|git|hg|svn)$',
  \ 'file': '\v\.(jpg|png|gif)$'
  \ }
"}}}
 
au FileType php inoremap <F7> <ESC>:call PhpDocSingle()<CR>
au FileType php nnoremap <F7>      :call PhpDocSingle()<CR>
au FileType php vnoremap <F7>      :call PhpDocRange()<CR>
au FileType php set      omnifunc=phpcomplete#CompletePHP
 
au FileType javascript inoremap <F7> <ESC>:call WriteJSDocComment()<CR>
au FileType javascript nnoremap <F7>      :call WriteJSDocComment()<CR>
au FileType javascript vnoremap <F7>      :call WriteJSDocComment()<CR>
au FileType javascript set      omnifunc=javascriptcomplete#CompleteJS
au Filetype sql setfiletype pgsql
