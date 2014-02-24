" 
" cvsgit - Algumas Funcionalidas do GIT para CVS
"

" variaveis globais para guardar ultima tag e tipo de commit
" usados na funcao inputdialog
let g:commitInputTag = ''
let g:commitInputTipo = ''

let s:sNomeJanelaCVSGIT = "CVSGIT"

"
" adiciona aruqivo a lista para commit
"
function! Cvsgit(sArgumentos) 

  call l:CloseWindow()
  " arquivo em php que adiciona arquivo a lista para commit 
  let commitArquivo = 'cvsgit '
  let s:arquivo = PathName() . '/' . FileName()

  if empty(a:sArgumentos)
    return
  endif

  let commitArquivo .= a:sArgumentos
  let commando = split(a:sArgumentos, ' ')[0]

  if commando == 'add'
    let commitArquivo .= ' ' . s:arquivo 
  endif

  if commando == 'log'
    let commitArquivo .= ' ' . s:arquivo 
  endif

  " executa cvsgit em php e guarda retorno na variavel respostaArquivo
  let respostaArquivo = system(commitArquivo . ' > /tmp/cvsgit_output_vim')

  " cvsgit respondeu com erro, mostra na tela o erro
  if v:shell_error 
    echohl WarningMsg | echon "\r " . respostaArquivo 
    return
  endif

  if commando == 'add'
    let respostaArquivo = system('cat /tmp/cvsgit_output_vim')

    if !empty(respostaArquivo)
      echohl WarningMsg | echon "\n\r " . respostaArquivo 
    endif

    return
  endif

  return l:CriarJanela()

endfunction;

function! l:CloseWindow() 

  if bufwinnr(s:sNomeJanelaCVSGIT) == -1
    return
  endif

  execute bufwinnr(s:sNomeJanelaCVSGIT) . 'wincmd w'
  execute bufwinnr(s:sNomeJanelaCVSGIT) . 'wincmd q'

endfunction

function! l:CriarJanela() abort

  exe "silent keepalt botright split [cvsgit]"

  exe ':%d'
  silent read /tmp/cvsgit_output_vim
  exe ':0d'

  " exe 'resize 10'

  " if line('$') < 10 
    exe 'resize ' . line('$')
  " endif

  setlocal filetype=cvsgit
  setlocal buftype=nofile
	setlocal bufhidden=delete
  setlocal nobackup
  setlocal noswapfile
  setlocal nobuflisted
  setlocal nolist
  setlocal cursorline
  setlocal nonumber
  setlocal nowrap
  setlocal winfixwidth
  setlocal textwidth=0
  setlocal nospell
  setlocal nofoldenable
  setlocal foldcolumn=0
  setlocal foldmethod&
  setlocal foldexpr&

  silent! bd! s:sNomeJanelaCVSGIT
	silent! file! `=s:sNomeJanelaCVSGIT`

endfunction

" registra comando Cvsgit que pode ter 1 ou nenhum argumento
" Tab completa com nome dos arquivos abertos
command! -nargs=? -complete=buffer Cvsgit call Cvsgit("<args>")
command! -nargs=? -complete=buffer CG call Cvsgit("<args>")
