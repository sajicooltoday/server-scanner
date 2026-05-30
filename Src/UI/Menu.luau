wax.shared.gui.main.container:Destroy()

local methods = {}

wax.shared.create("Frame", {
	className = "Frame",
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
		Text = "Method Selection",
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
})

local tween = wax.shared.tweenService:Create(
	wax.shared.gui.main,
	TweenInfo.new(0.5, Enum.EasingStyle.Exponential),
	{ Size = UDim2.fromOffset(300, 200) }
)

tween:Play()

for i, v in pairs(script.Parent.Parent.Methods:GetChildren()) do
	table.insert(methods, v.Name)
end

for i, method in pairs(methods) do
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
					local tween = wax.shared.tweenService:Create(
						self,
						wax.shared.defaultTween,
						{ BackgroundColor3 = Color3.fromRGB(55, 55, 55) }
					)

					tween:Play()
				end,

				MouseLeave = function(self)
					local tween = wax.shared.tweenService:Create(
						self,
						wax.shared.defaultTween,
						{ BackgroundColor3 = Color3.fromRGB(50, 50, 50) }
					)

					tween:Play()
				end,
			},

			[1] = {
				className = "UICorner",
				Name = "corner",
				CornerRadius = UDim.new(0, 12),
			},
		},

		[2] = {
			className = "TextLabel",
			Name = "title",
			Text = method,
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
		},
	},
})

return {}
