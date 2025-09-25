local setup = require("setup")
local u = require("utils")

function Main()
	setup.InitCLI()

	if arg[1] == nil then
		setup.UsageMessage()
	end

	setup.ProcessArgs(arg)
end

Main()
