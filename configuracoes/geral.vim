"""""""""""""""""""""""""""""""""""""""""""""
" Geral                                  
"""""""""""""""""""""""""""""""""""""""""""""

" encode
"call PadraoISO()
"call PadraoUTF()

filetype plugin on                " Plugins por tipo de arquivo
filetype indent on                " Indentação por tipo de arquivo
set nocompatible                  " desabilita compatiblidade com vi
set history     =2000             " Quantas linhas de histórico o vim deve lembra0
set ruler                         " Sempre mostra posicao atual
set hid                           " A buffer becomes hidden when it is abandoned
"set backspace   =eol,start,indent " Configure backspace so it acts as it should act
set backspace=indent,eol,start
set whichwrap  +=<,>,h,l          " @todo -naum sei
set ignorecase                    " Ignora maiusculas/minusculas quando fizer pesquisa
set smartcase                     " When searching try to be smart about cases ??? @todo descobrir o que eh mesmo
set hlsearch                      " Destaca resultados da busca
set incsearch                     " Vai buscando enquando digita
set magic                         " For regular expressions turn magic on
set showmatch                     " Show matching brackets when text indicator is over them
set matchtime   =2                " How many tenths of a second to blink when matching brackets
set autoindent

" scroll
set scroll=4        " linhas do ctrl+u e ctrl+d
set sidescroll=1    " ao chegar cursor final da pagina e tiver mais conteudo, move 1 caracter, default 0, meia pagina
set scrolloff=1     " quando cursor tiver 1 linha do final da pagina, move verticalmente
set sidescrolloff=2 " igual scrolloff so que horizontal, quando cursor ficar 2 caracteres final da pagina, move 1 caracter, o que esta configurado no sidescroll

"set directory=~/.vim/backup
"set backupdir=~/.vim/backup
set nobackup   
set nowritebackup 
set noswapfile  
  
set number
set mouse=
set ve=all
set showcmd
set showmode
set ttyfast

"set list
"set listchars=tab:\|\ 
"hi SpecialKey ctermbg=none

" diff
set diffopt+=iwhite
set diffexpr=""

" Navegacao
set wildmenu
set wildignore =*.o,*~,*.pyc,CVS,*~            " Ignora certos tipos de arquivo
set wildmode   =list:longest              " Command <tab> completion, list matches, then longest common, then all.


"set encoding      =latin1 " Codificação padrão
"set fileencoding  =latin1 " Codificação do arquivo
"set fileencodings =latin1 " Codificação do arquivo
set termencoding  =utf-8  " Codificação do terminal

set fileformats =unix,dos,mac                   " Use unix as the standard file type

set switchbuf =useopen,usetab,newtab          " Specify the behavior when switching between buffers 

" abriu arquivo somente leitura, editou e agora nao consegue salvar?
"cmap w!! w !sudo tee % >/dev/null

"Recolher Pela Syntax
"
set foldmethod        =manual
"set foldlevelstart    =1
"let javaScript_fold   =1                               " JavaScript
"let perl_fold         =1                               " Perl
"let php_folding       =1                               " PHP
"let r_syntax_folding  =1                               " R
"let ruby_fold         =1                               " Ruby
"let sh_fold_enabled   =1                               " sh
"let vimsyn_folding    ='af'                            " Vim script
"let xml_syntax_folding=1                               " XML

set shortmess        +=filmnrxoOtT                     " abbrev. of messages (avoids 'hit enter')
set viewoptions       =folds,options,cursor,unix,slash " better unix / windows compatibility
set virtualedit       =onemore                         " permite o cursor ficar na ultima letra da linha 
