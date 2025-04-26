local JeraldUi = {}

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

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

function JeraldUi:DraggingEnabled(frame, parent)
    parent = parent or frame
    local dragging = false
    local dragInput, mousePos, framePos

    local function startDrag(input)
        dragging = true
        mousePos = input.Position
        framePos = parent.Position
    end

    local function endDrag()
        dragging = false
    end

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            startDrag(input)
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    endDrag()
                end
            end)
        end
    end)

    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
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
local storedPosition = UDim2.new(0.35, 0, 0.3, 0) -- Default position

function JeraldUi:ToggleUI()
    if game.CoreGui[uiName].Enabled then
        game.CoreGui[uiName].Enabled = false
    else
        game.CoreGui[uiName].Enabled = true
    end
end

function JeraldUi.CreateLib(title, themeName)
    title = title or "Jerald UI"
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
    local HideButton = Instance.new("TextButton")
    local UnhideButton = Instance.new("TextButton")
    local TabContainer = Instance.new("Frame")
    local Tabs = Instance.new("ScrollingFrame")
    local TabList = Instance.new("UIListLayout")
    local Pages = Instance.new("Frame")

    ScreenGui.Name = uiName
    ScreenGui.Parent = game.CoreGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.ResetOnSpawn = false

    Main.Name = "Main"
    Main.Parent = ScreenGui
    Main.BackgroundColor3 = theme.Background
    Main.Position = storedPosition
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

    HideButton.Name = "HideButton"
    HideButton.Parent = Header
    HideButton.BackgroundColor3 = theme.Element
    HideButton.Position = UDim2.new(0.85, 0, 0.1, 0)
    HideButton.Size = UDim2.new(0, 20, 0, 20)
    HideButton.Font = Enum.Font.GothamBold
    HideButton.Text = "-"
    HideButton.TextColor3 = theme.Text
    HideButton.TextSize = 14
    local HideCorner = Instance.new("UICorner")
    HideCorner.CornerRadius = UDim.new(0, 4)
    HideCorner.Parent = HideButton

    UnhideButton.Name = "UnhideButton"
    UnhideButton.Parent = ScreenGui
    UnhideButton.BackgroundColor3 = theme.Element
    UnhideButton.Position = storedPosition
    UnhideButton.Size = UDim2.new(0, 30, 0, 30)
    UnhideButton.Font = Enum.Font.GothamBold
    UnhideButton.Text = "+"
    UnhideButton.TextColor3 = theme.Text
    UnhideButton.TextSize = 14
    UnhideButton.Visible = false
    local UnhideCorner = Instance.new("UICorner")
    UnhideCorner.CornerRadius = UDim.new(0, 4)
    UnhideCorner.Parent = UnhideButton

    HideButton.MouseButton1Click:Connect(function()
        storedPosition = Main.Position
        TweenObject(Main, {Size = UDim2.new(0, 0, 0, 0)}, 0.2)
        Main.Visible = false
        UnhideButton.Position = storedPosition
        UnhideButton.Visible = true
    end)

    UnhideButton.MouseButton1Click:Connect(function()
        Main.Position = storedPosition
        Main.Visible = true
        TweenObject(Main, {Size = UDim2.new(0, 400, 0, 300)}, 0.2)
        UnhideButton.Visible = false
    end)

    JeraldUi:DraggingEnabled(HideButton, Main)
    JeraldUi:DraggingEnabled(UnhideButton, UnhideButton)
    JeraldUi:DraggingEnabled(Header, Main)

    -- Update storedPosition when Main is dragged
    Main:GetPropertyChangedSignal("Position"):Connect(function()
        if Main.Visible then
            storedPosition = Main.Position
        end
    end)

    TabContainer.Name = "TabContainer"
    TabContainer.Parent = Main
    TabContainer.BackgroundTransparency = 1
    TabContainer.Position = UDim2.new(0, 0, 0.1, 0)
    TabContainer.Size = UDim2.new(1, 0, 0, 30)

    Tabs.Name = "Tabs"
    Tabs.Parent = TabContainer
    Tabs.BackgroundTransparency = 1
    Tabs.Position = UDim2.new(0, 0, 0, 0)
    Tabs.Size = UDim2.new(1, 0, 1, 0)
    Tabs.CanvasSize = UDim2.new(0, 0, 0, 0)
    Tabs.ScrollBarThickness = 4
    Tabs.ScrollBarImageColor3 = theme.Accent
    Tabs.ScrollingDirection = Enum.ScrollingDirection.X
    Tabs.ClipsDescendants = true

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

    local function UpdateTabCanvasSize()
        Tabs.CanvasSize = UDim2.new(0, TabList.AbsoluteContentSize.X + 10, 0, 0)
    end

    TabList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(UpdateTabCanvasSize)

    local TabsAPI = {}
    local firstTab = true

    function TabsAPI:NewTab(tabName)
        tabName = tabName or "Tab"
        local TabButton = Instance.new("TextButton")
        local TextContainer = Instance.new("Frame")
        local TabText = Instance.new("TextLabel")
        local Page = Instance.new("ScrollingFrame")
        local PageList = Instance.new("UIListLayout")

        TabButton.Name = tabName .. "Button"
        TabButton.Parent = Tabs
        TabButton.BackgroundColor3 = theme.Element
        TabButton.Size = UDim2.new(0, 100, 0, 25)
        TabButton.Font = Enum.Font.SourceSans
        TabButton.Text = ""
        TabButton.TextColor3 = theme.Text
        TabButton.TextSize = 12
        TabButton.AutoButtonColor = false
        TabButton.BackgroundTransparency = firstTab and 0 or 0.5

        local TabCorner = Instance.new("UICorner")
        TabCorner.CornerRadius = UDim.new(0, 4)
        TabCorner.Parent = TabButton

        TextContainer.Name = "TextContainer"
        TextContainer.Parent = TabButton
        TextContainer.BackgroundTransparency = 1
        TextContainer.Size = UDim2.new(1, -10, 1, 0)
        TextContainer.Position = UDim2.new(0, 5, 0, 0)
        TextContainer.ClipsDescendants = true

        TabText.Name = "TabText"
        TabText.Parent = TextContainer
        TabText.BackgroundTransparency = 1
        TabText.Size = UDim2.new(0, 0, 1, 0)
        TabText.Position = UDim2.new(0, 0, 0, 0)
        TabText.Font = Enum.Font.Gotham
        TabText.Text = tabName
        TabText.TextColor3 = theme.Text
        TabText.TextSize = 12
        TabText.TextXAlignment = Enum.TextXAlignment.Left
        TabText.TextTransparency = 0

        local textBounds = TabText.TextBounds.X
        local maxWidth = TabButton.AbsoluteSize.X - 10
        if textBounds > maxWidth then
            TabText.Size = UDim2.new(0, textBounds, 1, 0)
            local function slideText()
                if TabText.Parent then
                    TweenObject(TabText, {Position = UDim2.new(0, -textBounds, 0, 0)}, 3)
                    wait(3.5)
                    TabText.Position = UDim2.new(0, maxWidth, 0, 0)
                    TweenObject(TabText, {Position = UDim2.new(0, 0, 0, 0)}, 0.5)
                    wait(1)
                    if TabText.Parent then
                        spawn(slideText)
                    end
                end
            end
            spawn(slideText)
        else
            TabText.Size = UDim2.new(1, -10, 1, 0)
        end

        Page.Name = tabName .. "Page"
        Page.Parent = Pages
        Page.BackgroundTransparency = 1
        Page.Size = UDim2.new(1, -10, 1, -10)
        Page.Position = UDim2.new(0, 5, 0, 5)
        Page.CanvasSize = UDim2.new(0, 0, 0, 0)
        Page.ScrollBarThickness = 4
        Page.ScrollBarImageColor3 = theme.Accent
        Page.Visible = firstTab

        PageList.Name = "PageList"
        PageList.Parent = Page
        PageList.SortOrder = Enum.SortOrder.LayoutOrder
        PageList.Padding = UDim.new(0, 5)

        local function UpdateCanvasSize()
            Page.CanvasSize = UDim2.new(0, 0, 0, PageList.AbsoluteContentSize.Y + 10)
            UpdateTabCanvasSize()
        end

        PageList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(UpdateCanvasSize)

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
            UpdateCanvasSize()
        end)

        if firstTab then
            firstTab = false
        end

        local SectionsAPI = {}

        function SectionsAPI:NewSection(sectionName)
            sectionName = sectionName or "Section"
            local SectionFrame = Instance.new("Frame")
            local SectionList = Instance.new("UIListLayout")
            local TextContainer = Instance.new("Frame")
            local SectionText = Instance.new("TextLabel")

            SectionFrame.Name = sectionName
            SectionFrame.Parent = Page
            SectionFrame.BackgroundTransparency = 1
            SectionFrame.Size = UDim2.new(1, 0, 0, 30)

            SectionList.Name = "SectionList"
            SectionList.Parent = SectionFrame
            SectionList.SortOrder = Enum.SortOrder.LayoutOrder
            SectionList.Padding = UDim.new(0, 5)

            TextContainer.Name = "TextContainer"
            TextContainer.Parent = SectionFrame
            TextContainer.BackgroundTransparency = 1
            TextContainer.Size = UDim2.new(1, -10, 0, 20)
            TextContainer.Position = UDim2.new(0, 5, 0, 0)
            TextContainer.ClipsDescendants = true

            SectionText.Name = "SectionText"
            SectionText.Parent = TextContainer
            SectionText.BackgroundTransparency = 1
            SectionText.Size = UDim2.new(0, 0, 1, 0)
            SectionText.Position = UDim2.new(0, 0, 0, 0)
            SectionText.Font = Enum.Font.GothamBold
            SectionText.Text = sectionName
            SectionText.TextColor3 = theme.Accent
            SectionText.TextSize = 14
            SectionText.TextXAlignment = Enum.TextXAlignment.Left
            SectionText.TextTransparency = 0

            local textBounds = SectionText.TextBounds.X
            local maxWidth = SectionFrame.AbsoluteSize.X - 10
            if textBounds > maxWidth then
                SectionText.Size = UDim2.new(0, textBounds, 1, 0)
                local function slideText()
                    if SectionText.Parent then
                        TweenObject(SectionText, {Position = UDim2.new(0, -textBounds, 0, 0)}, 3)
                        wait(3.5)
                        SectionText.Position = UDim2.new(0, maxWidth, 0, 0)
                        TweenObject(SectionText, {Position = UDim2.new(0, 0, 0, 0)}, 0.5)
                        wait(1)
                        if SectionText.Parent then
                            spawn(slideText)
                        end
                    end
                end
                spawn(slideText)
            else
                SectionText.Size = UDim2.new(1, -10, 1, 0)
            end

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

return JeraldUi
