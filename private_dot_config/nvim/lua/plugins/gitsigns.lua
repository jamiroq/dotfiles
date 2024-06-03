return {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require('gitsigns').setup {
            signcolumn = false,
            numhl      = true,
            linehl     = false,
            word_diff  = false,
            on_attach  = function(bufnr)
                local gs = package.loaded.gitsigns
                local r = require("utils.remaps")
                r.map('n', ']c', function()
                    if vim.wo.diff then return ']c' end
                    vim.schedule(function() gs.next_hunk() end)
                    return '<Ignore>'
                end, { expr = true })
                r.map('n', '[c', function()
                    if vim.wo.diff then return '[c' end
                    vim.schedule(function() gs.prev_hunk() end)
                    return '<Ignore>'
                end, { expr = true })
            end
        }
    end
}
