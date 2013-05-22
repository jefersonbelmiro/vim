" vim plugin for cvs diff 
" description:
"   vim plugin to use vim split diff on cvs

" ligar debug
let s:lDebug = 0

" arquivo do debug
let s:debug_file = '/tmp/debugcvs'

" janela do cvsdiff ja iniciada
let s:lJanelaCriada = 0

" string com erro dos comandos executados
" @see Executar
let s:sErroExecutar = ''

" Objeto com versoes a serem comparadas
let s:oVersoes = {}
let s:oVersoes.primeiraVersao  = ''
let s:oVersoes.primeiraSelecao = ''
let s:oVersoes.segundaVersao   = ''
let s:oVersoes.segundaSelecao  = ''

"
" Gera log da execucao do script
"
function! s:LogDebugMessage(msg) abort

  if s:lDebug

    execute 'redir >> ' . s:debug_file
    silent echon strftime('%H:%M:%S') . ': ' . a:msg . "\n"
    redir END

  endif

endfunction

function! GenerateStatusline() abort
  return expand('%:t')
endfunction

function! s:CriarJanela() abort

  let s:lJanelaCriada = 1 

  setlocal filetype=cvsdiff

  silent read /tmp/cvs
  exe ':0d'
  setlocal noreadonly     " in case the "view" mode is used
  setlocal buftype=nofile
  setlocal bufhidden=hide
  setlocal nobackup
  setlocal noswapfile
  setlocal nobuflisted
  setlocal nomodifiable
  setlocal nolist
  setlocal cursorline
  setlocal nonumber
  setlocal nowrap
  setlocal winfixwidth
  setlocal textwidth=0
  setlocal nospell

  exe 'resize 10'

  if line('$') < 10 
    exe 'resize ' . line('$')
  endif

  if exists('+relativenumber')
    setlocal norelativenumber
  endif

  setlocal encoding=UTF8
  setlocal nofoldenable
  setlocal foldcolumn=0

  " Reset fold settings in case a plugin set them globally to something
  " expensive. Apparently 'foldexpr' gets executed even if 'foldenable' is
  " off, and then for every appended line (like with :put).
  setlocal foldmethod&
  setlocal foldexpr&

  " Earlier versions have a bug in local, evaluated statuslines
  if v:version > 701 || (v:version == 701 && has('patch097'))
    setlocal statusline=%!GenerateStatusline()
  else
    setlocal statusline=cvsdiff
  endif

  let cpoptions_save = &cpoptions
  set cpoptions&vim

endfunction

function! s:MapKeys() abort

  nnoremap <script> <silent> <buffer> <CR>  :call Processar()<CR>
  nnoremap <script> <silent> <buffer> <ESC> :call Sair()<CR>
  nnoremap <script> <silent> <buffer> m     :call Selecionar()<CR>
  nnoremap <script> <silent> <buffer> q     :call Sair()<CR>

endfunction

function Cvsdiff() 

  call s:Bootstrap()
  call s:MapKeys()

endfunction

function s:Bootstrap() 

  let s:iJanelaMae  = winnr()
  let s:sArquivo    = FileName()
  let l:sComandoLog = $HOME . '/.vim/plugin/cvsgit/cvsgit logvim ' . s:sArquivo . ' > /tmp/cvs'

  call Executar(l:sComandoLog)
  call LimparVersoes()

  exe 'silent keepalt botright split  cvsdiff'

  if s:lJanelaCriada > 0 
    return
  endif

  call s:CriarJanela()

endfunction

function! LimparVersoes() 

  let s:oVersoes.primeiraVersao  = ''
  let s:oVersoes.primeiraSelecao = ''
  let s:oVersoes.segundaVersao   = ''
  let s:oVersoes.segundaSelecao  = ''

endfunction

function! Sair() 

  exit
  "let numeroJanela = winnr()
  "execute numeroJanela . ' wincmd q'

endfunction

"
" Processar, abre aba com diffs
"
function! Processar() 

  try 

    let l:sLinhaCursor  = getline('.')
    let l:nVersaoCursor = split(l:sLinhaCursor, ' ')[0]

    " fecha janela com as versoes
    exit

    let l:sVersoes         = ''
    let l:sPathArquivos    = '/tmp/'
    let l:sComandoCheckout = 'cvs checkout '
    let l:sProjeto         = 'dbportal_prj/' | "@todo usar cvsgit para buscar projeto
    let s:sArquivo         = FileName()
    let l:sArquivo         = expand('%:t')
    let l:sSeparador       = '__'
    let l:sComandoMover    = 'mv ' . l:sProjeto . s:sArquivo . ' '. l:sPathArquivos . l:sArquivo . l:sSeparador
    let l:sComandoDiff     = 'vert diffsplit ' . l:sPathArquivos

    " Nao selecionou versao para comparar
    " Abre nova aba com versao da linha do cursor
    if empty(s:oVersoes.primeiraVersao)

      call Executar(l:sComandoCheckout . '-r ' . l:nVersaoCursor . ' '.  l:sProjeto . s:sArquivo)
      call Executar(sComandoMover . l:nVersaoCursor)

      exe 'tabnew ' . l:sPathArquivos . l:sArquivo . l:sSeparador . l:nVersaoCursor
      return

    endif

    " selecinou 1 versao apenas
    if empty(s:oVersoes.segundaVersao)

      let l:sVersoes .= ' -r ' . s:oVersoes.primeiraVersao
      call Executar(l:sComandoCheckout . '-r ' . s:oVersoes.primeiraVersao . ' '.  l:sProjeto . s:sArquivo)
      call Executar(sComandoMover . s:oVersoes.primeiraVersao)

      exe 'tabnew ' . s:sArquivo
      exe l:sComandoDiff . l:sArquivo . l:sSeparador . s:oVersoes.primeiraVersao

    else

      let l:sVersoes .= ' -r ' . s:oVersoes.primeiraVersao . ' -r ' . s:oVersoes.segundaVersao
      call Executar(l:sComandoCheckout . '-r ' . s:oVersoes.primeiraVersao . ' '.  l:sProjeto . s:sArquivo)
      call Executar(sComandoMover . s:oVersoes.primeiraVersao)
      call Executar(l:sComandoCheckout . '-r ' . s:oVersoes.segundaVersao . ' '.  l:sProjeto . s:sArquivo)
      call Executar(sComandoMover . s:oVersoes.segundaVersao)

      exe 'tabnew ' . l:sPathArquivos . l:sArquivo . l:sSeparador . s:oVersoes.primeiraVersao
      exe l:sComandoDiff . l:sArquivo . l:sSeparador . s:oVersoes.segundaVersao

    endif

    " remove pasta do projeto criada pelo cvs checkout
    call Executar('mv -f ' . l:sProjeto . ' ' . tempname())

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

endfunction
