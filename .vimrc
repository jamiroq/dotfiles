"====================================================================
" for Vim version : 7.3, 7.4 (recommend +lua, and git)
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
set statusline=%=(%<%F\ )%r%h%w%y%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}[%l/%L](%P)"%m
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
set vb t_vb=                    " To mute the beep
set autoread                    " If the file is rewritten, read automatically
set hidden                      " Hide without closing the buffer
set switchbuf=useopen           " If already open a buffer, jump to the window
set scrolloff=5                 " Secure margin when scrolling
set backspace=indent,eol,start  " Backspace erase everything
set whichwrap=b,s,h,l,<,>,[,]   " Not stop at the beginning and end of a line
set textwidth=0                 " Not wrapped automatically
set formatoptions=lmoq          " Text formatting option add multi-byte
set helplang=ja,en              " Help language
set foldmethod=marker
set matchpairs& matchpairs+=<:> " Add '<' and '>' to the corresponding brackets
set viewoptions=folds,cursor    " Change the effect of mkview command
autocmd BufWritePost * mkview
autocmd BufReadPost  * loadview
"--------------------------------------------------------------------
" Basics_end }}}
"====================================================================

"====================================================================
" Apperance: {{{
"--------------------------------------------------------------------
syntax enable
colorscheme hybrid
set background=dark
set ruler       " Show cursor position
set number      " Display line number
set showcmd     " Display command in the status line
set lazyredraw  " redrawn while executing macros, registers and other command
set showmatch   " highlight the matching parentheses
set linespace=0 " Number of pixel lines inserted between characters
set list        " Display unprintable characters
set display=uhex " Show unprintable charcters hexadecimal
set colorcolumn=80
" Useing string in list mode
set listchars=tab:»-,trail:-,extends:»,precedes:«,eol:¬
" Filetype syntax
autocmd MyAutoCmd BufNewFile,BufRead *.json    setf json
autocmd MyAutoCmd BufNewFile,BufRead *.md      setf markdown
autocmd MyAutoCmd BufNewFile,BufRead *.jquery  setf jquery
autocmd MyAutoCmd BufNewFile,BufRead *.css     setf css3
autocmd MyAutoCmd BufNewFile,BufRead *.txt     setf hybrid
"--------------------------------------------------------------------
" Apperance_end }}}
"====================================================================

"====================================================================
" Indent: {{{
"--------------------------------------------------------------------
set autoindent  " Copy indent from current line when starting a new line
set smartindent " Do smart autoindenting when starting a new line
set cindent     " Indent for C lang
set expandtab   " Replace the tabs to spaces
set shiftround
" Setting the tab width
set tabstop=4 shiftwidth=4 softtabstop=0
"--------------------------------------------------------------------
" Indent_end }}}
"====================================================================

"====================================================================
" Complete: {{{
"--------------------------------------------------------------------
set wildchar=<tab>     " Key for execute Complete
set wildmenu           " Expand complete for comand line
set wildmode=list:full " Display all match pattern, and complete first match
set complete+=k        " Adding the dictionary file
"--------------------------------------------------------------------
" Complete_end }}}
"====================================================================

"====================================================================
" Search: {{{
"--------------------------------------------------------------------
set wrapscan   " Search warp around the end of file
set ignorecase " Ignore Uppercase and lowercase
set smartcase  " If Start Uppercase, Case-sensitive
set incsearch  " Enable incremental search
set hlsearch   " Highlight the search charcters
" Tern off the highlight search
nnoremap <silent> s  :<C-u>nohlsearch<CR>
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
nnoremap <silent><C-j> :<C-u>bp<CR>
nnoremap <silent><C-k> :<C-u>bn<CR>
nnoremap <leader>d :<C-u>bd<CR>
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
" default encoding
set encoding=utf-8
" Line feed code
set fileformats=unix,dos,mac
" Encoding automatic identification
if &encoding !=# 'utf-8'
  set encoding=japan
  set fileencoding=japan
endif
if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  "Check eucJP-ms encoding by iconv
  if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'eucjp-ms'
    let s:enc_jis = 'iso-2022-jp-3'
    "Check JISX0213 encoding by iconv
  elseif iconv("\x87\x64\x87\x6a", 'cp932','euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
  " Setting fileencodings
  if &encoding ==# 'utf-8'
    let s:fileencodings_default = &fileencodings
    let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
    let &fileencodings = &fileencodings .','. s:fileencodings_default
    unlet s:fileencodings_default
  else
    let &fileencodings = &fileencodings .','. s:enc_jis
    set fileencodings+=utf-8,ucs-2le,ucs-2
    if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
      set fileencodings+=cp932
      set fileencodings-=euc-jp
      set fileencodings-=euc-jisx0213
      set fileencodings-=eucjp-ms
      let &encoding = s:enc_euc
      let &fileencoding = s:enc_euc
    else
      let &fileencodings = &fileencodings .','. s:enc_euc
    endif
  endif
  unlet s:enc_euc
  unlet s:enc_jis
endif
" If not japanses, use encoding instead of fileencoding
if has('autocmd')
  function! AU_ReCheck_FENC()
    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
      let &fileencoding=&encoding
    endif
  endfunction
  autocmd BufReadPost * call AU_ReCheck_FENC()
endif
" cursor support Multi byte characters
if exists('&ambiwidth')
  set ambiwidth=double
endif
"--------------------------------------------------------------------
" Encoding_end }}}
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
" Window auto command
augroup QfxAuto
    autocmd!
    " If use make or grep command, open Quickfix
    autocmd QuickfixCmdPost make,grep,grepadd,vimgrep copen
    " Close to QuickFix, Help
    autocmd FileType help,qf nnoremap <buffer> <ESC> <C-w>c
augroup END
" Binary mode for xxd
augroup BinaryXXD
    autocmd!
    autocmd BufReadPre *.bin let &binary =1
    autocmd BufReadPost * if &binary | silent %!xxd
    autocmd BufReadPost * set ft=xxd | endif
    autocmd BufWritePre * if &binary | %!xxd -r | endif
    autocmd BufWritePost * if &binary | silent %!xxd
    autocmd BufWritePost * set nomod | endif
augroup END
"--------------------------------------------------------------------
" Utility_end }}}
"====================================================================

"====================================================================
" Backup: {{{
"--------------------------------------------------------------------
set nobackup      " Not Buckup
set noswapfile    " Not create swap file
set nowritebackup " Disable Backup
set history=10000 " History number for command and search pattern
"" read/write a .viminfo file, don't store more than
set viminfo='50,<1000,s100,\"50,!
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
