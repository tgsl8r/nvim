local gitsigns_status, gitsigns = pcall(require, "gitsigns")
if not gitsigns_status then
    print("Couldn't load gitsigns")
    return
end

gitsigns.setup({
    -- TODO: Investigate intermittent display issues
    signs = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
        untracked = { text = "▎" },
    },
    signs_staged = {
        add = { text = "▎" },
        change = { text = "▎" },
        delete = { text = "" },
        topdelete = { text = "" },
        changedelete = { text = "▎" },
    },
})

vim.api.nvim_set_hl(0, 'GitSignsChange', { fg = '#E49B0F', bg = '', bold = false })
