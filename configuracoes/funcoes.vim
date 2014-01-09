"""""""""""""""""""""""""""""""""""
"       FUN??ES PERSONALIZADAS
"""""""""""""""""""""""""""""""""""
let g:diretorioArquivoTags = $VIMROOT . "/runtime/tags/"
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


function! AtualizaTags()

  let iOpcao              = confirm("Atualizar Tags??? Qual projeto?", "&zDBPortal_prj\n&xFuncoes8\n&cDBPref", 2)

  let aEscolhas           = { 1 : "dbportal_prj",
                            \ 2 : "funcoes8",
                            \ 3 : "dbpref"}
  let sProjeto            = aEscolhas[iOpcao]
  let sCaminhoArquivoTags = g:diretorioArquivoTags . sProjeto ."_tags"

  " ctags -R --fields=+aimS --languages=php
  " execute "!ctags -f " . sCaminhoArquivoTags . " -R --fields=+aimS --languages=php /var/www/" . sProjeto . "/ "
  execute "!ctags -f " . sCaminhoArquivoTags . " -R /var/www/" . sProjeto . "/ "
endfunction

function! FileName()
  return expand('%:t')
endfunction

function! PathName()
  return expand('%:p:h')
endfunction

if !exists('g:default_tab_width')
  let g:default_tab_width = 2
endif

function! PadraoISO() 

  execute 'set encoding=ISO-8859-1'
  execute 'set fileencoding=ISO-8859-1'
  " ao abrir aquivo ja formata
  "execute 'set fileencodings=ISO-8859-1'
  execute 'set ts=' . g:default_tab_width
  execute 'set softtabstop=' . g:default_tab_width
  execute 'set shiftwidth=' . g:default_tab_width

endfunction

function! PadraoUTF() 

  execute 'set encoding=UTF-8'
  execute 'set fileencoding=UTF-8'
  " ao abrir aquivo ja formata
  "execute 'set fileencodings=UTF-8'
  execute 'set ts=' . g:default_tab_width
  execute 'set softtabstop=' . g:default_tab_width
  execute 'set shiftwidth=' . g:default_tab_width

endfunction

function! Save() 

  try 

    silent execute ':w'
    silent execute ':set scr=4'
    silent execute ':set ft=' . &filetype

    if &filetype == 'php'
      call s:Executar('php -l ' . expand('%') . ' 2> /tmp/vim_save')
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

" command! -nargs=1 Silent
" \ | execute ':silent !'.<q-args>
" \ | execute ':redraw!'
function! ExecuteBackground(command, title)
  execute "silent !" . a:command. " > /dev/null 2>&1 && " .
        \ "/usr/bin/notify-send \"" . a:title . "\" complete &"
  execute ':redraw!'
endfunction

function! AutocompleteToggle() 
  if exists('g:neocomplcache_disable_auto_complete') && g:neocomplcache_disable_auto_complete == 1
    let g:neocomplcache_enable_at_startup     = 1  
    let g:neocomplcache_disable_auto_complete = 0
    echo "Autocomplete [ON]"
  else
    let g:neocomplcache_enable_at_startup     = 0  
    let g:neocomplcache_disable_auto_complete = 1
    echo "Autocomplete [OFF]"
  endif
endfunction

command! AutocompleteToggle :call AutocompleteToggle()

function! OpenFile() 

  let s:file = expand('<cfile>')
  let s:bufferNumberFile = buffer_number(s:file)
  let s:command = ''

	let ids = sort(filter(range(1, bufnr('$')), 'empty(getbufvar(v:val, "&bt"))'
        \ .' && getbufvar(v:val, "&bl")'))

  let bufs = [[], []]

  for id in ids

    let s:buffersTabs = s:buffersTabs(id)

    if s:bufferNumberFile == id
      if s:buffersTabs[1] != 0
        let s:command = 'tabnext ' . s:buffersTabs[0]
      else
        let s:command = 'tabnew | buffer ' . id
      endif
    endif

  endfo

  if empty(s:command)

    if !filereadable(s:file) 
      echo "Arquivo nao encontrado: " . s:file
      return
    endif

    let s:command = 'tabnew ' . s:file
  endif
  
  exe s:command

endfunction

function! s:buffersTabs(bufnr)
	for tabnr in range(1, tabpagenr('$'))
		if tabpagenr() == tabnr
      continue
    endif
		let buflist = tabpagebuflist(tabnr)
		if index(buflist, a:bufnr) >= 0
			for winnr in range(1, tabpagewinnr(tabnr, '$'))
				if buflist[winnr - 1] == a:bufnr | retu [tabnr, winnr] | en
			endfor
    endif
	endfor
	return [0, 0]
endfunction

command! OpenFile :call OpenFile()

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

  if has("gui_running")                       
    execute 'source ' . g:configPath . 'gvim.vim'
  else 
    execute 'source ' . g:configPath . 'cores.vim'
  endif 

endfunction


