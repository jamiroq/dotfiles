return {
    "andymass/vim-matchup",
    event = { "BufReadPost", "BufNewFile" },
    init = function()
        vim.g.matchup_mouse_enabled = 0
    end,
}
