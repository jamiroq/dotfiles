local r = require("utils.remaps")
local opts = { silent = true }

-- keymap --
vim.g.mapleader = " "

-- Nop
r.noremap("", "q:", "<Nop>", opts)
r.noremap("", "q/", "<Nop>", opts )
r.noremap("", "q?", "<Nop>", opts )

-- normal mode
r.noremap("n", "n", "nzz", opts )
r.noremap("n", "N", "Nzz", opts )
r.noremap("n", "*", "*N", opts )
r.noremap("n", "#", "#N", opts )
r.noremap("n", "Y", "y$", opts )
r.noremap("n", "<C-l>", "<cmd>nohlsearch<CR><ESC>", opts )
r.noremap("n", "<C-p>", "<cmd>bp<CR>", opts )
r.noremap("n", "<C-n>", "<cmd>bn<CR>", opts )
r.noremap("n", "<Leader>k", "<cmd>help<Space><C-r><C-w><CR>", opts )
r.noremap("n", "<Leader>K", "<cmd>vert bel help<Space><C-r><C-w><CR>", opts )
r.noremap("n", "<Leader><Leader>", "<cmd>up<CR>")

-- insert mode
r.noremap("i", "<C-a>", "<Home>", opts )
r.noremap("i", "<C-e>", "<End>", opts )
r.noremap("i", "<C-d>", "<Del>", opts )
r.noremap("i", "<C-b>", "<Left>", opts )
r.noremap("i", "<C-n>", "<Down>", opts )
r.noremap("i", "<C-p>", "<Up>", opts )
r.noremap("i", "<C-f>", "<Right>", opts )
r.noremap("i", "jj", "<ESC>", opts )

-- command mode
r.noremap("c", "<C-a>", "<Home>")
r.noremap("c", "<C-e>", "<End>")
r.noremap("c", "<C-d>", "<Del>")
r.noremap("c", "<C-b>", "<Left>")
r.noremap("c", "<C-f>", "<Right>")

-- visual mode
r.noremap("v", "v", "$h", opts )
r.noremap("v", "//", [[y/<C-R>=escape(@", '\\/.*$^~[]', opts  )<CR><CR>]], opts)

-- util
vim.api.nvim_create_user_command("Ev", "edit $MYVIMRC", {})
vim.api.nvim_create_user_command("Rv", "source $MYVIMRC", {})

vim.api.nvim_create_autocmd({ 'FileType' }, {
    pattern = 'help',
    group = 'vimrc',
    command = 'nnoremap <buffer> <ESC> <C-w>c'
})
