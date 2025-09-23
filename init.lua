local cmd_compile = require("commands.compile")
HL = {
	red = "\027[31m",
	green = "\027[32m",
	blue = "\027[34m",
	bold = "\027[1m",
	underline = "\027[4m",
	flush = "\027[0m",
}

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
	M.settings["bsq_dir"] = bsq_dir

	print("BSQON Directory:")
	local bsqon_dir = io.read()
	if file ~= nil then
		file:write("bsqon_dir = ", bsqon_dir, "\n")
	end
	M.settings["bsqon_dir"] = bsqon_dir

	--Look for scripts in the provided directories.
	local bsq_clis_dir = bsq_dir .. "bin/src/cmd/"
	M.AddCLIsToTable(bsq_clis_dir, "js", M.settings)

	local bsqon_clis_dir = bsqon_dir .. "build/output/"
	M.settings["smtextract"] = bsqon_clis_dir .. "smtextract"

	-- Now we have all the needed scripts and binaries locations.
	-- We write to the config.ini file.
	if file ~= nil then
		file:write("[scripts]\n")
		for script, dir in pairs(M.settings) do
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
		M.PopulateSettingsTable(config_file, M.settings)
	end
end

function M.UsageMessage()
	print(HL.underline .. "Usage:" .. HL.flush .. " bsq [commands] [options]\n")
	print(HL.bold .. "[Commands]" .. HL.flush)
	print("• compile	: compile bosque files")
	print("• test		: test bosque files")
	print("• solve	 	: run z3 on smt2 file generated")
	print("• json	 	: generate json files of the typeinfo of the bosque files")
	print("• smt	 	: generate a smt file from the bosque files")
	print("• extract	: run extractor on smt file, to get a SAT value")
	print("• help	 	: print this help message")
end

function M.ProcessArgs(args)
	for i, arg in ipairs(args) do
		if arg == "compile" then
		elseif arg == "test" then
		elseif arg == "solve" then
		elseif arg == "json" then
		elseif arg == "smt" then
		elseif arg == "extract" then
		elseif arg == "help" then
			M.UsageMessage()
		end
	end
end

function Main()
	M.settings = {}
	M.InitCLI()

	if arg[1] == nil then
		M.UsageMessage()
	end

	M.ProcessArgs(arg)
end

Main()
