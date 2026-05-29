wax.shared.gui.main.container:Destroy()

local tween = wax.shared.tweenService:Create(
	wax.shared.gui.main,
	TweenInfo.new(0.5, Enum.EasingStyle.Exponential),
	{ Size = UDim2.fromOffset(300, 200) }
)

tween:Play()

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
		TextSize = 23,
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
			CanvasSize = UDim2.new(1, 0, 0, 0),

			[1] = {
				className = "UICorner",
				Name = "corner",
				CornerRadius = UDim.new(0, 12),
			},
		},
	},
})

return {}
