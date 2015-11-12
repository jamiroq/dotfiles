"===============================================================================
" .vimrc_version : 0.8.2
" for MacVim version : 7.3, 7.4 (recommend +lua, and git)
"===============================================================================

"===============================================================================
" This_is_vim:
"===============================================================================
set nocompatible

"===============================================================================
" Initialization: {{{
"-------------------------------------------------------------------------------
" Initialize autocmd
augroup MyAutoCmd
	autocmd!
augroup END

let mapleader = " "             " Map leader
"-------------------------------------------------------------------------------
" Initialization_END }}}
"===============================================================================

"===============================================================================
" Plugins: {{{
"-------------------------------------------------------------------------------

"----------------------
" neobundle.vim
"----------------------
let s:noplugin = 0
let s:bundle_root = expand('~/.vim/bundle')
let s:neobundle_root = s:bundle_root . '/neobundle.vim'
if !isdirectory(s:neobundle_root) || v:version < 702
	" NeoBundleが存在しない、vimが古い場合読み込まない
	let s:noplugin = 1
else
	if has('vim_starting')
		execute "set runtimepath+=" . s:neobundle_root
	endif
	call neobundle#begin(s:bundle_root)
	" NeoBundle自身を管理する
	NeoBundleFetch 'Shougo/neobundle.vim'
	NeoBundle "Shougo/vimproc", {
			\ "build": {
			\   "windows"   : "make -f make_mingw32.mak",
			\   "cygwin"    : "make -f make_cygwin.mak",
			\   "mac"       : "make -f make_mac.mak",
			\   "unix"      : "make -f make_unix.mak",
			\ }}
	NeoBundle 'Shougo/vimshell.git'
	NeoBundle 'tpope/vim-surround.git'
	NeoBundle 'w0ng/vim-hybrid.git'
	NeoBundle 'vim-jp/vimdoc-ja.git'
	NeoBundle 'tsukkee/lingr-vim.git'
	NeoBundleLazy 'mattn/zencoding-vim', {
	\ "autoload": {"filetypes": ['html']}}

	"----------------------
	" VimShell
	"----------------------
	nnoremap <silent> <leader>s :VimShell<CR>

	"----------------------
	" neocomplete & neocomplcache
	"----------------------
	if has('lua') && v:version > 703 && has('patch825')
		NeoBundleLazy "Shougo/neocomplete.vim", {
			\ "autoload": {
			\   "insert": 1,
			\ }}
		let s:hooks = neobundle#get_hooks("neocomplete.vim")
		function! s:hooks.on_source(bundle)
			let g:acp_enableAtStartup = 0
			let g:neocomplet#enable_smart_case = 1
		endfunction
	else
		NeoBundleLazy "Shougo/neocomplcache.vim", {
			\ "autoload": {
			\   "insert": 1,
			\ }}
		let s:hooks = neobundle#get_hooks("neocomplcache.vim")
		function! s:hooks.on_source(bundle)
			let g:acp_enableAtStartup = 0
			let g:neocomplcache_enable_smart_case = 1
			let g:neocomplcache_enable_at_startup = 1
		endfunction
	endif

	"----------------------
	" neosnippet
	"----------------------
	"NeoBundleLazy "Shougo/neosnippet.vim", {
	"	\ "depends": ["honza/vim-snippets"],
	"	\ "autoload": {
	"	\   "insert": 1,
	"	\ }}
	"let s:hooks = neobundle#get_hooks("neosnippet.vim")
	"function! s:hooks.on_source(bundle)
	"" Plugin key-mappings.
	"imap <C-k>     <Plug>(neosnippet_expand_or_jump)
	"smap <C-k>     <Plug>(neosnippet_expand_or_jump)
	"xmap <C-k>     <Plug>(neosnippet_expand_target)
	"" SuperTab like snippets behavior.
	"imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
	"\ "\<Plug>(neosnippet_expand_or_jump)"
	"\: pumvisible() ? "\<C-n>" : "\<TAB>"
	"smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
	"\ "\<Plug>(neosnippet_expand_or_jump)"
	"\: "\<TAB>"
	"" For snippet_complete marker.
	"if has('conceal')
	"	set conceallevel=2 concealcursor=i
	"endif
	"" Enable snipMate compatibility feature.
	"let g:neosnippet#enable_snipmate_compatibility = 1
	"" Tell Neosnippet about the other snippets
	"let g:neosnippet#snippets_directory=s:bundle_root . '/vim-snippets/snippets'
	"endfunction

	"----------------------
	" Unite.vim
	"----------------------
	NeoBundleLazy "Shougo/unite.vim", {
		\ "autoload": {
		\   "commands": ["Unite", "UniteWithBufferDir"]
		\ }}
	NeoBundleLazy 'h1mesuke/unite-outline', {
		\ "autoload": {
		\   "unite_sources": ["outline"],
		\ }}
	nnoremap [unite] <Nop>
	nmap , [unite]
	nnoremap <silent> [unite]f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
	nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
	nnoremap <silent> [unite]r :<C-u>Unite register<CR>
	nnoremap <silent> [unite]m :<C-u>Unite file_mru<CR>
	nnoremap <silent> [unite]c :<C-u>Unite bookmark<CR>
	nnoremap <silent> [unite]o :<C-u>Unite outline<CR>
	nnoremap <silent> [unite]t :<C-u>Unite tab<CR>
	nnoremap <silent> [unite]w :<C-u>Unite window<CR>
	let s:hooks = neobundle#get_hooks("unite.vim")
	function! s:hooks.on_source(bundle)
		" start unite in insert mode
		let g:unite_enable_start_insert = 1
		" use vimfiler to open directory
		call unite#custom_default_action("source/bookmark/directory", "vimfiler")
		call unite#custom_default_action("directory", "vimfiler")
		call unite#custom_default_action("directory_mru", "vimfiler")
		autocmd MyAutoCmd FileType unite call s:unite_settings()
		function! s:unite_settings()
			imap <buffer> <Esc><Esc> <Plug>(unite_exit)
			nmap <buffer> <Esc> <Plug>(unite_exit)
			nmap <buffer> <C-n> <Plug>(unite_select_next_line)
			nmap <buffer> <C-p> <Plug>(unite_select_previous_line)
		endfunction
	endfunction

	"----------------------
	" vimfiler
	"----------------------
	NeoBundleLazy "Shougo/vimfiler", {
			\ "depends": ["Shougo/unite.vim"],
			\ "autoload": {
			\   "commands": ["VimFilerTab", "VimFiler", "VimFilerExplorer"],
			\   "mappings": ['<Plug>(vimfiler_switch)'],
			\   "explorer": 1,
			\ }}
	nnoremap <Leader>e :VimFilerExplorer<CR>
	" close vimfiler automatically when there are only vimfiler open
	autocmd MyAutoCmd BufEnter * if (winnr('$') == 1 && &filetype ==# 'vimfiler') | q | endif
	let s:hooks = neobundle#get_hooks("vimfiler")
	function! s:hooks.on_source(bundle)
		let g:vimfiler_as_default_explorer = 1
		let g:vimfiler_enable_auto_cd = 1
		" vimfiler specific key mappings
		autocmd MyAutoCmd FileType vimfiler call s:vimfiler_settings()
		function! s:vimfiler_settings()
			" ^^ to go up
			nmap <buffer> ^^ <Plug>(vimfiler_switch_to_parent_directory)
			" use R to refresh
			nmap <buffer> R <Plug>(vimfiler_redraw_screen)
			" overwrite C-l
			nmap <buffer> <C-l> <C-w>l
		endfunction
	endfunction

	"----------------------
	" gundo
	"----------------------
	NeoBundleLazy "sjl/gundo.vim", {
		\ "autoload": {
		\   "commands": ['GundoToggle'],
		\}}
	nnoremap <Leader>g :GundoToggle<CR>

	"----------------------
	" vim-template
	"----------------------
	NeoBundle "thinca/vim-template"
	" テンプレート中に含まれる特定文字列を置き換える
	autocmd MyAutoCmd User plugin-template-loaded call s:template_keywords()
	function! s:template_keywords()
		silent! %s/<+DATE+>/\=strftime('%Y-%m-%d')/g
		silent! %s/<+FILENAME+>/\=expand('%:r')/g
	endfunction
	" テンプレート中に含まれる'<+CURSOR+>'にカーソルを移動
	autocmd MyAutoCmd User plugin-template-loaded
		\   if search('<+CURSOR+>')
		\ |   silent! execute 'normal! "_da>'
		\ | endif

	"----------------------
	" quickrun
	"----------------------
	NeoBundleLazy "thinca/vim-quickrun", {
		\ "autoload": {
		\   "mappings": [['nxo', '<Plug>(quickrun)']]
		\ }}
	nmap <Leader>r <Plug>(quickrun)
	let s:hooks = neobundle#get_hooks("vim-quickrun")
	function! s:hooks.on_source(bundle)
	let g:quickrun_config = {
		\ "*": {"runner": "remote/vimproc"},
		\ }
	endfunction

	"----------------------
	" tagbar
	"----------------------
	NeoBundleLazy 'majutsushi/tagbar', {
		\ "autoload": {
		\   "commands": ["TagbarToggle"],
		\ },
		\ "build": {
		\   "mac": "brew install ctags",
		\ }}
	nmap <Leader>t :TagbarToggle<CR>

	"----------------------
	" jedi
	"----------------------
	"NeoBundleLazy "davidhalter/jedi-vim", {
	"	\ "autoload": {
	"	\   "filetypes": ["python", "python3", "djangohtml"],
	"	\   "build": {
	"	\     "mac": "pip install jedi",
	"	\     "unix": "pip install jedi",
	"	\   }
	"	\ }}
	"let s:hooks = neobundle#get_hooks("jedi-vim")
	"function! s:hooks.on_source(bundle)
	"	" jediにvimの設定を任せると'completeopt+=preview'するので
	"	" 自動設定機能をOFFにし手動で設定を行う
	"	let g:jedi#auto_vim_configuration = 0
	"	" 手動補完を行うキーマップを指定
	"	let g:jedi#completions_command = <C-/>
	"	" 補完の最初の項目が選択された状態だと使いにくいためオフにする
	"	let g:jedi#popup_select_first = 0
	"	" quickrunと被るため大文字に変更
	"	let g:jedi#rename_command = '<Leader>R'
	"	" gundoと被るため大文字に変更
	"	let g:jedi#goto_assignments_command = '<Leader>G'
	"endfunction

	"----------------------
	" TaskList
	"----------------------
	NeoBundleLazy 'vim-scripts/TaskList.vim', {
		\ "autoload": {"mappings": ['<Plug>TaskList']}}
	nmap <Leader>T <plug>TaskList

	"----------------------
	" qFixhowm
	"----------------------
	NeoBundle 'fuenor/qfixhowm.git'
	" メモのファイルタイプ
	let howm_dir = '~/Dropbox/howm'
	let QFixHowm_FileType = 'hybrid'
	let QFixHowm_RootDir = '~/Dropbox/howm'
	let QFixMRU_Filename = '~/.qfixmru'
	let QFixMRU_EntryMax = 300

	"----------------------
	" YankRing.vim
	"----------------------
	"NeoBundle 'vim-scripts/YankRing.vim'
	"nmap <leader>y :YRShow<CR>

	"----------------------
	" buftabs.vim
	"----------------------
	NeoBundle 'vim-scripts/buftabs.git'
	"バッファタブにパスを省略してファイル名のみ表示する
	let g:buftabs_only_basename=1
	"バッファタブをステータスライン内に表示する
	let g:buftabs_in_statusline=1

	"----------------------
	" Aligen
	"----------------------
	NeoBundle 'Align'
	" Alignを日本語環境で使用するための設定
	let g:Align_xstrlen = 3

	"----------------------
	" NeoBundle_END
	"----------------------
	call neobundle#end()
	filetype plugin indent on
	" インストールされていないプラグインのチェック
	"NeoBundleCheck
endif

"-------------------------------------------------------------------------------
" Plugins_end }}}
"===============================================================================

"===============================================================================
" StatusLine: {{{
"-------------------------------------------------------------------------------
" View the status line always
set laststatus=2
" Statusline format
set statusline=%=(%<%F\ )%r%h%w%y%{'['.(&fenc!=''?&fenc:&enc).']['.&ff.']'}[%l/%L](%P)"%m
" Status line color change on insert mode (gvim only)
augroup InsertHook
	autocmd!
	autocmd InsertEnter * highlight StatusLine ctermfg=245 ctermbg=235 guifg=#ccdc90 guibg=#2E4340
	autocmd InsertLeave * highlight StatusLine ctermfg=235 ctermbg=245 guifg=#2E4340 guibg=#ccdc90
augroup END
"-------------------------------------------------------------------------------
" StatusLine_end }}}
"===============================================================================

"===============================================================================
" Basicas: {{{
"-------------------------------------------------------------------------------
set vb t_vb=                    " To mute the beep
set autoread                    " If the file is rewritten, read automatically
set hidden                      " Hide without closing the buffer
set switchbuf=useopen           " To open a buffer is already in place to open new
set browsedir=buffer            " Initial directory of Explore
set scrolloff=5                 " Secure margin when scrolling
set backspace=indent,eol,start  " Backspace erase everything
set whichwrap=b,s,h,l,<,>,[,]   " Not stop at the beginning and end of a line
set textwidth=0                 " Not wrapped automatically even wrote a long text
set formatoptions=lmoq          " Text formatting option add multi-byte
set matchpairs& matchpairs+=<:> " Add '<' and '>' to the corresponding brackets
set helplang=ja,en              " Help language
set foldmethod=marker
set viewoptions=folds,cursor    " Change the effect of mkview command
filetype plugin indent on
autocmd BufWritePost * mkview
autocmd BufReadPost  * loadview
"-------------------------------------------------------------------------------
" Basics_end }}}
"===============================================================================

"===============================================================================
" Apperance: {{{
"-------------------------------------------------------------------------------
syntax enable
colorscheme hybrid
set background=dark
set ruler       " Show cursor position
set number      " Display line number
set showcmd     " Display command in the status line
set lazyredraw  " redrawn while executing macros, registers and other command
set showmatch   " highlight the matching parenthesis
set linespace=0 " Number of pixel lines inserted between characters
set list        " Display unprintable characters
" Useing string in list mode
set listchars=tab:»-,trail:-,extends:»,precedes:«,eol:¬
set display=uhex " Show unprintable charcters hexadecimal
set cursorline
"sytaxハイライトの設定
autocmd BufNewFile,BufRead *.json    setf json
autocmd BufNewFile,BufRead *.jquery  setf jquery
autocmd BufNewFile,BufRead *.css     setf css3
autocmd BufNewFile,BufRead *.txt     setf hybrid
"-------------------------------------------------------------------------------
" Apperance_end }}}
"===============================================================================

"===============================================================================
" Indent: {{{
"-------------------------------------------------------------------------------
set autoindent  " Copy indent from current line when starting a new line
set smartindent " Do smart autoindenting when starting a new line
set cindent     " Indent for C lang
set expandtab   " タブをスペースに展開する
set shiftround
" softtabstopはTabキー押し下げ時の挿入される空白の量，0の場合はtabstopと同じ，BSにも影響する
set tabstop=4 shiftwidth=4 softtabstop=0
"-------------------------------------------------------------------------------
" Indent_end }}}
"===============================================================================

"===============================================================================
" Complete: {{{
"-------------------------------------------------------------------------------
set wildmenu           " コマンド補完を強化
set wildchar=<tab>     " コマンド補完を開始するキー
set wildmode=list:full " リスト表示，最長マッチ
set history=1000       " コマンド・検索パターンの履歴数
set complete+=k        " 補完に辞書ファイル追加
"-------------------------------------------------------------------------------
" Complete_end }}}
"===============================================================================

"===============================================================================
" Search: {{{
"-------------------------------------------------------------------------------
set wrapscan   " 最後まで検索したら先頭へ戻る
set ignorecase " 大文字小文字無視
set smartcase  " 大文字ではじめたら大文字小文字無視しない
set incsearch  " インクリメンタルサーチ
set hlsearch   " 検索文字をハイライト
"検索によるハイライト消去
nnoremap <ESC><ESC> :nohlsearch<CR><ESC>
nnoremap <C-@><C-@> :nohlsearch<CR><ESC>
"選択した文字列を検索
vnoremap <silent> // y/<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>
"選択した文字列を置換
vnoremap /r "xy:%s/<C-R>=escape(@x, '\\/.*$^~[]')<CR>//gc<Left><Left><Left>
"-------------------------------------------------------------------------------
" Search_end }}}
"===============================================================================

"===============================================================================
" KeyConfig: {{{
"-------------------------------------------------------------------------------
" Prevent wrong target
nnoremap Q <Nop>
nnoremap q: <Nop>
" help search
nnoremap <S-k> :<C-u>vert bel help<Space><C-r><C-w><CR>
nnoremap <leader><S-k> :<C-u>vert bel help<Space><C-r><C-w>@en<CR>
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
nnoremap <silent><C-j> :bn<CR>
nnoremap <silent><C-k> :bp<CR>
nnoremap <leader>d <ESC>:bd<CR>
" ESC assign
inoremap <C-@> <ESC>
inoremap jj <Esc>
" Select to the end in visual mode
vnoremap v $h
" Save any changes
noremap <leader><leader> :up<CR>
" Edit vimrc/givmrc by Ev/Rv
command! Ev edit $MYVIMRC
command! Rv source $MYVIMRC
command! Eg edit $HOME/.gvimrc
command! Rg source $HOME/.gvimrc
" Save by superuser
cmap w!! w !sudo tee > /dev/null %
"-------------------------------------------------------------------------------
" KeyConfig_end }}}
"===============================================================================

"===============================================================================
" Encoding: {{{
"-------------------------------------------------------------------------------
set fileformats=unix,dos,mac "改行コードの自動認識
set encoding=utf-8   " デフォルトエンコーディング
" 文字コードの自動認識
if &encoding !=# 'utf-8'
  set encoding=japan
  set fileencoding=japan
endif
if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  "iconvがeucJP-msに対応しているかをチェック
  if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'eucjp-ms'
    let s:enc_jis = 'iso-2022-jp-3'
    " iconvがJISX0213に対応しているかをチェック
  elseif iconv("\x87\x64\x87\x6a", 'cp932','euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
  "fileencodingを構築
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
  "定数を処分
  unlet s:enc_euc
  unlet s:enc_jis
endif
"日本語を含まない場合にはfileencodingにencodingを使うようにする
if has('autocmd')
  function! AU_ReCheck_FENC()
    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
      let &fileencoding=&encoding
    endif
  endfunction
  autocmd BufReadPost * call AU_ReCheck_FENC()
endif
"□や○などの文字でカーソル位置を崩さない
if exists('&ambiwidth')
  set ambiwidth=double
endif
"-------------------------------------------------------------------------------
" Encoding_end }}}
"===============================================================================

"===============================================================================
" Utility: {{{
"-------------------------------------------------------------------------------
" クリップボードをデフォルトのレジスタとして指定。
if has('unnamedplus')
    set clipboard& clipboard+=unnamedplus
else
    " set clipboard& clipboard+=unnamed,autoselect
    set clipboard& clipboard+=unnamed
endif
" insertモードを抜けるとIMEオフ
set noimdisable
set iminsert=0 imsearch=0
set noimcmdline
inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>
" 現在開いているファイルのある場所に常にcdする
"autocmd   BufEnter *      exec ":lcd " . expand("%:p:h")
" Buffer autocommand
augroup BufferAu
	autocmd!
	" カレントディレクトリを自動的に移動
	autocmd BufNewFile,BufRead,BufEnter * if isdirectory(expand("%:p:h")) && bufname("%") !~ "NERD_tree" | cd %:p:h | endif
	" 前回終了したカーソル行に移動
	autocmd BufReadPost * if line("'\"") > 2 && line("'\"") <= line("$") | exe "normal g`\"" | endif
	" 保存時に行末の空白を除去する
	autocmd BufWritePre * :%s/\s\+$//ge
augroup END
" Window autocommand
augroup WindowAu
	autocmd!
	" make, grepコマンド後に自動的にQuickFixを開く
	autocmd QuickfixCmdPost make,grep,grepadd,vimgrep copen
	" QuickFix,Helpではqでバッファを閉じる
	autocmd FileType help,qf nnoremap <buffer> q <C-w>c
augroup END
"バイナリモード(vim -b)での起動、もしくは*.binファイルを開くとバイナリ編集モード(xxd)で起動
augroup BinaryXXD
	autocmd!
	autocmd BufReadPre *.bin let &binary =1
	autocmd BufReadPost * if &binary | silent %!xxd -g 1
	autocmd BufReadPost * set ft=xxd | endif
	autocmd BufWritePre * if &binary | %!xxd -r | endif
	autocmd BufWritePost * if &binary | silent %!xxd -g 1
	autocmd BufWritePost * set nomod | endif
augroup END
"-------------------------------------------------------------------------------
" Utility_end }}}
"===============================================================================

"===============================================================================
" Backup: {{{
"-------------------------------------------------------------------------------
"viminfoファイルの記憶情報
set viminfo='50,<1000,s100,\"50,!   " read/write a .viminfo file, don't store more than
set nobackup                      " バックアップ取らない
set noswapfile                    " スワップファイルを作成しない
set nowritebackup                 " バックアップファイルを無効化
"set directory=$VIM/tmp
"set backupdir=$VIM/tmp
"-------------------------------------------------------------------------------
" Backup_end }}}
"===============================================================================
"
"===============================================================================
" 外部設定ファイルの読み込み
let s:local_vimrc = expand('~/.vimrc.local')
if filereadable(s:local_vimrc)
		execute 'source ' . s:local_vimrc
endif
"===============================================================================

:finish
"===============================================================================
" Archive: {{{
"===============================================================================
"括弧/クォートの補完
vnoremap { "zdi{<C-R>z}<ESC>
vnoremap [ "zdi[<C-R>z]<ESC>
vnoremap ( "zdi(<C-R>z)<ESC>
vnoremap " "zdi"<C-R>z"<ESC>
vnoremap ' "zdi'<C-R>z'<ESC>
" -- tabでオムニ補完
function! InsertTabWrapper()
  if pumvisible()
    return "\<c-n>"
  endif
  let col = col('.') - 1
  if !col || getline('.')[col -1] !~ '\k\|<\|/'
    return "\<tab>"
  elseif exists('&omnifunc') && &omnifunc == ''
    return "\<c-n>"
  else
    return "\<c-x>\<c-o>"
  endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
" 全角スペースをハイライト
augroup highlightIdegraphicSpace
	autocmd!
	autocmd ColorScheme * highlight IdeographicSpace term=underline ctermbg=DarkGray guibg=DarkGray
	autocmd VimEnter,WinEnter * match IdeographicSpace /　/
augroup END
",g でそのコマンドを実行
nmap <leader>g :execute '!' &ft ' %'<CR>
if has("autocmd")
    autocmd FileType haskell map ,g :execute '!runghc %'<CR>
    autocmd FileType tex map ,g :execute '!platex %'<CR>
    autocmd FileType plaintex map ,g :execute '!platex %'<CR>
endif
"----------------------
" pathgen.vim
"----------------------
" pathogenでftdetectなどをloadさせるために一度ファイルタイプ判定をoff
filetype off
" pathogen.vimによってbundle配下のpluginをpathに加える
call pathogen#runtime_append_all_bundles()
call pathogen#helptags()
set helpfile=$VIMRUNTIME/doc/help.txt
" ファイルタイプ判定をon
filetype plugin indent on
"----------------------
" unite.vim
"----------------------
" 入力モードで開始する
let g:unite_enable_start_insert=1
" バッファ一覧
noremap <Leader>b :Unite buffer<CR>
" ファイル一覧
noremap <Leader>f :Unite -buffer-name=file file<CR>
" 最近使ったファイルの一覧
noremap <Leader>p :Unite file_mru<CR>
" ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-J> unite#do_action('split')
" ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-K> unite#do_action('vsplit')
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> :q<CR>
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>:q<CR>
" 初期設定関数を起動する
au FileType unite call s:unite_my_settings()
function! s:unite_my_settings()
" Overwrite settings.
endfunction
" 様々なショートカット
call unite#set_substitute_pattern('file', '\$\w\+', '\=eval(submatch(0))', 200)
call unite#set_substitute_pattern('file', '^@@', '\=fnamemodify(expand("#"), ":p:h")."/"', 2)
call unite#set_substitute_pattern('file', '^@', '\=getcwd()."/*"', 1)
call unite#set_substitute_pattern('file', '^;r', '\=$VIMRUNTIME."/"')
call unite#set_substitute_pattern('file', '^\~', escape($HOME, '\'), -2)
call unite#set_substitute_pattern('file', '\\\@<! ', '\\ ', -20)
call unite#set_substitute_pattern('file', '\\ \@!', '/', -30)
if has('win32') || has('win64')
  call unite#set_substitute_pattern('file', '^;p', 'C:/Program Files/')
  call unite#set_substitute_pattern('file', '^;v', '~/vimfiles/')
else
  call unite#set_substitute_pattern('file', '^;v', '~/.vim/')
endif
"----------------------
" VimFiler
"----------------------
let g:vimfiler_as_default_explorer = 1
call vimfiler#set_execute_file('html', 'vim')
call vimfiler#set_execute_file('css', 'vim')
call vimfiler#set_execute_file('java', 'vim')
call vimfiler#set_execute_file('py', 'vim')
call vimfiler#set_execute_file('js', 'vim')
call vimfiler#set_execute_file('json', 'vim')
"----------------------
" PowerLine
"----------------------
NeoBundle 'taichouchou2/alpaca_powertabline'
NeoBundle 'Lokaltog/powerline', { 'rtp' : 'powerline/bindings/vim'}
let g:Powerline_symbols = 'fancy'
let s:powerlineRC = expand('~/.vim/colors/powerline.vim')
if filereadable(s:powerlineRC)
	execute 'source ' . s:powerlineRC
endif
"===============================================================================
" Archive_end }}}
"===============================================================================
