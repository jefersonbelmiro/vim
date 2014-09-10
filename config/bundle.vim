execute pathogen#infect()
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Plugin 'gmarik/vundle'
Plugin 'shawncplus/phpcomplete.vim'
Plugin 'majutsushi/tagbar' 
Plugin 'kien/ctrlp.vim'
Plugin 'Lokaltog/vim-easymotion'
Plugin 'bling/vim-airline'
Plugin 'tpope/vim-repeat'
Plugin 'ervandew/supertab'
Plugin 'tomtom/tcomment_vim'
Plugin 'tsaleh/vim-matchit'
Plugin 'godlygeek/tabular'
Plugin 'Raimondi/delimitMate'
Plugin 'scrooloose/nerdtree'
Plugin 'MattesGroeger/vim-bookmarks'
Plugin 'digitaltoad/vim-jade'
Plugin 'wincent/command-t'

" javascript {
"   http://oli.me.uk/2013/06/29/equipping-vim-for-javascript/ 

    Plugin 'jelera/vim-javascript-syntax'
    Plugin 'pangloss/vim-javascript'
    Plugin 'nathanaelkane/vim-indent-guides'
    Plugin 'scrooloose/syntastic'
    Plugin 'Valloric/YouCompleteMe'
    Plugin 'marijnh/tern_for_vim'

" } 

filetype plugin indent on   
