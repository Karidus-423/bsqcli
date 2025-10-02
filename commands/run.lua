local u = require("utils")
local M = {}

function M.command(args, start, size, cmd)
	if size == 0 then
		u.UsageMessage(cmd)
	end

	local run_args = ""
	local i = start + 1
	repeat
		run_args = run_args .. args[i] .. " "
		i = i + 1
	until i > size

	local run_cmd = "node " .. cmd .. " " .. run_args .. " 2>&1"

	local res = io.popen(run_cmd)

	if res then
		local final = res:read("*a")
		res:close()
		print(final)
	end
end

return M
