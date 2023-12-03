return {
    "easymotion/vim-easymotion",
    event = "VeryLazy",
    config = function()
        vim.g.EasyMotion_do_mapping = 0
        vim.g.EasyMotion_smartcase = 1
        vim.keymap.set("n", "s", "<Plug>(easymotion-s2)")
    end
}
