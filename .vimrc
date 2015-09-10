" turns off vi compatibility
set nocompatible
" sets our leader
let mapleader=","
" stops vim from trying to run modelines
set nomodeline
" set numbers
set nu

" changes the title of the terminal
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
" let us use ; for : because you never use that in normal mode
nnoremap ; :
" strip whitespace from file
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>


" Starts up pathogen if installed
if isdirectory($HOME . "/.vim/bundle/vim-pathogen/autoload")
    runtime bundle/vim-pathogen/autoload/pathogen.vim
    execute pathogen#infect()
endif

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
set relativenumber

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
    " go fmt when go file closed
    autocmd FileType go autocmd BufWritePre <buffer> Fmt
    " make sure vim knows .md files are markdown
    autocmd BufNewFile,BufReadPost *.md set filetype=markdown
    au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
                \| exe "normal! g`\"" | endif
endif


" Remaps
" autocomment
noremap <silent> <leader>cc :<C-B>silent <C-E>s/^/<C-R>=escape(b:comment_leader,'\/')<CR>/<CR>:nohlsearch<CR>
noremap <silent> <leader>cu :<C-B>silent <C-E>s/^\V<C-R>=escape(b:comment_leader,'\/')<CR>//e<CR>:nohlsearch<CR>

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
" ############## Plugins ##############

function! AirLineLoad()
    let g:airline#extensions#whitespace#enabled = 1
endfunction

function! SyntasticLoad()
    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*
    " ignore file types that syntastic throws up on
    let g:syntastic_ignore_files = ['\m\c\.h$', '\m\.sbt$']

    " Scala has fsc and scalac checkers--running both is pretty redundant and
    " " slow. An explicit `:SyntasticCheck scalac` can always run the other.
    " let g:syntastic_scala_checkers = ['fsc']
    let g:syntastic_always_populate_loc_list = 1
    let g:syntastic_auto_loc_list = 1
    let g:syntastic_check_on_open = 1
    let g:syntastic_check_on_wq = 0
endfunction


function! UltiSnipsLoad()
    let g:UltiSnipsExpandTrigger="<C-CR>"
    let g:UltiSnipsJumpForwardTrigger="<C-tab>"
    let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
endfunction



function! NeoCompleteLoad()
    "Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
    " Disable AutoComplPop.
    let g:acp_enableAtStartup = 0
    " Use neocomplete.
    let g:neocomplete#enable_at_startup = 1
    " Use smartcase.
    let g:neocomplete#enable_smart_case = 1
    " Set minimum syntax keyword length.
    let g:neocomplete#sources#syntax#min_keyword_length = 3
    let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

    " Define dictionary.
    let g:neocomplete#sources#dictionary#dictionaries = {
                \ 'default' : '',
                \ 'vimshell' : $HOME.'/.vimshell_hist',
                \ 'scheme' : $HOME.'/.gosh_completions'
                \ }

    " Define keyword.
    if !exists('g:neocomplete#keyword_patterns')
        let g:neocomplete#keyword_patterns = {}
    endif
    let g:neocomplete#keyword_patterns['default'] = '\h\w*'

    " Plugin key-mappings.
    inoremap <expr><C-g>     neocomplete#undo_completion()
    inoremap <expr><C-l>     neocomplete#complete_common_string()

    " Recommended key-mappings.
    " <CR>: close popup and save indent.
    inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
    function! s:my_cr_function()
        return neocomplete#close_popup() . "\<CR>"
        " For no inserting <CR> key.
        "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
    endfunction
    " <TAB>: completion.
"     inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
    inoremap <expr><TAB>  pumvisible() ? "\<C-n>" :
                \ <SID>check_back_space() ? "\<TAB>" :
                \ neocomplete#start_manual_complete()
    function! s:check_back_space() "{{{
        let col = col('.') - 1
        return !col || getline('.')[col - 1]  =~ '\s'
    endfunction"}}}
    " <C-h>, <BS>: close popup and delete backword char.
    inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
    inoremap <expr><C-y>  neocomplete#close_popup()
    inoremap <expr><C-e>  neocomplete#cancel_popup()
    " Close popup by <Space>.
    "inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

    " For cursor moving in insert mode(Not recommended)
    "inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
    "inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
    "inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
    "inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
    " Or set this.
    "let g:neocomplete#enable_cursor_hold_i = 1
    " Or set this.
    "let g:neocomplete#enable_insert_char_pre = 1

    " AutoComplPop like behavior.
    "let g:neocomplete#enable_auto_select = 1

    " Shell like behavior(not recommended).
    "set completeopt+=longest
    "let g:neocomplete#enable_auto_select = 1
    "let g:neocomplete#disable_auto_complete = 1
    "inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

    " Enable omni completion.
    autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
    autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
    autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
    autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

    " Enable heavy omni completion.
    if !exists('g:neocomplete#sources#omni#input_patterns')
        let g:neocomplete#sources#omni#input_patterns = {}
    endif
    "let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
    "let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
    "let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

    " For perlomni.vim setting.
    " https://github.com/c9s/perlomni.vim
    let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
endfunction

function! CallPluginLoads()
    let BUNDLE=$HOME . "/.vim/bundle/"
    call AirLineLoad()
    call UltiSnipsLoad()
    call SyntasticLoad()
    call NeoCompleteLoad()
endfunction


if isdirectory($HOME . "/.vim/bundle/vim-pathogen/autoload")
    call CallPluginLoads()
endif
