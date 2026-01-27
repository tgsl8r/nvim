-- options.lua
-- Contains basic vim options

-- Files
vim.opt.swapfile = false    -- creates a swapfile
vim.opt.backup = false      -- creates a backup file
vim.opt.writebackup = false -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
vim.opt.undofile = true     -- enable persistent undo

-- UI Stuff
vim.opt.guifont = "monospace:h17" -- the font used in graphical neovim applications
vim.opt.termguicolors = true      -- set term gui colors (most terminals support this)
vim.opt.winborder = "rounded"
vim.opt.cursorline = true         -- highlight the current line
vim.opt.laststatus = 3            -- Once global status line
vim.opt.cmdheight = 2             -- more space in the neovim command line for displaying messages
vim.opt.pumheight = 10            -- pop up menu height
vim.opt.pumblend = 10             -- pop up menu transparency
vim.opt.showmode = false          -- hide traditional mode indicator
vim.opt.showtabline = 1           -- always show tabs
vim.opt.signcolumn = "yes"        -- always show the sign column, otherwise it would shift the text each time
vim.opt.ruler = false
vim.opt.colorcolumn = "160"

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 4 -- set number column width {default 4}

-- Tabs & Indentation
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.shiftwidth = 4  -- the number of spaces inserted for each indentation
vim.opt.expandtab = true
vim.opt.tabstop = 4     -- insert 4 spaces for a tab
vim.opt.softtabstop = 4 -- in-editor tab size

-- Line wrapping
vim.opt.wrap = false
vim.cmd("set whichwrap+=<,>,[,],h,l") -- Actions that can wrap lines

-- Words characters
vim.cmd([[set iskeyword+=-]]) -- Characters that can be in words

--- Spellcheck language
vim.opt.spelllang = { "en" }

-- Search settings
vim.opt.hlsearch = true
vim.opt.smartcase = true
vim.opt.ignorecase = true

-- Scroll buffers
vim.opt.scrolloff = 3
vim.opt.sidescrolloff = 8

-- Backspace
vim.opt.backspace = "indent,eol,start"

-- Clipboard
vim.opt.clipboard = "unnamedplus"

-- Split windows
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.splitkeep = "screen"

-- Don't allow rendering
vim.opt.conceallevel = 0

-- Completion options
vim.opt.updatetime = 300
vim.opt.completeopt = { "menuone", "noselect" }
vim.opt.shortmess:append("c") -- Less verbose completion menu

-- file type column config TODO: Is this needed?
vim.api.nvim_create_autocmd({
    "BufEnter",
    "BufWinEnter",
}, {
    pattern = { "*.py", "*.c", "*.h", "*.cpp", "*.hpp", "*.js", "*.lua" },
    callback = function()
        vim.wo.colorcolumn = "160"
    end,
})

-- Fill characters
vim.opt.fillchars = {
    foldopen = "",
    foldclose = "",
    fold = " ",
    foldsep = " ",
    diff = "╱",
    eob = " ",
}

-- Folds
vim.opt.foldlevel = 99
vim.opt.foldmethod = "indent"
vim.opt.foldtext = ""

-- Diagnostics
vim.diagnostic.config({
    virtual_lines = false,
    virtual_text = {
        source = true, -- Shows the source
    },
    float = {
        source = true, -- Always show the source
    },
})
