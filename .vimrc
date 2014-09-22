set nocompatible
set nu
set title
filetype plugin indent on
set cindent
"autocmd FileType  setlocal  smartindent  et cinwords=if,elif,else,for,while,try,except,finally,def,class

set pastetoggle=<F2>
set backspace=indent,eol,start

set tabstop=4 softtabstop=4 shiftwidth=4 expandtab
if &t_Co > 2 || has("gui_running")
    syntax on
    set hlsearch
    set background=dark
    set clipboard=unnamedplus
    "set mouse=a
endif
set hidden
set ignorecase
set nowrap
set incsearch
highlight Comment ctermfg=green


"Random stuff
set wildmenu
set wildmode=list:longest,full
set wildignore=*.o,*~,*.pyc
set ruler
set laststatus=2
set confirm
au FileType c,cpp,java setlocal comments-=:// comments+=f://

" Plaintext only, break on 78
autocmd FileType text setlocal textwidth=78
" Commenting blocks of code. ,cc to add, ,cu to remove
autocmd FileType c,cpp,java,scala,go    let b:comment_leader = '// '
autocmd FileType sh,ruby,python         let b:comment_leader = '# '
autocmd FileType conf,fstab             let b:comment_leader = '# '
autocmd FileType tex                    let b:comment_leader = '% '
autocmd FileType mail                   let b:comment_leader = '> '
autocmd FileType vim                    let b:comment_leader = '" '
noremap <silent> ,cc :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> ,cu :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>        

if has("autocmd")
	au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
		\| exe "normal! g`\"" | endif
endif

function! ToggleMouse()
    " check if mouse is enabled
    if &mouse == 'a'
        " disable mouse
        set mouse=
    else
        " enable mouse everywhere
        set mouse=a
    endif
endfunc

map <F3> :call ToggleMouse()<CR>
