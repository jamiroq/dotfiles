return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
    },
	build = ":MasonInstallAll",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
        require('mason').setup()
        require('mason-lspconfig').setup_handlers({ function(server)
            local opt = {
                capabilities = require('cmp_nvim_lsp').default_capabilities(
                    vim.lsp.protocol.make_client_capabilities()
                )
            }
            require('lspconfig')[server].setup(opt)
        end })
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
		vim.api.nvim_create_user_command("MasonInstallAll", function()
			vim.cmd('MasonUpdate')
			local ensure_installed = {
				"clang-format",
				"gopls",
				"lua-language-server",
				"stylua",
				"eslint-lsp",
				"html-lsp",
				"css-lsp",
				"bash-language-server",
				"shellcheck",
				"shellharden",
				"shfmt",
				"terraform-ls",
				"tflint",
				"dockerfile-language-server",
				"json-lsp",
				"yaml-language-server",
			}
			vim.cmd('MasonInstall ' .. table.concat(ensure_installed, ' '))
		end, { desc = "install all lsp tools" })
    end
}
