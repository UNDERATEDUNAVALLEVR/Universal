local Kavo = {}
local tween = game:GetService("TweenService")
local tweeninfo = TweenInfo.new
local input = game:GetService("UserInputService")
local run = game:GetService("RunService")

local Utility = {}
local Objects = {}

-- Dragging Function (Fixed for Mobile)
function Kavo:DraggingEnabled(frame, parent)
    parent = parent or frame
    local dragging = false
    local dragInput, mousePos, framePos

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            mousePos = input.Position
            framePos = parent.Position

            local connection
            connection = input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                    connection:Disconnect()
                end
            end)
        end
    end)

    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    input.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - mousePos
            parent.Position = UDim2.new(
                framePos.X.Scale,
                framePos.X.Offset + delta.X,
                framePos.Y.Scale,
                framePos.Y.Offset + delta.Y
            )
        end
    end)
end

-- Utility Tween Function
function Utility:TweenObject(obj, properties, duration, ...)
    tween:Create(obj, tweeninfo(duration, ...), properties):Play()
end

-- Themes
local themes = {
    SchemeColor = Color3.fromRGB(74, 99, 135),
    Background = Color3.fromRGB(36, 37, 43),
    Header = Color3.fromRGB(28, 29, 34),
    TextColor = Color3.fromRGB(255, 255, 255),
    ElementColor = Color3.fromRGB(32, 32, 38)
}

local themeStyles = {
    DarkTheme = {
        SchemeColor = Color3.fromRGB(64, 64, 64),
        Background = Color3.fromRGB(0, 0, 0),
        Header = Color3.fromRGB(0, 0, 0),
        TextColor = Color3.fromRGB(255, 255, 255),
        ElementColor = Color3.fromRGB(20, 20, 20)
    },
    LightTheme = {
        SchemeColor = Color3.fromRGB(150, 150, 150),
        Background = Color3.fromRGB(255, 255, 255),
        Header = Color3.fromRGB(200, 200, 200),
        TextColor = Color3.fromRGB(0, 0, 0),
        ElementColor = Color3.fromRGB(224, 224, 224)
    }
}

-- Create Library
function Kavo.CreateLib(kavName, themeList)
    themeList = themeList or "DarkTheme"
    if type(themeList) == "string" then
        themeList = themeStyles[themeList] or themes
    end

    kavName = kavName or "Kavo Library"
    for _, v in pairs(game.CoreGui:GetChildren()) do
        if v:IsA("ScreenGui") and v.Name == kavName then
            v:Destroy()
        end
    end

    local ScreenGui = Instance.new("ScreenGui")
    local Main = Instance.new("Frame")
    local MainCorner = Instance.new("UICorner")
    local MainHeader = Instance.new("Frame")
    local headerCover = Instance.new("UICorner")
    local coverup = Instance.new("Frame")
    local title = Instance.new("TextLabel")
    local close = Instance.new("ImageButton")
    local MainSide = Instance.new("Frame")
    local sideCorner = Instance.new("UICorner")
    local coverup_2 = Instance.new("Frame")
    local tabFrames = Instance.new("Frame")
    local tabListing = Instance.new("UIListLayout")
    local pages = Instance.new("Frame")
    local Pages = Instance.new("Folder")

    ScreenGui.Parent = game.CoreGui
    ScreenGui.Name = kavName
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.ResetOnSpawn = false

    Main.Name = "Main"
    Main.Parent = ScreenGui
    Main.BackgroundColor3 = themeList.Background
    Main.ClipsDescendants = true
    Main.Position = UDim2.new(0.336503863, 0, 0.275485456, 0)
    Main.Size = UDim2.new(0, 525, 0, 318)

    MainCorner.CornerRadius = UDim.new(0, 4)
    MainCorner.Name = "MainCorner"
    MainCorner.Parent = Main

    MainHeader.Name = "MainHeader"
    MainHeader.Parent = Main
    MainHeader.BackgroundColor3 = themeList.Header
    MainHeader.Size = UDim2.new(0, 525, 0, 29)

    headerCover.CornerRadius = UDim.new(0, 4)
    headerCover.Name = "headerCover"
    headerCover.Parent = MainHeader

    coverup.Name = "coverup"
    coverup.Parent = MainHeader
    coverup.BackgroundColor3 = themeList.Header
    coverup.BorderSizePixel = 0
    coverup.Position = UDim2.new(0, 0, 0.758620679, 0)
    coverup.Size = UDim2.new(0, 525, 0, 7)

    title.Name = "title"
    title.Parent = MainHeader
    title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    title.BackgroundTransparency = 1.000
    title.Position = UDim2.new(0.0171428565, 0, 0, 0)
    title.Size = UDim2.new(0, 204, 0, 29)
    title.Font = Enum.Font.Gotham
    title.Text = kavName
    title.TextColor3 = themeList.TextColor
    title.TextSize = 14.000
    title.TextXAlignment = Enum.TextXAlignment.Left

    close.Name = "close"
    close.Parent = MainHeader
    close.BackgroundTransparency = 1.000
    close.Position = UDim2.new(0.951428592, 0, 0.137931034, 0)
    close.Size = UDim2.new(0, 22, 0, 22)
    close.Image = "rbxassetid://3926305904"
    close.ImageRectOffset = Vector2.new(284, 4)
    close.ImageRectSize = Vector2.new(24, 24)
    close.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    MainSide.Name = "MainSide"
    MainSide.Parent = Main
    MainSide.BackgroundColor3 = themeList.Header
    MainSide.Position = UDim2.new(-0.000190999999, 0, 0.0911949687, 0)
    MainSide.Size = UDim2.new(0, 149, 0, 289)

    sideCorner.CornerRadius = UDim.new(0, 4)
    sideCorner.Name = "sideCorner"
    sideCorner.Parent = MainSide

    coverup_2.Name = "coverup"
    coverup_2.Parent = MainSide
    coverup_2.BackgroundColor3 = themeList.Header
    coverup_2.BorderSizePixel = 0
    coverup_2.Position = UDim2.new(0.791946053, 0, 0, 0)
    coverup_2.Size = UDim2.new(0, 31, 0, 289)

    tabFrames.Name = "tabFrames"
    tabFrames.Parent = MainSide
    tabFrames.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    tabFrames.BackgroundTransparency = 1.000
    tabFrames.Position = UDim2.new(0.0438990258, 0, -0.00066378375, 0)
    tabFrames.Size = UDim2.new(0, 135, 0, 283)

    tabListing.Name = "tabListing"
    tabListing.Parent = tabFrames
    tabListing.SortOrder = Enum.SortOrder.LayoutOrder

    pages.Name = "pages"
    pages.Parent = Main
    pages.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    pages.BackgroundTransparency = 1.000
    pages.BorderSizePixel = 0
    pages.Position = UDim2.new(0.299047589, 0, 0.122641519, 0)
    pages.Size = UDim2.new(0, 360, 0, 269)

    Pages.Name = "Pages"
    Pages.Parent = pages

    Kavo:DraggingEnabled(MainHeader, Main)

    coroutine.wrap(function()
        while wait() do
            Main.BackgroundColor3 = themeList.Background
            MainHeader.BackgroundColor3 = themeList.Header
            MainSide.BackgroundColor3 = themeList.Header
            coverup_2.BackgroundColor3 = themeList.Header
            coverup.BackgroundColor3 = themeList.Header
            title.TextColor3 = themeList.TextColor
        end
    end)()

    local Tabs = {}
    local selectedTab = nil

    function Kavo:ToggleUI()
        ScreenGui.Enabled = not ScreenGui.Enabled
    end

    function Tabs:NewTab(tabName)
        tabName = tabName or "Tab"
        local tabButton = Instance.new("TextButton")
        local tabFrame = Instance.new("ScrollingFrame")
        local tabList = Instance.new("UIListLayout")

        tabButton.Name = tabName
        tabButton.Parent = tabFrames
        tabButton.BackgroundColor3 = themeList.ElementColor
        tabButton.Size = UDim2.new(0, 135, 0, 28)
        tabButton.Font = Enum.Font.Gotham
        tabButton.Text = tabName
        tabButton.TextColor3 = themeList.TextColor
        tabButton.TextSize = 14.000

        tabFrame.Name = tabName
        tabFrame.Parent = Pages
        tabFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        tabFrame.BackgroundTransparency = 1.000
        tabFrame.BorderSizePixel = 0
        tabFrame.Size = UDim2.new(0, 360, 0, 269)
        tabFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
        tabFrame.ScrollBarThickness = 3
        tabFrame.Visible = false

        tabList.Name = "tabList"
        tabList.Parent = tabFrame
        tabList.SortOrder = Enum.SortOrder.LayoutOrder
        tabList.Padding = UDim.new(0, 3)

        tabButton.MouseButton1Click:Connect(function()
            for _, v in pairs(Pages:GetChildren()) do
                v.Visible = false
            end
            tabFrame.Visible = true
            selectedTab = tabFrame
        end)

        if not selectedTab then
            tabFrame.Visible = true
            selectedTab = tabFrame
        end

        local Sections = {}
        function Sections:NewSection(sectionName)
            sectionName = sectionName or "Section"
            local sectionFrame = Instance.new("Frame")
            local sectionInner = Instance.new("Frame")
            local sectionList = Instance.new("UIListLayout")
            local sectionTitle = Instance.new("TextLabel")
            local sectionCorner = Instance.new("UICorner")

            sectionFrame.Name = sectionName
            sectionFrame.Parent = tabFrame
            sectionFrame.BackgroundColor3 = themeList.ElementColor
            sectionFrame.Size = UDim2.new(0, 352, 0, 33)

            sectionInner.Name = "sectionInner"
            sectionInner.Parent = sectionFrame
            sectionInner.BackgroundColor3 = themeList.ElementColor
            sectionInner.Size = UDim2.new(0, 352, 0, 33)

            sectionList.Name = "sectionList"
            sectionList.Parent = sectionInner
            sectionList.SortOrder = Enum.SortOrder.LayoutOrder
            sectionList.Padding = UDim.new(0, 3)

            sectionTitle.Name = "sectionTitle"
            sectionTitle.Parent = sectionFrame
            sectionTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            sectionTitle.BackgroundTransparency = 1.000
            sectionTitle.Position = UDim2.new(0.0170454532, 0, 0, 0)
            sectionTitle.Size = UDim2.new(0, 340, 0, 33)
            sectionTitle.Font = Enum.Font.Gotham
            sectionTitle.Text = sectionName
            sectionTitle.TextColor3 = themeList.TextColor
            sectionTitle.TextSize = 14.000
            sectionTitle.TextXAlignment = Enum.TextXAlignment.Left

            sectionCorner.CornerRadius = UDim.new(0, 4)
            sectionCorner.Name = "sectionCorner"
            sectionCorner.Parent = sectionFrame

            local function updateSize()
                local contentSize = sectionList.AbsoluteContentSize
                sectionFrame.Size = UDim2.new(0, 352, 0, contentSize.Y + 10)
                sectionInner.Size = UDim2.new(0, 352, 0, contentSize.Y + 10)
                tabFrame.CanvasSize = UDim2.new(0, 0, 0, tabList.AbsoluteContentSize.Y + 10)
            end

            sectionList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateSize)

            local Elements = {}
            function Elements:NewButton(buttonText, buttonInfo, callback)
                buttonText = buttonText or "Button"
                buttonInfo = buttonInfo or ""
                callback = callback or function() end

                local buttonFrame = Instance.new("Frame")
                local button = Instance.new("TextButton")
                local buttonCorner = Instance.new("UICorner")
                local buttonInfoLabel = Instance.new("TextLabel")

                buttonFrame.Name = buttonText
                buttonFrame.Parent = sectionInner
                buttonFrame.BackgroundColor3 = themeList.ElementColor
                buttonFrame.Size = UDim2.new(0, 352, 0, 33)

                button.Name = "button"
                button.Parent = buttonFrame
                button.BackgroundColor3 = themeList.SchemeColor
                button.Size = UDim2.new(0, 344, 0, 25)
                button.Position = UDim2.new(0, 4, 0, 4)
                button.Font = Enum.Font.Gotham
                button.Text = buttonText
                button.TextColor3 = themeList.TextColor
                button.TextSize = 14.000

                buttonCorner.CornerRadius = UDim.new(0, 4)
                buttonCorner.Name = "buttonCorner"
                buttonCorner.Parent = button

                buttonInfoLabel.Name = "buttonInfo"
                buttonInfoLabel.Parent = buttonFrame
                buttonInfoLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                buttonInfoLabel.BackgroundTransparency = 1.000
                buttonInfoLabel.Position = UDim2.new(0, 4, 0, 18)
                buttonInfoLabel.Size = UDim2.new(0, 344, 0, 15)
                buttonInfoLabel.Font = Enum.Font.Gotham
                buttonInfoLabel.Text = buttonInfo
                buttonInfoLabel.TextColor3 = themeList.TextColor
                buttonInfoLabel.TextSize = 12.000
                buttonInfoLabel.TextTransparency = 0.5
                buttonInfoLabel.TextXAlignment = Enum.TextXAlignment.Left

                button.MouseButton1Click:Connect(function()
                    pcall(callback)
                end)

                updateSize()
                return button
            end

            function Elements:NewToggle(toggleText, toggleInfo, callback)
                toggleText = toggleText or "Toggle"
                toggleInfo = toggleInfo or ""
                callback = callback or function() end

                local toggleFrame = Instance.new("Frame")
                local toggleButton = Instance.new("TextButton")
                local toggleCorner = Instance.new("UICorner")
                local toggleInfoLabel = Instance.new("TextLabel")
                local toggleIndicator = Instance.new("Frame")
                local indicatorCorner = Instance.new("UICorner")

                toggleFrame.Name = toggleText
                toggleFrame.Parent = sectionInner
                toggleFrame.BackgroundColor3 = themeList.ElementColor
                toggleFrame.Size = UDim2.new(0, 352, 0, 33)

                toggleButton.Name = "toggle"
                toggleButton.Parent = toggleFrame
                toggleButton.BackgroundColor3 = themeList.SchemeColor
                toggleButton.Size = UDim2.new(0, 344, 0, 25)
                toggleButton.Position = UDim2.new(0, 4, 0, 4)
                toggleButton.Font = Enum.Font.Gotham
                toggleButton.Text = toggleText
                toggleButton.TextColor3 = themeList.TextColor
                toggleButton.TextSize = 14.000

                toggleCorner.CornerRadius = UDim.new(0, 4)
                toggleCorner.Name = "toggleCorner"
                toggleCorner.Parent = toggleButton

                toggleInfoLabel.Name = "toggleInfo"
                toggleInfoLabel.Parent = toggleFrame
                toggleInfoLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                toggleInfoLabel.BackgroundTransparency = 1.000
                toggleInfoLabel.Position = UDim2.new(0, 4, 0, 18)
                toggleInfoLabel.Size = UDim2.new(0, 344, 0, 15)
                toggleInfoLabel.Font = Enum.Font.Gotham
                toggleInfoLabel.Text = toggleInfo
                toggleInfoLabel.TextColor3 = themeList.TextColor
                toggleInfoLabel.TextSize = 12.000
                toggleInfoLabel.TextTransparency = 0.5
                toggleInfoLabel.TextXAlignment = Enum.TextXAlignment.Left

                toggleIndicator.Name = "indicator"
                toggleIndicator.Parent = toggleButton
                toggleIndicator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                toggleIndicator.Position = UDim2.new(0, 310, 0, 4)
                toggleIndicator.Size = UDim2.new(0, 30, 0, 17)

                indicatorCorner.CornerRadius = UDim.new(0, 4)
                indicatorCorner.Name = "indicatorCorner"
                indicatorCorner.Parent = toggleIndicator

                local toggled = false
                toggleButton.MouseButton1Click:Connect(function()
                    toggled = not toggled
                    toggleIndicator.BackgroundColor3 = toggled and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 255, 255)
                    pcall(callback, toggled)
                end)

                updateSize()
                return toggleButton
            end

            return Elements
        end
        return Sections
    end
    return Tabs
end

return Kavo
