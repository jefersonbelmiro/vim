
syntax on
set nocompatible                  " desabilita compatiblidade com vi
set history=2000                  " Quantas linhas de histórico o vim deve lembra0
set ruler                         " Sempre mostra posicao atual
set hid                           " A buffer becomes hidden when it is abandoned
set backspace=indent,eol,start
set whichwrap+=<,>,h,l
set ignorecase                    " Ignora maiusculas/minusculas quando fizer pesquisa
set smartcase                     " When searching try to be smart about cases ??? @todo descobrir o que eh mesmo
set hlsearch                      " Destaca resultados da busca
set incsearch                     " Vai buscando enquando digita
set magic                         " For regular expressions turn magic on
set showmatch                     " Show matching brackets when text indicator is over them
set matchtime=2                   " How many tenths of a second to blink when matching brackets
set autoindent
set number

" scroll
set scroll=4        " linhas do ctrl+u e ctrl+d
set sidescroll=1    " ao chegar cursor final da pagina e tiver mais conteudo, move 1 caracter, default 0, meia pagina
set scrolloff=1     " quando cursor tiver 1 linha do final da pagina, move verticalmente
set sidescrolloff=2 " igual scrolloff so que horizontal, quando cursor ficar 2 caracteres final da pagina, move 1 caracter, o que esta configurado no sidescroll


set expandtab " Use spaces instead of tabs
set smarttab  " Be smart when using tabs ;)

set shiftwidth=4 
set tabstop=4   
set softtabstop=4
"set linebreak          
"set textwidth  =150 " Linebreak on 150 characters

set autoindent  "Auto indent
set smartindent "Smart indent
set nowrap      "No Wrap lines

set nobackup   
set nowritebackup 
set noswapfile  
  
set mousem=popup_setpos
set mouse=a
set number
set showcmd
set showmode
set ttyfast

"set list
"set listchars=tab:\|\ 
"hi SpecialKey ctermbg=none

" diff
set diffopt+=iwhite
set diffexpr=""

"au FilterWritePre * call DiffToggle(0)
"au QuitPre * call DiffToggle(1)
"call DiffToggle(0)

" Navegacao
set wildmenu
set wildignore=*.o,*~,*.pyc,CVS,*~            " Ignora certos tipos de arquivo
set wildmode=list:longest                     " Command <tab> completion, list matches, then longest common, then all.

set termencoding=utf-8                       " Codificação do terminal
set fileformats=unix,dos,mac                 " Use unix as the standard file type
set switchbuf=useopen,usetab,newtab          " Specify the behavior when switching between buffers 

" abriu arquivo somente leitura, editou e agora nao consegue salvar?
"cmap w!! w !sudo tee % >/dev/null

" Folding
set foldmethod=manual

set shortmess+=filmnrxoOtT                      " abbrev. of messages (avoids 'hit enter')
set viewoptions=folds,options,cursor,unix,slash " better unix / windows compatibility
set virtualedit=all                             " permite o cursor mover onde nao tem caracter 

" nerdtree {

  " desabilita nerdtree ao abrir gvim
  let g:nerdtree_tabs_open_on_gui_startup = 0

" }

" tagbar {

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

" }

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType php setlocal omnifunc=phpcomplete#CompletePHP

autocmd FileType php inoremap <F7> <ESC>:call PhpDocSingle()<CR>
autocmd FileType php nnoremap <F7>      :call PhpDocSingle()<CR>
autocmd FileType php vnoremap <F7>      :call PhpDocRange()<CR>
 
autocmd FileType javascript inoremap <F7> <ESC>:call WriteJSDocComment()<CR>
autocmd FileType javascript nnoremap <F7>      :call WriteJSDocComment()<CR>
autocmd FileType javascript vnoremap <F7>      :call WriteJSDocComment()<CR>

autocmd Filetype sql set filetype=pgsql
autocmd filetype smarty setlocal filetype=php.html

" au filetype php set keywordprg=pman
autocmd filetype php set iskeyword+=$
