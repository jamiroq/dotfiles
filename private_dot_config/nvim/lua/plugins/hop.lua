return {
    "phaazon/hop.nvim",
    event = "VeryLazy",
    config = function()
        local hop = require('hop')
        hop.setup {
            keys = 'etovxqpdygfblzhckisuran'
        }
        local r = require("utils.remaps")
        r.noremap("n", "s", "<cmd>HopChar2<CR>")
    end
}
