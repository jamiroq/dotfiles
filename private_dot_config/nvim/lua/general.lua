local vim = vim

-- エンコード
vim.scriptencoding = "utf-8"
vim.opt.encoding = "utf-8" --[default]
vim.opt.fileencoding = "utf-8"
vim.opt.ambiwidth = "single"

-- 表示
vim.opt.number = true
vim.opt.showcmd = true
vim.opt.showmatch = true
vim.opt.cmdheight = 1
vim.opt.laststatus = 2 --[default]
vim.opt.winblend = 20
vim.opt.pumblend = 20
vim.opt.termguicolors = true
vim.opt.wrap = false
vim.opt.textwidth = 0
vim.opt.helplang = "ja"
vim.opt.formatoptions:remove('t')
vim.opt.formatoptions:append('mM')

-- 挙動
vim.opt.clipboard = "unnamedplus"
vim.opt.whichwrap = "b,s,h,l,[,],<,>"
vim.opt.backspace = "indent,eol,start"
vim.opt.nrformats = "bin,hex" --[default]
vim.opt.foldmethod = "marker"
vim.opt.timeoutlen = 500
vim.opt.autoindent = true --[default]
vim.opt.smartindent = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.autochdir = true

-- 補完
vim.opt.wildmenu = true  --[default]

-- 検索
vim.opt.hlsearch = true  --[default]
vim.opt.incsearch = true --[default]
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- backup
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.writebackup = false
vim.opt.undofile = false

-- disable default plugin
vim.g.loaded_gzip = true
vim.g.loaded_tar = true
vim.g.loaded_tarPlugin = true
vim.g.loaded_zip = true
vim.g.loaded_zipPlugin = true
vim.g.loaded_vimball = true
vim.g.loaded_vimballPlugin = true
vim.g.loaded_2html_plugin = true
vim.g.loaded_getscript = true
vim.g.loaded_getscriptPlugin = true
vim.g.loaded_netrw = true
vim.g.loaded_netrwPlugin = true
vim.g.loaded_netrwSettings = true
vim.g.loaded_netrwFileHandlers = true
vim.g.loaded_matchit = true
vim.g.loaded_matchparen = true
vim.g.loaded_shada_plugin = true
vim.g.loaded_spellfile_plugin = true
vim.g.loaded_tutor_mode_plugin = true
vim.g.did_install_default_menus = true
vim.g.did_install_syntax_menu = true
vim.g.skip_loading_mswin = true
vim.g.did_indent_on = true
vim.g.did_load_ftplugin = true
vim.g.loaded_rrhelper = true
