"  diretorio raiz
let $VIMROOT   = expand("$HOME") . "/vimfiles"
let $__VIMCONF = expand("$HOME") . "/.vim/configuracoes" 

source $__VIMCONF/funcoes.vim
source $__VIMCONF/geral.vim
source $__VIMCONF/atalhos.vim
source $__VIMCONF/aparencia.vim
source $__VIMCONF/cores.vim
source $__VIMCONF/indentacao.vim

set mouse=a
set ve=all

if has("gui_running")
  source $__VIMCONF/gvim.vim
endif
