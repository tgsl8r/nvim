local live_preview_status, live_preview = pcall(require, "livepreview")
if not live_preview_status then
    print("Couldn't load live-preview")
    return
end

require("livepreview.config").set({
    browser = "Google Chrome",
    picker = "snacks.picker",
})
