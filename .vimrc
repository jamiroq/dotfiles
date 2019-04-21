"====================================================================
" for Vim version : 8.0
"====================================================================

"====================================================================
" Initialization: {{{
"--------------------------------------------------------------------
" This_is_vim
if &compatible
    set nocompatible
endif

" Initialize autocmd
augroup MyAutoCmd
    autocmd!
augroup END

" Map leader
let mapleader = ' '
"--------------------------------------------------------------------
" Initialization_END }}}
"====================================================================

"====================================================================
" Plugins: {{{
"--------------------------------------------------------------------

"----------------------
" neobundle.vim
"----------------------
let s:bundle_root = expand('~/.vim/bundle')
let s:neobundle_root = s:bundle_root . '/neobundle.vim'

if !isdirectory(s:neobundle_root)
    echomsg "Please install NeoBundle using the InitNeoBundle Command"
    command! InitNeoBundle call s:install_neobundle()

    function! s:install_neobundle()
        redraw | echo 'Installing neobundle.vim...'
        if !isdirectory(s:bundle_root)
            call mkdir(s:bundle_root, 'p')
        endif
        execute 'cd' s:bundle_root

        if executable('git')
            call system('git clone git://github.com/Shougo/neobundle.vim')
            if v:shell_error
                echoerr 'Can not install NeoBundle: Git error.'
                return
            endif
        endif

        echo printf("Reloading '%s'", $MYVIMRC)
        execute 'set runtimepath+=' . s:neobundle_root
        source $MYVIMRC
        echomsg 'Installed NeoBundle and Plugins'
    endfunction
else
    if has('vim_starting')
        execute 'set runtimepath+=' . s:neobundle_root
    endif

    call neobundle#begin(s:bundle_root)

    " Taking case of neobundle by ifself
    NeoBundleFetch 'Shougo/neobundle.vim'

    call neobundle#load_toml('~/.vim/rc/neobundle.toml')
    call neobundle#load_toml('~/.vim/rc/neobundlelazy.toml', {'lazy' : 1})
    execute 'source' fnameescape(expand('~/.vim/rc/plugins_rc.vim'))

    cal neobundle#end()

    filetype plugin indent on
    if !has('vim_starting')
        NeoBundleCheck
    endif
endif

"--------------------------------------------------------------------
" Plugins_end }}}
"====================================================================

"====================================================================
" StatusLine: {{{
"--------------------------------------------------------------------
" View the status line always
set laststatus=2

" Statusline format
set statusline=
set statusline+=%{b:gitbranch}
set statusline+=%m
set statusline+=%=(%<%F\ )%r%h%w%y%{'['.(&fenc!=''?&fenc:&enc).']'}[%l/%L](%P)"
function! StatuslineGitBranch()
    let b:gitbranch=""
    if &modifiable
        lcd %:p:h
        let l:gitrevparse=system("git rev-parse --abbrev-ref HEAD")
        lcd -
        if l:gitrevparse!~"fatal: not a git repository"
            let b:gitbranch="(".substitute(l:gitrevparse, '\n', '', 'g').") "
        endif
    endif
endfunction

augroup GetGitBranch
    autocmd!
    autocmd VimEnter,WinEnter,BufEnter * call StatuslineGitBranch()
augroup END

" Status line color change on insert mode
augroup InsertHook
    autocmd!
    autocmd InsertEnter * highlight StatusLine ctermfg=245 ctermbg=235 guifg=#ccdc90 guibg=#2E4340
    autocmd InsertLeave * highlight StatusLine ctermfg=235 ctermbg=245 guifg=#2E4340 guibg=#ccdc90
augroup END
"--------------------------------------------------------------------
" StatusLine_end }}}
"====================================================================

"====================================================================
" Basics: {{{
"--------------------------------------------------------------------
" To mute the beep
set vb t_vb=
" Speed up terminal drawing
set ttyfast
" If the file is rewritten, read automatically
set autoread
" Hide without closing the buffer
set hidden
" If already open a buffer, jump to the window
set switchbuf=useopen
" Secure margin when scrolling
set scrolloff=5
" Backspace erase everything
set backspace=indent,eol,start
" Not stop at the beginning and end of a line
set whichwrap=b,s,h,l,<,>,[,]
" Not wrapped automatically
set textwidth=0
" Text formatting option add multi-byte
set formatoptions=lmoq
" Help language
set helplang=ja,en
" Fold with marker
set foldmethod=marker
" Number of lines to find a vim setting
set modelines=5
set tags=./tags;
" Add '<' and '>' to the corresponding brackets
set matchpairs& matchpairs+=<:>
" Only rectangular visual mode can move anywhere
set virtualedit=block
"--------------------------------------------------------------------
" Basics_end }}}
"====================================================================

"====================================================================
" Apperance: {{{
"--------------------------------------------------------------------
syntax enable
colorscheme hybrid
" background color
set background=dark
" Show cursor position
set ruler
" Display line number
set number
" Display command in the status line
set showcmd
" redrawn while executing macros, registers and other command
set lazyredraw
" highlight the matching parentheses
set showmatch
" Number of pixel lines inserted between characters
set linespace=0
" Show unprintable charcters hexadecimal
set display=uhex
" Open window below
set splitbelow
" Useing string in list mode
set colorcolumn=80
" Display unprintable characters
set list
set listchars=tab:»-,trail:-,extends:»,precedes:«,eol:¬ " Filetype syntax
autocmd MyAutoCmd BufNewFile,BufRead *.json    setf json
autocmd MyAutoCmd BufNewFile,BufRead *.md      setf markdown
autocmd MyAutoCmd BufNewFile,BufRead *.jquery  setf jquery
autocmd MyAutoCmd BufNewFile,BufRead *.css     setf css3
autocmd MyAutoCmd BufNewFile,BufRead *.txt     setf hybrid
autocmd MyAutoCmd BufNewFile,BufRead *.go      setf go
autocmd MyAutoCmd BufNewFile,BufRead *.pug     setf pug
function! EnableJavascript()
    " Setup for javascript-libraries-syntax
    let g:used_javascript_libs = 'jquery,underscore,react,flux'
    let b:javascript_lib_use_jquery = 1
    let b:javascript_lib_use_underscore = 1
    let b:javascript_lib_use_react = 1
    let b:javascript_lib_use_flux = 1
endfunction
autocmd MyAutoCmd Filetype javascript,javascript.jsx call EnableJavascript()
"--------------------------------------------------------------------
" Apperance_end }}}
"====================================================================

"====================================================================
" Indent: {{{
"--------------------------------------------------------------------
" Copy indent from current line when starting a new line
set autoindent
" Do smart autoindenting when starting a new line
set smartindent
" Indent for C lang
set cindent
" Replace the tabs to spaces
set expandtab
set shiftround
" Setting the tab width
set tabstop=4 shiftwidth=4 softtabstop=0
"--------------------------------------------------------------------
" Indent_end }}}
"====================================================================

"====================================================================
" Complete: {{{
"--------------------------------------------------------------------
" Key for execute Complete
set wildchar=<tab>
" Expand complete for comand line
set wildmenu
" Display all match pattern, and complete first match
set wildmode=list:full
" Adding the dictionary file
set complete+=k
"--------------------------------------------------------------------
" Complete_end }}}
"====================================================================

"====================================================================
" Search: {{{
"--------------------------------------------------------------------
" Search warp around the end of file
set wrapscan
" Ignore Uppercase and lowercase
set ignorecase
" If Start Uppercase, Case-sensitive
set smartcase
" Enable incremental search
set incsearch
" Highlight the search charcters
set hlsearch
" Tern off the highlight search
nnoremap <silent><ESC>  :<C-u>nohlsearch<CR>
" Search the selected charcters
vnoremap <silent> // y/<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>
" Replace the selected charcters
vnoremap /r "xy:%s/<C-R>=escape(@x, '\\/.*$^~[]')<CR>//gc<Left><Left><Left>
"--------------------------------------------------------------------
" Search_end }}}
"====================================================================

"====================================================================
" KeyConfig: {{{
"--------------------------------------------------------------------
" Prevent wrong target
nnoremap Q  <Nop>
nnoremap q: <Nop>
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>
" help search
nnoremap <S-k> :<C-u>vert bel help<Space><C-r><C-w><CR>
" Move on line base
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk
" When jump, to center the cursor position
nnoremap n nzz
nnoremap N Nzz
" Forward/back search not moveing
nnoremap * *N
nnoremap # #N
nnoremap g* g*N
nnoremap g# g#N
" Keymap in insert mode
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-d> <Del>
inoremap <C-b> <Left>
inoremap <C-n> <Down>
inoremap <C-p> <Up>
inoremap <C-f> <Right>
" Keymap in command mode
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-d> <Del>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
" Buffer manipulate
nnoremap <silent><C-p> :<C-u>bp<CR>
nnoremap <silent><C-n> :<C-u>bn<CR>
nnoremap <leader>d :<C-u>bd<CR>
" Window manipulate
nnoremap <silent><C-h> <C-w>h
nnoremap <silent><C-j> <C-w>j
nnoremap <silent><C-k> <C-w>k
nnoremap <silent><C-l> <C-w>l
" ESC assign
inoremap <C-@> <ESC>
inoremap jj <Esc>
" Select to the end in visual mode
vnoremap v $h
" Save any changes
noremap <leader><leader> :<C-u>up<CR>
" Edit vimrc/givmrc by Ev/Rv
command! Ev edit $MYVIMRC
command! Rv source $MYVIMRC
command! Eg edit $HOME/.gvimrc
command! Rg source $HOME/.gvimrc
" Save by superuser
cmap w!! w !sudo tee > /dev/null %
"--------------------------------------------------------------------
" KeyConfig_end }}}
"====================================================================

"====================================================================
" Encoding: {{{
"--------------------------------------------------------------------
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,iso-2022-jp,sjis,cp932,euc-jp,cp20932
set fileformats=unix,dos,mac
"--------------------------------------------------------------------
" Encoding_end }}}
"====================================================================

"====================================================================
" Terminal: {{{
"--------------------------------------------------------------------
set termkey=<C-q>
noremap <silent><leader>t :terminal<CR>
tnoremap <Esc> <C-\><C-n>
"--------------------------------------------------------------------
" Terminal_end }}}
"====================================================================

"====================================================================
" Utility: {{{
"--------------------------------------------------------------------
" Use clipboard
if has('unnamedplus')
    set clipboard& clipboard+=unnamedplus
else
    set clipboard& clipboard+=unnamed
endif
" Buffer auto command
augroup BufferAuto
    autocmd!
    " Automove to current directory
    autocmd BufNewFile,BufRead,BufEnter * if isdirectory(expand("%:p:h")) | cd %:p:h | endif
    " When save, remove trailing spaces
    autocmd BufWritePre * :%s/\s\+$//ge
augroup END
"--------------------------------------------------------------------
" Utility_end }}}
"====================================================================

"====================================================================
" Backup: {{{
"--------------------------------------------------------------------
" Not Buckup
set nobackup
" Not create swap file
set noswapfile
" Disable Backup
set nowritebackup
" History number for command and search pattern
set history=10000
set viminfo='50,<1000,s100,\"50,!
" Change the effect of mkview command
set viewoptions=folds,cursor
" Save fold settings
autocmd BufWritePost * if expand('%') != '' && &buftype !~ 'nofile' | mkview | endif
autocmd BufRead * if expand('%') != '' && &buftype !~ 'nofile' | silent loadview | endif
"--------------------------------------------------------------------
" Backup_end }}}
"====================================================================

"====================================================================
" Load an external file
let s:local_vimrc = expand('~/.vimrc.local')
if filereadable(s:local_vimrc)
        execute 'source ' . s:local_vimrc
endif
"====================================================================
