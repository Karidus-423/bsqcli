local setup = require("setup")
local utils = require("utils")

function Main()
	setup.InitCLI()

	if arg[1] == nil then
		utils.UsageMessage()
	end

	setup.ProcessArgs(arg)
end

Main()
