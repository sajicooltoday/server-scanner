local Methods = {}

local firstrun = true

Methods.runMethod = function(method: LuaSourceContainer)
	if not firstrun then
		firstrun = false
		wax.shared.log("")
	end

	firstrun = false

	wax.shared.log([[Starting method: "]] .. method.Name .. [["]])
	wax.shared.log("")
	local run = require(method)

	if run.found == nil or run.found ~= true then
		wax.shared.log("")
		wax.shared.log("Method (" .. method.Name .. ") found nothing")

		return
	end

	for i, v in pairs(run.results) do
		wax.shared.log([[Result has been found ("]] .. v .. [[")]])
	end
end

return Methods
