set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/autoload/plug.vim
call plug#begin('~/.vim/plugged')

" Needed to speed up folding while using pymode
Plug 'ervandew/supertab'
Plug 'konfekt/fastfold'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/syntastic'
Plug 'bling/vim-airline'
Plug 'scrooloose/nerdcommenter'
Plug 'christoomey/vim-tmux-navigator'
Plug 'nathanaelkane/vim-indent-guides'

" Languages
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-markdown'
Plug 'othree/html5.vim'
Plug 'elzr/vim-json'
Plug 'derekwyatt/vim-scala'
Plug 'rust-lang/rust.vim'

call plug#end()            " required

syntax on
filetype plugin indent on


" set up other stuff
let mapleader=","
" stops vim from trying to run modelines
set nomodeline
" set numbers
set nu

" Starts scrolling 10 lines away from the bottom or top of the page
set scrolloff=10

set title
" loads plugin files for filetypes
filetype plugin indent on
" c style indenting
set cindent
" use UTF8 everywhere because we aren't animals
set encoding=utf-8
" let Tab move you around
nnoremap <tab> %
vnoremap <tab> %

" strip whitespace from file
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

nnoremap <M-h> :bp<CR>
nnoremap <M-l> :bn<CR>

" Starts up pathogen if installed

" toggle insert paste
set pastetoggle=<F2>
" lets you delete over the end of a line
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
    " allows you to toggle mouse wit hF#
    map <F3> :call ToggleMouse()<CR>
    " set mouse=a
    " turns on syntax stuff
    syntax on
    " highlight your search
    set hlsearch
    " spooky background color
    set background=dark
    " attempts to allow the x clipboard and the vim clipboard to work
    set clipboard=unnamedplus
    " needed to get the status line stuff working
    set laststatus=2
    " let's us use pretty colors in vim
    set t_Co=256
endif


set background=dark

" lets you keep the changed buffer without saving it or something?
set hidden
" search ignores case by default
set ignorecase
" if a search has a capital letter, starts searching for only things with caps
set smartcase
" stops text from wrapping, so we have super long lines like we want
set nowrap
" while searching for something, show all strings matching the search as you
" type it out
set incsearch
" comments are now green
highlight Comment ctermfg=green
" shows only relative line numbers from the current cursor position
"set relativenumber

" toggle line numbers
map <F6> :set number!<CR>
map <F7> :set relativenumber!<CR>

"Random stuff
"menu added when you tab complete in : mode
set wildmenu
" starts with the longest possible outcome
set wildmode=list:longest,full
" ignore these filetypes by default, basically files you won't generally open
" in vim
set wildignore=*.o,*~,*.pyc
" shows line and column position in the status bar
set ruler
" adds a confirm dialog when trying to quit without saving instead of failing
set confirm
" shows a line to allow me to see when I get to 80 characters
set colorcolumn=81
" allows you to wrap around lines
set whichwrap+=<,>,h,l,[,]


" For backwards compatibility, check for autocmd
if has('autocmd')
    " needed to define what a comment is in these languages I guess
    au FileType c,cpp,java,rust setlocal comments-=:// comments+=f://
    " Text only, break on 78
    autocmd FileType text setlocal textwidth=90
    autocmd FileType markdown setlocal textwidth=90
    " Commenting blocks of code. ,cc to add, ,cu to remove
    autocmd FileType c,cpp,java,scala,go,rust       let b:comment_leader = '// '
    autocmd FileType sh,ruby,python,yaml            let b:comment_leader = '# '
    autocmd FileType conf,fstab                     let b:comment_leader = '# '
    autocmd FileType tex                            let b:comment_leader = '% '
    autocmd FileType mail                           let b:comment_leader = '> '
    autocmd FileType vim                            let b:comment_leader = '" '
    " go fmt when go file closed
    autocmd FileType go autocmd BufWritePre <buffer> Fmt
    " make sure vim knows .md files are markdown
    autocmd BufNewFile,BufReadPost *.md set filetype=markdown
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
                \| exe "normal! g`\"" | endif
endif


" Remaps
" autocomment
"noremap <silent> <leader>cc :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
"noremap <silent> <leader>cu :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1

" edit .vimrc
nmap <silent> <leader>ev :e $MYVIMRC<CR>
nmap <silent> <leader>sv :so $MYVIMRC<CR>

" removes highlighted search
nmap <silent> <leader>/ :nohlsearch<CR>

" Press F5 then a number to switch buffers
nnoremap <F5> :buffers<CR>:buffer<Space>

" reopen as sudo
cmap w!! w !sudo tee % >/dev/null


" Because I'm HARDCORE and don't want arrow keys
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
nnoremap j gj
nnoremap k gk

" stop help from popping up when you hit F1
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

" move around windows with Ctrl-direction
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

let g:tex_fold_enabled=1
let g:python_syntax_folding = 1


set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:syntastic_mode_map = {"mode": "passive"}
map <F8> :SyntasticCheck<CR>
map <C-F8> :SyntasticToggleMode<CR>
map <M-F8> :lclose<CR>


let g:indent_guides_enable_on_vim_startup = 1
map <F9> :IndentGuidesToggle<CR>
