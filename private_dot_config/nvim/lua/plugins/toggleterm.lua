return {
    "akinsho/toggleterm.nvim",
    keys = {
        { "<Leader>l", ":lua _lazygit_toggle()<CR>", mode = "n" },
    },
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
    end,
}
