"----------------------
" neocomplete
"----------------------
if neobundle#tap('neocomplete.vim') && has('lua')
    let g:neocomplete#enable_at_startup = 1
    let g:neocomplete#enable_ignore_case = 1
    let g:neocomplete#enable_smart_case = 1
    let g:neocomplete#enable_auto_select = 1
    let g:neocomplete#enable_enable_camel_case_completion = 0
    if !exists('g:neocomplete#keyword_patterns')
        let g:neocomplete#keyword_patterns = {}
    endif
    let g:neocomplete#keyword_patterns._ = '\h\w*'
    inoremap <expr><C-i>  pumvisible() ? "\<C-n>" : "\<TAB>"
    call neobundle#untap()
endif

"----------------------
" neocomplcache
"----------------------
if neobundle#tap('neocomplcache.vim')
    "let g:acp_enableAtStartup = 0
    let g:neocomplcache_enable_at_startup = 1
    let g:neocomplcache_enable_ignore_case = 1
    let g:neocomplcache_enable_smart_case = 1
    let g:neocomplcache_enable_auto_select = 1
    let g:neocomplcache_enable_enable_camel_case_completion = 0
    if !exists('g:neocomplcache_keyword_patterns')
        let g:neocomplcache_keyword_patterns = {}
    endif
    let g:neocomplcache_keyword_patterns._ = '\h\w*'
    inoremap <expr><C-i>  pumvisible() ? "\<C-n>" : "\<TAB>"
    call neobundle#untap()
endif

"----------------------
" Unite.vim
"----------------------
if neobundle#tap('unite.vim')
    nnoremap [unite] <Nop>
    nmap , [unite]
    nnoremap <silent> [unite]f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
    nnoremap <silent> [unite]m :<C-u>Unite file_mru<CR>
    nnoremap <silent> [unite]b :<C-u>Unite buffer<CR>
    nnoremap <silent> [unite]r :<C-u>Unite register<CR>
    nnoremap <silent> [unite]g
            \ :<C-u>Unite grep -buffer-name=grep`tabpagenr()`
            \ -split -no-empty -resume<CR>
    nnoremap <silent> [unite]c :<C-u>Unite bookmark<CR>
    nnoremap <silent> [unite]o :<C-u>Unite outline<CR>
    nnoremap <silent> [unite]t :<C-u>Unite tab<CR>
    nnoremap <silent> [unite]w :<C-u>Unite window<CR>
    " start unite in insert mode
    let g:unite_enable_start_insert = 1
    let g:unite_enable_ignore_case = 1
    let g:unite_enable_smart_case = 1
    "" use vimfiler to open directory
    autocmd MyAutoCmd FileType unite call s:unite_settings()
    function! s:unite_settings()
        imap <buffer> <Tab> <Plug>(unite_complete)
        imap <buffer> <C-w> <Plug>(unite_delete_backward_path)
        imap <buffer> jj    <Plug>(unite_insert_leave)
        imap <buffer> <Esc> <Plug>(unite_exit)
    endfunction
    call neobundle#untap()
endif

"----------------------
" vimfiler
"----------------------
if neobundle#tap('vimfiler')
    nnoremap <Leader>e :VimFilerExplorer<CR>
    let g:vimfiler_as_default_explorer = 1
    let g:vimfiler_enable_auto_cd = 1
    let g:vimfiler_tree_leaf_icon = ' '
    let g:vimfiler_tree_opened_icon = '▾'
    let g:vimfiler_tree_closed_icon = '▸'
    let g:vimfiler_file_icon = ' '
    let g:vimfiler_readonly_file_icon = '✗'
    let g:vimfiler_marked_file_icon = '✓'
    autocmd MyAutoCmd FileType vimfiler call s:vimfiler_settings()
    function! s:vimfiler_settings()
        nmap <buffer> <Tab> <Plug>(vimfiler_switch_to_other_window)
    endfunction
    call neobundle#untap()
endif

"----------------------
" gundo
"----------------------
if neobundle#tap('gundo.vim')
    nnoremap <Leader>g :GundoToggle<CR>
    call neobundle#untap()
endif

"----------------------
" vim-template
"----------------------
if neobundle#tap('vim-template')
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
    call neobundle#untap()
endif

"----------------------
" quickrun
"----------------------
if neobundle#tap('vim-quickrun')
    nmap <silent> <Leader>r <Plug>(quickrun)
    let g:quickrun_config = {
        \ 'go': {'command': 'go run'},
        \ '*': {'runner': 'vimproc'},
        \ }
    call neobundle#untap()
endif

"----------------------
" qFixhowm
"----------------------
if neobundle#tap('qfixhowm')
    let howm_dir = '~/Dropbox/howm'
    let QFixHowm_RootDir = '~/Dropbox/howm'
    let QFixMRU_Filename = '~/.qfixmru'
    let QFixHowm_FileType = 'markdown'
    let QFixMRU_EntryMax = 300
    call neobundle#untap()
endif

"----------------------
" buftabs.vim
"----------------------
if neobundle#tap('buftabs')
    "バッファタブにパスを省略してファイル名のみ表示する
    let g:buftabs_only_basename=1
    "バッファタブをステータスライン内に表示する
    "let g:buftabs_in_statusline=1
    call neobundle#untap()
endif

"----------------------
" Align
"----------------------
if neobundle#tap('Align')
    " Alignを日本語環境で使用するための設定
    let g:Align_xstrlen = 3
    call neobundle#untap()
endif

"----------------------
" VimShell
"----------------------
if neobundle#tap('vimshell.vim')
    nnoremap <silent> <leader>s :<C-u>VimShell<CR>
    call neobundle#untap()
endif

"----------------------
" vim-go
"----------------------
if neobundle#tap('vim-go')
    let g:go_highlight_functions = 1
    let g:go_highlight_methods = 1
    let g:go_highlight_structs = 1
    call neobundle#untap()
endif

"----------------------
" tagbar
"----------------------
if neobundle#tap('tagbar')
    nnoremap <Leader>t :TagbarToggle<CR>
    let g:tagbar_left = 0
    let g:tagbar_autofocus = 1
    call neobundle#untap()
endif

"----------------------
" YankRing.vim
"----------------------
"if neobundle#tap('YankRing')
"    nmap <leader>y :YRShow<CR>
"    call neobundle#untap()
"endif

"----------------------
" neosnippet
"----------------------
"if neobundle#tap('neosnippet')
"    " Plugin key-mappings.
"    imap <C-k>     <Plug>(neosnippet_expand_or_jump)
"    smap <C-k>     <Plug>(neosnippet_expand_or_jump)
"    xmap <C-k>     <Plug>(neosnippet_expand_target)
"    " SuperTab like snippets behavior.
"    imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
"    \ "\<Plug>(neosnippet_expand_or_jump)"
"    \: pumvisible() ? "\<C-n>" : "\<TAB>"
"    smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
"    \ "\<Plug>(neosnippet_expand_or_jump)"
"    \: "\<TAB>"
"    " For snippet_complete marker.
"    if has('conceal')
"       set conceallevel=2 concealcursor=i
"    endif
"    " Enable snipMate compatibility feature.
"    let g:neosnippet#enable_snipmate_compatibility = 1
"    " Tell Neosnippet about the other snippets
"    let g:neosnippet#snippets_directory=s:bundle_root . '/vim-snippets/snippets'
"   call neobundle#untap()
"endif

"----------------------
" jedi
"----------------------
"if neobundle#tap('jedi-vim')
"   " jediにvimの設定を任せると'completeopt+=preview'するので
"   " 自動設定機能をOFFにし手動で設定を行う
"   let g:jedi#auto_vim_configuration = 0
"   " 手動補完を行うキーマップを指定
"   let g:jedi#completions_command = <C-/>
"   " 補完の最初の項目が選択された状態だと使いにくいためオフにする
"   let g:jedi#popup_select_first = 0
"   " quickrunと被るため大文字に変更
"   let g:jedi#rename_command = '<Leader>R'
"   " gundoと被るため大文字に変更
"   let g:jedi#goto_assignments_command = '<Leader>G'
"   call neobundle#untap()
"endif
