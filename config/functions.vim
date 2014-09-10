
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

function! AtualizaTagsBG() 

  let sProjeto = 'dbportal_prj'
  let sCaminhoArquivoTags = g:diretorioArquivoTags . sProjeto ."_tags"
  let l:command  = "ctags -f " . sCaminhoArquivoTags . " -R --fields=+aimS --languages=php /var/www/" . sProjeto . "/ "
  call ExecuteBackground(l:command, 'Atualizar arquivo tags')
  echo 'Atualizando tags do dbportal_prj'

endfunction

function! FileName()
  return expand('%:t')
endfunction

function! PathName()
  return expand('%:p:h')
endfunction

" ao abrir aquivo ja formata: set fileencodings=UTF-8
" latin1 = ISO-8859-1
function! SetEncoding(encoding)

  execute 'set encoding=' . a:encoding
  execute 'set fileencoding=' . a:encoding

endfunction

function! SetTabWidth(tabWidth)

  execute 'set ts=' . a:tabWidth
  execute 'set softtabstop=' . a:tabWidth
  execute 'set shiftwidth=' . a:tabWidth

endfunction

function! Save() 

  try 

    silent execute ':w'
    silent execute ':set scr=4'
    silent execute ':set ft=' . &filetype

    " php lint
    " if &filetype == 'php'
      " call s:Executar('php -l ' . expand('%') . ' 2> /tmp/vim_save')
    " endif

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

" Exibe/oculta scrollbar
function! UpdateScroll()
  let fileLines = line('$')
  let winHeight = winheight(winnr())
  if fileLines > winHeight 
    set go+=r 
  else 
    set go-=r 
  endif
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

function! Strip(input_string)
  return substitute(a:input_string, '^\s*\(.\{-}\)\s*$', '\1', '')
endfunction

function! ExecuteBackground(command, title)
  execute "silent !" . a:command. " > /dev/null 2>&1 && " .
        \ "/usr/bin/notify-send \"" . a:title . "\" complete &"
  execute ':redraw!'
endfunction

" @todo - auto-complete plugin
"
" Tab completion of tags/keywords if not at the beginning of the line.
" function! InsertTabWrapper()
"   let col = col('.') - 1
"    if !col || getline('.')[col - 1] !~ '\k'
"       return "\<tab>"
"    else
"       return "\<c-p>"
"    endif
" endfunction
" 
" inoremap <tab> <c-r>=InsertTabWrapper()<cr>

function! LoadingProblematicConfigurations() 

  setlocal ve=all 
  setlocal scr=4

  if &filetype == 'php' 
    setlocal iskeyword+=$
  endif

endfunction

function! DiffToggle(close) 

  if !&diff
    return
  endif

  if a:close == 0 
    colorscheme jellybeans
    return 
  endif

endfunction
