local utils = {}

-- sunc failure

utils.suncfail = function(text: string)
	error("Your executor does not support the following sunc function: '" .. text .. "' (terminating server scanner)")
end

-- cloneref polyfill

utils.cloneref = cloneref or function(i): Instance
	return i
end

-- services

utils.httpService = utils.cloneref(game:GetService("HttpService"))
utils.tweenService = utils.cloneref(game:GetService("TweenService"))
utils.userInputService = utils.cloneref(game:GetService("UserInputService"))
utils.coreGui = utils.cloneref(game:GetService("CoreGui"))
utils.players = utils.cloneref(game:GetService("Players"))

-- other polyfills

utils.gethui = function()
	if typeof(gethui) == "function" then
		return gethui()
	end

	return utils.coreGui.RobloxGui or utils.players.LocalPlayer.PlayerGui
end

-- simple creation func

utils.create = function(className: string, props: { [any]: any })
	local obj = Instance.new(className)

	for key, value in pairs(props or {}) do
		if typeof(value) == "table" and (typeof(key) == "number" or value.className or value.class) then
			local childClass = value.className or value.class

			local subObj = utils.create(childClass, value)
			subObj.Parent = obj
		elseif key == "Events" and typeof(value) == "table" then
			for eventName, callback in pairs(value) do
				local event = obj[eventName]
				if event and typeof(event) == "RBXScriptSignal" then
					event:Connect(function(...)
						callback(obj, ...)
					end)
				end
			end
		elseif typeof(key) == "string" and key ~= "className" and key ~= "class" and key ~= "Events" then
			obj[key] = value
		end
	end

	return obj
end

return utils
