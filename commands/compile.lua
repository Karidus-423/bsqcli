local u = require('utils')
local M = {}

function CompileUsageMsg()
	print("bsq compile <FLAGS> <FILES>")
end

function M.run(args, start, size)
	if size == 0 then
		CompileUsageMsg()
	end
	local run_cmd = ""
	local i = start
	repeat
		--Build the argument strings
		run_cmd = run_cmd .. " ".. args[i]
		i = i + 1
	until i == (start + size)
	io.popen('node "' .. u.settings["bosque.js"] .. run_cmd .. '"')
	-- print(run_cmd)
end

return M
