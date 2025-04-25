local SimpleUi = {}

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local function TweenObject(obj, properties, duration)
    TweenService:Create(obj, TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), properties):Play()
end

local theme = {
    Background = Color3.fromRGB(30, 30, 35),
    Accent = Color3.fromRGB(100, 100, 255),
    Text = Color3.fromRGB(220, 220, 220),
    Element = Color3.fromRGB(40, 40, 45),
    Border = Color3.fromRGB(50, 50, 55)
}

function SimpleUi:DraggingEnabled(frame, parent)
    parent = parent or frame
    local dragging = false
    local dragInput, mousePos, framePos

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            mousePos = input.Position
            framePos = parent.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - mousePos
            parent.Position = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)
        end
    end)
end

local uiName = tostring(math.random(1, 100)) .. tostring(math.random(1, 50))

function SimpleUi:ToggleUI()
    if game.CoreGui[uiName].Enabled then
        game.CoreGui[uiName].Enabled = false
    else
        game.CoreGui[uiName].Enabled = true
    end
end

function SimpleUi.CreateLib(title, themeName)
    title = title or "Simple UI"
    for _, v in pairs(game.CoreGui:GetChildren()) do
        if v:IsA("ScreenGui") and v.Name == title then
            v:Destroy()
        end
    end

    local ScreenGui = Instance.new("ScreenGui")
    local Main = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local Header = Instance.new("Frame")
    local HeaderCorner = Instance.new("UICorner")
    local Title = Instance.new("TextLabel")
    local Close = Instance.new("TextButton")
    local Tabs = Instance.new("Frame")
    local TabList = Instance.new("UIListLayout")
    local Pages = Instance.new("Frame")

    ScreenGui.Name = uiName
    ScreenGui.Parent = game.CoreGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.ResetOnSpawn = false

    Main.Name = "Main"
    Main.Parent = ScreenGui
    Main.BackgroundColor3 = theme.Background
    Main.Position = UDim2.new(0.35, 0, 0.3, 0)
    Main.Size = UDim2.new(0, 400, 0, 300)
    Main.ClipsDescendants = true

    UICorner.CornerRadius = UDim.new(0, 6)
    UICorner.Parent = Main

    Header.Name = "Header"
    Header.Parent = Main
    Header.BackgroundColor3 = theme.Background
    Header.Size = UDim2.new(1, 0, 0, 30)
    Header.BorderSizePixel = 0

    HeaderCorner.CornerRadius = UDim.new(0, 6)
    HeaderCorner.Parent = Header

    Title.Name = "Title"
    Title.Parent = Header
    Title.BackgroundTransparency = 1
    Title.Position = UDim2.new(0.03, 0, 0, 0)
    Title.Size = UDim2.new(0.5, 0, 1, 0)
    Title.Font = Enum.Font.GothamBold
    Title.Text = title
    Title.TextColor3 = theme.Text
    Title.TextSize = 14
    Title.TextXAlignment = Enum.TextXAlignment.Left

    Close.Name = "Close"
    Close.Parent = Header
    Close.BackgroundTransparency = 1
    Close.Position = UDim2.new(0.93, 0, 0.1, 0)
    Close.Size = UDim2.new(0, 20, 0, 20)
    Close.Font = Enum.Font.GothamBold
    Close.Text = "X"
    Close.TextColor3 = theme.Text
    Close.TextSize = 14
    Close.MouseButton1Click:Connect(function()
        TweenObject(Main, {Size = UDim2.new(0, 0, 0, 0)}, 0.2)
        wait(0.2)
        ScreenGui:Destroy()
    end)

    Tabs.Name = "Tabs"
    Tabs.Parent = Main
    Tabs.BackgroundTransparency = 1
    Tabs.Position = UDim2.new(0, 0, 0.1, 0)
    Tabs.Size = UDim2.new(1, 0, 0, 30)

    TabList.Name = "TabList"
    TabList.Parent = Tabs
    TabList.FillDirection = Enum.FillDirection.Horizontal
    TabList.SortOrder = Enum.SortOrder.LayoutOrder
    TabList.Padding = UDim.new(0, 5)

    Pages.Name = "Pages"
    Pages.Parent = Main
    Pages.BackgroundTransparency = 1
    Pages.Position = UDim2.new(0, 0, 0.2, 0)
    Pages.Size = UDim2.new(1, 0, 0.8, 0)

    SimpleUi:DraggingEnabled(Header, Main)

    local TabsAPI = {}

    function TabsAPI:NewTab(tabName)
        tabName = tabName or "Tab"
        local TabButton = Instance.new("TextButton")
        local Page = Instance.new("ScrollingFrame")
        local PageList = Instance.new("UIListLayout")
        local first = true

        TabButton.Name = tabName .. "Button"
        TabButton.Parent = Tabs
        TabButton.BackgroundColor3 = theme.Element
        TabButton.Size = UDim2.new(0, 100, 0, 25)
        TabButton.Font = Enum.Font.Gotham
        TabButton.Text = tabName
        TabButton.TextColor3 = theme.Text
        TabButton.TextSize = 12
        TabButton.AutoButtonColor = false
        TabButton.BackgroundTransparency = 0.5

        local TabCorner = Instance.new("UICorner")
        TabCorner.CornerRadius = UDim.new(0, 4)
        TabCorner.Parent = TabButton

        Page.Name = tabName .. "Page"
        Page.Parent = Pages
        Page.BackgroundTransparency = 1
        Page.Size = UDim2.new(1, -10, 1, -10)
        Page.Position = UDim2.new(0, 5, 0, 5)
        Page.CanvasSize = UDim2.new(0, 0, 0, 0)
        Page.ScrollBarThickness = 4
        Page.ScrollBarImageColor3 = theme.Accent
        Page.Visible = false

        PageList.Name = "PageList"
        PageList.Parent = Page
        PageList.SortOrder = Enum.SortOrder.LayoutOrder
        PageList.Padding = UDim.new(0, 5)

        local function UpdateCanvasSize()
            Page.CanvasSize = UDim2.new(0, 0, 0, PageList.AbsoluteContentSize.Y + 10)
        end

        PageList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(UpdateCanvasSize)

        if first then
            first = false
            Page.Visible = true
            TabButton.BackgroundTransparency = 0
        end

        TabButton.MouseButton1Click:Connect(function()
            for _, v in pairs(Pages:GetChildren()) do
                v.Visible = false
            end
            Page.Visible = true
            for _, v in pairs(Tabs:GetChildren()) do
                if v:IsA("TextButton") then
                    TweenObject(v, {BackgroundTransparency = 0.5}, 0.2)
                end
            end
            TweenObject(TabButton, {BackgroundTransparency = 0}, 0.2)
        end)

        local SectionsAPI = {}

        function SectionsAPI:NewSection(sectionName)
            sectionName = sectionName or "Section"
            local SectionFrame = Instance.new("Frame")
            local SectionList = Instance.new("UIListLayout")
            local SectionTitle = Instance.new("TextLabel")

            SectionFrame.Name = sectionName
            SectionFrame.Parent = Page
            SectionFrame.BackgroundTransparency = 1
            SectionFrame.Size = UDim2.new(1, 0, 0, 30)

            SectionList.Name = "SectionList"
            SectionList.Parent = SectionFrame
            SectionList.SortOrder = Enum.SortOrder.LayoutOrder
            SectionList.Padding = UDim.new(0, 5)

            SectionTitle.Name = "SectionTitle"
            SectionTitle.Parent = SectionFrame
            SectionTitle.BackgroundTransparency = 1
            SectionTitle.Size = UDim2.new(1, 0, 0, 20)
            SectionTitle.Font = Enum.Font.GothamBold
            SectionTitle.Text = sectionName
            SectionTitle.TextColor3 = theme.Accent
            SectionTitle.TextSize = 14
            SectionTitle.TextXAlignment = Enum.TextXAlignment.Left

            local function UpdateSectionSize()
                SectionFrame.Size = UDim2.new(1, 0, 0, SectionList.AbsoluteContentSize.Y + 25)
                UpdateCanvasSize()
            end

            SectionList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(UpdateSectionSize)

            local ElementsAPI = {}

            function ElementsAPI:NewButton(buttonName, info, callback)
                buttonName = buttonName or "Button"
                info = info or "Click to execute"
                callback = callback or function() end

                local Button = Instance.new("TextButton")
                local ButtonCorner = Instance.new("UICorner")
                local ButtonText = Instance.new("TextLabel")

                Button.Name = buttonName
                Button.Parent = SectionFrame
                Button.BackgroundColor3 = theme.Element
                Button.Size = UDim2.new(1, -10, 0, 30)
                Button.Position = UDim2.new(0, 5, 0, 0)
                Button.Font = Enum.Font.SourceSans
                Button.Text = ""
                Button.TextColor3 = theme.Text
                Button.TextSize = 14
                Button.AutoButtonColor = false

                ButtonCorner.CornerRadius = UDim.new(0, 4)
                ButtonCorner.Parent = Button

                ButtonText.Name = "ButtonText"
                ButtonText.Parent = Button
                ButtonText.BackgroundTransparency = 1
                ButtonText.Size = UDim2.new(1, -10, 1, 0)
                ButtonText.Position = UDim2.new(0, 5, 0, 0)
                ButtonText.Font = Enum.Font.Gotham
                ButtonText.Text = buttonName
                ButtonText.TextColor3 = theme.Text
                ButtonText.TextSize = 14
                ButtonText.TextXAlignment = Enum.TextXAlignment.Left

                Button.MouseButton1Click:Connect(function()
                    pcall(callback)
                    TweenObject(Button, {BackgroundColor3 = theme.Accent}, 0.1)
                    wait(0.1)
                    TweenObject(Button, {BackgroundColor3 = theme.Element}, 0.1)
                end)

                Button.MouseEnter:Connect(function()
                    TweenObject(Button, {BackgroundColor3 = Color3.fromRGB(theme.Element.r * 255 + 10, theme.Element.g * 255 + 10, theme.Element.b * 255 + 10)}, 0.1)
                end)

                Button.MouseLeave:Connect(function()
                    TweenObject(Button, {BackgroundColor3 = theme.Element}, 0.1)
                end)

                UpdateSectionSize()
            end

            return ElementsAPI
        end

        return SectionsAPI
    end

    return TabsAPI
end

return SimpleUi
