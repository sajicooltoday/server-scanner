wax.shared.gui.main.container:Destroy()

local modules = script.Parent.Parent.Methods

local methods = {
	["Module Scan"] = modules.moduleScan,
	["Remote Func Fuzz"] = modules.remoteFunctionFuzz,
}

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
		Text = "Options",
		ZIndex = 2,
	},

	[2] = {
		className = "Frame",
		Name = "container",
		Size = UDim2.new(1, 0, 1, -70),
		BorderSizePixel = 0,
		BackgroundTransparency = 1,
		AnchorPoint = Vector2.new(1, 1),
		Position = UDim2.new(1, 0, 1, -35),
		ZIndex = 2,

		[1] = {
			className = "ScrollingFrame",
			Name = "scroll",
			Size = UDim2.fromScale(0.95, 0.95),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			BorderSizePixel = 0,
			BackgroundColor3 = Color3.fromRGB(35, 36, 39),
			ScrollBarThickness = 0,
			AutomaticCanvasSize = Enum.AutomaticSize.Y,
			CanvasSize = UDim2.new(0, 0, 0, 0),
			ZIndex = 2,

			[1] = {
				className = "UICorner",
				Name = "corner",
				CornerRadius = UDim.new(0, 12),
			},

			[2] = {
				className = "Frame",
				Name = "container",
				Size = UDim2.fromScale(0.95, 0.95),
				BorderSizePixel = 0,
				BackgroundTransparency = 1,
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.fromScale(0.5, 0.5),
				ZIndex = 2,

				[2] = {
					className = "UIListLayout",
					Padding = UDim.new(0, 10),
					FillDirection = Enum.FillDirection.Vertical,
				},
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
						{ Size = UDim2.fromOffset(250, 150) }
					)

					local colortween = wax.shared.tweenService:Create(
						self.Parent.Parent.Parent,
						wax.shared.defaultTween,
						{ BackgroundColor3 = Color3.fromRGB(20, 21, 24) }
					)

					tween:Play()
					colortween:Play()

					local function hasProp(v, name)
						local success, _ = pcall(function()
							v[name] = v[name]
						end)

						return success
					end

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
})

local tween = wax.shared.tweenService:Create(
	wax.shared.gui.main,
	TweenInfo.new(0.5, Enum.EasingStyle.Exponential),
	{ Size = UDim2.fromOffset(300, 200) }
)

tween:Play()

local selected = {}

for k, method in pairs(methods) do
	task.spawn(function()
		local toggle = false

		wax.shared.create("Frame", {
			Name = "method",
			BorderSizePixel = 0,
			BackgroundTransparency = 1,
			Size = UDim2.new(1, 0, 0, 30),
			ZIndex = 2,
			Parent = wax.shared.gui.main.container.container.scroll.container,

			[1] = {
				className = "ImageButton",
				BorderSizePixel = 0,
				Name = "button",
				ImageTransparency = 1,
				BackgroundColor3 = Color3.fromRGB(50, 50, 50),
				Size = UDim2.new(0, 20, 0, 20),
				AnchorPoint = Vector2.new(0, 0.5),
				Position = UDim2.fromScale(0, 0.5),
				AutoButtonColor = false,
				ZIndex = 2,

				Events = {
					MouseEnter = function(self)
						if toggle then
							return
						end

						local tween = wax.shared.tweenService:Create(
							self,
							wax.shared.defaultTween,
							{ BackgroundColor3 = Color3.fromRGB(55, 55, 55) }
						)

						tween:Play()
					end,

					MouseLeave = function(self)
						if toggle then
							return
						end

						local tween = wax.shared.tweenService:Create(
							self,
							wax.shared.defaultTween,
							{ BackgroundColor3 = Color3.fromRGB(50, 50, 50) }
						)

						tween:Play()
					end,

					MouseButton1Click = function(self)
						toggle = not toggle
						local btncolor = if toggle then Color3.fromRGB(70, 70, 70) else Color3.fromRGB(50, 50, 50)

						if toggle then
							table.insert(selected, method)
						end

						if not toggle then
							for i, v in pairs(selected) do
								if v == method then
									table.remove(selected, i)
									break
								end
							end
						end

						local tween = wax.shared.tweenService:Create(
							self,
							wax.shared.defaultTween,
							{ BackgroundColor3 = btncolor }
						)

						tween:Play()
					end,
				},

				[1] = {
					className = "UICorner",
					Name = "corner",
					CornerRadius = UDim.new(0, 8),
				},
			},

			[2] = {
				className = "TextLabel",
				Name = "title",
				Text = k,
				FontFace = wax.shared.getFont(Enum.FontWeight.Regular),
				Size = UDim2.fromScale(1, 1),
				AnchorPoint = Vector2.new(0.5, 0.5),
				TextSize = 15,
				BorderSizePixel = 0,
				BackgroundTransparency = 1,
				TextColor3 = Color3.fromRGB(255, 255, 255),
				Position = UDim2.fromScale(0.5, 0.5),
				TextYAlignment = Enum.TextYAlignment.Center,
				TextXAlignment = Enum.TextXAlignment.Left,
				ZIndex = 2,

				[1] = {
					className = "UIPadding",
					Name = "padding",
					PaddingLeft = UDim.new(0, 25),
				},
			},
		})
	end)
end

wax.shared.create("Frame", {
	Name = "start",
	BorderSizePixel = 0,
	BackgroundColor3 = Color3.fromRGB(43, 45, 48),
	Size = UDim2.new(0, 90, 0, 25),
	AnchorPoint = Vector2.new(0.5, 0),
	Position = UDim2.new(0.5, 0, 1, -30),
	Parent = wax.shared.gui.main.container,
	ZIndex = 2,

	[1] = {
		className = "UICorner",
		Name = "corner",
		CornerRadius = UDim.new(0, 12),
	},

	[2] = {
		className = "UIStroke",
		Name = "stroke",
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Color = Color3.fromRGB(55, 57, 62),
		Thickness = 1,
	},

	[3] = {
		className = "Frame",
		Name = "container",
		BorderSizePixel = 0,
		BackgroundTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		ZIndex = 2,

		[1] = {
			className = "UIPadding",
			Name = "padding",
			PaddingRight = UDim.new(0, 8),
		},

		[2] = {
			className = "TextLabel",
			Name = "text",
			BorderSizePixel = 0,
			BackgroundTransparency = 1,
			FontFace = wax.shared.getFont(Enum.FontWeight.Medium),
			Text = "Start Scan",
			TextColor3 = Color3.fromRGB(142, 144, 147),
			TextSize = 10,
			TextXAlignment = Enum.TextXAlignment.Right,
			TextYAlignment = Enum.TextYAlignment.Center,
			Size = UDim2.fromScale(1, 1),
			ZIndex = 2,
		},
	},

	[4] = {
		className = "Frame",
		Name = "shadow",
		BackgroundColor3 = Color3.fromRGB(26, 27, 30),
		BorderSizePixel = 0,
		Size = UDim2.new(0, 90, 0, 25),
		Position = UDim2.new(0.5, 0, 0.7, 0),
		AnchorPoint = Vector2.new(0.5, 0.5),
		ZIndex = 1,

		[1] = {
			className = "UICorner",
			Name = "corner",
			CornerRadius = UDim.new(0, 12),
		},
	},

	[5] = {
		className = "ImageLabel",
		Name = "circle",
		BorderSizePixel = 0,
		BackgroundTransparency = 1,
		Size = UDim2.new(0, 20, 0.85, 0),
		Position = UDim2.new(0, 5, 0.5, 0),
		AnchorPoint = Vector2.new(0, 0.5),
		Image = "rbxassetid://115638502740483",
		ZIndex = 2,
	},

	[6] = {
		className = "ImageButton",
		Name = "click",
		BorderSizePixel = 0,
		BackgroundTransparency = 1,
		ImageTransparency = 1,
		Size = UDim2.fromScale(1, 1),
		ZIndex = 2,

		Events = {
			MouseEnter = function(self)
				local tween = wax.shared.tweenService:Create(
					self.Parent,
					wax.shared.defaultTween,
					{ BackgroundColor3 = Color3.fromRGB(53, 55, 58) }
				)
				tween:Play()
			end,

			MouseLeave = function(self)
				local tween = wax.shared.tweenService:Create(
					self.Parent,
					wax.shared.defaultTween,
					{ BackgroundColor3 = Color3.fromRGB(43, 45, 48) }
				)
				tween:Play()
			end,

			MouseButton1Click = function(self)
				if selected[1] == nil then
					return
				end

				require(script.Parent.Scanner).start(selected)
			end,
		},
	},
})

return {}
