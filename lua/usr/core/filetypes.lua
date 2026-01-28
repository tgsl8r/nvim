-- filetypes.lua

local filetype_configs = {
    -- Shell files
    {
        pattern = { "sh", "bash", "zsh", "fish" },
        opts = {},
        keymaps = {
            { "n", "<leader>r", ":!/bin/sh %<CR>", "Run File (shell)" },
        },
    },

    -- Makefiles
    {
        pattern = "make",
        opts = {
            expandtab = false
        },
        keymaps = {},
    },

}

-- Create autocmds
for _, config in ipairs(filetype_configs) do
    vim.api.nvim_create_autocmd("FileType", {
        pattern = config.pattern,
        callback = function()
            -- Set buffer-local options
            if config.opts then
                for k, v in pairs(config.opts) do
                    vim.opt_local[k] = v
                end
            end

            -- Set buffer-local keymaps
            if config.keymaps then
                for _, km in ipairs(config.keymaps) do
                    local mode, keys, map, desc = unpack(km)
                    vim.keymap.set(mode, keys, map, { buffer = true, desc = desc })
                end
            end
        end,
    })
end
