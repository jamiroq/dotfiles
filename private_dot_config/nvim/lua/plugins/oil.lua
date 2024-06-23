return {
    "stevearc/oil.nvim",
    keys = {
        { "<Leader>e", ":Oil<CR>", mode = "n" },
    },
    config = function()
       require("oil").setup{
            keymaps = {
                ["<C-j>"] = "actions.select",
                ["<C-k>"] = "actions.parent",
                ["<C-l>"] = "actions.close",
            }
        }
    end
}
