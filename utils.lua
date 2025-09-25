local M = {}

M.settings = {}

M.hl = {
	red = "\027[31m",
	green = "\027[32m",
	blue = "\027[34m",
	bold = "\027[1m",
	underline = "\027[4m",
	flush = "\027[0m",
}

M.cmds = {
	"compile",
	"test",
	"solve",
	"json",
	"smt",
	"extract",
	"help",
}

function M.UsageMessage(cmd)
	local hl = M.hl
	if cmd then
	elseif cmd == "help" or cmd == nil then
	print(hl.underline .. "Usage:" .. hl.flush .. " bsq [commands] [options]\n")
	print(hl.bold .. "[Commands]" .. hl.flush)
	print("• compile	: compile bosque files")
	print("• test		: test bosque files")
	print("• solve	 	: run z3 on smt2 file generated")
	print("• json	 	: generate json files of the typeinfo of the bosque files")
	print("• smt	 	: generate a smt file from the bosque files")
	print("• extract	: run extractor on smt file, to get a SAT value")
	print("• help	 	: print this help message")
	end
end

return M
