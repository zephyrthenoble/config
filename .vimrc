" turns off vi compatibility
set nocompatible
let mapleader=","
" stops vim from trying to run modelines
set nomodeline
" set numbers
set nu

set title
filetype plugin indent on
set cindent


" Starts up pathogen
if isdirectory($HOME . "/.vim/bundle/vim-pathogen/autoload")
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
    " needed to get the status line stuff working
    set laststatus=2
    set t_Co=256
endif


syntax on
set hidden
set ignorecase
set smartcase
set nowrap
set incsearch
highlight Comment ctermfg=green


"Random stuff
"menu added when you tab complete in : mode
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
nmap <silent> <leader>/ :nohlsearch<CR>

" Press F5 then a number to switch buffers
nnoremap <F5> :buffers<CR>:buffer<Space>

" reopen as sudo
cmap w!! w !sudo tee % >/dev/null

function! SyntasticLoad()
    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*

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
call UltiSnipsLoad()
call SyntasticLoad()
call NeoCompleteLoad()
