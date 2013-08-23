"""""""""""""""""""""""""""""""""""
"       FUN??ES PERSONALIZADAS
"""""""""""""""""""""""""""""""""""
let g:diretorioArquivoTags = $VIMROOT . "/runtime/tags/"
function UtilizarTags()

  let iOpcao              = confirm("Utilizar Tags???? Qual projeto?", "&zDBPortal_prj\n&xFuncoes8\n&cDBPref", 2) 
  let aEscolhas           = { 1 : "dbportal_prj",
                            \ 2 : "funcoes8",
                            \ 3 : "dbpref"}
  let sProjeto            = aEscolhas[iOpcao]

  echo "Definindo configuracoes VIM"
  let sCaminhoArquivoTags = g:diretorioArquivoTags ."".sProjeto."_tags"

  execute "set tags=". sCaminhoArquivoTags
  echo 'Feito o Brique... Pode usar as tags...'
endfunction


function AtualizaTags()

  let iOpcao              = confirm("Atualizar Tags??? Qual projeto?", "&zDBPortal_prj\n&xFuncoes8\n&cDBPref", 2)

  let aEscolhas           = { 1 : "dbportal_prj",
                            \ 2 : "funcoes8",
                            \ 3 : "dbpref"}
  let sProjeto            = aEscolhas[iOpcao]
  let sCaminhoArquivoTags = g:diretorioArquivoTags . sProjeto ."_tags"

  execute "!ctags -f " . sCaminhoArquivoTags . " -R /var/www/" . sProjeto . "/ "
endfunction

" toggle mouse no vim
function ShowMouseMode()
	if (&mouse == 'a')
		echo "mouse-vim"
	else
		echo "mouse-xterm"
	endif
endfunction

function! FileName()
  return expand('%')
endfunction

function! PathName()
  return expand('%:p:h')
endfunction

function PadraoISO() 

  execute 'set encoding=ISO-8859-1'
  execute 'set fileencoding=ISO-8859-1'
  "execute 'set fileencodings=ISO-8859-1'
  execute 'set ts=2'
  execute 'set softtabstop=2' 
  execute 'set shiftwidth=2' 

endfunction

function PadraoUTF() 

  execute 'set encoding=UTF-8'
  execute 'set fileencoding=UTF-8'
  "execute 'set fileencodings=UTF-8'
  execute 'set ts=2'
  execute 'set softtabstop=2' 
  execute 'set shiftwidth=2' 

endfunction

function! Save() 

  try 

    silent execute ':w'
    silent execute ':set scr=4'
    silent execute ':set ft=' . &filetype

    if &filetype == 'php'
      call s:Executar('php -l ' . FileName() . ' 2> /tmp/vim_save')
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
