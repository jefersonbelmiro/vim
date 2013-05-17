" vim plugin for cvs diff 
" description:
"   vim plugin to use vim split diff on cvs
" maintainer:  Eric Ji <eji@yahoo-inc.com>
"
" usage:
" 1) install
"    copy this file to your vim plugin directory, normally ~/.vim/plugin
"    if not, can manally source this file in vim or add into ~/.vimrc
"    :source cvsdiff.vim
" 2) used as vim command, format :Cvsdiff [v] [version #]
"    :Cvsdiff     
"       -- diff between opened file and lastest cvs version, horizontal split
"    :Cvsdiff     
"       -- diff between opened file and lastest cvs version, vertical split
"    :Cvsdiff <version #>  example  :Cvsdiff 1.2
"       -- diff between opened file and cvs version #, horizontal split
"    :Cvsdiff v <version #>  example  :Cvsdiff v 1.2
"       -- diff between opened file and cvs version #, vertical split
" 3) map to key 
"    can create mapping in ~/.vimrc, example
"    a. map <F8> <Plug>Cvsdiff
"         -- press F8 in vim, show diff to cvs last version, horizontal split
"    b. map <F7> <Plug>Cvsdiffv
"         -- press F8 in vim, show diff to cvs last version, vertical split
" 4) return from diff mode to normal mode
"    :set nodiff

"if exists("loaded_cvsdiff") || &cp
"    finish
"endif
"let loaded_cvsdiff = 1
"
"noremap <unique> <script> <Plug>Cvsdiff :call <SID>Cvsdiff()<CR>
"noremap <unique> <script> <plug>Cvsdiffv :call <SID>Cvsdiff("v")<CR>
"com! -bar -nargs=? Cvsdiff :call s:Cvsdiff(<f-args>)
"
"function! s:Cvsdiff(...)
"    if a:0 > 1
"        let rev = a:2
"    else
"        let rev = ''
"    endif
"
"    let ftype = &filetype
"    let tmpfile = tempname()
"    let cmd = "cat " . bufname("%") . " > " . tmpfile
"    let cmd_output = system(cmd)
"    let tmpdiff = tempname()
"    let cmd = "cvs diff" . rev . " " . bufname("%") . " > " . tmpdiff
"    let cmd_output = system(cmd)
"    if v:shell_error && cmd_output != ""
"        echohl WarningMsg | echon cmd_output 
"        return
"    endif
"
"    let cmd = "patch -R -p0 " . tmpfile . " " . tmpdiff
"    let cmd_output = system(cmd)
"    if v:shell_error && cmd_output != ""
"        echohl WarningMsg | echon cmd_output 
"        return
"    endif
"
"    if a:0 > 0 && a:1 == "v"
"        exe "vert diffsplit" . tmpfile
"    else
"        exe "diffsplit" . tmpfile
"    endif  
"
"    exe "set filetype=" . ftype
"endfunction


let s:debug = 0
let s:debug_file = '/tmp/debugcvs'
let s:inicializado = 0
let g:cvsRevisions = []

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
    exe 'resize 15'

	  if line('$') < 15 
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
    nnoremap <script> <silent> <buffer> <CR>    :call Processar()<CR>
    nnoremap <script> <silent> <buffer> <ESC>   :call Sair()<CR>
    nnoremap <script> <silent> <buffer> m       :call Selecionar()<CR>
    nnoremap <script> <silent> <buffer> q       :call Sair()<CR>

endfunction


function Cvsdiff() 

  "call s:CreateAutocommands()
  call s:Init()
  call s:MapKeys()

endfunction

function s:Init() 

  let arquivo = FileName()
  let comando = '/home/dbseller/.vim/plugin/cvsgit/cvsgit logvim ' . arquivo . ' > /tmp/cvs'
  let arquivos = system(comando)

  let g:cvsRevisions = []
  exe 'silent keepalt botright split  cvsdiff'
  let autoclose = 'autoclose'

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


  if len(g:cvsRevisions) == 1 
    echo ' -r ' . g:cvsRevisions[0]
  endif

  if len(g:cvsRevisions) == 2 
    echo ' -r ' . g:cvsRevisions[0] . ' -r ' . g:cvsRevisions[1]
  endif

  let numeroJanela = winnr()

  exe 'tabnew ' 

  "if bufwinnr("__Tagbar__") != -1 
  execute numeroJanela . ' noautocmd wincmd q'
  "execute 'noautocmd wincmd p'

endfunction

" @see :help matchadd e matchdelete
function! Selecionar() 
  
  let linha   = getline('.')
  let versao  = split(linha, ' - ')[0]

  if get(g:cvsRevisions, 1, 0) > 0 
    return
  endif

  "for i in g:cvsRevisions 
  "  if i == versao 
  "    echo "versao atual: " . i
  "    exe 'call matchdelete("'. i .'")'
  "    return
  "  endif
  "endfor

  let versoes = add(g:cvsRevisions, versao)
  "let versoes = insert(g:cvsRevisions, versao, atual)
  
  exe 'call matchadd("WildMenu", "' . linha . '")'
  "echo 'Versao: ' . versao . ' lista: ' . join(g:cvsRevisions, ', ')

endfunction
