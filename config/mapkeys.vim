
" <leader>
let mapleader = ","

" abre arquivo
map <F9> <ESC> :call OpenFile() <CR>

" troca de abas
nnoremap <silent> tk :tabnext<CR>
nnoremap <silent> tj :tabprev<CR>
nnoremap <silent> <A-1> 1gt
nnoremap <silent> <A-2> 2gt
nnoremap <silent> <A-3> 3gt
nnoremap <silent> <A-4> 4gt
nnoremap <silent> <A-5> 5gt
nnoremap <silent> <A-6> 6gt
nnoremap <silent> <A-7> 7gt
nnoremap <silent> <A-8> 8gt
nnoremap <silent> <A-9> 9gt

" Remap vim 0 to first non-blank character
" map 0 ^

" fecha arquivo e remove do buffer
" map <F4> :execute 'bd "' . PathName() . '/' . FileName() . '"' <CR>

" fecha arquivo
map <F4> :q<CR>

" identation
vmap <TAB> >gv
vmap <S-TAB> <gv

" toggle mouse no vim
map <silent><F5> <ESC> :call ToggleMouse() <CR> hh
imap <silent><F5> <ESC> :call ToggleMouse() <CR> hi

" K abre 'man' do que esta sob o cursor 
map K k

" apos buscar, nao pula cursor
map * *N
map # #N

" Salvar 
map <F2> <ESC>:call Save()<CR>
imap <F2> <ESC>:call Save()<CR>

" CTRL-V and SHIFT-Insert are Paste
"map <C-V>		"+gP
"map <S-Insert>		"+gP
exe 'inoremap <script> <C-V>' paste#paste_cmd['i']
exe 'vnoremap <script> <C-V>' paste#paste_cmd['v']

" CTRL-X and SHIFT-Del are Cut
vnoremap <C-X> "+x
vnoremap <S-Del> "+x

" CTRL-C and CTRL-Insert are Copy
vnoremap <C-C> "+y
vnoremap <C-Insert> "+y

" backspace in Visual mode deletes selection
vnoremap <BS> d

" Redimensiona Janela com Ctrl + Direcional 
nnoremap <C-Up>    <C-w>+
nnoremap <C-Down>  <C-w>-
nnoremap <C-Left>  <C-w><
nnoremap <C-Right> <C-w>>

" Movimentaçao entre janelas
noremap <C-j> <C-W>j
noremap <C-k> <C-W>k
noremap <C-l> <C-W>l
noremap <C-h> <C-W>h

" Move linhas ou blocos { 
"  usando ALT+SETA nnoremap <A-DOWN> mz:m+<CR>`z==
    " normal
    nnoremap <A-UP> mz:m-2<CR>`z==
    nnoremap <A-DOWN> mz:m+<CR>`z==
    " insert
    inoremap <A-UP> <Esc>:m-2<CR>==gi
    inoremap <A-DOWN> <Esc>:m+<CR>==gi
    " visual
    vnoremap <A-UP> :m'<-2<CR>gv=`>my`<mzgv`yo`z
    vnoremap <A-DOWN> :m'>+<CR>gv=`<my`>mzgv`yo`z
" }

" Ctrl-Space para AutoComplete Like Eclipse
if has("gui_running")
  inoremap <C-Space> <C-x><C-o>
else 
  if has("unix")
    inoremap <Nul> <C-x><C-o>
  endif
endif

" Cvsdiff {
  map <F8> :CvsDiffToggle<cr>
" }

" volta pro normal mode
inoremap jk <ESC>l
inoremap JK <ESC>l

" apos abrir algo como {}, identa: {
"   _  <--- cursor
" }
imap <C-c> <CR><Esc>O

" navegacao em insert mode
inoremap <C-k> <c-o>k
inoremap <C-j> <c-o>j
inoremap <C-h> <c-o>h
inoremap <C-l> <c-o>l
