se nu
set title
filetype plugin indent on
set cindent
"autocmd FileType  setlocal  smartindent  et cinwords=if,elif,else,for,while,try,except,finally,def,class

set backspace=indent,eol,start

set tabstop=4 softtabstop=4 shiftwidth=4 expandtab

syntax on
set hidden
set ignorecase
set nowrap
set hlsearch
set incsearch
highlight Comment ctermfg=green


"Random stuff
set wildmenu
set wildmode=list:longest,full
set wildignore=*.o,*~,*.pyc
set ruler
set laststatus=2
set confirm



if has("autocmd")
	au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
		\| exe "normal! g`\"" | endif
endif
