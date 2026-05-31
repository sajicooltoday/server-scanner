local Methods = {}

local methodsFolder = script.Parent.Parent.Methods

Methods.runMethod = function(method: string)
	wax.shared.log([[Starting method: "]] .. method .. [["]])
	wax.shared.log("")
	local run = require(methodsFolder:FindFirstChild(method))

	if run.found == nil or run.found ~= true then
		wax.shared.log("Method (" .. method .. ") found nothing")
		wax.shared.log("")

		return
	end

	for i, v in pairs(run.results) do
		wax.shared.log([[Result has been found ("]] .. v .. [[")]])
	end
end

return Methods
