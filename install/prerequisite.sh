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
git config --global pager.diff false
git config --global difftool.prompt false
git config --global diff.external git_diff_wrapper
sudo ln -s ~/.vim/bin/git_diff_wrapper /usr/local/bin/

# git auth cache
git config --global credential.helper "cache --timeout=10800"

# forcar gvim abrir arquivos na mesma janela 
sudo ln -s ~/.vim/bin/gvimtab /usr/local/bin/gvimtab

# pathogen
sudo apt-get install curl
mkdir -p ~/.vim/autoload ~/.vim/bundle; \
  curl -Sso ~/.vim/autoload/pathogen.vim \
      https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim

# vundle
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle

# commant-t
cd ~/.vim/bundle/command-t/ruby/command-t
ruby extconf.rb
make

# YouCompleteMe
sudo apt-get install build-essential cmake
sudo apt-get install python-dev
cd ~/.vim/bundle/YouCompleteMe
./install.sh --clang-completer
