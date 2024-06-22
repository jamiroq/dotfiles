return {
    "phaazon/hop.nvim",
    keys = {
        { "s", ":HopChar2<CR>", mode = "n" },
    },
    config = function()
        local hop = require('hop')
        hop.setup {
            keys = 'etovxqpdygfblzhckisuran'
        }
    end
}
