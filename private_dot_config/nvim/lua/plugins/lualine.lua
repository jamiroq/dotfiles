return {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    config = function()
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
    end,
}
