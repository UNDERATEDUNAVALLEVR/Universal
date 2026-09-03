--[[
    Modified UI Library
    Mobile Supported | Cleaned & Optimized
--]]

local Library = {}

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")

local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local TweenStandard = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)
local LibName = "UI_" .. tostring(math.random(100000, 999999))

function Library:DraggingEnabled(frame, parent)
	parent = parent or frame
	local dragging = false
	local dragStart, startPos

	frame.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = parent.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			local delta = input.Position - dragStart
			parent.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		end
	end)
end

function Library:tween(object, goal, callback)
	local anim = TweenService:Create(object, TweenStandard, goal)
	if callback then
		anim.Completed:Connect(callback)
	end
	anim:Play()
	return anim
end

function Library:ToggleUI()
	local ui = CoreGui:FindFirstChild(LibName)
	if ui then
		ui.Enabled = not ui.Enabled
	end
end

function Library:DestroyUI()
	local ui = CoreGui:FindFirstChild(LibName)
	if ui then
		ui:Destroy()
	end
end

function Library:Create(TitleText)
	TitleText = TitleText or "Untitled"

	local UILibrary = Instance.new("ScreenGui")
	local Main = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local TopBar = Instance.new("Frame")
	local UICorner_2 = Instance.new("UICorner")
	local Extension = Instance.new("Frame")
	local Title = Instance.new("TextLabel")
	local UIPadding = Instance.new("UIPadding")
	local Close = Instance.new("ImageButton")
	local Line = Instance.new("Frame")
	local DropShadowHolder = Instance.new("Frame")
	local DropShadow = Instance.new("ImageLabel")
	local Navigation = Instance.new("Frame")
	local UICorner_3 = Instance.new("UICorner")
	local Hide = Instance.new("Frame")
	local Hide2 = Instance.new("Frame")
	local ButtonHolder = Instance.new("Frame")
	local UIPadding_2 = Instance.new("UIPadding")
	local UIListLayout = Instance.new("UIListLayout")
	local Line_2 = Instance.new("Frame")
	local ContentContainer = Instance.new("Frame")
	local TabsFolder = Instance.new("Folder")

	Library:DraggingEnabled(TopBar, Main)

	UILibrary.Name = LibName
	UILibrary.Parent = CoreGui
	UILibrary.ResetOnSpawn = false

	Main.Name = "Main"
	Main.Parent = UILibrary
	Main.AnchorPoint = Vector2.new(0.5, 0.5)
	Main.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	Main.Position = UDim2.new(0.5, 0, 0.5, 0)
	Main.Size = UDim2.new(0, 400, 0, 228)

	UICorner.CornerRadius = UDim.new(0, 6)
	UICorner.Parent = Main

	TopBar.Name = "TopBar"
	TopBar.Parent = Main
	TopBar.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
	TopBar.Size = UDim2.new(1, 0, 0, 30)

	UICorner_2.CornerRadius = UDim.new(0, 6)
	UICorner_2.Parent = TopBar

	Extension.Name = "Extension"
	Extension.Parent = TopBar
	Extension.AnchorPoint = Vector2.new(0, 1)
	Extension.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
	Extension.BorderSizePixel = 0
	Extension.Position = UDim2.new(0, 0, 1, 0)
	Extension.Size = UDim2.new(1, 0, 0.5, 0)

	Title.Name = "Title"
	Title.Parent = TopBar
	Title.BackgroundTransparency = 1
	Title.Size = UDim2.new(0.5, 0, 1, 0)
	Title.Font = Enum.Font.Gotham
	Title.Text = TitleText
	Title.TextColor3 = Color3.fromRGB(255, 255, 255)
	Title.TextSize = 14
	Title.TextXAlignment = Enum.TextXAlignment.Left

	UIPadding.Parent = Title
	UIPadding.PaddingLeft = UDim.new(0, 8)

	Close.Name = "Close"
	Close.Parent = TopBar
	Close.AnchorPoint = Vector2.new(1, 0.5)
	Close.BackgroundTransparency = 1
	Close.Position = UDim2.new(1, -8, 0.5, 0)
	Close.Size = UDim2.new(0, 14, 0, 14)
	Close.Image = "rbxassetid://10884453403"
	Close.MouseButton1Click:Connect(function()
		TweenService:Create(Close, TweenInfo.new(0.1), {ImageTransparency = 1}):Play()
		TweenService:Create(Main, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
			Size = UDim2.new(0, 0, 0, 0)
		}):Play()
		task.wait(0.2)
		Library:DestroyUI()
	end)

	Line.Name = "Line"
	Line.Parent = TopBar
	Line.AnchorPoint = Vector2.new(0, 1)
	Line.BackgroundColor3 = Color3.fromRGB(81, 81, 81)
	Line.BorderSizePixel = 0
	Line.Position = UDim2.new(0, 0, 1, 0)
	Line.Size = UDim2.new(1, 0, 0, 1)

	DropShadowHolder.Name = "DropShadowHolder"
	DropShadowHolder.Parent = Main
	DropShadowHolder.BackgroundTransparency = 1
	DropShadowHolder.Size = UDim2.new(1, 0, 1, 0)
	DropShadowHolder.ZIndex = 0

	DropShadow.Name = "DropShadow"
	DropShadow.Parent = DropShadowHolder
	DropShadow.AnchorPoint = Vector2.new(0.5, 0.5)
	DropShadow.BackgroundTransparency = 1
	DropShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
	DropShadow.Size = UDim2.new(1, 44, 1, 44)
	DropShadow.ZIndex = 0
	DropShadow.Image = "rbxassetid://6015897843"
	DropShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
	DropShadow.ImageTransparency = 0.5
	DropShadow.ScaleType = Enum.ScaleType.Slice
	DropShadow.SliceCenter = Rect.new(49, 49, 450, 450)

	Navigation.Name = "Navigation"
	Navigation.Parent = Main
	Navigation.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	Navigation.BorderSizePixel = 0
	Navigation.Position = UDim2.new(0, 0, 0, 30)
	Navigation.Size = UDim2.new(0, 120, 1, -30)

	UICorner_3.CornerRadius = UDim.new(0, 6)
	UICorner_3.Parent = Navigation

	Hide.Name = "Hide"
	Hide.Parent = Navigation
	Hide.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	Hide.BorderSizePixel = 0
	Hide.Size = UDim2.new(1, 0, 0, 20)

	Hide2.Name = "Hide2"
	Hide2.Parent = Navigation
	Hide2.AnchorPoint = Vector2.new(1, 0)
	Hide2.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	Hide2.BorderSizePixel = 0
	Hide2.Position = UDim2.new(1, 0, 0, 0)
	Hide2.Size = UDim2.new(0, 20, 1, 0)

	ButtonHolder.Name = "ButtonHolder"
	ButtonHolder.Parent = Navigation
	ButtonHolder.BackgroundTransparency = 1
	ButtonHolder.Size = UDim2.new(1, 0, 1, 0)

	UIPadding_2.Parent = ButtonHolder
	UIPadding_2.PaddingBottom = UDim.new(0, 8)
	UIPadding_2.PaddingTop = UDim.new(0, 8)

	UIListLayout.Parent = ButtonHolder
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 1)

	Line_2.Name = "Line"
	Line_2.Parent = Navigation
	Line_2.BackgroundColor3 = Color3.fromRGB(81, 81, 81)
	Line_2.BorderSizePixel = 0
	Line_2.Position = UDim2.new(1, 0, 0, 0)
	Line_2.Size = UDim2.new(0, 1, 1, 0)

	ContentContainer.Name = "ContentContainer"
	ContentContainer.Parent = Main
	ContentContainer.AnchorPoint = Vector2.new(1, 0)
	ContentContainer.BackgroundTransparency = 1
	ContentContainer.Position = UDim2.new(1, -6, 0, 36)
	ContentContainer.Size = UDim2.new(1, -133, 1, -42)

	TabsFolder.Name = "TabsFolder"
	TabsFolder.Parent = ContentContainer

	local Tabs = {}
	local first = true

	function Tabs:Tab(TabText, TabIcon)
		TabText = TabText or "Untitled"
		TabIcon = TabIcon or ""

		local Active = Instance.new("TextButton")
		local UIPadding_3 = Instance.new("UIPadding")
		local Icon = Instance.new("ImageLabel")
		local NewTab = Instance.new("ScrollingFrame")
		local UIPadding_5 = Instance.new("UIPadding")
		local UIListLayout_2 = Instance.new("UIListLayout")

		Active.Name = TabText .. "_TabButton"
		Active.Parent = ButtonHolder
		Active.BackgroundTransparency = 1
		Active.BorderSizePixel = 0
		Active.Size = UDim2.new(1, 0, 0, 28)
		Active.Font = Enum.Font.Ubuntu
		Active.Text = TabText
		Active.TextColor3 = Color3.fromRGB(199, 199, 199)
		Active.TextSize = 12
		Active.TextXAlignment = Enum.TextXAlignment.Left

		UIPadding_3.Parent = Active
		UIPadding_3.PaddingLeft = UDim.new(0, 28)

		Icon.Name = "Icon"
		Icon.Parent = Active
		Icon.AnchorPoint = Vector2.new(0, 0.5)
		Icon.BackgroundTransparency = 1
		Icon.Position = UDim2.new(0, -24, 0.5, 0)
		Icon.Size = UDim2.new(0, 20, 0, 20)
		Icon.Image = TabIcon

		NewTab.Name = "NewTab"
		NewTab.Parent = TabsFolder
		NewTab.BackgroundTransparency = 1
		NewTab.BorderSizePixel = 0
		NewTab.Size = UDim2.new(1, 0, 1, 0)
		NewTab.AutomaticCanvasSize = Enum.AutomaticSize.Y
		NewTab.CanvasSize = UDim2.new(0, 0, 0, 0)
		NewTab.ScrollBarThickness = 0
		NewTab.Visible = false

		UIPadding_5.Parent = NewTab
		UIPadding_5.PaddingBottom = UDim.new(0, 1)
		UIPadding_5.PaddingLeft = UDim.new(0, 1)
		UIPadding_5.PaddingRight = UDim.new(0, 1)
		UIPadding_5.PaddingTop = UDim.new(0, 1)

		UIListLayout_2.Parent = NewTab
		UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout_2.Padding = UDim.new(0, 6)

		if first then
			first = false
			NewTab.Visible = true
			Active.BackgroundTransparency = 0.9
			Active.TextColor3 = Color3.fromRGB(255, 255, 255)
		end

		Active.MouseButton1Click:Connect(function()
			for _, v in ipairs(TabsFolder:GetChildren()) do
				v.Visible = false
			end
			NewTab.Visible = true

			for _, v in ipairs(ButtonHolder:GetChildren()) do
				if v:IsA("TextButton") then
					TweenService:Create(v, TweenStandard, {BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(199, 199, 199)}):Play()
					local btnIcon = v:FindFirstChild("Icon")
					if btnIcon then
						TweenService:Create(btnIcon, TweenStandard, {ImageColor3 = Color3.fromRGB(199, 199, 199)}):Play()
					end
				end
			end
			TweenService:Create(Active, TweenStandard, {BackgroundTransparency = 0.9, TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
			TweenService:Create(Icon, TweenStandard, {ImageColor3 = Color3.fromRGB(255, 255, 255)}):Play()
		end)

		local Elements = {}

		local function createRipple(btn)
			local sample = Instance.new("ImageLabel")
			sample.Name = "Sample"
			sample.BackgroundTransparency = 1
			sample.Image = "http://www.roblox.com/asset/?id=4560909609"
			sample.ImageColor3 = Color3.fromRGB(0, 0, 0)
			sample.ImageTransparency = 0.6
			sample.Parent = btn

			local x, y = (Mouse.X - sample.AbsolutePosition.X), (Mouse.Y - sample.AbsolutePosition.Y)
			sample.Position = UDim2.new(0, x, 0, y)
			local size = math.max(btn.AbsoluteSize.X, btn.AbsoluteSize.Y) * 1.5

			sample:TweenSizeAndPosition(UDim2.new(0, size, 0, size), UDim2.new(0.5, -size / 2, 0.5, -size / 2), "Out", "Quad", 0.35, true)
			TweenService:Create(sample, TweenInfo.new(0.35), {ImageTransparency = 1}):Play()
			task.delay(0.35, function()
				sample:Destroy()
			end)
		end

		function Elements:Button(ButtonName, callback)
			ButtonName = ButtonName or "Button"
			callback = callback or function() end

			local Button = Instance.new("TextButton")
			local UICorner_4 = Instance.new("UICorner")
			local Title_2 = Instance.new("TextLabel")
			local UIPadding_5 = Instance.new("UIPadding")
			local UIStroke = Instance.new("UIStroke")

			Button.Name = "Button"
			Button.Parent = NewTab
			Button.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
			Button.ClipsDescendants = true
			Button.Size = UDim2.new(1, 0, 0, 32)
			Button.AutoButtonColor = false
			Button.Text = ""

			UICorner_4.CornerRadius = UDim.new(0, 4)
			UICorner_4.Parent = Button

			Title_2.Name = "Title"
			Title_2.Parent = Button
			Title_2.BackgroundTransparency = 1
			Title_2.Size = UDim2.new(1, -20, 1, 0)
			Title_2.Font = Enum.Font.Ubuntu
			Title_2.Text = ButtonName
			Title_2.TextColor3 = Color3.fromRGB(255, 255, 255)
			Title_2.TextSize = 14
			Title_2.TextXAlignment = Enum.TextXAlignment.Left

			UIPadding_5.Parent = Button
			UIPadding_5.PaddingLeft = UDim.new(0, 6)

			UIStroke.Parent = Button
			UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			UIStroke.Color = Color3.fromRGB(81, 81, 81)

			Button.MouseButton1Click:Connect(function()
				createRipple(Button)
				pcall(callback)
			end)

			Button.MouseEnter:Connect(function()
				TweenService:Create(Button, TweenStandard, {BackgroundColor3 = Color3.fromRGB(54, 54, 54)}):Play()
				TweenService:Create(UIStroke, TweenStandard, {Color = Color3.fromRGB(162, 162, 162)}):Play()
			end)

			Button.MouseLeave:Connect(function()
				TweenService:Create(Button, TweenStandard, {BackgroundColor3 = Color3.fromRGB(26, 26, 26)}):Play()
				TweenService:Create(UIStroke, TweenStandard, {Color = Color3.fromRGB(81, 81, 81)}):Play()
			end)
		end

		function Elements:TextBox(TextBoxTitle, callback)
			TextBoxTitle = TextBoxTitle or "TextBox"
			callback = callback or function() end

			local TextBoxHolder = Instance.new("Frame")
			local UICorner_34 = Instance.new("UICorner")
			local Title_12 = Instance.new("TextLabel")
			local UIPadding_20 = Instance.new("UIPadding")
			local UIStroke_9 = Instance.new("UIStroke")
			local InputBox = Instance.new("TextBox")
			local UICorner_35 = Instance.new("UICorner")

			TextBoxHolder.Name = "TextBox"
			TextBoxHolder.Parent = NewTab
			TextBoxHolder.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
			TextBoxHolder.Size = UDim2.new(1, 0, 0, 32)

			UICorner_34.CornerRadius = UDim.new(0, 4)
			UICorner_34.Parent = TextBoxHolder

			Title_12.Name = "Title"
			Title_12.Parent = TextBoxHolder
			Title_12.BackgroundTransparency = 1
			Title_12.Size = UDim2.new(0.65, 0, 1, 0)
			Title_12.Font = Enum.Font.Ubuntu
			Title_12.Text = TextBoxTitle
			Title_12.TextColor3 = Color3.fromRGB(255, 255, 255)
			Title_12.TextSize = 14
			Title_12.TextXAlignment = Enum.TextXAlignment.Left

			UIPadding_20.Parent = TextBoxHolder
			UIPadding_20.PaddingLeft = UDim.new(0, 6)

			UIStroke_9.Parent = TextBoxHolder
			UIStroke_9.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			UIStroke_9.Color = Color3.fromRGB(81, 81, 81)

			InputBox.Parent = TextBoxHolder
			InputBox.BackgroundColor3 = Color3.fromRGB(72, 72, 72)
			InputBox.AnchorPoint = Vector2.new(1, 0.5)
			InputBox.Position = UDim2.new(1, -6, 0.5, 0)
			InputBox.Size = UDim2.new(0, 80, 0, 20)
			InputBox.ClearTextOnFocus = false
			InputBox.Font = Enum.Font.Ubuntu
			InputBox.PlaceholderText = "Type..."
			InputBox.Text = ""
			InputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
			InputBox.TextSize = 12

			UICorner_35.CornerRadius = UDim.new(0, 4)
			UICorner_35.Parent = InputBox

			InputBox.FocusLost:Connect(function(enterPressed)
				if enterPressed then
					pcall(callback, InputBox.Text)
					InputBox.Text = ""
				end
			end)
		end

		function Elements:Toggle(ToggleName, callback)
			ToggleName = ToggleName or "Toggle"
			callback = callback or function() end

			local Toggle = Instance.new("TextButton")
			local UICorner_8 = Instance.new("UICorner")
			local Title_6 = Instance.new("TextLabel")
			local CheckmarkHolder = Instance.new("Frame")
			local UICorner_9 = Instance.new("UICorner")
			local UIStroke_2 = Instance.new("UIStroke")
			local UIStroke_3 = Instance.new("UIStroke")

			Toggle.Name = "Toggle"
			Toggle.Parent = NewTab
			Toggle.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
			Toggle.Size = UDim2.new(1, 0, 0, 32)
			Toggle.AutoButtonColor = false
			Toggle.Text = ""

			UICorner_8.CornerRadius = UDim.new(0, 4)
			UICorner_8.Parent = Toggle

			Title_6.Name = "Title"
			Title_6.Parent = Toggle
			Title_6.BackgroundTransparency = 1
			Title_6.Position = UDim2.new(0, 6, 0, 0)
			Title_6.Size = UDim2.new(1, -30, 1, 0)
			Title_6.Font = Enum.Font.Ubuntu
			Title_6.Text = ToggleName
			Title_6.TextColor3 = Color3.fromRGB(255, 255, 255)
			Title_6.TextSize = 14
			Title_6.TextXAlignment = Enum.TextXAlignment.Left

			UIStroke_2.Parent = Toggle
			UIStroke_2.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			UIStroke_2.Color = Color3.fromRGB(81, 81, 81)

			CheckmarkHolder.Name = "CheckmarkHolder"
			CheckmarkHolder.Parent = Toggle
			CheckmarkHolder.AnchorPoint = Vector2.new(1, 0.5)
			CheckmarkHolder.BackgroundColor3 = Color3.fromRGB(63, 63, 63)
			CheckmarkHolder.Position = UDim2.new(1, -6, 0.5, 0)
			CheckmarkHolder.Size = UDim2.new(0, 16, 0, 16)

			UICorner_9.CornerRadius = UDim.new(0, 2)
			UICorner_9.Parent = CheckmarkHolder

			UIStroke_3.Parent = CheckmarkHolder
			UIStroke_3.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			UIStroke_3.Color = Color3.fromRGB(81, 81, 81)

			local toggled = false
			Toggle.MouseButton1Click:Connect(function()
				toggled = not toggled
				createRipple(Toggle)

				local targetBg = toggled and Color3.fromRGB(115, 191, 92) or Color3.fromRGB(63, 63, 63)
				local targetStroke = toggled and Color3.fromRGB(0, 255, 59) or Color3.fromRGB(81, 81, 81)

				TweenService:Create(CheckmarkHolder, TweenStandard, {BackgroundColor3 = targetBg}):Play()
				TweenService:Create(UIStroke_3, TweenStandard, {Color = targetStroke}):Play()

				pcall(callback, toggled)
			end)
		end

		function Elements:Slider(SliderTitle, minvalue, maxvalue, callback)
			SliderTitle = SliderTitle or "Slider"
			minvalue = minvalue or 0
			maxvalue = maxvalue or 100
			callback = callback or function() end

			local Slider = Instance.new("Frame")
			local UICorner_12 = Instance.new("UICorner")
			local UIStroke_4 = Instance.new("UIStroke")
			local Title_8 = Instance.new("TextLabel")
			local Valuee = Instance.new("TextLabel")
			local SliderButton = Instance.new("TextButton")
			local SliderInner = Instance.new("Frame")
			local UICorner_13 = Instance.new("UICorner")

			Slider.Name = "Slider"
			Slider.Parent = NewTab
			Slider.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
			Slider.Size = UDim2.new(1, 0, 0, 38)

			UICorner_12.CornerRadius = UDim.new(0, 4)
			UICorner_12.Parent = Slider

			UIStroke_4.Parent = Slider
			UIStroke_4.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			UIStroke_4.Color = Color3.fromRGB(81, 81, 81)

			Title_8.Name = "Title"
			Title_8.Parent = Slider
			Title_8.BackgroundTransparency = 1
			Title_8.Position = UDim2.new(0, 6, 0, 4)
			Title_8.Size = UDim2.new(0.7, 0, 0, 16)
			Title_8.Font = Enum.Font.Ubuntu
			Title_8.Text = SliderTitle
			Title_8.TextColor3 = Color3.fromRGB(255, 255, 255)
			Title_8.TextSize = 14
			Title_8.TextXAlignment = Enum.TextXAlignment.Left

			Valuee.Name = "Value"
			Valuee.Parent = Slider
			Valuee.BackgroundTransparency = 1
			Valuee.Position = UDim2.new(0.7, 0, 0, 4)
			Valuee.Size = UDim2.new(0.3, -6, 0, 16)
			Valuee.Font = Enum.Font.Ubuntu
			Valuee.Text = tostring(minvalue)
			Valuee.TextColor3 = Color3.fromRGB(255, 255, 255)
			Valuee.TextSize = 14
			Valuee.TextXAlignment = Enum.TextXAlignment.Right

			SliderButton.Name = "SliderButton"
			SliderButton.Parent = Slider
			SliderButton.BackgroundTransparency = 1
			SliderButton.Position = UDim2.new(0, 6, 0.7, 0)
			SliderButton.Size = UDim2.new(1, -12, 0, 6)
			SliderButton.Text = ""

			SliderInner.Name = "SliderInner"
			SliderInner.Parent = SliderButton
			SliderInner.BackgroundColor3 = Color3.fromRGB(115, 191, 92)
			SliderInner.Size = UDim2.new(0, 0, 1, 0)

			UICorner_13.CornerRadius = UDim.new(0, 4)
			UICorner_13.Parent = SliderInner

			local dragging = false

			local function updateSlider(input)
				local sizeX = math.clamp((input.Position.X - SliderButton.AbsolutePosition.X) / SliderButton.AbsoluteSize.X, 0, 1)
				SliderInner.Size = UDim2.new(sizeX, 0, 1, 0)

				local val = math.floor(minvalue + (maxvalue - minvalue) * sizeX)
				Valuee.Text = tostring(val)
				pcall(callback, val)
			end

			SliderButton.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					dragging = true
					updateSlider(input)
				end
			end)

			UserInputService.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					dragging = false
				end
			end)

			UserInputService.InputChanged:Connect(function(input)
				if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
					updateSlider(input)
				end
			end)
		end

		return Elements
	end
	return Tabs
end

return Library
