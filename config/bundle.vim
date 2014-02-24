execute pathogen#infect()
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'
Bundle 'shawncplus/phpcomplete.vim'
Bundle 'majutsushi/tagbar' 
Bundle 'kien/ctrlp.vim'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'bling/vim-airline'
Bundle 'tpope/vim-repeat'
Bundle 'ervandew/supertab'
Bundle 'tomtom/tcomment_vim'
Bundle 'tsaleh/vim-matchit'
Bundle 'godlygeek/tabular'
Bundle 'Raimondi/delimitMate'
Bundle 'scrooloose/nerdtree'

filetype plugin indent on   
