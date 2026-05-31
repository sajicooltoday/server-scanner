local remoteFuzzer = {
	found = false,
	results = {},
}

-- simple remote func arg fuzz error extraction method

local skip = { "RobloxReplicatedStorage", "DefaultChatSystemChatEvents" }

local function findServerPath(err)
	if type(err) ~= "string" then
		return nil
	end

	local path = err:match("(game%.ServerScriptService[%w_%.]*)")
		or err:match("(game%.ServerStorage[%w_%.]*)")
		or err:match("(ServerScriptService[%w_%.]*)")
		or err:match("(ServerStorage[%w_%.]*)")

	if not path then
		return nil
	end

	path = path:gsub("%.+$", "")

	if path:sub(1, 5) ~= "game." then
		path = "game." .. path
	end

	remoteFuzzer.found = true
	table.insert(remoteFuzzer.results, path)

	return path
end

local null = {}

local fuzzArgs = {
	math.huge,
	-math.huge,
	0 / 0,
	2 ^ 53 - 2 ^ 53,
	null,
	"",
	{},
	(function()
		local t = {}
		local current = t
		for i = 1, 100 do
			current.child = {}
			current = current.child
		end
		return t
	end)(),
	true,
	false,
	print,
	Vector3.new(math.huge, math.huge, math.huge),
	CFrame.new(math.huge, math.huge, math.huge),
}

local function fuzzRemoteFunc(func: RemoteFunction)
	local function invokeWithTimeout(arg, hasArg)
		local result = nil
		local done = false

		task.spawn(function()
			local success, extractedPath = xpcall(function()
				if hasArg then
					func:InvokeServer(arg)
				else
					func:InvokeServer()
				end
			end, findServerPath)

			result = { success = success, extractedPath = extractedPath }
			done = true
		end)

		local elapsed = 0
		while not done and elapsed < 1 do -- if a remote func takes longer than 1 sec to return smth, we skip it
			task.wait(0.1)
			elapsed += 0.1
		end

		return result
	end

	local result = invokeWithTimeout(nil, false)
	if result == nil or (not result.success and result.extractedPath ~= nil) then
		return
	end

	for i, v in pairs(fuzzArgs) do
		local arg = if v == null then nil else v
		result = invokeWithTimeout(arg, true)
		if result == nil or (not result.success and result.extractedPath ~= nil) then
			return
		end
	end
end

local remotes = {}

for i, v in pairs(game:GetDescendants()) do
	if v.ClassName ~= "RemoteFunction" then
		continue
	end

	if v.Parent ~= nil and table.find(skip, v.Parent.Name) then
		continue
	end

	table.insert(remotes, v)
end

local threads = {}

for i, v in pairs(remotes) do
	table.insert(
		threads,
		task.spawn(function()
			fuzzRemoteFunc(v)
		end)
	)
end

for _, thread in ipairs(threads) do
	while coroutine.status(thread) ~= "dead" do
		task.wait()
	end
end

if remoteFuzzer.found ~= false then
	local isPrefix = {}

	for _, path in ipairs(remoteFuzzer.results) do
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

	for _, path in ipairs(remoteFuzzer.results) do
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

return remoteFuzzer
