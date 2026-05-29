local UI = {}

wax.shared.defaultFont = 12187365364
wax.shared.defaultTween = TweenInfo.new(0.25, Enum.EasingStyle.Exponential)

wax.shared.gui = nil

wax.shared.getFont = function(weight: Enum.FontWeight)
	return Font.fromId(wax.shared.defaultFont, weight, Enum.FontStyle.Normal)
end

local function dragify(frame: Frame)
	local dragToggle = nil
	local dragSpeed = 0.25
	local dragStart = nil
	local startPos = nil

	local function updateInput(input)
		local delta = input.Position - dragStart
		local position =
			UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		wax.shared.tweenService:Create(frame, TweenInfo.new(dragSpeed), { Position = position }):Play()
	end

	frame.InputBegan:Connect(function(input)
		if
			input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch
		then
			dragToggle = true
			dragStart = input.Position
			startPos = frame.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragToggle = false
				end
			end)
		end
	end)

	wax.shared.userInputService.InputChanged:Connect(function(input)
		if
			input.UserInputType == Enum.UserInputType.MouseMovement
			or input.UserInputType == Enum.UserInputType.Touch
		then
			if dragToggle then
				updateInput(input)
			end
		end
	end)
end

UI.Init = function()
	wax.shared.gui = wax.shared.create("ScreenGui", {
		Name = wax.shared.httpService:GenerateGUID(false),
		DisplayOrder = 100000,
		IgnoreGuiInset = true,
		ResetOnSpawn = false,
		ZIndexBehavior = Enum.ZIndexBehavior.Global,
		Parent = wax.shared.gethui(),

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
					FontFace = wax.shared.getFont(Enum.FontWeight.SemiBold),
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
							FontFace = wax.shared.getFont(Enum.FontWeight.Medium),
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

					[6] = {
						className = "ImageButton",
						Name = "click",
						BorderSizePixel = 0,
						BackgroundTransparency = 1,
						ImageTransparency = 1,
						Size = UDim2.fromScale(1, 1),

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

							MouseButton1Click = function()
								require(script.Parent.Menu)
							end,
						},
					},
				},
			},
		},
	})

	dragify(wax.shared.gui.main)
end

return UI
