local treesitter_status, treesitter = pcall(require, "nvim-treesitter")
if not treesitter_status then
    print("Couldn't load treesitter")
    return
end

local treesitter_context_status, treesitter_context = pcall(require, "treesitter-context")
if not treesitter_context_status then
    print("Couldn't load treesitter-context")
    return
end

treesitter.setup()

-- Replaces ensure_installed (async; already-installed parsers are skipped)
treesitter.install({
    "json", "markdown", "markdown_inline", "bash", "lua", "vim", "vimdoc", "query",
    "dockerfile", "gitignore", "yaml", "toml", "html", "css", "scss",
    "javascript", "typescript", "tsx", "jsdoc", "jsonc", "graphql", "regex",
    "python", "c", "cpp", "go",
})

-- Replaces highlight.enable, indent.enable, disable and auto_install
local function start(buf, lang)
    if not vim.api.nvim_buf_is_valid(buf) then
        return
    end
    if pcall(vim.treesitter.start, buf, lang) then
        vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
end

vim.api.nvim_create_autocmd("FileType", {
    callback = function(args)
        local buf = args.buf
        local ft = vim.bo[buf].filetype
        if ft == "large_file" then
            return
        end

        local lang = vim.treesitter.language.get_lang(ft)
        if not lang then
            return
        end

        if vim.treesitter.language.add(lang) then
            start(buf, lang)
        elseif vim.tbl_contains(treesitter.get_available(), lang) then
            -- auto_install equivalent
            treesitter.install(lang):await(function()
                vim.schedule(function()
                    if vim.treesitter.language.add(lang) then
                        start(buf, lang)
                    end
                end)
            end)
        end
    end,
})

treesitter_context.setup()

local textobjects_status, textobjects = pcall(require, "nvim-treesitter-textobjects")
if textobjects_status then
    textobjects.setup({ move = { set_jumps = true } })

    local move = require("nvim-treesitter-textobjects.move")
    local maps = {
        { "]f", "goto_next_start", "@function.outer" },
        { "]c", "goto_next_start", "@class.outer" },
        { "]a", "goto_next_start", "@parameter.inner" },
        { "]F", "goto_next_end", "@function.outer" },
        { "]C", "goto_next_end", "@class.outer" },
        { "]A", "goto_next_end", "@parameter.inner" },
        { "[f", "goto_previous_start", "@function.outer" },
        { "[c", "goto_previous_start", "@class.outer" },
        { "[a", "goto_previous_start", "@parameter.inner" },
        { "[F", "goto_previous_end", "@function.outer" },
        { "[C", "goto_previous_end", "@class.outer" },
        { "[A", "goto_previous_end", "@parameter.inner" },
    }
    for _, m in ipairs(maps) do
        vim.keymap.set({ "n", "x", "o" }, m[1], function()
            move[m[2]](m[3], "textobjects")
        end, { desc = m[3] .. " (" .. m[2] .. ")" })
    end
end

-- Auto close/rename JSX, TSX and HTML tag pairs
local autotag_status, autotag = pcall(require, "nvim-ts-autotag")
if not autotag_status then
    print("Couldn't load nvim-ts-autotag")
    return
end

autotag.setup()
