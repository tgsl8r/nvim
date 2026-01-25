local ai_status, ai = pcall(require, "mini.ai")
if not ai_status then
	print("Couldn't load mini.ai")
	return
end

local surround_status, surround = pcall(require, "mini.surround")
if not surround_status then
	print("Couldn't load mini.surround")
	return
end

ai.setup()

surround.setup()
