local UI = {}

local utils = require(script.Parent.Utils)
local defaultFont = 12187365364

local function getFont(weight: Enum.FontWeight)
	return Font.fromId(defaultFont, weight, Enum.FontStyle.Normal)
end

UI.Init = function()
	utils.create("ScreenGui", {
		Name = utils.httpService:GenerateGUID(false),
		DisplayOrder = 100000,
		IgnoreGuiInset = true,
		ResetOnSpawn = false,
		ZIndexBehavior = Enum.ZIndexBehavior.Global,
		Parent = utils.gethui(),

		[1] = {
			className = "Frame",
			Name = "main",
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			BorderSizePixel = 0,
			BackgroundColor3 = Color3.fromRGB(30, 31, 34),
			Size = UDim2.fromOffset(200, 80),
			ZIndex = 0,

			[1] = {
				className = "UICorner",
				Name = "corner",
				CornerRadius = UDim.new(0, 12),
			},

			[2] = {
				className = "UIStroke",
				Name = "stroke",
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				Color = Color3.fromRGB(49, 50, 53),
				Thickness = 1,
			},

			[3] = {
				className = "Frame",
				Name = "container",
				Size = UDim2.fromScale(0.85, 0.85),
				BorderSizePixel = 0,
				BackgroundTransparency = 1,
				Position = UDim2.fromScale(0.5, 0.5),
				AnchorPoint = Vector2.new(0.5, 0.5),
				ZIndex = 2,

				[1] = {
					className = "TextLabel",
					Name = "title",
					FontFace = getFont(Enum.FontWeight.SemiBold),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Size = UDim2.new(1, 0, 0, 35),
					TextColor3 = Color3.fromRGB(223, 225, 229),
					TextSize = 23,
					Text = "Server Scanner",
					ZIndex = 2,
				},

				[2] = {
					className = "Frame",
					Name = "continue",
					BorderSizePixel = 0,
					BackgroundColor3 = Color3.fromRGB(43, 45, 48),
					Size = UDim2.new(0, 90, 0, 25),
					AnchorPoint = Vector2.new(0.5, 0),
					Position = UDim2.new(0.5, 0, 1, -30),
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
							FontFace = getFont(Enum.FontWeight.Medium),
							Text = "Continue",
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
						Image = "rbxassetid://109000112978694",
						ZIndex = 2,
					},
				},
			},
		},
	})
end

return UI
