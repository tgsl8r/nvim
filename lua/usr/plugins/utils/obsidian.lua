-- obsidian-nvim/obsidian.nvim (the maintained community fork)
-- Option names have moved between releases: if anything errors, check
-- :checkhealth obsidian and :Obsidian help against your installed version.
vim.pack.add({
  {
    src = "https://github.com/obsidian-nvim/obsidian.nvim",
    version = vim.version.range("*"), -- latest release; remove to track main
  },
})

require("obsidian").setup({
  legacy_commands = false,
  workspaces = { { name = "kb", path = "~/kb" } },

  notes_subdir = "notes",
  new_notes_location = "notes_subdir",
  -- "Hello, world" -> "hello-world": matches the kebab-case filename rule
  note_id_func = require("obsidian.builtin").title_id,

  -- Standard [label](path.md) links instead of [[wikilinks]]
  link = { style = "markdown" },

  -- Keep whatever keys are already in the frontmatter; don't inject `id`
  -- or empty `aliases`, which would create noisy diffs on every save.
  frontmatter = {
    enabled = true,
    func = function(note)
      local out = vim.tbl_extend("force", {}, note.metadata or {})
      out.id = nil
      if note.tags and #note.tags > 0 then out.tags = note.tags end
      if note.aliases and #note.aliases > 0 then out.aliases = note.aliases end
      return out
    end,
  },

  -- Same folder and moment.js date format as Obsidian's core Templates plugin
  templates = {
    folder = "_templates",
    date_format = "YYYY-MM-DD",
    time_format = "HH:mm",
  },
})
