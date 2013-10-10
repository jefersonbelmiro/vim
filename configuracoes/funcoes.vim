"""""""""""""""""""""""""""""""""""
"       FUN??ES PERSONALIZADAS
"""""""""""""""""""""""""""""""""""
let g:diretorioArquivoTags = $VIMROOT . "/runtime/tags/"
function! UtilizarTags()

  let iOpcao              = confirm("Utilizar Tags???? Qual projeto?", "DBPortal_prj\nFuncoes8\nDBPref", 1) 
  let aEscolhas           = { 1 : "dbportal_prj",
                            \ 2 : "funcoes8",
                            \ 3 : "dbpref"}
  let sProjeto            = aEscolhas[iOpcao]

  echo "Definindo configuracoes VIM: " . g:diretorioArquivoTags ."".sProjeto."_tags" 
  let sCaminhoArquivoTags = g:diretorioArquivoTags ."".sProjeto."_tags"

  execute "set tags=". sCaminhoArquivoTags
  echo 'Feito o Brique... Pode usar as tags...'
endfunction


function! AtualizaTags()

  let iOpcao              = confirm("Atualizar Tags??? Qual projeto?", "&zDBPortal_prj\n&xFuncoes8\n&cDBPref", 2)

  let aEscolhas           = { 1 : "dbportal_prj",
                            \ 2 : "funcoes8",
                            \ 3 : "dbpref"}
  let sProjeto            = aEscolhas[iOpcao]
  let sCaminhoArquivoTags = g:diretorioArquivoTags . sProjeto ."_tags"

  execute "!ctags -f " . sCaminhoArquivoTags . " -R /var/www/" . sProjeto . "/ "
endfunction

function! FileName()
  return expand('%:t')
endfunction

function! PathName()
  return expand('%:p:h')
endfunction

if !exists('g:default_tab_width')
  let g:default_tab_width = 2
endif

function! PadraoISO() 

  execute 'set encoding=ISO-8859-1'
  execute 'set fileencoding=ISO-8859-1'
  " ao abrir aquivo ja formata
  "execute 'set fileencodings=ISO-8859-1'
  execute 'set ts=' . g:default_tab_width
  execute 'set softtabstop=' . g:default_tab_width
  execute 'set shiftwidth=' . g:default_tab_width

endfunction

function! PadraoUTF() 

  execute 'set encoding=UTF-8'
  execute 'set fileencoding=UTF-8'
  " ao abrir aquivo ja formata
  "execute 'set fileencodings=UTF-8'
  execute 'set ts=' . g:default_tab_width
  execute 'set softtabstop=' . g:default_tab_width
  execute 'set shiftwidth=' . g:default_tab_width

endfunction

function! Save() 

  try 

    silent execute ':w'
    silent execute ':set scr=4'
    silent execute ':set ft=' . &filetype

    if &filetype == 'php'
      call s:Executar('php -l ' . expand('%') . ' 2> /tmp/vim_save')
    endif

    echo 'Arquivo salvo'

  catch

    let s:erro = Executar('cat /tmp/vim_save')

    if !empty(s:erro) 
      let s:erro = split(s:erro, "\n")[0] 
    else 
      let s:erro = v:exception
    endif

    echohl WarningMsg | echo s:erro 
  endtry

endfunction

"
" Executa um comando e retorna resposta do comando ou erro
"
function! s:Executar(comando) 

  let l:retornoComando = system(a:comando)

  if v:shell_error 
    throw l:retornoComando
  endif

  return l:retornoComando

endfunction

function! ToggleMouse()
  if !exists("s:old_mouse")
    let s:old_mouse = "a"
  endif

  if &mouse == ""
    let &mouse = s:old_mouse
    echo "Mouse is for Vim (" . &mouse . ")"
  else
    let s:old_mouse = &mouse
    let &mouse=""
    echo "Mouse is for terminal"
  endif
endfunction

" identacao tabular
function TabularIndent(alignRight) 
  normal! gv
  if !empty(a:alignRight) 
    let l:busca = input("Tabularize right: ")
    exec ":'<,'>Tab /" . l:busca . "\zs"
  else
    let l:busca = input("Tabularize: ")
    exec ":'<,'>Tab /" . l:busca
  endif
  execute "normal! \<Esc>"
endfunction
