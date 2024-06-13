local r = require("utils.remaps")
local opts = { silent = true }

-- keymap --
vim.g.mapleader = " "

-- Nop
r.noremap("", "q:", "<Nop>", opts)
r.noremap("", "q/", "<Nop>", opts)
r.noremap("", "q?", "<Nop>", opts)

-- normal mode
r.noremap("n", "n", "nzz", opts)
r.noremap("n", "N", "Nzz", opts)
r.noremap("n", "*", "*N", opts)
r.noremap("n", "#", "#N", opts)
r.noremap("n", "Y", "y$", opts)
r.noremap("n", "<C-l>", "<cmd>nohlsearch<CR><ESC>", opts)
r.noremap("n", "<C-p>", "<cmd>bp<CR>", opts)
r.noremap("n", "<C-n>", "<cmd>bn<CR>", opts)
r.noremap("n", "<Leader>k", "<cmd>help<Space><C-r><C-w><CR>", opts)
r.noremap("n", "<Leader>K", "<cmd>vert bel help<Space><C-r><C-w><CR>", opts)
r.noremap("n", "<Leader><Leader>", "<cmd>up<CR>")
r.noremap("n", "<Leader>t", "<cmd>terminal<CR>", opts)

-- insert mode
r.noremap("i", "<C-a>", "<Home>", opts)
r.noremap("i", "<C-e>", "<End>", opts)
r.noremap("i", "<C-d>", "<Del>", opts)
r.noremap("i", "<C-b>", "<Left>", opts)
r.noremap("i", "<C-n>", "<Down>", opts)
r.noremap("i", "<C-p>", "<Up>", opts)
r.noremap("i", "<C-f>", "<Right>", opts)
r.noremap("i", "<C-v>", "<C-r>*", opts)
r.noremap("i", "jj", "<ESC>", opts)

-- command mode
r.noremap("c", "<C-a>", "<Home>")
r.noremap("c", "<C-e>", "<End>")
r.noremap("c", "<C-d>", "<Del>")
r.noremap("c", "<C-b>", "<Left>")
r.noremap("c", "<C-f>", "<Right>")

-- visual mode
r.noremap("v", "v", "$h", opts)
r.noremap("v", "//", [[y/<C-R>=escape(@", '\\/.*$^~[]', opts  )<CR><CR>]], opts)

-- terminal
r.noremap("t", "<Esc>", "<C-\\><C-n>", opts)
vim.api.nvim_create_autocmd({ 'TermOpen' }, {
    pattern = '*',
    group = 'vimrc',
    command = 'startinsert'
})
vim.api.nvim_create_autocmd({ 'TermOpen' }, {
    pattern = '*',
    group = 'vimrc',
    command = 'setlocal nonumber'
})

-- util
vim.api.nvim_create_user_command("Ev", "edit $MYVIMRC", {})
vim.api.nvim_create_user_command("Rv", "source $MYVIMRC", {})

vim.api.nvim_create_autocmd({ 'FileType' }, {
    pattern = { 'help', 'qf' },
    group = 'vimrc',
    command = 'nnoremap <buffer> <ESC> <C-w>c'
})

-- goimports
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    pattern = "*.go",
    callback = function()
        local params = vim.lsp.util.make_range_params()
        params.context = { only = { "source.organizeImports" } }
        local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
        for cid, res in pairs(result or {}) do
            for _, r in pairs(res.result or {}) do
                if r.edit then
                    local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
                    vim.lsp.util.apply_workspace_edit(r.edit, enc)
                end
            end
        end
        vim.lsp.buf.format({ async = false })
    end
})
