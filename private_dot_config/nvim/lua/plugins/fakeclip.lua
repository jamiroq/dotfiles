return {
    "kana/vim-fakeclip",
    event = "VeryLazy",
    init = function()
        vim.g.fakeclip_no_default_key_mappings = true
    end,
    config = function()
        local r = require("utils.remaps")
        r.map("n", "<Leader>y", "<Plug>(fakeclip-y)")
        r.map("n", "<Leader>p", "<Plug>(fakeclip-p)")
    end
}
