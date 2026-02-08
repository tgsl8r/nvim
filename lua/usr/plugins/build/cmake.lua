-- Load and configure cmake-tools
local cmake_tools_status, cmake_tools = pcall(require, "cmake-tools")
if not cmake_tools_status then
	print("Couldn't load cmake-tools")
	return
end

require(cmake_tools).setup({
	cmake_command = "cmake",
	cmake_build_directory = "build",
	cmake_build_type = "Debug",
	cmake_generate_options = { "-DCMAKE_EXPORT_COMPILE_COMMANDS=1" },

	cmake_notifications = {
		enabled = true,
	},

	cmake_executor = {
		name = "quickfix",
	},

	cmake_runner = {
		name = "terminal",
	},
})
