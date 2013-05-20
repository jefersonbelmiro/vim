" vim plugin for cvs diff 
" description:
"   vim plugin to use vim split diff on cvs

" ligar debug
let s:lDebug = 0

" arquivo do debug
let s:debug_file   = '/tmp/debugcvs'

let s:lJanelaCriada = 0

let s:oVersoes = {}
let s:oVersoes.primeiraVersao  = ''
let s:oVersoes.primeiraSelecao = ''
let s:oVersoes.segundaVersao   = ''
let s:oVersoes.segundaSelecao  = ''

function! s:LogDebugMessage(msg) abort

  if s:lDebug

    execute 'redir >> ' . s:debug_file
    silent echon strftime('%H:%M:%S') . ': ' . a:msg . "\n"
    redir END

  endif

endfunction

function! GenerateStatusline() abort
  return '[CVS Diff]'
endfunction

function! s:CriarJanela() abort

  let s:lJanelaCriada = 1 

  setlocal filetype=cvsdiff

  silent read /tmp/cvs
  exe ':0d'
  setlocal noreadonly " in case the "view" mode is used
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

  let s:iJanelaMae = winnr()
  let s:sArquivo   = FileName()
  let s:sDiretorioAtual = system('pwd')

  let comando = $HOME . '/.vim/plugin/cvsgit/cvsgit logvim ' . s:sArquivo . ' > /tmp/cvs'
  call Executar(comando)
  
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

function! Processar() 

  if empty(s:oVersoes.primeiraVersao)

    echohl WarningMsg | echo 'Nenhuma versao selecionada'
    return

  endif

  exit

  let l:sVersoes = ''
  let l:sComandoCheckout = 'cvs checkout '
  let l:sProjeto = 'dbportal_prj/' | "@todo usar cvsgit para buscar projeto
  let l:sArquivo = expand('%:t')
  let l:sSeparador = '__'
  let l:sComandoMover = 'mv ' . l:sProjeto . s:sArquivo . ' /tmp/' . l:sArquivo . l:sSeparador

  " selecinou 1 versao apenas
  if empty(s:oVersoes.segundaVersao)

    let l:sVersoes .= ' -r ' . s:oVersoes.primeiraVersao
    call Executar(l:sComandoCheckout . '-r ' . s:oVersoes.primeiraVersao . ' '.  l:sProjeto . s:sArquivo)
    call Executar(sComandoMover . s:oVersoes.primeiraVersao)

    exe 'tabnew ' . s:sArquivo
    exe 'vert diffsplit /tmp/' . l:sArquivo . l:sSeparador . s:oVersoes.primeiraVersao

  else

    let l:sVersoes .= ' -r ' . s:oVersoes.primeiraVersao . ' -r ' . s:oVersoes.segundaVersao
    call Executar(l:sComandoCheckout . '-r ' . s:oVersoes.primeiraVersao . ' '.  l:sProjeto . s:sArquivo)
    call Executar(sComandoMover . s:oVersoes.primeiraVersao)
    call Executar(l:sComandoCheckout . '-r ' . s:oVersoes.segundaVersao . ' '.  l:sProjeto . s:sArquivo)
    call Executar(sComandoMover . s:oVersoes.segundaVersao)

    exe 'tabnew /tmp/' . l:sArquivo . l:sSeparador . s:oVersoes.primeiraVersao
    exe 'vert diffsplit /tmp/' . l:sArquivo . l:sSeparador . s:oVersoes.segundaVersao

  endif

  " remove pasta do projeto criada pelo cvs checkout
  call Executar('mv -f ' . l:sProjeto . ' ' . tempname())

  exe "normal \<C-W>L"
  exe "normal \<C-h>"

endfunction

" @see :help matchadd e matchdelete
function! Selecionar() 

  let sLinha  = getline('.')
  let nVersao = split(sLinha, ' ')[0]

  if ( nVersao == s:oVersoes.primeiraVersao )

    call matchdelete(s:oVersoes.primeiraSelecao)
    let s:oVersoes.primeiraVersao = ''
    return

  endif

  if ( nVersao == s:oVersoes.segundaVersao )

    call matchdelete(s:oVersoes.segundaSelecao)
    let s:oVersoes.segundaVersao = ''
    return

  endif

  " ja selecionou 2 versoes
  if !empty(s:oVersoes.segundaVersao) && !empty(s:oVersoes.primeiraVersao)
    return
  endif

  if empty(s:oVersoes.primeiraVersao) 

    let s:oVersoes.primeiraVersao  = nVersao
    let s:oVersoes.primeiraSelecao = matchadd("WildMenu", sLinha)

  else 

    let s:oVersoes.segundaVersao  = nVersao
    let s:oVersoes.segundaSelecao = matchadd("WildMenu", sLinha)

  endif

endfunction

function! Executar(comando) 

  let retorno = system(a:comando)

  if v:shell_error && retorno != ""
    echohl WarningMsg | echon retorno 
    return
  endif

  return retorno

endfunction
