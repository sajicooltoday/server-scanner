local utils = script.Utils
local ui = script.UI

-- this is for if your turning it into a infinite yield plugin

local plugin = {
	["PluginName"] = "ServerScanner",
	["PluginDescription"] = "Scans for server sided objects and reconstructs them for any explorer to view.",
	["Commands"] = {
		["serverscan"] = {
			["ListName"] = "serverscan",
			["Description"] = "Scans for server sided objects and reconstructs them for any explorer to view.",
			["Aliases"] = { "sscan" },
			["Function"] = function(args, speaker)
				require(ui.Init)
			end,
		},
	},
}

local infinite_yield = false -- change this to true before building to compile it into a infinite yield plugin for a .IY file
-- keep this as false if your gonna make a new release on the github or if ur gonna commit

-- utility

require(utils.Services)
require(utils.Polyfill)

-- user interface

require(ui.Create)

if not infinite_yield then
	require(ui.Init)
end

wax.shared.setthreadidentidy(8) -- better to be at highest thread for this typa stuff

-- reference the server services so explorers like dex or onyx can pick them up

wax.shared.cloneref(game:GetService("ServerScriptService"))
wax.shared.cloneref(game:GetService("ServerStorage"))

if infinite_yield then
	return plugin
end
