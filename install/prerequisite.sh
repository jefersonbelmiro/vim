#!/bin/sh

# exuberant-ctags
# - usado no plugin tagbar
sudo apt-get install exuberant-ctags

# ag - the silver search
#
# plugin vim
# - https://github.com/rking/ag.vim
# programa
# - https://github.com/ggreer/the_silver_searcher
#
sudo apt-get install python-software-properties
sudo apt-add-repository ppa:mizuno-as/silversearcher-ag
sudo apt-get update
sudo apt-get install silversearcher-ag

# git diff com vim
git config --global difftool.prompt false
git config --global diff.external git_diff_wrapper
sudo ln -s ~/.vim/bin/git_diff_wrapper /usr/local/bin/

# forcar gvim abrir arquivos na mesma janela 
sudo ln -s ~/.vim/bin/gvimserver /usr/local/bin/gvimserver

# alterar cor do gtk usando gvim
# pro no arquivo ~/.gtkrc-2.0 
# style "vimfix" {
#   bg[NORMAL] = "#141414" # this matches my gvim theme 'Normal' bg color.
# }
# widget "vim-main-window.*GtkForm" style "vimfix"
