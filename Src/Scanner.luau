local Scanner = {}

local methodsFolder = script.Parent.Methods

Scanner.runMethods = function(methods: { string })
	for i, v in ipairs(methods) do
		require(methodsFolder:FindFirstChild(v))
	end
end

return Scanner
