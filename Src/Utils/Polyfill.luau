wax.shared.gethui = function()
	if typeof(gethui) == "function" then
		return gethui()
	end

	return wax.shared.coreGui.RobloxGui or wax.shared.players.LocalPlayer.PlayerGui
end

wax.shared.setthreadidentidy = function(identidy: number)
	if typeof(setthreadidentity) == "function" then
		return setthreadcontext(identidy)
	end

	return nil
end

return {}
