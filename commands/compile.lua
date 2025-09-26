local u = require("utils")
local M = {}

function M.run(args, start, size)
	if size == 0 then
		u.UsageMessage("compile")
	end

	local run_args = ""
	local i = start + 1
	repeat
		run_args = run_args .. args[i] .. " "
		i = i + 1
	until i > size

	local run_cmd = "node " .. u.settings["bosque.js"] .. " " .. run_args
	local res = io.popen(run_cmd)
	if res then
		local final = res:read("*a")
		res:close()
		print(final)
	end
end

return M
