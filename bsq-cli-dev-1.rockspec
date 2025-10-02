package = "bsq-cli"
version = "dev-1"
source = {
	url = "git+ssh://git@github.com/Karidus-423/bsqcli.git",
}
description = {
	homepage = "TODO: Bosque Homepage",
	license = "MIT License",
}
dependencies = {
	"lua >= 5.4",
}
-- build_dependencies = {
--    queries = {}
-- }
build = {
	type = "builtin",
	modules = {
		["commands.compile"] = "commands/compile.lua",
		["commands.help"] = "commands/help.lua",
		["commands.run"] = "commands/run.lua",
		init = "init.lua",
		setup = "setup.lua",
		utils = "utils.lua",
	},
}
-- test_dependencies = {
--    queries = {}
-- }
