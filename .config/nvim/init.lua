-- 起動の高速化
vim.loader.enable()

-- init
vim.api.nvim_create_augroup('vimrc', { clear = true })

-- reuqire
require("general")
require("commands")
require("plugins")
