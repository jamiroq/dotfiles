return {
    "romgrk/barbar.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    event = "VeryLazy",
    config = function()
        -- option setting
        local barbar = require('barbar')
        barbar.setup {
            animation = false,
            auto_hide = false,
            clickable = false,
            focus_one_close = 'previous',
            tabpages = true,
            maximum_padding = 0,
            icons = {
                button = false,
                filetype = {
                    enabled = true
                },
                gitsigns = {
                    added = { enabled = true, icon = '+' },
                    changed = { enabled = true, icon = '~' },
                    deleted = { enabled = true, icon = '-' },
                },
            },
        }

        -- command setting
        local r = require("utils.remaps")
        local opts = { silent = true }
        -- Move to previous/next
        r.noremap('n', '<A-j>', '<Cmd>BufferPrevious<CR>', opts)
        r.noremap('n', '<A-k>', '<Cmd>BufferNext<CR>', opts)
        -- Close buffer
        r.noremap('n', '<A-l>', '<Cmd>BufferClose<CR>', opts)
        -- Goto buffer
        r.noremap('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', opts)
        r.noremap('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', opts)
        r.noremap('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', opts)
        r.noremap('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', opts)
        r.noremap('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', opts)
        r.noremap('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', opts)
        r.noremap('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', opts)
        r.noremap('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', opts)
        r.noremap('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', opts)
        r.noremap('n', '<A-0>', '<Cmd>BufferLast<CR>', opts)
    end
}
