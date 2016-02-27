execute pathogen#infect()
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'shawncplus/phpcomplete.vim'
Bundle 'tpope/vim-repeat'
Bundle 'ervandew/supertab'
" Bundle 'tsaleh/vim-matchit'
Bundle 'godlygeek/tabular'
Bundle 'Raimondi/delimitMate'
" Bundle 'scrooloose/nerdtree'
Bundle 'MattesGroeger/vim-bookmarks'
Bundle 'digitaltoad/vim-jade'

Bundle 'altercation/vim-colors-solarized'
Bundle 'whatyouhide/vim-gotham'

" javascript {
"   http://oli.me.uk/2013/06/29/equipping-vim-for-javascript/ 

    Bundle 'jelera/vim-javascript-syntax'
    Bundle 'pangloss/vim-javascript'
    " Bundle 'nathanaelkane/vim-indent-guides'
    " Bundle 'marijnh/tern_for_vim'

" } 

" TComment { " - https://github.com/tomtom/tcomment_vim

  Bundle 'tomtom/tcomment_vim'
  noremap <leader>c :TComment<CR>
  vnoremap <leader>c :TComment<CR>

" }

" Command-t {

  Bundle 'wincent/command-t'
  let g:CommandTMaxFiles = 99999
  let g:CommandTMaxDepth = 99999
  let g:CommandTMaxHeight = 10
  " let g:CommandTFileScanner = 'find'
  map <leader>b :CommandTMRU<CR>
  if &term =~ "xterm" || &term =~ "screen"
    let g:CommandTCancelMap = ['<ESC>', '<C-c>']
  endif

" }

" CTRL-P {
"
  Bundle 'kien/ctrlp.vim'

  map <leader>m :CtrlPBufTag<CR>
  " map <leader>p :CtrlPCmdPalette<CR>
  " map <leader>b :CtrlPBuffer<CR>

  let g:ctrlp_map = '<c-p>'
  let g:ctrlp_cmd = 'CtrlPCurWD' 
  "let g:ctrlp_working_path_mode = 'c'
  "let g:ctrlp_user_command = 'find %s -type f'
  let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
  "let g:ctrlp_max_height = 99999999
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

" YCM - YouCompleteMe {
"
"     Bundle 'Valloric/YouCompleteMe'
"     let g:ycm_add_preview_to_completeopt=0
"     let g:ycm_confirm_extra_conf=0
"     set completeopt-=preview
"     " set completeopt=menu,preview 
"
"     let g:ycm_semantic_triggers =  {
"       \   'c' : ['->', '.'],
"       \   'objc' : ['->', '.'],
"       \   'ocaml' : ['.', '#'],
"       \   'cpp,objcpp' : ['->', '.', '::'],
"       \   'perl' : ['->'],
"       \   'php' : ['->', '::'],
"       \   'cs,java,javascript,d,python,perl6,scala,vb,elixir,go' : ['.'],
"       \   'vim' : ['re![_a-zA-Z]+[_\w]*\.'],
"       \   'ruby' : ['.', '::'],
"       \   'lua' : ['.', ':'],
"       \   'erlang' : [':'],
"       \ }
"
"     set pumheight=5
"
" }

" syntastic {
    " Bundle 'scrooloose/syntastic'
    " This does what it says on the tin. It will check your file on open too, not just on save.
    " " You might not want this, so just leave it out if you don't.
    " let g:syntastic_check_on_open=1
" }

" easymotion {
" - https://github.com/Lokaltog/vim-easymotion

  Bundle 'Lokaltog/vim-easymotion'
  " let g:EasyMotion_leader_key = '<space>'

  " Gif config
  " map  / <Plug>(easymotion-sn)
  " omap / <Plug>(easymotion-tn)
  " map  n <Plug>(easymotion-next)
  " map  N <Plug>(easymotion-prev)

  " Gif config
  " nmap s <Plug>(easymotion-s2)

  " Gif config
  map <space>h <Plug>(easymotion-linebackward)
  map <space>j <Plug>(easymotion-j)
  map <space>k <Plug>(easymotion-k)
  map <space>l <Plug>(easymotion-lineforward)

  let g:EasyMotion_startofline = 0 " keep cursor colum when JK motion
  let g:EasyMotion_smartcase = 1 " search case-insensitive

" }

"  DBGPavim xdebug {
" - https://github.com/brookhong/DBGPavim

  "Bundle 'brookhong/DBGPavim'
  "map <leader>d :ToggleDebug<CR>

" }

" tagbar {
  Bundle 'majutsushi/tagbar' 
  nnoremap <silent> tg :TagbarToggle<CR>
" }

" status line
"Plugin 'itchyny/lightline.vim'

" ------------------------------------------------------------------------------
" airline {
" ------------------------------------------------------------------------------

  "Bundle 'bling/vim-airline'

  "function! AirlineInit()
  "  let g:airline_section_a = airline#section#create(['mode'])
  "  let g:airline_section_b = airline#section#create_left(['%f'])
  "  let g:airline_section_c = airline#section#create(['filetype', '  ', 'ffenc', '  ', '%v'])
  "  let g:airline_section_x = airline#section#create([])
  "  let g:airline_section_y = airline#section#create([])
  "  let g:airline_section_z = airline#section#create_right(['%L'])
  "  let g:airline_section_warning = airline#section#create_right([])
  "endfunction

  "function! AirlineInit2()
  "  let g:airline_section_a = airline#section#create(['mode'])
  "  let g:airline_section_b = airline#section#create_left(['%f'])
  "  let g:airline_section_c = airline#section#create(['filetype', '  ', 'ffenc', '  ', '%v'])
  "  let g:airline_section_x = airline#section#create(["%{tagbar#currenttag('%s ','')}"])
  "  let g:airline_section_y = airline#section#create([])
  "  let g:airline_section_z = airline#section#create_right(['%L'])
  "  let g:airline_section_warning = airline#section#create_right([])
  "endfunction
 
  "autocmd VimEnter * call AirlineInit2()
 
  "let g:airline_mode_map = {
  "      \ '__' : '-',
  "      \ 'n'  : 'N',
  "      \ 'i'  : 'I',
  "      \ 'R'  : 'R',
  "      \ 'c'  : 'C',
  "      \ 'v'  : 'V',
  "      \ 'V'  : 'V',
  "      \ '' : 'V',
  "      \ 's'  : 'S',
  "      \ 'S'  : 'S',
  "      \ '' : 'S',
  "      \ }
 
  "" tagbar
  "let g:airline#extensions#tagbar#enabled = 1
 
  "" let g:airline_theme = 'ubaryd'
  "let g:airline#extensions#tabline#enabled = 1
  "let g:airline#extensions#tabline#show_buffers = 0
  "let g:airline#extensions#tabline#show_tab_nr = 0
  "let g:airline#extensions#tabline#fnamemod = ':t'
  "let g:airline#extensions#tabline#tab_min_count = 2
 
  "if !exists('g:airline_symbols')
  "  let g:airline_symbols = {}
  "endif
 
  "let g:airline_left_sep = ''
  "let g:airline_right_sep = ''
 
" ------------------------------------------------------------------------------
" }
" ------------------------------------------------------------------------------

filetype plugin indent on   
