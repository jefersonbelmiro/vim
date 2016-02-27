
"Habilita coloração por syntax 
syntax enable 

set t_Co=256
set textwidth=110

" 1 - mostra abas somente se tiver 2 arquivos 
" 2 - sempre mostra abas 
set showtabline=1

" Sempre mostra barra de Mensagens 
set laststatus=2

set colorcolumn=120

" Formata Barra de Status
"set statusline =%<%f\ \ %h%m%r%Y%=\ \ linha:\ %l,total\ :%L,%c%V\ %P 

set statusline=%f
set statusline+=\ \ 
set statusline+=%=  " Switch to the right side
set statusline+=%L
function! HighlightSearch()
  if &hls
    return 'H'
  else
    return ''
  endif
endfunction

" set statusline=
" set statusline+=%7*\[%n]                                  "buffernr
" set statusline+=%1*\ %<%F\                                "File+path
" set statusline+=%2*\ %y\                                  "FileType
" set statusline+=%3*\ %{''.(&fenc!=''?&fenc:&enc).''}      "Encoding
" set statusline+=%3*\ %{(&bomb?\",BOM\":\"\")}\            "Encoding2
" set statusline+=%4*\ %{&ff}\                              "FileFormat (dos/unix..) 
" set statusline+=%5*\ %{&spelllang}\%{HighlightSearch()}\  "Spellanguage & Highlight on?
" set statusline+=%8*\ %=\ row:%l/%L\ (%03p%%)\             "Rownumber/total (%)
" set statusline+=%9*\ col:%03c\                            "Colnr
" set statusline+=%0*\ \ %m%r%w\ %P\ \                      "Modified? Readonly? Top/bot.
"
" Fancy status line.
" set statusline =
" set statusline+=%n                                 "buffer number
" set statusline+=%{'/'.bufnr('$')}\                 "buffer count
" set statusline+=%f%m\                              "file name/modified flag
" set statusline+=(%{strlen(&ft)?&ft:'none'})        "file type
" set statusline+=%=                                 "indent right
" set statusline+=U+%04B\                            "Unicode char under cursor
" set statusline+=%-6.(%l/%{line('$')},%c%V%)\ %<%P  "position

set statusline=
set statusline+=%f%m\  "file name/modified flag
set statusline+=%=                                 "indent right
set statusline+=%r\          "file type
set statusline+=%{strlen(&ft)?&ft:'none'}        "file type
set statusline+=%1*\ %{''.(&fenc!=''?&fenc:&enc).''}      "Encoding
set statusline+=%1*\ %{&ff}\                              "FileFormat (dos/unix..) 
"set statusline+=%.200c  "position
set statusline+=%3(%c%)\            " line and column"
set statusline+=%1*%L  "position

if !has("gui_running")                       

  " ---------------------------------------------------------------
  " VIM
  " ---------------------------------------------------------------

  set background=dark

  " let g:airline_theme = 'ubaryd'
  colorscheme womprat

  hi StatusLine ctermbg=NONE cterm=NONE
  hi StatusLineNC ctermbg=NONE cterm=NONE

  hi vertsplit ctermbg=none
  
  set nonu
  set fillchars+=vert:│

  "color gotham256

else 

  " ---------------------------------------------------------------
  " GVIM
  " ---------------------------------------------------------------

  colorscheme Tomorrow-Night
  " colorscheme molokai

  " remove todas as parafernalias visuais do gvim
  " L - scroll da esquerda
  " r - scroll da direita
  " T - icones de opcoes(copiar, colar, voltar, bla bla)
  set guioptions-=aegimrLtT
  set guioptions=ar

  " destaca linha atual do cursor
  hi clear CursorLineNr
  hi CursorLineNr guifg=#999999
  hi clear Search guifg
  hi Search guibg=#444444

  " + - ctrl+c clipboard
  " * - select clipboard
  cnoremap <C-V>      	<C-R>+
  cnoremap <S-Insert>		<C-R>*
  inoremap <S-Insert>		<C-R>*

endif

" NERDTree {
  let g:NERDTreeDirArrows=0
" }
