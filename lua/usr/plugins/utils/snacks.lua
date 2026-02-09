local snacks_status, snacks = pcall(require, "snacks")
if not snacks_status then
	print("Couldn't load snacks")
	return
end

snacks.setup({
	bigfile = { enabled = false },
	explorer = { enabled = true },
	indent = {
        enabled = true,
        animate = {
            enabled = false
        },
    },
	input = { enabled = true },
	notifier = {
		enabled = true,
		timeout = 3000,
	},
	picker = { enabled = true },
	quickfile = { enabled = true },
	scope = { enabled = true },
	scroll = { enabled = true },
	statuscolumn = { enabled = true },
    terminal = { enabled = true },
	words = { enabled = true },
	styles = {
		notification = {
			wo = { wrap = true } -- Wrap notifications
		},
	},
})
