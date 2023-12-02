-- setting
vim.api.nvim_create_augroup('plugins', { clear = true })

-- Automatically intall jetpack
local install_path = vim.fn.stdpath("data") .. "/site/pack/jetpack/opt/vim-jetpack/plugin/jetpack.vim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system({
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/tani/vim-jetpack.git",
        install_path,
    })
    print("Installing jetpack close and reopen Neovim...")
end

vim.cmd('packadd vim-jetpack')
require('jetpack').setup {
    -- package_manager
    {'tani/jetpack'},
    -- library
     'nvim-lua/plenary.nvim',
     'nvim-tree/nvim-web-devicons',
    -- treesitter
     'nvim-treesitter/nvim-treesitter',
    -- fuzzy finder
     'nvim-telescope/telescope.nvim',
     'Allianaab2m/telescope-kensaku.nvim',
    -- colorschemes
     'EdenEast/nightfox.nvim',
     'w0ng/vim-hybrid',
    -- lsp
     'neovim/nvim-lspconfig',
     'williamboman/mason.nvim',
     'williamboman/mason-lspconfig.nvim',
    -- complement
     'hrsh7th/nvim-cmp',
     'hrsh7th/cmp-nvim-lsp',
     'cohama/lexima.vim',
     'tpope/vim-surround',
    -- filer
     'cocopon/vaffle.vim',
    -- util
     'tyru/caw.vim',
     'kana/vim-fakeclip',
     'easymotion/vim-easymotion',
     'unblevable/quick-scope',
     'RRethy/vim-illuminate',
     'vim-jp/vimdoc-ja',
}

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
