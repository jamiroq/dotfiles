return {
    "monaqa/dial.nvim",
    event = { "BufReadPost", "BufNewFile" },
    config = function()
        local r = require("utils.remaps")
        -- r.map({ "n", "v" }, "<C-a>", "<Plug>(dial-increment)")
        -- r.map({ "n", "v" }, "<C-x>", "<Plug>(dial-decrement)")
        r.map("n", "<C-a>", function()
            require("dial.map").manipulate("increment", "normal")
        end)
        r.map({ "n", "v" }, "<C-x>", function()
            require("dial.map").manipulate("decrement", "normal")
        end)
    end,
}
