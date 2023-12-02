-- TODO
-- telescopeの設定
-- pluginの見直し

-- 起動の高速化
vim.loader.enable()

-- init
vim.api.nvim_create_augroup('vimrc', { clear = true })

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
vim.opt.helplang = "ja", "en"
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
vim.g.loaded_gzip = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_netrwFileHandlers = 1

-- keymap --
local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap
vim.g.mapleader = " "

-- Nop
keymap("", "q:", "<Nop>", opts)
keymap("", "q/", "<Nop>", opts)
keymap("", "q?", "<Nop>", opts)

-- normal mode
keymap("n", "n", "nzz", opts)
keymap("n", "N", "Nzz", opts)
keymap("n", "*", "*N", opts)
keymap("n", "#", "#N", opts)
keymap("n", "Y", "y$", opts)
keymap("n", "<Leader><Leader>", ":<C-u>up<CR>", opts)
keymap("n", "<C-l>", ":<C-u>nohlsearch<CR><ESC>", opts)
keymap("n", "<C-p>", ":<C-u>bp<CR>", opts)
keymap("n", "<C-n>", ":<C-u>bn<CR>", opts)
keymap("n", "<Leader>k", ":<C-u>help<Space><C-r><C-w><CR>", opts)
keymap("n", "<Leader>K", ":<C-u>vert bel help<Space><C-r><C-w><CR>", opts)

-- insert mode
keymap("i", "<C-a>", "<Home>", opts)
keymap("i", "<C-e>", "<End>", opts)
keymap("i", "<C-d>", "<Del>", opts)
keymap("i", "<C-b>", "<Left>", opts)
keymap("i", "<C-n>", "<Down>", opts)
keymap("i", "<C-p>", "<Up>", opts)
keymap("i", "<C-f>", "<Right>", opts)
keymap("i", "jj", "<ESC>", opts)

-- command mode
keymap("c", "<C-a>", "<Home>", opts)
keymap("c", "<C-e>", "<End>", opts)
keymap("c", "<C-d>", "<Del>", opts)
keymap("c", "<C-b>", "<Left>", opts)
keymap("c", "<C-f>", "<Right>", opts)

-- visual mode
keymap("v", "v", "$h", opts)
keymap("v", "//", [[y/<C-R>=escape(@", '\\/.*$^~[]')<CR><CR>]], opts)

-- util
vim.api.nvim_create_user_command("Ev", function(opts)
    vim.cmd("edit" .. "$MYVIMRC")
end, {})
vim.api.nvim_create_user_command("Rv", function(opts)
    vim.cmd("source" .. "$MYVIMRC")
end, {})
vim.api.nvim_create_autocmd({ 'FileType' }, {
    pattern = 'help',
    group = 'vimrc',
    command = 'nnoremap <buffer> <ESC> <C-w>c'
})

-- plugin
require "lazy_plugins"
