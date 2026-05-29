wax.shared.gethui = function()
	if typeof(gethui) == "function" then
		return gethui()
	end

	return wax.shared.coreGui.RobloxGui or wax.shared.players.LocalPlayer.PlayerGui
end

return {}
