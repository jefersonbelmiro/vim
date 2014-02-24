
" ignroa espacos
set diffopt+=iwhite
set diffexpr=""

map <F4> :qa<CR>

color jellybeans

" destaca linha atual do cursor
hi clear CursorLineNr
set cursorline

" remove todas as parafernalias visuais do gvim
" L - scroll da esquerda
" r - scroll da direita
" T - icones de opcoes(copiar, colar, voltar, bla bla)
if has("gui_running")

  set guioptions+=aegimrtTb

  hi cursor guibg=#f0f0f0 guifg=#222222

  " remove todos os icones
  aunmenu ToolBar.Open		
  aunmenu ToolBar.Save		
  aunmenu ToolBar.Undo		
  aunmenu ToolBar.Redo		
  aunmenu ToolBar.Cut			
  aunmenu ToolBar.Copy		
  aunmenu ToolBar.Paste		
  aunmenu ToolBar.Print		
  aunmenu ToolBar.Help		
  aunmenu ToolBar.SaveAll	 
  aunmenu ToolBar.SaveSesn 
  aunmenu ToolBar.LoadSesn 
  aunmenu ToolBar.RunScript	
  aunmenu ToolBar.Replace		
  aunmenu ToolBar.FindPrev 
  aunmenu ToolBar.FindNext 
  aunmenu ToolBar.FindHelp 
  aunmenu ToolBar.Make		
  aunmenu ToolBar.TagJump	 
  aunmenu ToolBar.RunCtags 
  aunmenu ToolBar.-sep1- 
  aunmenu ToolBar.-sep2- 
  aunmenu ToolBar.-sep3- 
  aunmenu ToolBar.-sep5- 
  aunmenu ToolBar.-sep6- 
  aunmenu ToolBar.-sep7- 

  tmenu ToolBar.FindPrev Modifiação anterior
  amenu ToolBar.FindPrev [c

  tmenu ToolBar.FindNext Proxima modificação
  amenu ToolBar.FindNext ]c

  amenu ToolBar.-sep1- :

  tmenu ToolBar.Undo Pegar modificações da outra janela
  amenu ToolBar.Undo do

  tmenu ToolBar.Redo Enviar modificações para outra janela 
  amenu ToolBar.Redo dp

  amenu ToolBar.-sep2- :

  tmenu ToolBar.RunScript Atualizar diferenças
  amenu ToolBar.RunScript :diffupdate <CR>

  amenu ToolBar.-sep3- :

  tmenu ToolBar.WinMin Esconder treçhos iguais
  amenu ToolBar.WinMin zM
  
  tmenu ToolBar.WinMax Mostrar treçhos iguais 
  amenu ToolBar.WinMax zR

  amenu ToolBar.-sep4- :

  tmenu ToolBar.Save Salvar
  amenu ToolBar.Save :call Save() <CR>

  " neocomplcache
  let g:neocomplcache_enable_at_startup     = 0
  let g:neocomplcache_disable_auto_complete = 1

  " win keys mode
  source $VIMRUNTIME/mswin.vim

endif

