return {
    "cocopon/vaffle.vim",
    event = "VeryLazy",
    config = function()
        local r = require("utils.remaps")
        r.noremap("n", "<Leader>e", "<cmd>Vaffle<CR>")
        local function customize_vaffle_mappings()
            r.noremap("n", "<Bslash>", "<Plug>(vaffle-open-root)")
            r.noremap("n", "s", "<Plug>(vaffle-toggle-current)")
            r.noremap("n", "<ESC>", "<Plug>(vaffle-quit)")
        end
        vim.api.nvim_create_autocmd({ 'FileType' }, {
            pattern = 'vaffle',
            group = 'vimrc',
            callback = customize_vaffle_mappings,
        })
    end
}
