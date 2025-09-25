local cmd_compile = require('commands.compile')
local u = require('utils')

local M = {}

function M.InitConfigFile()
	print("config.ini file not found. Need directories.")

	local file = io.open("config.ini", "w")
	print("BosqueCore Directory:")
	local bsq_dir = io.read()
	if file ~= nil then
		file:write("[directory]\n")
		--NOTE:dirs must end with the / character.
		file:write("bsq_dir = ", bsq_dir, "\n")
	end
	u.settings["bsq_dir"] = bsq_dir

	print("BSQON Directory:")
	local bsqon_dir = io.read()
	if file ~= nil then
		file:write("bsqon_dir = ", bsqon_dir, "\n")
	end
	u.settings["bsqon_dir"] = bsqon_dir

	--Look for scripts in the provided directories.
	local bsq_clis_dir = bsq_dir .. "bin/src/cmd/"
	M.AddCLIsToTable(bsq_clis_dir, "js", u.settings)

	local bsqon_clis_dir = bsqon_dir .. "build/output/"
	u.settings["smtextract"] = bsqon_clis_dir .. "smtextract"

	-- Now we have all the needed scripts and binaries locations.
	-- We write to the config.ini file.
	if file ~= nil then
		file:write("[scripts]\n")
		for script, dir in pairs(u.settings) do
			file:write(script, " = ", dir, "\n")
		end
		file:close()
	end
end

function M.PopulateSettingsTable(file, settings)
	for line in file:lines() do
		local setting, val = line:match("^(.-)%s*=%s*(.-)$")
		if setting and val then
			settings[setting] = val
		end
	end
end

function M.AddCLIsToTable(dir, ft, settings)
	if ft == "js" then
		for file in io.popen('ls "' .. dir .. '"'):lines() do
			if not string.find(file, ".map") then
				settings[file] = dir .. file
			end
		end
	end
end

function M.InitCLI()
	local config_file = io.open("./config.ini", "r")
	if config_file == nil then
		M.InitConfigFile()
	else
		M.PopulateSettingsTable(config_file, u.settings)
	end
end


function M.ProcessArgs(args)
	local actions = {}
	for i, arg in ipairs(args) do
		for _, cmd in ipairs(u.cmds) do
			if arg == cmd then
				table.insert(actions, { cmd = arg, pos = i })
			end
		end
	end

	--TODO: Fix error here that is not processing arguments correctly.
	for i, c in ipairs(actions) do
		local next = i + 1
		if next <= #actions then
			local first_var = c.pos + 1
			local arg_size = actions[next].pos - (first_var)
			if c.cmd == "compile" then
				cmd_compile.run(args, first_var, arg_size)
			end
		end
	end
end

return M
