local keymap = vim.keymap

local X = {}

function X.map(type, input, output, additional_options)
    local options = { remap = true }
    if additional_options then
        options = vim.tbl_deep_extend("force", options, additional_options)
    end
    keymap.set(type, input, output, options)
end

function X.noremap(type, input, output, additional_options)
    local options = { remap = false }
    if additional_options then
        options = vim.tbl_deep_extend("force", options, additional_options)
    end
    keymap.set(type, input, output, options)
end

return X
