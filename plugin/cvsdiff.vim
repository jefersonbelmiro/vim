" vim plugin for cvs diff 
" description:
"   vim plugin to use vim split diff on cvs

let s:debug        = 0
let s:debug_file   = '/tmp/debugcvs'
let s:inicializado = 0
let s:cvsRevisions = []

" s:LogDebugMessage() {{{2
function! s:LogDebugMessage(msg) abort
  if s:debug
    execute 'redir >> ' . s:debug_file
    silent echon strftime('%H:%M:%S') . ': ' . a:msg . "\n"
    redir END
  endif
endfunction

function! GenerateStatusline() abort
  return '[CVS Diff]'
endfunction

" s:InitWindow() {{{2
function! s:InitWindow() abort

  call s:LogDebugMessage('InitWindow Called')
  let s:inicializado = 1 

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

  call s:LogDebugMessage('InitWindow finished')

endfunction

function! s:MapKeys() abort

  call s:LogDebugMessage('Mapping keys')
  nnoremap <script> <silent> <buffer> <CR>  :call Processar()<CR>
  nnoremap <script> <silent> <buffer> <ESC> :call Sair()<CR>
  nnoremap <script> <silent> <buffer> m     :call Selecionar()<CR>
  nnoremap <script> <silent> <buffer> q     :call Sair()<CR>

endfunction

function Cvsdiff() 

  call s:Init()
  call s:MapKeys()

endfunction

function s:Init() 

  let s:iJanelaMae = winnr()
  let s:sArquivo   = FileName()
  let s:sDiretorioAtual = system('pwd')

  echo 'Processando: Gerando log dos arquivos...'
  let comando = '/home/dbseller/.vim/plugin/cvsgit/cvsgit logvim ' . s:sArquivo . ' > /tmp/cvs'
  let comando = '~/.vim/plugin/cvsgit/cvsgit logvim ' . s:sArquivo . ' > /tmp/cvs'
  call Executar(comando)

  let s:cvsRevisions = []
  exe 'silent keepalt botright split  cvsdiff'

  if s:inicializado > 0 
    return
  endif

  call s:InitWindow()

endfunction

function! Sair() 

  exit
  "let numeroJanela = winnr()
  "execute numeroJanela . ' wincmd q'

endfunction

function! Processar() 

  if len(s:cvsRevisions) == 0 

    echo 'Nenhum arquivo selecionado'
    return

  endif

  echo 'Processando: Gerando arquivos...'
  let l:sVersoes = ''
  let l:sComandoCheckout = 'cvs checkout '
  let l:sProjeto = 'dbportal_prj/' | "@todo usar cvsgit para buscar projeto
  let l:sArquivo = expand('%:t')
  let l:sSeparador = '__'
  let l:sComandoMover = 'mv ' . l:sProjeto . s:sArquivo . ' /tmp/' . l:sArquivo . l:sSeparador
  exit

  if len(s:cvsRevisions) == 1 

    let l:sVersoes .= ' -r ' . s:cvsRevisions[0]
    call Executar(l:sComandoCheckout . '-r ' . s:cvsRevisions[0] . ' '.  l:sProjeto . s:sArquivo)
    call Executar(sComandoMover . s:cvsRevisions[0])

    exe 'tabnew ' . s:sArquivo
    exe 'vert diffsplit /tmp/' . l:sArquivo . l:sSeparador . s:cvsRevisions[0]

  endif

  if len(s:cvsRevisions) == 2 

    let l:sVersoes .= ' -r ' . s:cvsRevisions[0] . ' -r ' . s:cvsRevisions[1]
    call Executar(l:sComandoCheckout . '-r ' . s:cvsRevisions[0] . ' '.  l:sProjeto . s:sArquivo)
    call Executar(sComandoMover . s:cvsRevisions[0])
    call Executar(l:sComandoCheckout . '-r ' . s:cvsRevisions[1] . ' '.  l:sProjeto . s:sArquivo)
    call Executar(sComandoMover . s:cvsRevisions[1])

    exe 'tabnew /tmp/' . l:sArquivo . l:sSeparador . s:cvsRevisions[0]
    exe 'vert diffsplit /tmp/' . l:sArquivo . l:sSeparador . s:cvsRevisions[1]

  endif

  call Executar('mv -f ' . l:sProjeto . ' ' . tempname())
  "exe "normal \<C-W>L"

endfunction

" @see :help matchadd e matchdelete
function! Selecionar() 

  let linha   = getline('.')
  let versao  = split(linha, ' ')[0]

  if get(s:cvsRevisions, 1, 0) > 0 
    return
  endif

  "for i in s:cvsRevisions 
  "  if i == versao 
  "    echo "versao atual: " . i
  "    exe 'call matchdelete("'. i .'")'
  "    return
  "  endif
  "endfor

  let versoes = add(s:cvsRevisions, versao)
  "let versoes = insert(s:cvsRevisions, versao, atual)

  exe 'call matchadd("WildMenu", "' . linha . '")'
  "echo 'Versao: ' . versao . ' lista: ' . join(s:cvsRevisions, ', ')

endfunction

function! Executar(comando) 

  let retorno = system(a:comando)

  if v:shell_error && retorno != ""
    echohl WarningMsg | echon retorno 
    return
  endif

  return retorno

endfunction
