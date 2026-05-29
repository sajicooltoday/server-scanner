local moduleScan = {
	found = false,
	results = {},
}

local skip = {
	"CorePackages",
	"RobloxReplicatedStorage",
	"Players",
	"CoreGui",
}

-- simple modulescan implementation using pattern matching and decompilation

local function findServerLinks(script: LocalScript | ModuleScript): { string }
	local source = decompile(script)

	if not source:find("ServerStorage", 1, true) and not source:find("ServerScriptService", 1, true) then
		return {}
	end

	local seen = {}
	local results = {}
	local aliases = {}

	local function push(svc, chain)
		local path = "game." .. svc .. "." .. chain
		if not seen[path] then
			seen[path] = true
			table.insert(results, path)
		end
	end

	local services = { "ServerStorage", "ServerScriptService" }

	for _, svc in ipairs(services) do
		if not source:find(svc, 1, true) then
			continue
		end

		for chain in source:gmatch("game%." .. svc .. "%.([%w_%.]+)") do
			push(svc, chain)
		end

		for chain in source:gmatch('game%["' .. svc .. '"%]%.([%w_%.]+)') do
			push(svc, chain)
		end

		for chain in source:gmatch("game%['" .. svc .. "'%]%.([%w_%.]+)") do
			push(svc, chain)
		end

		for chain in source:gmatch('game:GetService%("' .. svc .. '"%)' .. "%.([%w_%.]+)") do
			push(svc, chain)
		end

		for chain in source:gmatch("game:GetService%('" .. svc .. "'%)%.([%w_%.]+)") do
			push(svc, chain)
		end

		for chain in source:gmatch('game:FindService%("' .. svc .. '"%)' .. "%.([%w_%.]+)") do
			push(svc, chain)
		end

		for chain in source:gmatch("game:FindService%('" .. svc .. "'%)%.([%w_%.]+)") do
			push(svc, chain)
		end

		for chain in source:gmatch('game:WaitForChild%("' .. svc .. '"%)' .. "%.([%w_%.]+)") do
			push(svc, chain)
		end

		for chain in source:gmatch("game:WaitForChild%('" .. svc .. "'%)%.([%w_%.]+)") do
			push(svc, chain)
		end

		for chain in source:gmatch('game:FindFirstChild%("' .. svc .. '"%)' .. "%.([%w_%.]+)") do
			push(svc, chain)
		end

		for chain in source:gmatch("game:FindFirstChild%('" .. svc .. "'%)%.([%w_%.]+)") do
			push(svc, chain)
		end

		for chain in source:gmatch('game:FindFirstChildOfClass%("' .. svc .. '"%)' .. "%.([%w_%.]+)") do
			push(svc, chain)
		end

		for chain in source:gmatch("game:FindFirstChildOfClass%('" .. svc .. "'%)%.([%w_%.]+)") do
			push(svc, chain)
		end

		for chain in source:gmatch('game:FindFirstChildWhichIsA%("' .. svc .. '"%)' .. "%.([%w_%.]+)") do
			push(svc, chain)
		end

		for chain in source:gmatch("game:FindFirstChildWhichIsA%('" .. svc .. "'%)%.([%w_%.]+)") do
			push(svc, chain)
		end

		for chain in source:gmatch(svc .. "%.([%w_%.]+)") do
			push(svc, chain)
		end

		for var in source:gmatch("local%s+([%w_]+)%s*=%s*game%." .. svc) do
			aliases[var] = svc
		end

		for var in source:gmatch('local%s+([%w_]+)%s*=%s*game%["' .. svc .. '"%]') do
			aliases[var] = svc
		end

		for var in source:gmatch("local%s+([%w_]+)%s*=%s*game%['" .. svc .. "'%]") do
			aliases[var] = svc
		end

		for var in source:gmatch('local%s+([%w_]+)%s*=%s*game:GetService%("' .. svc .. '"%)') do
			aliases[var] = svc
		end

		for var in source:gmatch("local%s+([%w_]+)%s*=%s*game:GetService%('" .. svc .. "'%)") do
			aliases[var] = svc
		end

		for var in source:gmatch('local%s+([%w_]+)%s*=%s*game:FindService%("' .. svc .. '"%)') do
			aliases[var] = svc
		end

		for var in source:gmatch("local%s+([%w_]+)%s*=%s*game:FindService%('" .. svc .. "'%)") do
			aliases[var] = svc
		end

		for var in source:gmatch('local%s+([%w_]+)%s*=%s*game:WaitForChild%("' .. svc .. '"%)') do
			aliases[var] = svc
		end

		for var in source:gmatch("local%s+([%w_]+)%s*=%s*game:WaitForChild%('" .. svc .. "'%)") do
			aliases[var] = svc
		end

		for var in source:gmatch('local%s+([%w_]+)%s*=%s*game:FindFirstChild%("' .. svc .. '"%)') do
			aliases[var] = svc
		end

		for var in source:gmatch("local%s+([%w_]+)%s*=%s*game:FindFirstChild%('" .. svc .. "'%)") do
			aliases[var] = svc
		end

		for var in source:gmatch("([%w_]+)%s*=%s*game%." .. svc .. "[^%w_]") do
			aliases[var] = svc
		end
	end

	for var, svc in pairs(aliases) do
		for chain in source:gmatch(var .. "%.([%w_%.]+)") do
			push(svc, chain)
		end
	end

	return results
end

local function reconstruct(paths: { string })
	local isPrefix = {}

	for _, path in ipairs(paths) do
		local parts = path:split(".")
		for i = 2, #parts - 1 do
			isPrefix[table.concat(parts, ".", 1, i)] = true
		end
	end

	local function endsWithS(name)
		return name:sub(-1):lower() == "s"
	end

	local function isAllCaps(name)
		return name == name:upper() and name:find("%a")
	end

	local function guessLeaf(name, rootService)
		local lower = name:lower()
		if isAllCaps(name) or lower:find("module") or lower:find("service") then
			return "ModuleScript"
		end
		if rootService == "ServerStorage" then
			return "ModuleScript"
		end
		return "Script"
	end

	local done = {}

	for _, path in ipairs(paths) do
		if done[path] then
			continue
		end
		done[path] = true

		local parts = path:split(".")
		local rootService = parts[2]
		local current = game

		for i = 2, #parts do
			local name = parts[i]
			local existing = current:FindFirstChild(name)

			if existing then
				current = existing
			else
				local subPath = table.concat(parts, ".", 1, i)
				local kind
				if i < #parts or isPrefix[subPath] or endsWithS(name) then
					kind = "Folder"
				else
					kind = guessLeaf(name, rootService)
				end
				local inst = Instance.new(kind)
				inst.Name = name
				inst.Parent = current
				current = inst
			end
		end
	end
end

local found = {}

for i, v in pairs(game:GetChildren()) do
	if table.find(skip, v.Name) then
		continue
	end

	local descendants = v:GetDescendants()

	for i, descendant in pairs(descendants) do
		-- i know its called modulescan but every script that we can access the bytecode on the client is better
		if descendant:IsA("LuaSourceContainer") then
			if descendant.ClassName == "Script" then
				if descendant.RunContext ~= Enum.RunContext.Client then
					continue
				end
			end

			local paths = findServerLinks(descendant)

			for i, path in paths do
				table.insert(found, path)
			end

			reconstruct(paths)
		end
	end
end

if found[1] ~= nil then
	moduleScan.found = true
	moduleScan.results = found
end

return moduleScan
