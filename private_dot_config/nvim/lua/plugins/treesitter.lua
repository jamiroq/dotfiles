return {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
        local treesitter = require("nvim-treesitter.configs")
        treesitter.setup({
            ensure_installed = {
				"bash",
                "vim",
                "go",
                "lua",
				"javascript",
                "html",
				"css",
                "json",
                "yaml",
                "toml",
				"regex",
				"sql",
                "markdown",
                "markdown_inline",
				"terraform",
                "dockerfile",
                "gitignore",
            },
            highlight = {
                enable = true,
                additional_vim_regex_highlighting = false,
                disable = {},
            },
            indent = {
                enable = true,
                disable = { "html" },
            },
            autotag = {
                enable = true,
            },
            updater = {
                enable = true
            }
        })
    end,
}
