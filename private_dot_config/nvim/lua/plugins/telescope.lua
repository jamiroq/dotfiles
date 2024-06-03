return {
    "nvim-telescope/telescope.nvim",
    event = "VeryLazy",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        local telescope = require("telescope")
        telescope.setup({
            defaults = {
                layout_config = {
                    anchor = "center",
                    height = 0.9,
                    width = 0.9,
                    prompt_position = "bottom",
                },
                sorting_strategy = "ascending",
                winblend = 4,
                layout_strategy = 'vertical',
                file_ignore_patterns = {
                    "^.git/",
                    "^node_modules/",
                },
            },
        })

        local r = require("utils.remaps")
        local builtin = require('telescope.builtin')

        -- file
        r.noremap('n', '<Leader>f', function()
            builtin.find_files({ no_ignore = false, hidden = true })
        end)
        -- oldfile
        r.noremap('n', '<Leader>o', function()
            builtin.oldfiles({ no_ignore = false, hidden = true })
        end)
        -- grep
        r.noremap('n', '<Leader>r', function()
            builtin.live_grep({ no_ignore = false, hidden = true })
        end)
        -- buffers
        r.noremap('n', '<Leader>b', function()
            builtin.buffers({ no_ignore = false, hidden = true })
        end)
    end,
}
