" 
" cvsgit
"
"

" variaveis globais para guardar ultima tag e tipo de commit
" usados na funcao inputdialog
let g:commitInputTag = ''
let g:commitInputTipo = ''

"
" adiciona aruqivo a lista para commit
"
function! CvsGit(sArgumentos) 

  " arquivo em php que adiciona arquivo a lista para commit 
  let commitArquivo = '~/.vim/plugin/cvsgit/cvsgit '

  " caso passar argumentos para a funcao, exemplo: :CvsGit -m 'mensagem do  comit' -t 99999 -fix 
  if !empty(a:sArgumentos)

    let commitArquivo .= a:sArgumentos

  " Funcao chamada sem parametro, pergunta mensagem, tag e tipo de commit
  else

    let l:commitMensagem = inputdialog('mensagem: ') 
    let l:commitTag      = inputdialog('tag: ', g:commitInputTag)
    let l:commitTipo     = inputdialog('tipo: ', g:commitInputTipo)

    let commitArquivo .= 'add -m "' . l:commitMensagem . '" -t '. l:commitTag.' -'. l:commitTipo

    " guarga ultima tag digitada para mostrar no proximo commit
    if !empty(l:commitTag) 
      let g:commitInputTag = l:commitTag
    endif

    " guarga ultimo tipo de commit digitado para mostrar no proximo commit
    if !empty(l:commitTipo) 
      let g:commitInputTipo = l:commitTipo
    endif

  endif

  "exec '!clear & '.commitArquivo . ' ' . FileName()

  " executa cvsgit em php e guarda retorno na variavel respostaArquivo
  let respostaArquivo = system(commitArquivo . ' ' . FileName())

  " cvsgit respondeu com erro, mostra na tela o erro
  if v:shell_error || respostaArquivo != ""
    echohl WarningMsg | echon "\r" . respostaArquivo 
    return
  endif

endfunction;

" registra comando CvsGit que pode ter 1 ou nenhum argumento
command! -nargs=? -complete=buffer CvsGit call CvsGit("<args>")
command! -nargs=? -complete=buffer CG call CvsGit("<args>")
