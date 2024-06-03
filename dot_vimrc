"====================================================================
" for Vim version : 8.1
"====================================================================

"====================================================================
" Initialization: {{{
"--------------------------------------------------------------------
" Encoding
set encoding=utf-8
scriptencoding utf-8
set fileencodings=ucs-bom,utf-8,iso-2022-jp,sjis,cp932,euc-jp,cp20932
set fileformats=unix,dos,mac

" This is vim
if &compatible
    set nocompatible
endif

" Initialize autocmd
augroup auvimrc
    autocmd!
augroup END

" Map leader
let g:mapleader = ' '

"--------------------------------------------------------------------
" Initialization_END }}}
"====================================================================

"====================================================================
" Disable_default_plugin: {{{
"--------------------------------------------------------------------
let g:loaded_gzip              = 1
let g:loaded_tar               = 1
let g:loaded_tarPlugin         = 1
let g:loaded_zip               = 1
let g:loaded_zipPlugin         = 1
let g:loaded_rrhelper          = 1
let g:loaded_vimball           = 1
let g:loaded_vimballPlugin     = 1
let g:loaded_getscript         = 1
let g:loaded_getscriptPlugin   = 1
let g:loaded_netrw             = 1
let g:loaded_netrwPlugin       = 1
let g:loaded_netrwSettings     = 1
let g:loaded_netrwFileHandlers = 1
"--------------------------------------------------------------------
" Initialization_END }}}
"====================================================================

"====================================================================
" Plugins: {{{
"--------------------------------------------------------------------

"" The next package to be installed
" easymotion
" vim-xtabline
" ultisnips
" coc, coc-pairs, coc-snippets

if empty(glob('~/.vim/autoload/plug.vim'))
    silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
        \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin()

"============================================
"  Input_support:
"============================================

" LSP
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_text_edit_enabled = 0
function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    nmap <silent> <f2> <plug>(lsp-rename)
    nmap <silent> <buffer> <C-]> <plug>(lsp-definition)
    nmap <silent> <Leader>d <plug>(lsp-definition)
    nmap <silent> <Leader>i <plug>(lsp-implementation)
    nmap <silent> <Leader>r <plug>(lsp-references)
    nmap <silent> <Leader>h <plug>(lsp-hover)
endfunction
autocmd auvimrc User lsp_buffer_enabled call s:on_lsp_buffer_enabled()

" Comment out
Plug 'tyru/caw.vim'
nmap <C-_> <Plug>(caw:zeropos:toggle)
vmap <C-_> <Plug>(caw:zeropos:toggle)

" Clipboard extension
Plug 'kana/vim-fakeclip'
map <Leader>y <Plug>(fakeclip-y)
map <Leader>p <Plug>(fakeclip-p)

" Parenthesis completion
Plug 'cohama/lexima.vim'

" Extend text object about surrounding characters
Plug 'tpope/vim-surround'

" Detonation velocity html coding
Plug 'mattn/emmet-vim'

"============================================
" Layout_customize:
"============================================

" Favorite Colorscheme
Plug 'w0ng/vim-hybrid'
Plug 'cocopon/iceberg.vim'

" Highlight unique characters in a line for f or F
Plug 'unblevable/quick-scope'
let g:qs_highlight_on_keys = ['f', 'F']

" Highlight same keyword
Plug 'RRethy/vim-illuminate'

" Customize statusline/tabline
Plug 'itchyny/lightline.vim'
let g:lightline = {
        \ 'colorscheme': 'seoul256',
        \ 'mode_map': {'c': 'NORMAL'},
        \ 'active': {
        \   'left': [
        \       [ 'mode', 'paste' ],
        \       [ 'bufnum' ],
        \       [ 'readonly', 'filename', 'modified' ],
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
        \   'filename': 'LightlineFilename',
        \ },
        \ }

function! LightlineBranch()
    try
        let branch = fugitive#head()
        return branch !=# '' ? ' '.branch : ''
    catch
        return ''
    endtry
endfunction

function! LightlineFilename()
    return strlen(expand('%:p')) < (winwidth(0) - 45) ? expand('%:p') : expand('%')
endfunction

"============================================
" Addtional_features:
"============================================

" Fazzy fineder
Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --bin'}
Plug 'junegunn/fzf.vim'
nnoremap <Leader>m :FZFMru<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>f :Files<CR>
command! FZFMru
    \  call fzf#run({
    \    'source':  v:oldfiles,
    \    'sink':    'e',
    \    'options': '-m -x +s',
    \    'down':    '40%'})
if executable('rg')
    command! -bang -nargs=* Rg
        \  call fzf#vim#grep(
        \    'rg --column --line-number --no-heading --color=always '.<q-args>, 1,
        \    fzf#vim#with_preview('right:50%:hidden', '?'), <bang>0)
    cnoreabbrev rg Rg
endif

" easy motion
Plug 'easymotion/vim-easymotion'
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1
map s <Plug>(easymotion-s2)

" Simple filer
Plug 'cocopon/vaffle.vim'
nnoremap <silent><Leader>e :<C-u>Vaffle<CR>
function! s:customize_vaffle_mappings() abort
    nmap <buffer> <Bslash> <Plug>(vaffle-open-root)
    nmap <buffer> s        <Plug>(vaffle-toggle-current)
    nmap <buffer> <ESC>    <Plug>(vaffle-quit)
endfunction
autocmd auvimrc FileType vaffle call s:customize_vaffle_mappings()

" Task runnner
Plug 'thinca/vim-quickrun', { 'on': '<Plug>(quickrun)' }
nmap <silent> <Leader>q <Plug>(quickrun)

" Open browser
Plug 'tyru/open-browser.vim'
nmap <Leader>g <Plug>(openbrowser-smart-search)
vmap <Leader>g <Plug>(openbrowser-smart-search)

" Display git diff in the sign column
Plug 'airblade/vim-gitgutter'
set signcolumn=yes

" Git operator
Plug 'tpope/vim-fugitive'

"============================================
" Filetype_plugin:
"============================================

" Autofomatter for golang
Plug 'mattn/vim-goimports', { 'for': 'go' }

" Syntax for pug(jade)
Plug 'digitaltoad/vim-pug', { 'for': 'pug' }
" Syntax for javascript
Plug 'othree/yajs.vim', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'othree/es.next.syntax.vim', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'othree/javascript-libraries-syntax.vim',
            \ { 'for': ['javascript', 'javascript.jsx'] }
function! s:enable_javascript() abort
    " Setup for javascript-libraries-syntax
    let g:used_javascript_libs = 'jquery,underscore,react,flux'
    let b:javascript_lib_use_jquery = 1
    let b:javascript_lib_use_underscore = 1
    let b:javascript_lib_use_react = 1
    let b:javascript_lib_use_flux = 1
endfunction
autocmd auvimrc Filetype javascript,javascriptreact call s:enable_javascript()

" Syntax for markdown
Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }

" Translate vimdoc to Japanese
Plug 'vim-jp/vimdoc-ja', { 'for': 'help' }

call plug#end()

"--------------------------------------------------------------------
" Plugins_end }}}
"====================================================================

"====================================================================
" Basics: {{{
"--------------------------------------------------------------------
" To mute the beep
set belloff=all
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
set formatoptions& formatoptions+=rmb
" Help language
set helplang=ja,en
" Fold with marker
set foldmethod=marker
" keycode timeout
set timeout timeoutlen=1000 ttimeoutlen=10
" Number of lines to find a vim setting
set modelines=5
set tags=./tags;
" Add '<' and '>' to the corresponding brackets
set matchpairs& matchpairs+=<:>
" Only rectangular visual mode can move anywhere
set virtualedit=block
" How numbers are recognized in CTRL-A and CTRL-X command
set nrformats=hex,bin
" Disable k command
set keywordprg=
"--------------------------------------------------------------------
" Basics_end }}}
"====================================================================

"====================================================================
" Apperance: {{{
"--------------------------------------------------------------------
syntax enable
filetype plugin indent on
" Set colorscheme
colorscheme hybrid
" colorscheme iceberg
" Background color
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
" Tenths of a second to show the matching bracket
set matchtime=1
" Number of pixel lines inserted between characters
set linespace=0
" View the status line always
set laststatus=2
" Display the last line as much as possible
set display=lastline
" Open window below
set splitbelow
" Useing string in list mode
set colorcolumn=80
" Skip messages
set shortmess& shortmess+=aI
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
set complete& complete+=k
" Number of items to show in the popup menu for completion
set pumheight=10
"--------------------------------------------------------------------
" Complete_end }}}
"====================================================================

"====================================================================
" Search: {{{
"--------------------------------------------------------------------
" Searches warp around the end of the file
set wrapscan
" Ignore Uppercase and lowercase
set ignorecase
" If search pattern contains Uppercase characters, Case-sensitive
set smartcase
" Enable incremental search
set incsearch
" Highlight the search characters
set hlsearch
"--------------------------------------------------------------------
" Search_end }}}
"====================================================================

"====================================================================
" Terminal: {{{
"--------------------------------------------------------------------
set termwinkey=<C-t>
noremap <silent><Leader>s :terminal<CR>
"--------------------------------------------------------------------
" Terminal_end }}}
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
" Disable persistent undo
set noundofile
" History number for command and search pattern
set history=10000
set viminfo='50,<1000,s100,\"50,!
" Change the effect of mkview command
set viewoptions=folds,cursor
" Save fold settings
autocmd auvimrc BufWritePost * if expand('%') != '' && &buftype !~ 'nofile'
            \ | mkview | endif
autocmd auvimrc BufRead * if expand('%') != '' && &buftype !~ 'nofile'
            \ | silent loadview | endif
"--------------------------------------------------------------------
" Backup_end }}}
"====================================================================

"====================================================================
" Keymap: {{{
"--------------------------------------------------------------------
" Prevent wrong target
nnoremap q: <Nop>
nnoremap q/ <Nop>
nnoremap q? <Nop>
nnoremap Q  <Nop>
nnoremap ZZ <Nop>
nnoremap ZQ <Nop>
" help search
nnoremap <S-k> :<C-u>help<Space><C-r><C-w><CR>
nnoremap <C-k> :<C-u>vert bel help<Space><C-r><C-w><CR>
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
" Emacs like keymap in insert mode
inoremap <C-a> <Home>
inoremap <C-e> <End>
inoremap <C-d> <Del>
inoremap <C-b> <Left>
inoremap <C-n> <Down>
inoremap <C-p> <Up>
inoremap <C-f> <Right>
" Emacs like keymap in command mode
cnoremap <C-a> <Home>
cnoremap <C-e> <End>
cnoremap <C-d> <Del>
cnoremap <C-b> <Left>
cnoremap <C-f> <Right>
" Buffer manipulate
nnoremap <silent><C-p> :<C-u>bp<CR>
nnoremap <silent><C-n> :<C-u>bn<CR>
" Resize window
nnoremap <silent>+ <c-w>+
nnoremap <silent>- <c-w>-
" ESC assign
inoremap jj <ESC>
inoremap <C-@> <ESC>
" Select to the end in visual mode
vnoremap v $h
" Yank till the end of line.
nnoremap Y y$
" Save any changes
noremap <Leader><Leader> :<C-u>up<CR>
" Save by superuser
cmap w!! w !sudo tee > /dev/null %
" Tern off the highlight search characters
nnoremap <silent><C-l>  :<C-u>nohlsearch<CR><ESC>
" Replace word with yank characters
nnoremap <silent> cy ce<C-R>0<ESC>:let@/=@1<CR>:noh<CR>
vnoremap <silent> cy c<C-R>0<ESC>:let@/=@1<CR>:noh<CR>
nnoremap <silent> ciy ciw<C-R>0<ESC>:let@/=@1<CR>:noh<CR>
" Search the selected characters
vnoremap <silent> // y/<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>
" Replace the selected characters
vnoremap /r "xy:%s/\<<C-R>=escape(@x, '\\/.*$^~[]')<CR>\>//gc<Left><Left><Left>
"--------------------------------------------------------------------
" KeyConfig_end }}}
"====================================================================

"====================================================================
" Utility: {{{
"--------------------------------------------------------------------
" Edit vimrc/givmrc by Ev/Rv
command! Ev edit $MYVIMRC
command! Rv source $MYVIMRC

" Use clipboard
if has('unnamedplus')
    set clipboard& clipboard^=unnamedplus
else
    set clipboard& clipboard^=unnamed
endif

" When grep execute, open quickfix
autocmd auvimrc QuickfixCmdPost grep cwindow

" Automove to current directory
autocmd auvimrc BufNewFile,BufRead,BufEnter * if isdirectory(expand('%:p:h'))
            \ | cd %:p:h | endif

" Remove trailing spaces
function! s:space_trim() abort
    let s:cursor = getpos(".")
    if &filetype == "markdown"
        %s/\s\+\(\s\{2}\)$/\1/ge
        match Visual /\s\{2}/
    else
        %s/\s\+$//ge
    endif
    call setpos(".", s:cursor)
endfunction
autocmd auvimrc BufWritePre * call s:space_trim()

" MoveToNewTab
function! s:MoveToNewTab() abort
    tab split
    tabprevious
    if winnr('$') > 1
        close
    elseif bufnr('$') > 1
        buffer #
    endif
    tabnext
endfunction
nnoremap <silent> <Leader>k :<C-u>call <SID>MoveToNewTab()<CR>

" Close help
autocmd auvimrc Filetype help nnoremap <buffer> <ESC> <C-w>c

"--------------------------------------------------------------------
" Utility_end }}}
"====================================================================

"====================================================================
" Load an external file
let s:local_vimrc = expand('~/.vimrc.local')
if filereadable(s:local_vimrc)
    execute 'source ' . s:local_vimrc
endif
"====================================================================
