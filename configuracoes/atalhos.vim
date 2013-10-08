
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
map <silent><F5> <ESC> :call ToggleMouse() <CR> hh
imap <silent><F5> <ESC> :call ToggleMouse() <CR> hi

map K k

" Salvar 
map <F2> <ESC>:call Save()<CR>
imap <F2> <ESC>:call Save()<CR>

" copiar e colar da ara de transferencia(clipboard)
imap <C-v> <ESC> h"+p <ESC> hi
vmap <C-c> "+y <ESC>

" Redimensiona Janela com ALT + Direcional 
nnoremap <C-Up>    <C-w>+
nnoremap <C-Down>  <C-w>-
nnoremap <C-Left>  <C-w><
nnoremap <C-Right> <C-w>>

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

" Ctrl-Space para AutoComplete Like Eclipse
if has("gui_running")
  inoremap <C-Space> <C-x><C-o>
else 
  if has("unix")
    inoremap <Nul> <C-x><C-o>
  endif
endif

" tagbar
nnoremap <silent> tg :TagbarToggle<CR>

" neocomplcache
let g:neocomplcache_enable_at_startup     = 1  
let g:neocomplcache_disable_auto_complete = 0
"let g:neocomplcache_enable_auto_select    = 1

" Cvsdiff
map <F8> :ToogleCvsdiff<cr>

"                                                                                 
" CTRL-P {{{
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP' "let g:ctrlp_working_path_mode = 'c'
"let g:ctrlp_user_command = 'find %s -type f'
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
let g:ctrlp_max_height = 99999999

"------------------------------------------------------------------------------
"- abrir programas em aba, ctrl+t
"------------------------------------------------------------------------------
"let g:ctrlp_prompt_mappings = {
"      \ 'AcceptSelection("e")' :  [],
"      \ 'AcceptSelection("t")' :  ['<cr>', '<c-m>'],
"      \ }

let g:ctrlp_custom_ignore = {
      \ 'dir':  '\v[\/]\.(CVS|git|hg|svn)$',
      \ 'file': '\v\.(jpg|png|gif)$'
      \ }
"}}}

" easy motion
let g:EasyMotion_leader_key = '<space>'
 
au FileType php inoremap <F7> <ESC>:call PhpDocSingle()<CR>
au FileType php nnoremap <F7>      :call PhpDocSingle()<CR>
au FileType php vnoremap <F7>      :call PhpDocRange()<CR>
au FileType php set      omnifunc=phpcomplete#CompletePHP
 
au FileType javascript inoremap <F7> <ESC>:call WriteJSDocComment()<CR>
au FileType javascript nnoremap <F7>      :call WriteJSDocComment()<CR>
au FileType javascript vnoremap <F7>      :call WriteJSDocComment()<CR>
au FileType javascript set      omnifunc=javascriptcomplete#CompleteJS

au Filetype sql setfiletype pgsql
