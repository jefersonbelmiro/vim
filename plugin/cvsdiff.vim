" vim plugin for cvs diff 
" description:
"   vim plugin to use vim split diff on cvs

" ligar debug
let s:lDebug = 0

" arquivo do debug
let s:sDebugFile = '/tmp/debugcvs'

" Objeto com versoes a serem comparadas
let s:oVersoes = {}
let s:oVersoes.primeiraVersao  = ''
let s:oVersoes.primeiraSelecao = ''
let s:oVersoes.segundaVersao   = ''
let s:oVersoes.segundaSelecao  = ''

let s:lFecharJanela = 1

"
" Gera log da execucao do script
"
function! s:LogDebugMessage(msg) abort

  if s:lDebug

    execute 'redir >> ' . s:sDebugFile
    silent echon strftime('%H:%M:%S') . ': ' . a:msg . "\n"
    redir END

  endif

endfunction

function! GenerateStatusline() abort
  return s:sArquivo
endfunction

function! s:CriarJanela() abort

  exe 'silent keepalt botright split ' . expand('%:t') . '[cvsdiff]'

  setlocal modifiable
  setlocal noreadonly 
  exe ':%d'
  silent read /tmp/cvslogvim
  exe ':0d'

  exe 'resize 10'

  if line('$') < 10 
    exe 'resize ' . line('$')
  endif

  setlocal fenc=latin1
  setlocal encoding=latin1
  setlocal fileencoding=latin1
  setlocal fileencodings=latin1
  setlocal filetype=cvsdiff
  setlocal buftype=nofile
  setlocal bufhidden=hide
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

  "setlocal statusline=%!GenerateStatusline()
  setlocal statusline=cvsdiff
  setlocal nomodifiable

endfunction

function! s:MapKeys() abort

  nnoremap <script> <silent> <buffer> <CR>  :call Processar()<CR>
  nnoremap <script> <silent> <buffer> <ESC> :call Sair()<CR>
  nnoremap <script> <silent> <buffer> m     :call Selecionar()<CR>
  nnoremap <script> <silent> <buffer> q     :call Sair()<CR>

endfunction

function Cvsdiff(argumentos) 

  call s:LimparVersoes()

  if !empty( a:argumentos ) 

    let l:aArgumentos = split(a:argumentos, ' ')

    for sArgumento in l:aArgumentos 
      
      if empty(sArgumento)
        continue
      endif

      if empty(s:oVersoes.primeiraVersao)
        let s:oVersoes.primeiraVersao = sArgumento
        continue
      endif

      if empty(s:oVersoes.segundaVersao)
        let s:oVersoes.segundaVersao = sArgumento
        continue
      endif

    endfor

    let s:lFecharJanela = 0
    call s:Bootstrap()
    call Processar()
    return

  endif

  call s:Bootstrap()
  call s:CriarJanela()
  call s:MapKeys()

endfunction

function s:Bootstrap() 

  try 

    if !filereadable('CVS/Repository')
      throw 'Projeto CVS nao encontrado'
    endif

    let s:sProjeto  = split(Executar('cat CVS/Repository'))[0] . '/'
    let s:sArquivo  = FileName()
    let s:sFileType = &filetype

    let s:sEncoding      = &encoding
    let s:sFileEncoding  = &fileencoding
    let s:sFileEncodings = &fileencodings

    setlocal termencoding=latin1

    call Executar($HOME . '/.vim/plugin/cvsgit/cvsgit logvim ' . s:sArquivo)

  catch
    echohl WarningMsg | echon "Erro:\n" . v:exception 
  endtry

endfunction

function! s:LimparVersoes() 

  let s:oVersoes.primeiraVersao  = ''
  let s:oVersoes.primeiraSelecao = ''
  let s:oVersoes.segundaVersao   = ''
  let s:oVersoes.segundaSelecao  = ''

endfunction

function! Sair() 

  if ( s:lFecharJanela > 0 )  
    exit
  endif
  setlocal termencoding=utf8

endfunction

"
" Processar, abre aba com diffs
"
function! Processar() 

  try 

    let l:sLinhaCursor  = getline('.')
    let l:nVersaoCursor = split(l:sLinhaCursor, ' ')[0]

    " fecha janela com as versoes
    call Sair()

    let l:sVersoes         = ''
    let l:sPathArquivos    = '/tmp/'
    let l:sComandoCheckout = 'cvs checkout '
    let s:sArquivo         = FileName()
    let l:sArquivo         = expand('%:t')
    let l:sSeparador       = '__'
    let l:sComandoMover    = 'mv ' . s:sProjeto . s:sArquivo . ' '. l:sPathArquivos . l:sArquivo . l:sSeparador
    let l:sComandoDiff     = 'vert diffsplit ' . l:sPathArquivos

    " Nao selecionou versao para comparar
    " Abre nova aba com versao da linha do cursor
    if empty(s:oVersoes.primeiraVersao)

      call Executar(l:sComandoCheckout . '-r ' . l:nVersaoCursor . ' '.  s:sProjeto . s:sArquivo)
      call Executar(sComandoMover . l:nVersaoCursor)

      exe 'tabnew ' . l:sPathArquivos . l:sArquivo . l:sSeparador . l:nVersaoCursor
      exe 'setlocal filetype=' . s:sFileType
      return

    endif

    " selecinou 1 versao apenas
    if empty(s:oVersoes.segundaVersao)

      let l:sVersoes .= ' -r ' . s:oVersoes.primeiraVersao
      call Executar(l:sComandoCheckout . '-r ' . s:oVersoes.primeiraVersao . ' '.  s:sProjeto . s:sArquivo)
      call Executar(sComandoMover . s:oVersoes.primeiraVersao)

      exe 'tabnew ' . s:sArquivo
      exe l:sComandoDiff . l:sArquivo . l:sSeparador . s:oVersoes.primeiraVersao
      exe 'setlocal filetype=' . s:sFileType

    else

      let l:sVersoes .= ' -r ' . s:oVersoes.primeiraVersao . ' -r ' . s:oVersoes.segundaVersao
      call Executar(l:sComandoCheckout . '-r ' . s:oVersoes.primeiraVersao . ' '.  s:sProjeto . s:sArquivo)
      call Executar(sComandoMover . s:oVersoes.primeiraVersao)
      call Executar(l:sComandoCheckout . '-r ' . s:oVersoes.segundaVersao . ' '.  s:sProjeto . s:sArquivo)
      call Executar(sComandoMover . s:oVersoes.segundaVersao)

      exe 'tabnew ' . l:sPathArquivos . l:sArquivo . l:sSeparador . s:oVersoes.primeiraVersao
      exe 'setlocal filetype=' . s:sFileType
      exe l:sComandoDiff . l:sArquivo . l:sSeparador . s:oVersoes.segundaVersao
      exe 'setlocal filetype=' . s:sFileType

    endif

    " remove pasta do projeto criada pelo cvs checkout
    call Executar('mv -f ' . s:sProjeto . ' ' . tempname())

    " Troca lado dos splits do diff e retorna cursor pra primeiro split
    exe "normal \<C-W>L"
    exe "normal \<C-h>"

  catch
    echohl WarningMsg | echon "Erro:\n" . v:exception 
  endtry

endfunction

"
" Selecionar linha
"
function! Selecionar() 

  let sLinha  = getline('.')
  let nVersao = split(sLinha, ' ')[0]

  " Remove selecao da primeira versao
  if ( nVersao == s:oVersoes.primeiraVersao )

    call matchdelete(s:oVersoes.primeiraSelecao)
    let s:oVersoes.primeiraVersao = ''
    return

  endif

  " Remove selecao da segunda versao
  if ( nVersao == s:oVersoes.segundaVersao )

    call matchdelete(s:oVersoes.segundaSelecao)
    let s:oVersoes.segundaVersao = ''
    return

  endif

  " ja selecionou 2 versoes, retorna funcao
  if !empty(s:oVersoes.segundaVersao) && !empty(s:oVersoes.primeiraVersao)
    return
  endif

  " seleciona primeira e segunda versao
  if empty(s:oVersoes.primeiraVersao) 

    let s:oVersoes.primeiraVersao  = nVersao
    let s:oVersoes.primeiraSelecao = matchadd("WildMenu", sLinha)

  else 

    let s:oVersoes.segundaVersao  = nVersao
    let s:oVersoes.segundaSelecao = matchadd("WildMenu", sLinha)

  endif

endfunction

"
" Executa um comando e retorna resposta do comando ou erro
"
function! Executar(comando) 

  let l:retornoComando = system(a:comando)

  if v:shell_error 
    throw l:retornoComando
  endif

  return l:retornoComando

endfunction

" registra comando Cvsdiff que pode ter 1 ou nenhum argumento
command! -nargs=? -complete=buffer Cvsdiff call Cvsdiff("<args>")
command! -nargs=? -complete=buffer CD      call Cvsdiff("<args>")
