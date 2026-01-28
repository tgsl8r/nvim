local live_preview_status, live_preview= pcall(require, "livepreview")
if not live_preview_status then
	print("Couldn't load live-preview")
	return
end

vim.g.loaded_livepreview = 1

require("livepreview.config").set({
    browser = "chrome",
    picker = "snacks.picker",
})
