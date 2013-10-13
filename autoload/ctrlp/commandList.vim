" =============================================================================
" File:          autoload/ctrlp/commandList.vim
" Description:   Command extension for ctrlp.vim
" =============================================================================

" Load guard
if ( exists('g:loaded_ctrlp_commandList') && g:loaded_ctrlp_commandList )
	\ || v:version < 700 || &cp
	finish
endif
let g:loaded_ctrlp_commandList = 1


" Add this extension's settings to g:ctrlp_ext_vars
"
" Required:
"
" + init: the name of the input function including the brackets and any
"         arguments
"
" + accept: the name of the action function (only the name)
"
" + lname & sname: the long and short names to use for the statusline
"
" + type: the matching type
"   - line : match full line
"   - path : match full line like a file or a directory path
"   - tabs : match until first tab character
"   - tabe : match until last tab character
"
" Optional:
"
" + enter: the name of the function to be called before starting ctrlp
"
" + exit: the name of the function to be called after closing ctrlp
"
" + opts: the name of the option handling function called when initialize
"
" + sort: disable sorting (enabled by default when omitted)
"
" + specinput: enable special inputs '..' and '@cd' (disabled by default)
"
call add(g:ctrlp_ext_vars, {
	\ 'init': 'ctrlp#commandList#init()',
	\ 'accept': 'ctrlp#commandList#accept',
	\ 'lname': 'Comandos registrados',
	\ 'sname': 'comandos',
	\ 'type': 'tabe',
	\ 'enter': 'ctrlp#commandList#enter()',
	\ 'exit': 'ctrlp#commandList#exit()',
	\ 'opts': 'ctrlp#commandList#opts()',
	\ 'sort': 0,
	\ 'specinput': 0,
	\ })

let s:scriptPath = expand("<sfile>")
let s:sCommands  = expand("<sfile>")

" Provide a list of strings to search in
"
" Return: a Vim's List
"
function! ctrlp#commandList#init()

  let l:commandList = [
    \ {'sname' : 'log', 'lname' : 'Histórico de modificações do arquivo atual', 'command' : 'teste'},
    \ {'sname' : 'status', 'lname' : 'Verificar diferenças com o repositório'},
    \ {'sname' : 'push', 'lname' : 'Enviar modificações'},
  \ ]

  let l:commandLength = 1

  for l:command in l:commandList 
    if strlen(l:command.sname) > l:commandLength
      let l:commandLength = strlen(l:command.sname)
    endif
  endfor

  return map(copy(l:commandList), 'printf("%-' . l:commandLength . 's\t: %s", v:val.sname, v:val.lname)')
endfunction


" The action to perform on the selected string
"
" Arguments:
"  a:mode   the mode that has been chosen by pressing <cr> <c-v> <c-t> or <c-x>
"           the values are 'e', 'v', 't' and 'h', respectively
"  a:str    the selected string
"
function! ctrlp#commandList#accept(mode, str)

  " feedkeys(), envia teclas como se fosse o usuario
  call feedkeys(':')
  call feedkeys(split(a:str, '\t')[0])
  call feedkeys("\<CR>")
  return

	call ctrlp#exit()

  echo expand(s:self_path)
  return

  let l:line = split(a:str, "\t")
  let l:command = Strip(l:line[0])
  echo '"' . l:command . '"'
  CommandList
  echo 'mode: ' . a:mode . ' -- ' . a:str
endfunction


" (optional) Do something before enterting ctrlp
function! ctrlp#commandList#enter()
endfunction


" (optional) Do something after exiting ctrlp
function! ctrlp#commandList#exit()
endfunction


" (optional) Set or check for user options specific to this extension
function! ctrlp#commandList#opts()
endfunction


" Give the extension an ID
let s:id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)

" Allow it to be called later
function! ctrlp#commandList#id()
	return s:id
endfunction
