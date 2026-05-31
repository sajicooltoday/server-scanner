local scanner = {}

local root = script.Parent.Parent
local methods = require(root.Utils.Methods)

local function hasProp(v, name)
	local success, _ = pcall(function()
		v[name] = v[name]
	end)

	return success
end

for i, v in pairs(wax.shared.gui.main.container:GetDescendants()) do
	if hasProp(v, "BackgroundTransparency") then
		local transparencytween =
			wax.shared.tweenService:Create(v, wax.shared.defaultTween, { BackgroundTransparency = 1 })

		transparencytween:Play()
	end

	if hasProp(v, "ImageTransparency") then
		local transparencytween = wax.shared.tweenService:Create(v, wax.shared.defaultTween, { ImageTransparency = 1 })

		transparencytween:Play()
	end

	if hasProp(v, "TextTransparency") then
		local transparencytween = wax.shared.tweenService:Create(v, wax.shared.defaultTween, { TextTransparency = 1 })

		transparencytween:Play()
	end

	if hasProp(v, "Transparency") then
		local transparencytween = wax.shared.tweenService:Create(v, wax.shared.defaultTween, { Transparency = 1 })

		transparencytween:Play()
	end
end

task.wait(0.2)

wax.shared.gui.main.container:Destroy()

local logcount = 0
local firstlog = true

wax.shared.log = function(text: string)
	local logscontainer = wax.shared.gui.main.container.container.logs
	local offset = logcount * 15

	logcount += 1

	if firstlog then
		offset = 0
	end

	if firstlog then
		firstlog = false
	end

	wax.shared.create("TextLabel", {
		Name = "log",
		Parent = logscontainer,
		BorderSizePixel = 0,
		BackgroundTransparency = 1,
		FontFace = wax.shared.getFont(Enum.FontWeight.Medium),
		Text = text,
		TextSize = 10,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		Size = UDim2.new(1, 0, 0, 10),
		Position = UDim2.fromOffset(0, offset),
		TextYAlignment = Enum.TextYAlignment.Center,
		TextXAlignment = Enum.TextXAlignment.Left,
		ZIndex = 2,

		[1] = {
			className = "UIPadding",
			Name = "padding",
			PaddingLeft = UDim.new(0, 10),
			PaddingTop = UDim.new(0, 10),
		},
	})

	logscontainer.CanvasSize = UDim2.new(1, 0, 0, wax.shared.gui.main.container.container.logs.CanvasSize.Y.Offset + 15)
	logscontainer.CanvasPosition = Vector2.new(logscontainer.CanvasPosition.X, logscontainer.AbsoluteCanvasSize.Y)
end

wax.shared.create("Frame", {
	Name = "container",
	Size = UDim2.fromScale(0.95, 0.95),
	BorderSizePixel = 0,
	BackgroundTransparency = 1,
	Position = UDim2.fromScale(0.5, 0.5),
	AnchorPoint = Vector2.new(0.5, 0.5),
	ZIndex = 2,
	Parent = wax.shared.gui.main,

	[1] = {
		className = "TextLabel",
		Name = "title",
		FontFace = wax.shared.getFont(Enum.FontWeight.SemiBold),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Size = UDim2.new(1, 0, 0, 35),
		TextColor3 = Color3.fromRGB(223, 225, 229),
		TextSize = 19,
		Text = "Scanning",
		ZIndex = 2,
	},

	[2] = {
		className = "Frame",
		Name = "container",
		Size = UDim2.new(1, 0, 1, -35),
		BorderSizePixel = 0,
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(1, 1),
		Position = UDim2.fromScale(1, 1),
		ZIndex = 2,

		[1] = {
			className = "ScrollingFrame",
			Name = "logs",
			Size = UDim2.fromScale(0.95, 0.95),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			BorderSizePixel = 0,
			BackgroundColor3 = Color3.fromRGB(35, 36, 39),
			ScrollBarThickness = 0,
			CanvasSize = UDim2.new(0, 0, 0, 0),
			ZIndex = 2,

			[1] = {
				className = "UICorner",
				Name = "corner",
				CornerRadius = UDim.new(0, 12),
			},
		},
	},

	[3] = {
		className = "Frame",
		Name = "topbarstuffcontainer",
		BorderSizePixel = 0,
		BackgroundTransparency = 1,
		Size = UDim2.new(1, 0, 0, 35),
		ZIndex = 2,

		[1] = {
			className = "ImageButton",
			Name = "close",
			AnchorPoint = Vector2.new(0, 0.5),
			Image = "rbxassetid://11293981586",
			BorderSizePixel = 0,
			BackgroundTransparency = 1,
			Size = UDim2.fromOffset(18, 18),
			Position = UDim2.new(1, -23, 0.5, 0),
			ScaleType = Enum.ScaleType.Fit,
			ZIndex = 2,

			Events = {
				MouseEnter = function(self)
					local tween = wax.shared.tweenService:Create(
						self,
						wax.shared.defaultTween,
						{ ImageColor3 = Color3.fromRGB(200, 200, 200) }
					)

					tween:Play()
				end,

				MouseLeave = function(self)
					local tween = wax.shared.tweenService:Create(
						self,
						wax.shared.defaultTween,
						{ ImageColor3 = Color3.fromRGB(255, 255, 255) }
					)

					tween:Play()
				end,

				MouseButton1Click = function(self)
					local tween = wax.shared.tweenService:Create(
						self.Parent.Parent.Parent,
						wax.shared.defaultTween,
						{ Size = UDim2.fromOffset(450, 200) }
					)

					local colortween = wax.shared.tweenService:Create(
						self.Parent.Parent.Parent,
						wax.shared.defaultTween,
						{ BackgroundColor3 = Color3.fromRGB(20, 21, 24) }
					)

					tween:Play()
					colortween:Play()

					for i, v in pairs(self.Parent.Parent.Parent.Parent:GetDescendants()) do
						if hasProp(v, "BackgroundTransparency") then
							local transparencytween = wax.shared.tweenService:Create(
								v,
								wax.shared.defaultTween,
								{ BackgroundTransparency = 1 }
							)

							transparencytween:Play()
						end

						if hasProp(v, "ImageTransparency") then
							local transparencytween =
								wax.shared.tweenService:Create(v, wax.shared.defaultTween, { ImageTransparency = 1 })

							transparencytween:Play()
						end

						if hasProp(v, "TextTransparency") then
							local transparencytween =
								wax.shared.tweenService:Create(v, wax.shared.defaultTween, { TextTransparency = 1 })

							transparencytween:Play()
						end

						if hasProp(v, "Transparency") then
							local transparencytween =
								wax.shared.tweenService:Create(v, wax.shared.defaultTween, { Transparency = 1 })

							transparencytween:Play()
						end
					end

					task.wait(0.25)

					self.Parent.Parent.Parent.Parent:Destroy()
				end,
			},
		},
	},

	[4] = {
		className = "Frame",
		Name = "hide",
		Size = UDim2.fromScale(1, 1),
		BorderSizePixel = 0,
		BackgroundColor3 = Color3.fromRGB(30, 31, 34),
		ZIndex = 2,
	},
})

local transparencytween =
	wax.shared.tweenService:Create(wax.shared.gui.main.container.hide, wax.shared.defaultTween, { Transparency = 1 })

transparencytween:Play()

local tween = wax.shared.tweenService:Create(
	wax.shared.gui.main,
	TweenInfo.new(0.5, Enum.EasingStyle.Exponential),
	{ Size = UDim2.fromOffset(500, 250) }
)

tween:Play()

function scanner.start(selected: { string })
	local start = tick()
	wax.shared.log("-------------------------------------------------------")
	wax.shared.log("Starting Scan (may lag)...")
	wax.shared.log("Server Scanner by Saji (discord.gg/5SszD6fWC8)")
	wax.shared.log("Repo: github.com/sajicooltoday/server-scanner")
	wax.shared.log("Open any explorer to see found instances")
	wax.shared.log("-------------------------------------------------------")
	wax.shared.log("")

	task.wait(2.5)

	for i, v in pairs(selected) do
		methods.runMethod(v)
		task.wait(2.5)
	end

	local endtime = tick()
	wax.shared.log("")
	wax.shared.log("-------------------------------------------------------")
	wax.shared.log("Scan has been finished! (discord.gg/5SszD6fWC8)")
	wax.shared.log("Total scan time: " .. endtime - start)
	wax.shared.log("-------------------------------------------------------")
end

return scanner
