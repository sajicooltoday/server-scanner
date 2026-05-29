wax.shared.create = function(className: string, props: { [any]: any })
	local obj = Instance.new(className)

	for key, value in pairs(props or {}) do
		if typeof(value) == "table" and (typeof(key) == "number" or value.className or value.class) then
			local childClass = value.className or value.class

			local subObj = wax.shared.create(childClass, value)
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

return {}
