return {
    "nvim-telescope/telescope.nvim",
    event = "VeryLazy",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-telescope/telescope-file-browser.nvim",
        "nvim-telescope/telescope-live-grep-args.nvim",
    },
    config = function()
        local telescope = require("telescope")
        local tele_actions = require("telescope.actions")
        local lga_actions = require("telescope-live-grep-args.actions")
        local lga_shortcuts = require("telescope-live-grep-args.shortcuts")
        local r = require("utils.remaps")
        telescope.setup({
            defaults = {
                layout_config = {
                    anchor = "center",
                    height = 0.9,
                    width = 0.9,
                    preview_width = 0.6,
                    prompt_position = "bottom",
                },
                sorting_strategy = "ascending",
                winblend = 4,
                layout_strategy = 'vertical',
                mappings = {
                    i = {
                        ["<esc>"] = tele_actions.close,
                    },
                },
                file_ignore_patterns = {
                    "^.git/",
                    "^node_modules/",
                },
            },
            extensions = {
                live_grep_args = {
                    auto_quoting = true,
                    mappings = {
                        i = {
                            ["<c-\\>"] = lga_actions.quote_prompt({ postfix = " --hidden " }),
                        },
                    },
                },
                file_browser = {
                    depth = 1,
                    auto_depth = false,
                    hidden = { file_browser = true, folder_browser = true },
                    hide_parent_dir = false,
                    collapse_dirs = false,
                    prompt_path = false,
                    quiet = false,
                    -- dir_icon = "󰉓 ",
                    dir_icon_hl = "Default",
                    display_stat = { date = true, size = true, mode = true },
                    git_status = true,
                },
            },
        })
        r.noremap("n", "\\", function()
            telescope.extensions.live_grep_args.live_grep_args({
                prompt_title = 'grep',
                additional_args = '-i',
            })
        end)
        r.noremap("n", "<leader>o", ":Telescope oldfiles<cr>")
        r.noremap("n", "<leader>gc", function()
            lga_shortcuts.grep_word_under_cursor({ postfix = " --hidden " })
        end)
        r.noremap("n", "<leader>f", function()
            telescope.extensions.file_browser.file_browser()
        end)
        r.noremap("n", "<leader>.", function()
            telescope.extensions.file_browser.file_browser({
                path = vim.fn.stdpath("config")
            })
        end)
        telescope.load_extension("file_browser")
        telescope.load_extension("live_grep_args")

        -- local builtin = require('telescope.builtin')
        -- -- file
        -- vim.keymap.set('n', '<Leader>f', function()
        --     builtin.find_files({ no_ignore = false, hidden = true })
        -- end)
        -- -- grep
        -- vim.keymap.set('n', '<Leader>r', function()
        --     builtin.live_grep({ no_ignore = false, hidden = true })
        -- end)
        -- -- buffers
        -- vim.keymap.set('n', '<Leader>b', function()
        --     builtin.buffers({ no_ignore = false, hidden = true })
        -- end)
    end,
}
