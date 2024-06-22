return {
    "cocopon/vaffle.vim",
    keys = {
        { "<Leader>e", ":Vaffle<CR>", mode = "n" },
    },
    config = function()
        local r = require("utils.remaps")
        local function customize_vaffle_mappings()
            r.map("n", "<Bslash>", "<Plug>(vaffle-open-root)", { buffer = true })
            r.map("n", "s", "<Plug>(vaffle-toggle-current)", { buffer = true })
            r.map("n", "<ESC>", "<Plug>(vaffle-quit)", { buffer = true })
        end
        vim.api.nvim_create_autocmd({ 'FileType' }, {
            pattern = 'vaffle',
            group = 'vimrc',
            callback = customize_vaffle_mappings,
        })
    end
}
