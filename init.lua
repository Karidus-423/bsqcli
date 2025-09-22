local function InitConfigFile()
	print("config.ini file not found. Need directories.")

	local file = io.open("config.ini", "w")
	print("BosqueCore Directory:")
	local bsq_dir = io.read()
	if file ~= nil then
		file:write("[directory]\n")
		--NOTE:dirs must end with the / character.
		file:write("bsq_dir = ", bsq_dir, "\n")
	end

	print("BSQON Directory:")
	local bsqon_dir = io.read()
	if file ~= nil then
		file:write("bsqon_dir = ", bsqon_dir, "\n")
	end
end

local function ScanForCLIs(dir, ft, settings)
	--Read the file and use as key, value is the file path.
	if ft == "js" then
		for file in io.popen('ls "' .. dir .. '"'):lines() do
			if not string.find(file, ".map") then
				settings[file] = dir .. file
			end
		end
	else
		for file in io.popen('ls "' .. dir .. '"'):lines() do
			if string.find(file, "") then
				settings[file] = dir .. file
			end
		end
	end
end

local function PopulateSettingsTable(file, settings)
	for line in file:lines() do
		local setting, val = line:match("^(.-)%s*=%s*(.-)$")
		if setting and val then
			settings[setting] = val
		end
	end

	local bsq_dir = settings["bsq_dir"]
	local bsq_clis_dir = bsq_dir .. "bin/src/cmd/"
	ScanForCLIs(bsq_clis_dir, "js", settings)

	local bsqon_dir = settings["bsqon_dir"]
	local bsqon_clis_dir = bsq_dir .. "bin/src/cmd/"
	ScanForCLIs(bsq_clis_dir, "cpp", settings)
end

function CLI()
	local settings = {}

	local config_file = io.open("./config.ini", "r")
	if config_file == nil then
		InitConfigFile()
	end

	PopulateSettingsTable(config_file, settings)
end

CLI()
