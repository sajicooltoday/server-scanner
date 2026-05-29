wax.shared.cloneref = cloneref or function(i): Instance
	return i
end

wax.shared.httpService = wax.shared.cloneref(game:GetService("HttpService"))
wax.shared.tweenService = wax.shared.cloneref(game:GetService("TweenService"))
wax.shared.userInputService = wax.shared.cloneref(game:GetService("UserInputService"))
wax.shared.coreGui = wax.shared.cloneref(game:GetService("CoreGui"))
wax.shared.players = wax.shared.cloneref(game:GetService("Players"))

return {}
