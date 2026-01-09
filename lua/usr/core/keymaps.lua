-- keymaps.lua
-- Contains core/snacks keybindings
local keymap = vim.keymap.set
local defopts = { noremap = true, silent = true }

-- Leader key
keymap("n", "<Space>", "", defopts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Helper for diag gotos
local diagnostic_goto = function(next, severity)
	return function()
		vim.diagnostic.jump({
			count = (next and 1 or -1) * vim.v.count1,
			severity = severity and vim.diagnostic.severity[severity] or nil,
			float = true,
		})
	end
end

--- bindings ---
--- DECLARE THEM.
local bindings = {

    -- files
    { "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
    { "<leader>fe",   function() Snacks.explorer() end, desc = "File Explorer" },
    { "<leader>ff",  function() Snacks.picker.files() end, desc = "Find Files" },
    { "<leader>fg",  function() Snacks.picker.git_files() end, desc = "Find Git Files" },
    { "<leader>fp",  function() Snacks.picker.projects() end, desc = "Projects" },
    { "<leader>fr",  function() Snacks.picker.recent() end, desc = "Recent" },
    { "<leader>fc",  function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
    { "<leader>fn",  "<cmd>enew<cr>", desc = "New File" },

    -- Windows
    { "<leader>w-",  "<C-W>s",  desc = "Split Window Below", remap = true },
    { "<leader>w|",  "<C-W>v",  desc = "Split Window Right", remap = true },
    { "<leader>wd",  "<C-W>c",  desc = "Delete Window", remap = true },
    { "<leader>wt",  function() Snacks.terminal() end, desc = "Toggle Terminal" },
    { "<leader>wz",  function() Snacks.zen() end, desc = "Toggle Zen Mode" },
    { "<leader>wZ",  function() Snacks.zen.zoom() end, desc = "Toggle Zoom" },
    { "<leader>w.",  function() Snacks.scratch() end, desc = "Toggle Scratch Buffer" },
    { "<leader>wS",  function() Snacks.scratch.select() end, desc = "Select Scratch Buffer" },
    { "<C-h>",       "<C-w>h", desc = "Go to Left Window", remap = true },
    { "<C-j>",       "<C-w>j", desc = "Go to Lower Window", remap = true },
    { "<C-k>",       "<C-w>k", desc = "Go to Upper Window", remap = true },
    { "<C-l>",       "<C-w>l", desc = "Go to Right Window", remap = true },
    { "<C-A-K>",       "<cmd>resize +2<cr>", desc = "Increase Window Height" },
    { "<C-A-J>",       "<cmd>resize -2<cr>", desc = "Decrease Window Height" },
    { "<C-A-H>",       "<cmd>vertical resize -2<cr>", desc = "Decrease Window Width" },
    { "<C-A-L>",       "<cmd>vertical resize +2<cr>", desc = "Increase Window Width" },
    { "<c-/>",       function() Snacks.terminal() end, desc = "Toggle Terminal" },
    { "<c-_>",       function() Snacks.terminal() end, desc = "which_key_ignore" },

    -- Buffers
    { "<leader>bb",  function() Snacks.picker.buffers() end, desc = "Browse Buffers" },
    { "<leader>bd",  function() Snacks.bufdelete() end, desc = "Delete Buffer" },
    { "<leader>bo",  function() Snacks.bufdelete.other() end, desc = "Delete Other Buffers" },
    { "<leader>bD",  "<cmd>:bd<cr>", desc = "Delete Buffer and Window" },
    { "[b",          "<cmd>bprevious<cr>", desc = "Prev Buffer" },
    { "]b",          "<cmd>bnext<cr>", desc = "Next Buffer" },

    -- search/show
    { "<leader>sg",  function() Snacks.picker.grep() end, desc = "Grep" },
    { "<leader>sw",  function() Snacks.picker.grep_word() end, desc = "Visual selection or word", mode = { "n", "x" } },
    { "<leader>sB",  function() Snacks.picker.grep_buffers() end, desc = "Grep Open Buffers" },
    { "<leader>sb",  function() Snacks.picker.lines() end, desc = "Buffer Lines" },
    { "<leader>sd",  function() Snacks.picker.diagnostics() end, desc = "Diagnostics" },
    { "<leader>sD",  function() Snacks.picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
    { '<leader>s"',  function() Snacks.picker.registers() end, desc = "Registers" },
    { "<leader>sm",  function() Snacks.picker.marks() end, desc = "Marks" },
    { "<leader>sj",  function() Snacks.picker.jumps() end, desc = "Jumps" },
    { "<leader>sa",  function() Snacks.picker.autocmds() end, desc = "Autocmds" },
    { "<leader>sC",  function() Snacks.picker.commands() end, desc = "Commands" },
    { "<leader>si",  function() Snacks.picker.icons() end, desc = "Icons" },
    { "<leader>sl",  function() Snacks.picker.loclist() end, desc = "Location List" },
    { "<leader>sq",  function() Snacks.picker.qflist() end, desc = "Quickfix List" },
    { "<leader>sM",  function() Snacks.picker.man() end, desc = "Man Pages" },
    { "<leader>sh",  function() Snacks.picker.help() end, desc = "Help Pages" },
    { "<leader>sR",  function() Snacks.picker.resume() end, desc = "Resume" },
    { "<leader>sp",  function() Snacks.picker.lazy() end, desc = "Search for Plugin Spec" },
    { "<leader>sk",  function() Snacks.picker.keymaps() end, desc = "Keymaps" },
    { "<leader>sH",  function() Snacks.picker.highlights() end, desc = "Highlights" },

    -- diags / code
    { "<leader>ca",  vim.lsp.buf.code_action, desc = "Code Actions" },
    { "<leader>cf",  function() vim.lsp.buf.format({ async = true }) end, desc = "Format Buffer" },
    { "<leader>cr",  function() Snacks.rename.rename_file() end, desc = "Rename File" },
    { "<leader>cd",  vim.diagnostic.open_float, desc = "Line Diagnostics" },
    { "<leader>cD",  function() vim.diagnostic.open_float(nil, { border = "rounded" }) vim.diagnostic.open_float() end, desc = "Diagnostics {focused)" },
    { "<leader>cl",  vim.diagnostic.setloclist, desc = "Add Diag to List" },
    { "<leader>ck",  vim.lsp.buf.signature_help, desc = "Signature Help" }, -- TODO: Insert mode bind for this
    { "<leader>cK",  vim.lsp.buf.hover, desc = "Hover" },
    { "]d",          diagnostic_goto(true), desc = "Next Diagnostic" },
    { "[d",          diagnostic_goto(false), desc = "Prev Diagnostic" },
    { "]e",          diagnostic_goto(true, "ERROR"), desc = "Next Error" },
    { "[e",          diagnostic_goto(false, "ERROR"), desc = "Prev Error" },
    { "]w",          diagnostic_goto(true, "WARN"), desc = "Next Warning" },
    { "[w",          diagnostic_goto(false, "WARN"), desc = "Prev Warning" },
    { "[q",          vim.cmd.cprev, desc = "Previous Quickfix" },
    { "]q",          vim.cmd.cnext, desc = "Next Quickfix" },

    -- git
    { "<leader>gb",  function() Snacks.picker.git_branches() end, desc = "Git Branches" },
    { "<leader>gl",  function() Snacks.picker.git_log() end, desc = "Git Log" },
    { "<leader>gL",  function() Snacks.picker.git_log_line() end, desc = "Git Log Line" },
    { "<leader>gs",  function() Snacks.picker.git_status() end, desc = "Git Status" },
    { "<leader>gS",  function() Snacks.picker.git_stash() end, desc = "Git Stash" },
    { "<leader>gd",  function() Snacks.picker.git_diff() end, desc = "Git Diff (Hunks)" },
    { "<leader>gf",  function() Snacks.picker.git_log_file() end, desc = "Git Log File" },
    { "<leader>gB",  function() Snacks.gitbrowse() end, desc = "Git Browse (open)", mode = { "n", "x" } },
    { "<leader>gY",  function() Snacks.gitbrowse({ open = function(url) vim.fn.setreg("+", url) end, notify = false, }) end, desc = "Git Browse (open)", mode = { "n", "x" } },
    -- gh
    { "<leader>gi",  function() Snacks.picker.gh_issue() end, desc = "GitHub Issues (open)" },
    { "<leader>gI",  function() Snacks.picker.gh_issue({ state = "all" }) end, desc = "GitHub Issues (all)" },
    { "<leader>gp",  function() Snacks.picker.gh_pr() end, desc = "GitHub Pull Requests (open)" },
    { "<leader>gP",  function() Snacks.picker.gh_pr({ state = "all" }) end, desc = "GitHub Pull Requests (all)" },

    -- history
    { '<leader>h/',  function() Snacks.picker.search_history() end, desc = "Search History" },
    { "<leader>hu",  function() Snacks.picker.undo() end, desc = "Undo History" },
    { "<leader>h:",  function() Snacks.picker.command_history() end, desc = "Command History" },
    { "<leader>hn",  function() Snacks.picker.notifications() end, desc = "Notification History" },
    { "<leader>un",  function() Snacks.notifier.show_history() end, desc = "Notification History" },
    { "<leader>un",  function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },

    -- LSP
    { "gd",          function() Snacks.picker.lsp_definitions() end, desc = "Goto Definition" },
    { "gD",          function() Snacks.picker.lsp_declarations() end, desc = "Goto Declaration" },
    { "gr",          function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
    { "gI",          function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
    { "gy",          function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
    { "gai",         function() Snacks.picker.lsp_incoming_calls() end, desc = "C[a]lls Incoming" },
    { "gao",         function() Snacks.picker.lsp_outgoing_calls() end, desc = "C[a]lls Outgoing" },
    { "<leader>ss",  function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
    { "<leader>sS",  function() Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },

    -- Comments
    { "gco",         "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", desc = "Add Comment Below" },
    { "gcO",         "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", desc = "Add Comment Above" },

    -- Utils
    { "<leader>uK",  "<cmd>norm! K<cr>", desc = "Keywordprg" },
    { "<leader>ur",  "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>", desc = "Redraw / Clear hlsearch / Diff Update" },
    { "<leader>uC",  function() Snacks.picker.colorschemes() end, desc = "Colorschemes" },

    -- Other
    { "]]",          function() Snacks.words.jump(vim.v.count1) end, desc = "Next Reference", mode = { "n", "t" } },
    { "[[",          function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference", mode = { "n", "t" } },
}

--- MAP THEM. ---
for _, map in ipairs(bindings) do
  keymap(
    map.mode or "n",
    map[1],
    map[2],
    { desc = map.desc, nowait = map.nowait, remap = map.remap }
  )
end


--- UTILS ---
-- Snacks toggle options
Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>us")
Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
Snacks.toggle.diagnostics():map("<leader>ud")
Snacks.toggle.line_number():map("<leader>ul")
Snacks.toggle
	.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2, name = "Conceal Level" })
	:map("<leader>uc")
Snacks.toggle
	.option("showtabline", { off = 0, on = vim.o.showtabline > 0 and vim.o.showtabline or 2, name = "Tabline" })
	:map("<leader>uA")
Snacks.toggle.treesitter():map("<leader>uT")
Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
Snacks.toggle.dim():map("<leader>uD")
Snacks.toggle.animate():map("<leader>ua")
Snacks.toggle.indent():map("<leader>ug")
Snacks.toggle.scroll():map("<leader>uS")
Snacks.toggle.profiler():map("<leader>dpp")
Snacks.toggle.profiler_highlights():map("<leader>dph")

if vim.lsp.inlay_hint then
	Snacks.toggle.inlay_hints():map("<leader>uh")
end

-- Add undo break-points at punctuation
for _, char in ipairs({ ",", ".", "!", "?", ";", ":" }) do
	keymap("i", char, char .. "<C-g>u")
end

-- highlights under cursor
keymap("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })
keymap("n", "<leader>uI", function()
	vim.treesitter.inspect_tree()
	vim.api.nvim_input("I")
end, { desc = "Inspect Tree" })

-- Run lua
keymap({ "n", "x" }, "<leader>ur", function()
	Snacks.debug.run()
end, { desc = "Run Lua" })


--- LINES ---
-- better up/down
keymap({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
keymap({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
keymap({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
keymap({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- Shift Lines
keymap("n", "<A-Down>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Shift lines Down" })
keymap("n", "<A-Up>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Shift lines Up" })
keymap("i", "<A-Down>", "<esc><cmd>m .+1<cr>==gi", { desc = "Shift lines Down" })
keymap("i", "<A-Up>", "<esc><cmd>m .-2<cr>==gi", { desc = "Shift lines Up" })
keymap("v", "<A-Down>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Shift lines Down" })
keymap("v", "<A-Up>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Shift lines Up" })

-- Centre view on jumps
keymap("n", "n", "nzz", defopts)
keymap("n", "N", "Nzz", defopts)
keymap("n", "*", "*zz", defopts)
keymap("n", "#", "#zz", defopts)
keymap("n", "g*", "g*zz", defopts)
keymap("n", "g#", "g#zz", defopts)

-- Stay in indent mode
keymap("v", "<", "<gv", defopts)
keymap("v", ">", ">gv", defopts)

-- Keep register contents on paste replace
keymap("x", "p", [["_dP]])


------------------------- Weird shit under here

-- What?
keymap("n", "<C-i>", "<C-i>", defopts)

-- Do I need this? It overwrites my view centring binds
-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
keymap("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
keymap("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
keymap("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
keymap("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
keymap("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
keymap("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

-- Easy normal mode in terminal (test this) do I use it?
vim.api.nvim_set_keymap("t", "<C-;>", "<C-\\><C-n>", defopts)
