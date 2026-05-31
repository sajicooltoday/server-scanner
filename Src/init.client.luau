local utils = script.Utils
local ui = script.UI

-- utility

require(utils.Services)
require(utils.Polyfill)

-- user interface

require(ui.Create)
require(ui.Init)

wax.shared.setthreadidentidy(8) -- better to be at highest thread for this typa stuff

-- reference the server services so explorers like dex or onyx can pick them up

wax.shared.cloneref(game:GetService("ServerScriptService"))
wax.shared.cloneref(game:GetService("ServerStorage"))
