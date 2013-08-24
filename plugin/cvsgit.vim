" 
" cvsgit - Algumas Funcionalidas do GIT para CVS
"

" variaveis globais para guardar ultima tag e tipo de commit
" usados na funcao inputdialog
let g:commitInputTag = ''
let g:commitInputTipo = ''

"
" adiciona aruqivo a lista para commit
"
function! Cvsgit(sArgumentos) 

  " arquivo em php que adiciona arquivo a lista para commit 
  let commitArquivo = 'cvsgit '

  " caso passar argumentos para a funcao, exemplo: :Cvsgit -m 'mensagem do  comit' -t 99999 -fix 
  if !empty(a:sArgumentos)

    let commitArquivo .= a:sArgumentos

  " Funcao chamada sem parametro, pergunta mensagem, tag e tipo de commit
  else

    let l:commitMensagem = inputdialog('mensagem: ') 
    let l:commitTag      = inputdialog('tag: ', g:commitInputTag)
    let l:commitTipo     = inputdialog('tipo: ', g:commitInputTipo)

    let commitArquivo .= 'add '

    if !empty(l:commitMensagem)
      let commitArquivo .= ' --message="' . l:commitMensagem . '"'
    endif

    if !empty(l:commitTag)
      let commitArquivo .= ' --tag=' . l:commitTag
    endif

    if !empty(l:commitTipo)
      let commitArquivo .= ' -' . l:commitTipo
    endif

    " guarga ultima tag digitada para mostrar no proximo commit
    if !empty(l:commitTag) 
      let g:commitInputTag = l:commitTag
    endif

    " guarga ultimo tipo de commit digitado para mostrar no proximo commit
    if !empty(l:commitTipo) 
      let g:commitInputTipo = l:commitTipo
    endif

  endif

  " executa cvsgit em php e guarda retorno na variavel respostaArquivo
  let respostaArquivo = system(commitArquivo . ' ' . FileName() . ' > /tmp/cvsgit_output_vim')

  " cvsgit respondeu com erro, mostra na tela o erro
  if v:shell_error 
    echohl WarningMsg | echon "\r " . respostaArquivo 
    return
  endif

  if !empty(a:sArgumentos)

    let respostaArquivo = system('cat /tmp/cvsgit_output_vim')

    if !empty(respostaArquivo)
      exec '!clear & less /tmp/cvsgit_output_vim'
    endif

  endif

endfunction;

" registra comando Cvsgit que pode ter 1 ou nenhum argumento
" Tab completa com nome dos arquivos abertos
command! -nargs=? -complete=buffer Cvsgit call Cvsgit("<args>")
command! -nargs=? -complete=buffer CG call Cvsgit("<args>")
