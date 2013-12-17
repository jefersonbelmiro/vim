"  diretorio raiz
let $VIMROOT   = expand("$HOME") . "/vimfiles"
let $__VIMCONF = expand("$HOME") . "/.vim/configuracoes" 

if has("gui_running")
  let g:defaultColor = 'Tomorrow-Night'
else 
  let g:defaultColor = 'womprat'
endif

source $__VIMCONF/funcoes.vim
source $__VIMCONF/geral.vim
source $__VIMCONF/aparencia.vim
source $__VIMCONF/indentacao.vim
source $__VIMCONF/atalhos.vim

if has("gui_running")
  source $__VIMCONF/gvim.vim
else 
  source $__VIMCONF/cores.vim
endif 

au BufEnter * call LoadingProblematicConfigurations()
