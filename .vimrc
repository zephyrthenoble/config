" turns off vi compatibility
set nocompatible
let mapleader=","
" stops vim from trying to run modelines
set nomodeline
set nu
set title
filetype plugin indent on
set cindent

" Starts up pathogen
if isdirectory($HOME . "/.vim/bundle/vim-pathogen/autoload")
    echo "Yay"
    runtime bundle/vim-pathogen/autoload/pathogen.vim
    execute pathogen#infect()
endif

" toggle insert paste
set pastetoggle=<F2>
set backspace=indent,eol,start

" toggle mouse
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
" tabs are turned into 4 spaces
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab

" things to run if in gui environment
if &t_Co > 2 || has("gui_running")
    map <F3> :call ToggleMouse()<CR>
    syntax on
    set hlsearch
    set background=dark
    set clipboard=unnamedplus
endif

syntax on
set hidden
set ignorecase
set smartcase
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
set colorcolumn=81
set whichwrap+=<,>,h,l,[,]

" For backwards compatibility, check for autocmd
if has('autocmd')
    " Plaintext only, break on 78
    autocmd FileType text setlocal textwidth=78
    " Commenting blocks of code. ,cc to add, ,cu to remove
    autocmd FileType c,cpp,java,scala,go    let b:comment_leader = '// '
    autocmd FileType sh,ruby,python         let b:comment_leader = '# '
    autocmd FileType conf,fstab             let b:comment_leader = '# '
    autocmd FileType tex                    let b:comment_leader = '% '
    autocmd FileType mail                   let b:comment_leader = '> '
    autocmd FileType vim                    let b:comment_leader = '" '
    autocmd filetype python set expandtab
    " go fmt when go file closed
    autocmd FileType go autocmd BufWritePre <buffer> Fmt 
    " make sure vim knows .md files are markdown
    autocmd BufNewFile,BufReadPost *.md set filetype=markdown
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
                \| exe "normal! g`\"" | endif
endif


" Custom Functions
" autocomment
noremap <silent> <leader>cc :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> <leader>cu :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>        

" edit .vimrc
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" removes highlighted search
nmap <silent> ,/ :nohlsearch<CR>


" reopen as sudo
cmap w!! w !sudo tee % >/dev/null
