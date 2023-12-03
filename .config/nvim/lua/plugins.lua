local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- use a protected call so we don't error out on first use
local status_ok, lazy = pcall(require, "lazy")
if not status_ok then
	print("lazy just installed, please restart neovim")
	return
end

-- install plugins
lazy.setup({
	spec = {
		require("plugins.catppuccin"),
		require("plugins.lsp"),
		require("plugins.cmp"),
		require("plugins.comment"),
		require("plugins.hop"),
		require("plugins.gitsigns"),
		require("plugins.lualine"),
		require("plugins.telescope"),
		require("plugins.treesitter"),
		require("plugins.vaffle"),
        {"andymass/vim-matchup"},
        {"cohama/lexima.vim"},
        -- {"windwp/nvim-autopairs"},
        {"vim-jp/vimdoc-ja"},
        -- {"kana/vim-fakeclip"},
	},
	dev = {
		path = "~/.local/share",
	},
	lockfile = vim.fn.stdpath("config") .. "/lua/plugins/lazy-lock.json",
	ui = {
		size = { width = 0.8, height = 0.8 },
		wrap = true,
		border = "shadow",
        icons = {
          cmd = "⌘",
          config = "🛠",
          event = "📅",
          ft = "📂",
          init = "⚙",
          keys = "🗝",
          plugin = "🔌",
          runtime = "💻",
          require = "🌙",
          source = "📄",
          start = "🚀",
          task = "📌",
          lazy = "💤 ",
        },
	},
	performance = {
		cache = {
			enabled = true,
		},
		reset_packpath = true,
	},
})
