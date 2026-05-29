local Scanner = {}

local methodsFolder = script.Parent.Methods

Scanner.runMethod = function(method: string)
	local run = require(methodsFolder:FindFirstChild(method))

	if run.found == nil or run.found ~= true then
		wax.shared.log("Warning", "Method (" .. method .. ") found nothing, continuing.")
		return
	end

	for i, v in pairs(run.results) do
		wax.shared.log("Normal", [[Result has been found! ("]] .. v .. [[")]])
	end
end

return Scanner
