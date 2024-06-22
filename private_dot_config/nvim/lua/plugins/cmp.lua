return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp-signature-help",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-cmdline",
        "hrsh7th/vim-vsnip",
    },
    config = function()
        local cmp = require("cmp")
        cmp.setup({
            snippet = {
                expand = function(args)
                    vim.fn["vsnip#anonymous"](args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert({
                ["<C-p>"] = cmp.mapping.select_prev_item(),
                ["<C-n>"] = cmp.mapping.select_next_item(),
                ["<C-l>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping.confirm { select = true },
            }),
            experimental = {
                ghost_text = true,
            },
            sources = {
                { name = "nvim_lsp_signature_help", group_index = 1 },
                { name = "nvim_lsp",                max_item_count = 20, group_index = 1 },
                { name = "nvim_lua",                group_index = 1 },
                { name = "path",                    group_index = 2 },
                { name = "buffer",                  keyword_length = 2,  max_item_count = 5, group_index = 2 },
            },
        })
    end,
}
