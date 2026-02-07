local overseer_status, overseer= pcall(require, "overseer")
if not overseer_status then
	print("Couldn't load Overseer")
	return
end

overseer.setup()
