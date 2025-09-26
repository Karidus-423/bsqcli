local setup = require("setup")

function Main()
	setup.InitCLI()

	if arg[1] == nil then
		setup.UsageMessage()
	end

	setup.ProcessArgs(arg)
end

Main()
