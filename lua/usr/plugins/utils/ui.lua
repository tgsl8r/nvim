-- ui.lua
-- bufferline
local bufferline_status, bufferline = pcall(require, "bufferline")
if not bufferline_status then
    print("Couldn't load bufferline")
    return
end

bufferline.setup({
    options = {
        diagnostics = "nvim_lsp",
        always_show_bufferline = false,
        offsets = {
            {
                filetype = "neo-tree",
                text = "Neo-tree",
                highlight = "Directory",
                text_align = "left",
            },
            {
                filetype = "snacks_layout_box",
            },
        },
    },
})

-- nvim-highlight-colors
local highlight_color_status, highlight_color = pcall(require, "nvim-highlight-colors")
if not highlight_color_status then
    print("Couldn't load nvim-highlight-colors")
    return
end

highlight_color.setup({})

-- STATUS LINE --
-- helpers

local function git()
    local git_info = vim.b.gitsigns_status_dict
    if not git_info or git_info.head == "" then
        return ""
    end

    local head = git_info.head

    local symbols = {
        added = " ",
        changed = " ",
        removed = " ",
    }

    local colors = {
        added = "%#GitSignsAdd#",
        changed = "%#GitSignsChange#",
        removed = "%#GitSignsDelete#",
        reset = "%#StatusLine#",
    }

    local changes = {}
    if git_info.added and git_info.added > 0 then
        table.insert(changes, colors.added .. symbols.added .. git_info.added .. colors.reset)
    end
    if git_info.changed and git_info.changed > 0 then
        table.insert(changes, colors.changed .. symbols.changed .. git_info.changed .. colors.reset)
    end
    if git_info.removed and git_info.removed > 0 then
        table.insert(changes, colors.removed .. symbols.removed .. git_info.removed .. colors.reset)
    end

    return table.concat({
        "%#StatusLine#",
        " ",
        head,
        " ",
    }) .. table.concat(changes, " ")
end

local function path()
    local bufname = vim.api.nvim_buf_get_name(0)
    if bufname == "" then
        return ""
    end

    local git_status = vim.b.gitsigns_status_dict
    local git_root = git_status and git_status.root
    if git_root and bufname:sub(1, #git_root) == git_root then
        local repo_name = vim.fn.fnamemodify(git_root, ":t")
        local rel_path = bufname:sub(#git_root + 2)
        return repo_name .. "/" .. rel_path
    end

    return vim.fn.fnamemodify(bufname, ":~")
end

local function unsaved()
    if vim.bo.modified then
        return " %#String#%#StatusLine#"
    end
    return ""
end

local function lsp()
    local diags = vim.diagnostic.get(vim.api.nvim_get_current_buf())
    local counts = { errors = 0, warnings = 0, info = 0, hints = 0 }
    for _, diag in ipairs(diags) do
        local s = diag.severity
        if s == vim.diagnostic.severity.ERROR then
            counts.errors = counts.errors + 1
        elseif s == vim.diagnostic.severity.WARN then
            counts.warnings = counts.warnings + 1
        elseif s == vim.diagnostic.severity.INFO then
            counts.info = counts.info + 1
        elseif s == vim.diagnostic.severity.HINT then
            counts.hints = counts.hints + 1
        end
    end

    local parts = { vim.bo.filetype }
    if counts.errors > 0 then
        table.insert(parts, "%#DiagnosticError# " .. counts.errors .. "%#StatusLine#")
    end
    if counts.warnings > 0 then
        table.insert(parts, "%#DiagnosticWarn# " .. counts.warnings .. "%#StatusLine#")
    end
    if counts.info > 0 then
        table.insert(parts, "%#DiagnosticInfo# " .. counts.info .. "%#StatusLine#")
    end
    if counts.hints > 0 then
        table.insert(parts, "%#DiagnosticHint# " .. counts.hints .. "%#StatusLine#")
    end

    return table.concat(parts, " ")
end

Statusline = {}

function Statusline.active()
    return table.concat({
        "[ ",
        path(),
        unsaved(),
        " ][ ",
        git(),
        " ][ ",
        lsp(),
        " ]",
        "%=",
        "[%P %l:%c]",
    })
end

function Statusline.inactive()
    return " %t"
end

local group = vim.api.nvim_create_augroup("StatusLine", { clear = true })

vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
    group = group,
    desc = "Activate statusline on focus",
    callback = function()
        vim.opt_local.statusline = "%!v:lua.Statusline.active()"
    end,
})

vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
    group = group,
    desc = "Deactivate statusline when unfocused",
    callback = function()
        vim.opt_local.statusline = "%!v:lua.Statusline.inactive()"
    end,
})
