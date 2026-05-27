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
		if typeof(value) == "table" and (typeof(key) == "number" or value.className) then
			local childClass = value.className or value.class

			local subObj = utils.create(childClass, value)
			subObj.Parent = obj
		elseif typeof(key) == "string" and key ~= "className" and key ~= "class" then
			obj[key] = value
		end
	end

	return obj
end

return utils
