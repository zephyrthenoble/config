se nu
set title
filetype plugin indent on
set cindent
"autocmd FileType  setlocal  smartindent  et cinwords=if,elif,else,for,while,try,except,finally,def,class

set backspace=indent,eol,start

set tabstop=4 softtabstop=4 shiftwidth=4 expandtab

set clipboard=unnamed

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
set mouse=a

set background=dark

" Commenting blocks of code. ,cc to add, ,cu to remove
autocmd FileType c,cpp,java,scala,go    let b:comment_leader = '// '
autocmd FileType sh,ruby,python         let b:comment_leader = '# '
autocmd FileType conf,fstab             let b:comment_leader = '# '
autocmd FileType tex                    let b:comment_leader = '% '
autocmd FileType mail                   let b:comment_leader = '> '
autocmd FileType vim                    let b:comment_leader = '" '
noremap <silent> ,cc :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> ,cu :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>        

autocmd FileType go autocmd BufWritePre <buffer> Fmt 

if has("autocmd")
	au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
		\| exe "normal! g`\"" | endif
endif
