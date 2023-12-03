return {
    "kana/vim-fakeclip",
    event = "VeryLazy",
    config = function()
        local r= require("utils.remaps")
        r.noremap("n", "<Leader>y", "<Plug>(fakeclip-y)")
        r.noremap("n", "<Leader>p", "<Plug>(fakeclip-p)")
    end
}
