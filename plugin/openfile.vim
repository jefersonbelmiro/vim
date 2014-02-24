
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

