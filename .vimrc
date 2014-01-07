let g:configPath = expand("$HOME") . "/.vim/configuracoes/" 

execute 'source ' . g:configPath . 'funcoes.vim'
execute 'source ' . g:configPath . 'geral.vim'
execute 'source ' . g:configPath . 'aparencia.vim'
execute 'source ' . g:configPath . 'indentacao.vim'
execute 'source ' . g:configPath . 'atalhos.vim'

if has("gui_running")                       
  let g:defaultColor = 'Tomorrow-Night'
  execute 'source ' . g:configPath . 'gvim.vim'
else 
  let g:defaultColor = 'womprat'
  execute 'source ' . g:configPath . 'cores.vim'
endif 

au BufEnter <buffer> call LoadingProblematicConfigurations()

execute pathogen#infect()
syntax on
filetype plugin indent on

set nocompatible  
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'shawncplus/phpcomplete.vim'

filetype plugin indent on   
