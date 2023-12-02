-- setting
vim.api.nvim_create_augroup('plugins', { clear = true })

-- Automatically intall packer
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = vim.fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
    })
    print("Installing packer close and reopen Neovim...")
    vim.cmd.packadd "packer.nvim"
end

vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = { "plugins.lua" },
    command = "PackerCompile",
})

require('packer').startup(function()
    -- package_manager
    use({ "wbthomason/packer.nvim" })
    -- library
    use({ "nvim-lua/plenary.nvim" })
    use({ "nvim-tree/nvim-web-devicons" })
    -- treesitter
    use({ "nvim-treesitter/nvim-treesitter" })
    -- fuzzy finder
    use({ "nvim-telescope/telescope.nvim" })
    use({ "Allianaab2m/telescope-kensaku.nvim" })
    -- colorschemes
    use({ "EdenEast/nightfox.nvim" })
    use({ "w0ng/vim-hybrid" })
    -- lsp
    use({ "neovim/nvim-lspconfig" })
    use({ "williamboman/mason.nvim" })
    use({ "williamboman/mason-lspconfig.nvim" })
    -- complement
    use({ "hrsh7th/nvim-cmp" })
    use({ "hrsh7th/cmp-nvim-lsp" })
    use({ "cohama/lexima.vim" })
    use({ "tpope/vim-surround" })
    -- filer
    use({ "cocopon/vaffle.vim" })
    -- util
    use({ "tyru/caw.vim" })
    use({ "kana/vim-fakeclip" })
    use({ "easymotion/vim-easymotion" })
    use({ "unblevable/quick-scope" })
    use({ "RRethy/vim-illuminate" })
    use({ "vim-jp/vimdoc-ja" })
end)

-- mason
require('mason').setup()
require('mason-lspconfig').setup_handlers({ function(server)
    local opt = {
        capabilities = require('cmp_nvim_lsp').default_capabilities(
            vim.lsp.protocol.make_client_capabilities()
        )
    }
    require('lspconfig')[server].setup(opt)
end })

-- lsp
vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
vim.keymap.set('n', 'gf', '<cmd>lua vim.lsp.buf.format()<CR>')
vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
vim.keymap.set('n', 'gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>')
vim.keymap.set('n', 'gn', '<cmd>lua vim.lsp.buf.rename()<CR>')
vim.keymap.set('n', 'ga', '<cmd>lua vim.lsp.buf.code_action()<CR>')
vim.keymap.set('n', 'ge', '<cmd>lua vim.diagnostic.open_float()<CR>')
vim.keymap.set('n', 'g]', '<cmd>lua vim.diagnostic.goto_next()<CR>')
vim.keymap.set('n', 'g[', '<cmd>lua vim.diagnostic.goto_prev()<CR>')
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, { virtual_text = false }
)

-- nvim-cmp
local cmp = require("cmp")
cmp.setup({
    sources = {
        { name = "nvim_lsp" },
    },
    mapping = cmp.mapping.preset.insert({
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-l>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<CR>"] = cmp.mapping.confirm { select = true },
    }),
    experimental = {
        ghost_text = true,
    },
})

-- treesitter
-- require'nvim-treesitter.configs'.setup {
--   ensure_installed = "maintained",
--   highlight = {
--     enable = true,
--     disable = {},
--   },
-- }

-- caw
vim.keymap.set("n", "<C-_>", "<Plug>(caw:zeropos:toggle)")
vim.keymap.set("v", "<C-_>", "<Plug>(caw:zeropos:toggle)")

-- fakeclip
vim.keymap.set("n", "<Leader>y", "<Plug>(fakeclip-y)")
vim.keymap.set("n", "<Leader>p", "<Plug>(fakeclip-p)")

-- easymotion
vim.g.EasyMotion_do_mapping = 0
vim.g.EasyMotion_smartcase = 1
vim.keymap.set("n", "s", "<Plug>(easymotion-s2)")

-- quick-scope
vim.g.qs_highlight_on_keys = { 'f', 'F' }

-- vaffle
vim.keymap.set("n", "<Leader>e", ":<C-u>Vaffle<CR>")
local function customize_vaffle_mappings()
    vim.keymap.set("n", "<Bslash>", "<Plug>(vaffle-open-root)")
    vim.keymap.set("n", "s", "<Plug>(vaffle-toggle-current)")
    vim.keymap.set("n", "<ESC>", "<Plug>(vaffle-quit)")
end
vim.api.nvim_create_autocmd({ 'FileType' }, {
    pattern = 'vaffle',
    group = 'plugins',
    callback = customize_vaffle_mappings,
})
