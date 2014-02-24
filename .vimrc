let g:configPath = expand("$HOME") . "/.vim/config/" 

execute 'source ' . g:configPath . 'functions.vim'
execute 'source ' . g:configPath . 'config.vim'
execute 'source ' . g:configPath . 'appearance.vim'
execute 'source ' . g:configPath . 'mapkeys.vim'
execute 'source ' . g:configPath . 'bundle.vim'
