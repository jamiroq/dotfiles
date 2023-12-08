return {
    "akinsho/toggleterm.nvim",
    event = "VeryLazy",
    config = function()
        local Terminal = require("toggleterm.terminal").Terminal
        local lazygit = Terminal:new({
            cmd = "lazygit",
            direction = "float",
            hidden = true
        })

        function _lazygit_toggle()
            lazygit:toggle()
        end

        local r = require("utils.remaps")
        r.map("n", "<Leader>l", "<cmd>lua _lazygit_toggle()<CR>", { silent = true })
    end,
}
