
" <leader>
let mapleader = ","

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

" neocomplcache {
"
  " Disable AutoComplPop.
  let g:acp_enableAtStartup = 0
  " Use neocomplcache.
  let g:neocomplcache_enable_at_startup = 1
  " Use smartcase.
  let g:neocomplcache_enable_smart_case = 1
  " Set minimum syntax keyword length.
  let g:neocomplcache_min_syntax_length = 3
  let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'
  let g:neocomplcache_enable_at_startup     = 1
  
  " For cursor moving in insert mode
  " let g:neocomplcache_enable_cursor_hold_i = 1
  " habilita pop-up somente quando inserir algum caracter
  let g:neocomplcache_enable_insert_char_pre = 1

  " AutoComplPop like behavior.
  let g:neocomplcache_enable_auto_select = 1

  " NAO TESTADOS {
    " Enable heavy omni completion.
    if !exists('g:neocomplcache_omni_patterns')
     let g:neocomplcache_omni_patterns = {}
    endif
    let g:neocomplcache_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
    " let g:neocomplcache_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
    " let g:neocomplcache_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

    " For perlomni.vim setting.
    " https://github.com/c9s/perlomni.vim
    "let g:neocomplcache_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
  " }

  " desabilita autocomplete
  "let g:neocomplcache_enable_at_startup     = 0  
  let g:neocomplcache_disable_auto_complete = 1

" }

" Cvsdiff {
  map <F8> :CvsDiffToggle<cr>
" }

" CTRL-P {

  let g:ctrlp_map = '<c-p>'
  let g:ctrlp_cmd = 'CtrlPCurWD' 
  "let g:ctrlp_working_path_mode = 'c'
  "let g:ctrlp_user_command = 'find %s -type f'
  let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
  let g:ctrlp_max_height = 99999999
  "let g:ctrlp_extensions = ['funky']
  
  " abrir programas em aba, ctrl+t
  " let g:ctrlp_prompt_mappings = {
  "      \ 'AcceptSelection("e")' :  [],
  "      \ 'AcceptSelection("t")' :  ['<cr>', '<c-m>'],
  "      \ }
  
  let g:ctrlp_custom_ignore = {
        \ 'dir':  '\v[\/]\.(CVS|git|hg|svn)$',
        \ 'file': '\v\.(jpg|png|gif)$'
        \ }
" }

" easy motion
let g:EasyMotion_leader_key = '<space>'

map <leader>m :CtrlPBufTag<CR>
map <leader>p :CtrlPCmdPalette<CR>
map <leader>b :CtrlPBuffer<CR>

" volta pro normal mode
inoremap jj <ESC>l
inoremap JJ <ESC>l

" ------------------------------------------------------------------------------
" airline {
" ------------------------------------------------------------------------------
"

  function! AirlineInit()
    let g:airline_section_a = airline#section#create(['mode'])
    let g:airline_section_b = airline#section#create_left(['%f'])
    let g:airline_section_c = airline#section#create(['filetype', '  ', 'ffenc', '  ', '%v'])
    let g:airline_section_x = airline#section#create([])
    let g:airline_section_y = airline#section#create([])
    let g:airline_section_z = airline#section#create_right(['%L'])
    let g:airline_section_warning = airline#section#create_right([])
  endfunction

  autocmd VimEnter * call AirlineInit()

  let g:airline_mode_map = {
        \ '__' : '-',
        \ 'n'  : 'N',
        \ 'i'  : 'I',
        \ 'R'  : 'R',
        \ 'c'  : 'C',
        \ 'v'  : 'V',
        \ 'V'  : 'V',
        \ '' : 'V',
        \ 's'  : 'S',
        \ 'S'  : 'S',
        \ '' : 'S',
        \ }


  let g:airline_theme = 'ubaryd'
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#show_buffers = 0
  let g:airline#extensions#tabline#fnamemod = ':t'
  let g:airline#extensions#tabline#tab_min_count = 2

  if !exists('g:airline_symbols')
    let g:airline_symbols = {}
  endif

  let g:airline_left_sep = ''
  let g:airline_right_sep = ''

" ------------------------------------------------------------------------------
" }
" ------------------------------------------------------------------------------

" TComment {
" - https://github.com/tomtom/tcomment_vim
  map <leader>c :TComment<CR>
  vmap <leader>c :TComment<CR>
" }
 
" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP

au FileType php inoremap <F7> <ESC>:call PhpDocSingle()<CR>
au FileType php nnoremap <F7>      :call PhpDocSingle()<CR>
au FileType php vnoremap <F7>      :call PhpDocRange()<CR>
 
au FileType javascript inoremap <F7> <ESC>:call WriteJSDocComment()<CR>
au FileType javascript nnoremap <F7>      :call WriteJSDocComment()<CR>
au FileType javascript vnoremap <F7>      :call WriteJSDocComment()<CR>

au Filetype sql setfiletype pgsql
