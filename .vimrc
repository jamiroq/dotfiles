"====================================================================
" for Vim version : 8.1
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

"" The next package to be installed
" ack.vim
" snippet
" ale
" vim-lsp
" polyglot
" easymotion

if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

"============================================
" Filter:
"============================================

"----------------------
" fzf
"----------------------
Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
Plug 'junegunn/fzf.vim'
command! FZFMru call fzf#run({
            \  'source':  v:oldfiles,
            \  'sink':    'e',
            \  'options': '-m -x +s',
            \  'down':    '40%'})
nnoremap <Leader>m :FZFMru<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>f :Files<CR>

"============================================
" Input_support:
"============================================

"----------------------
" deoplete
"----------------------
Plug 'Shougo/deoplete.nvim', { 'on': [] }
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_complete_delay = 0
let g:deoplete#enable_smart_case = 1
let g:deoplete#enable_ignore_case = 1

"----------------------
" Other-plugins
"----------------------
Plug 'kana/vim-smartinput', { 'on': [] }
Plug 'mattn/emmet-vim', { 'on': [] }

" Load plugin at insert mode
augroup LoadPluginInsertHook
    autocmd!
    autocmd InsertEnter * call plug#load(
                \ 'deoplete.nvim',
                \ 'vim-smartinput',
                \ 'emmet-vim')
                \ | autocmd! LoadPluginInsertHook
augroup END

"============================================
" Execution_environment:
"============================================

"----------------------
" quickrun
"----------------------
Plug 'thinca/vim-quickrun', { 'on': '<Plug>(quickrun)' }
nmap <silent><Leader>r <Plug>(quickrun)
let g:quickrun_config = {
            \ 'go': {'command': 'go run'},
            \ }

"============================================
" Utility:
"============================================

"----------------------
" Colorscheme
"----------------------
Plug 'w0ng/vim-hybrid'

"----------------------
" caw
"----------------------
Plug 'tyru/caw.vim'
nmap <C-_> <Plug>(caw:zeropos:toggle)
vmap <C-_> <Plug>(caw:zeropos:toggle)

"----------------------
" fakeclip
"----------------------
Plug 'kana/vim-fakeclip'
map <Leader>y <Plug>(fakeclip-y)
map <Leader>p <Plug>(fakeclip-p)

"----------------------
" Surround
"----------------------
Plug 'tpope/vim-surround'

"----------------------
" open-browser
"----------------------
Plug 'tyru/open-browser.vim'
nmap <Leader>g <Plug>(openbrowser-smart-search)
vmap <Leader>g <Plug>(openbrowser-smart-search)

"----------------------
" gitgutter
"----------------------
Plug 'airblade/vim-gitgutter'
set signcolumn=yes

"----------------------
" fugitive
"----------------------
Plug 'tpope/vim-fugitive', { 'on': ['Gblame', 'Gbrowse', 'Glog'] }

"----------------------
" Filer
"----------------------
Plug 'cocopon/vaffle.vim'
nnoremap <silent><Leader>e :<C-u>Vaffle<CR>
function! s:customize_vaffle_mappings() abort
    " Customize key mappings here
    nmap <buffer> <Bslash> <Plug>(vaffle-open-root)
    nmap <buffer> s        <Plug>(vaffle-toggle-current)
    nmap <buffer> <ESC>    <Plug>(vaffle-quit)
endfunction
augroup VaffleKeymap
    autocmd!
    autocmd FileType vaffle call s:customize_vaffle_mappings()
augroup END

"----------------------
" lightline
"----------------------
Plug 'itchyny/lightline.vim'
let g:lightline = {
        \ 'colorscheme': 'seoul256',
        \ 'mode_map': {'c': 'NORMAL'},
        \ 'active': {
        \   'left': [
        \       [ 'mode', 'paste' ],
        \       [ 'bufnum' ],
        \       [ 'readonly', 'absolutepath', 'modified' ],
        \   ],
        \   'right': [
        \       [ 'linepercent' ],
        \       [ 'branch' ],
        \       [ 'filetype' ],
        \       [ 'fileencoding' ],
        \   ]
        \ },
        \ 'component': {
        \   'linepercent': '%P[%L]'
        \ },
        \ 'component_function': {
        \   'branch': 'LightlineBranch',
        \   'mode': 'LightlineMode',
        \   'filetype': 'LightlineFiletype',
        \   'fileencoding': 'LightlineFileencoding',
        \ },
        \ }

function! LightlineMode()
    return winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! LightlineBranch()
    " Define in StatuslineGitBranch()
    return winwidth(0) > 70 ? b:gitbranch : ''
endfunction

function! LightlineFiletype()
    return winwidth(0) > 70 ? (&filetype !=# '' ? &filetype : 'no ft') : ''
endfunction

function! LightlineFileencoding()
    return winwidth(0) > 70 ? (&fenc !=# '' ? &fenc : &enc) : ''
endfunction

"----------------------
" tagbar
"----------------------
Plug 'majutsushi/tagbar', { 'on': 'TagbarToggle' }
nnoremap <Leader>t :TagbarToggle<CR>
let g:tagbar_left = 0
let g:tagbar_autofocus = 1

"============================================
" Filetype:
"============================================

" Deployment Environment for go
"----------------------
" vim-go
"----------------------
Plug 'fatih/vim-go', { 'for': 'go' }
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1

" Translate help to Japanese
Plug 'vim-jp/vimdoc-ja', { 'for': 'help' }
" Syntax for markdown
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
" Syntax for pug(jade)
Plug 'digitaltoad/vim-pug', { 'for': 'pug' }
" Syntax for javascript
Plug 'othree/yajs.vim', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'othree/es.next.syntax.vim', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'othree/javascript-libraries-syntax.vim',
            \ { 'for': ['javascript', 'javascript.jsx'] }
function! EnableJavascript()
    " Setup for javascript-libraries-syntax
    let g:used_javascript_libs = 'jquery,underscore,react,flux'
    let b:javascript_lib_use_jquery = 1
    let b:javascript_lib_use_underscore = 1
    let b:javascript_lib_use_react = 1
    let b:javascript_lib_use_flux = 1
endfunction
autocmd MyAutoCmd Filetype javascript,javascript.jsx call EnableJavascript()

call plug#end()

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
            let b:gitbranch=substitute(l:gitrevparse, '\n', '', 'g')
        endif
    endif
endfunction

augroup GetGitBranch
    autocmd!
    autocmd VimEnter,WinEnter,BufEnter * call StatuslineGitBranch()
augroup END

" Status line color change on insert mode
augroup StatusChangeInsertHook
    autocmd!
    autocmd InsertEnter * highlight StatusLine ctermfg=245 ctermbg=235
                \ guifg=#ccdc90 guibg=#2E4340
    autocmd InsertLeave * highlight StatusLine ctermfg=235 ctermbg=245
                \ guifg=#2E4340 guibg=#ccdc90
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
" keycode timeout
set timeout timeoutlen=1000 ttimeoutlen=10
" Number of LINes to find a vim setting
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
filetype plugin indent on
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
set listchars=tab:»-,trail:-,extends:»,precedes:«,eol:¬
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
nnoremap <silent><C-@>  :<C-u>nohlsearch<CR><ESC>
" Search the selected charcters
vnoremap <silent> // y/<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>
" Replace the selected charcters
vnoremap /r "xy:%s/\<<C-R>=escape(@x, '\\/.*$^~[]')<CR>\>//gc<Left><Left><Left>
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
nnoremap <silent><c-j> :<C-u>bp<CR>
nnoremap <silent><C-k> :<C-u>bn<CR>
nnoremap <leader>d :<C-u>bd<CR>
" ESC assign
inoremap jj <ESC>
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
set termwinkey=<A-q>
noremap <silent><leader>s :terminal<CR>
tnoremap <Esc> <C-\><C-n>:<C-u>bd!<CR>
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
    autocmd BufNewFile,BufRead,BufEnter * if isdirectory(expand("%:p:h"))
                \ | cd %:p:h | endif
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
augroup BackupSave
    autocmd!
    autocmd BufWritePost * if expand('%') != '' && &buftype !~ 'nofile'
                \ | mkview | endif
    autocmd BufRead * if expand('%') != '' && &buftype !~ 'nofile'
                \ | silent loadview | endif
augroup END
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

