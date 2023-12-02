-- TODO
-- ファイル分割
-- cmp設定
-- vim-sandwich
-- aerial.nvim
-- karen-yank

-- init
vim.api.nvim_create_augroup('plugins', { clear = true })

-- Automatically intall lazy
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

require('lazy').setup({
    -- package_manager
    -- library
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    -- treesitter
    "nvim-treesitter/nvim-treesitter",
    -- fuzzy finder
    "nvim-telescope/telescope.nvim",
    "Allianaab2m/telescope-kensaku.nvim",
    -- colorschemes
    "EdenEast/nightfox.nvim",
    "catppuccin/nvim",
    "sainnhe/everforest",
    -- lsp
    "neovim/nvim-lspconfig",
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    -- "nvimdev/lspsaga.nvim",
    -- complement
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/vim-vsnip",
    -- git
    "lewis6991/gitsigns.nvim",
    -- filer
    "cocopon/vaffle.vim",
    -- statusbar
    "nvim-lualine/lualine.nvim",
    -- util
    "cohama/lexima.vim",
    "andymass/vim-matchup",
    "numToStr/Comment.nvim",
    "kana/vim-fakeclip",
    "easymotion/vim-easymotion",
    "vim-jp/vimdoc-ja",
})

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

-- lspsaga
-- require("lspsaga").setup({
--   border_style = "single",
--   symbol_in_winbar = {
--     enable = true,
--   },
--   code_action_lightbulb = {
--     enable = true,
--   },
--   show_outline = {
--     win_width = 50,
--     auto_preview = false,
--   },
-- })
-- vim.keymap.set("n", "K",  "<cmd>Lspsaga hover_doc<CR>")
-- vim.keymap.set('n', 'gr', '<cmd>Lspsaga lsp_finder<CR>')
-- vim.keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>")
-- vim.keymap.set("n", "ga", "<cmd>Lspsaga code_action<CR>")
-- vim.keymap.set("n", "gn", "<cmd>Lspsaga rename<CR>")
-- vim.keymap.set("n", "ge", "<cmd>Lspsaga show_line_diagnostics<CR>")
-- vim.keymap.set("n", "[e", "<cmd>Lspsaga diagnostic_jump_next<CR>")
-- vim.keymap.set("n", "]e", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
-- vim.keymap.set("n", "<A-d>", "<cmd>Lspsaga open_floaterm<CR>")
-- vim.keymap.set("t", "<A-d>", [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]])

-- nvim-cmp
local cmp = require("cmp")
cmp.setup({
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
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
require('nvim-treesitter.configs').setup {
    ensure_installed = { "vim", "markdown", "markdown_inline", "dockerfile", "javascript", "go", "lua", "gitignore", "html", "json", "yaml", "toml" },
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false,
        disable = {},
    },
    indent = {
        enable = true,
        disable = { "html" },
    },
    autotag = {
        enable = true,
    },
    updater = {
        enable = true
    }
}

-- colorscheme
vim.cmd.colorscheme "catppuccin"


-- comment
require('Comment').setup({
    ---Add a space b/w comment and the line
    padding = true,
    ---Whether the cursor should stay at its position
    sticky = true,
    ---Lines to be ignored while (un)comment
    ignore = nil,
    ---LHS of toggle mappings in NORMAL mode
    toggler = {
        ---Line-comment toggle keymap
        line = '<C-_>',
        ---Block-comment toggle keymap
        --block = '',
    },
    ---LHS of operator-pending mappings in NORMAL and VISUAL mode
    opleader = {
        ---Line-comment keymap
        line = '<C-_>',
        ---Block-comment keymap
        --block = 'gb',
    },
    ---LHS of extra mappings
    extra = {
        ---Add comment on the line above
        --above = 'gcO',
        ---Add comment on the line below
        --below = 'gco',
        ---Add comment at the end of line
        --eol = 'gcA',
    },
    ---Enable keybindings
    ---NOTE: If given `false` then the plugin won't create any mappings
    mappings = {
        ---Operator-pending mapping; `gcc` `gbc` `gc[count]{motion}` `gb[count]{motion}`
        basic = true,
        ---Extra mapping; `gco`, `gcO`, `gcA`
        extra = false,
    },
    ---Function to call before (un)comment
    pre_hook = nil,
    ---Function to call after (un)comment
    post_hook = nil,
})

-- fakeclip
vim.keymap.set("n", "<Leader>y", "<Plug>(fakeclip-y)")
vim.keymap.set("n", "<Leader>p", "<Plug>(fakeclip-p)")

-- easymotion
vim.g.EasyMotion_do_mapping = 0
vim.g.EasyMotion_smartcase = 1
vim.keymap.set("n", "s", "<Plug>(easymotion-s2)")

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

-- telescope
local status, telescope = pcall(require, "telescope")
if (not status) then return end

local builtin = require('telescope.builtin')

telescope.setup({
    defaults = {
        sorting_strategy = "ascending", -- 検索結果を上から下に並べる
        winblend = 4,                   --若干ウィンドウを透明に
        layout_strategy = 'vertical',
        layout_config = { height = 0.9 },
        file_ignore_patterns = { --検索対象に含めないファイルを指定
            "^.git/",
            "^node_modules/",
        },
    },
})

-- file search
vim.keymap.set('n', '<Leader>f', function()
    builtin.find_files({ no_ignore = false, hidden = true })
end)
-- Grep
vim.keymap.set('n', '<Leader>r', function()
    builtin.live_grep({ no_ignore = false, hidden = true })
end)
vim.keymap.set('n', '<Leader>b', function()
    builtin.buffers({ no_ignore = false, hidden = true })
end)

-- lualine
require('lualine').setup {
    options = {
        icons_enabled = false,
        theme = 'everforest',
        component_separators = {},
        section_separators = {},
        disabled_filetypes = {},
        always_divide_middle = false,
        globalstatus = false,
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff' },
        lualine_c = { 'filename' },
        lualine_x = { 'diagnostics' },
        lualine_y = { 'filetype', 'encoding', 'fileformat' },
        lualine_z = { 'progress' }
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {},
    extensions = {}
}

-- gitsigns
require('gitsigns').setup {
    signs                        = {
        add          = { hl = 'GitSignsAdd', text = '│', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
        change       = { hl = 'GitSignsChange', text = '│', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
        delete       = { hl = 'GitSignsDelete', text = '_', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
        topdelete    = { hl = 'GitSignsDelete', text = '‾', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
        changedelete = { hl = 'GitSignsChange', text = '~', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
    },
    signcolumn                   = false,
    numhl                        = true,
    linehl                       = false,
    word_diff                    = false,
    watch_gitdir                 = {
        interval = 1000,
        follow_files = true
    },
    attach_to_untracked          = true,
    current_line_blame           = false,
    current_line_blame_opts      = {
        virt_text = true,
        virt_text_pos = 'eol',
        delay = 1000,
        ignore_whitespace = false,
    },
    current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
    sign_priority                = 6,
    update_debounce              = 100,
    status_formatter             = nil,
    max_file_length              = 40000,
    preview_config               = {
        border = 'single',
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1
    },
    yadm                         = {
        enable = false
    },
    on_attach                    = function(bufnr)
        local gs = package.loaded.gitsigns
        local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
        end
        map('n', ']c', function()
            if vim.wo.diff then return ']c' end
            vim.schedule(function() gs.next_hunk() end)
            return '<Ignore>'
        end, { expr = true })

        map('n', '[c', function()
            if vim.wo.diff then return '[c' end
            vim.schedule(function() gs.prev_hunk() end)
            return '<Ignore>'
        end, { expr = true })
        map({ 'n', 'v' }, '<leader>hs', ':Gitsigns stage_hunk<CR>')
        map({ 'n', 'v' }, '<leader>hr', ':Gitsigns reset_hunk<CR>')
        map('n', '<leader>hS', gs.stage_buffer)
        map('n', '<leader>hu', gs.undo_stage_hunk)
        map('n', '<leader>hR', gs.reset_buffer)
        map('n', '<leader>hp', gs.preview_hunk)
        map('n', '<leader>hb', function() gs.blame_line { full = true } end)
        map('n', '<leader>tb', gs.toggle_current_line_blame)
        map('n', '<leader>hd', gs.diffthis)
        map('n', '<leader>hD', function() gs.diffthis('~') end)
        map('n', '<leader>td', gs.toggle_deleted)
        map({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
    end
}
