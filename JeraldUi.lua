
local JeraldUi = {}

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local function TweenObject(obj, properties, duration)
    TweenService:Create(obj, TweenInfo.new(duration, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), properties):Play()
end

local themes = {
    DarkTheme = {
        Background = Color3.fromRGB(30, 30, 35),
        Accent = Color3.fromRGB(100, 100, 255),
        Text = Color3.fromRGB(220, 220, 220),
        Element = Color3.fromRGB(40, 40, 45),
        Border = Color3.fromRGB(50, 50, 55)
    },
    RedTheme = {
        Background = Color3.fromRGB(35, 25, 25),
        Accent = Color3.fromRGB(255, 80, 80),
        Text = Color3.fromRGB(230, 200, 200),
        Element = Color3.fromRGB(50, 30, 30),
        Border = Color3.fromRGB(60, 40, 40)
    },
    BlueTheme = {
        Background = Color3.fromRGB(25, 30, 35),
        Accent = Color3.fromRGB(80, 120, 255),
        Text = Color3.fromRGB(200, 210, 230),
        Element = Color3.fromRGB(30, 40, 50),
        Border = Color3.fromRGB(40, 50, 60)
    },
    GreenTheme = {
        Background = Color3.fromRGB(25, 35, 30),
        Accent = Color3.fromRGB(80, 255, 120),
        Text = Color3.fromRGB(200, 230, 210),
        Element = Color3.fromRGB(30, 50, 40),
        Border = Color3.fromRGB(40, 60, 50)
    },
    PurpleTheme = {
        Background = Color3.fromRGB(30, 25, 35),
        Accent = Color3.fromRGB(180, 80, 255),
        Text = Color3.fromRGB(220, 200, 230),
        Element = Color3.fromRGB(40, 30, 50),
        Border = Color3.fromRGB(50, 40, 60)
    },
    OrangeTheme = {
        Background = Color3.fromRGB(35, 30, 25),
        Accent = Color3.fromRGB(255, 150, 80),
        Text = Color3.fromRGB(230, 210, 200),
        Element = Color3.fromRGB(50, 40, 30),
        Border = Color3.fromRGB(60, 50, 40)
    },
    CyanTheme = {
        Background = Color3.fromRGB(25, 35, 35),
        Accent = Color3.fromRGB(80, 255, 255),
        Text = Color3.fromRGB(200, 230, 230),
        Element = Color3.fromRGB(30, 50, 50),
        Border = Color3.fromRGB(40, 60, 60)
    },
    PinkTheme = {
        Background = Color3.fromRGB(35, 25, 35),
        Accent = Color3.fromRGB(255, 100, 180),
        Text = Color3.fromRGB(230, 200, 220),
        Element = Color3.fromRGB(50, 30, 50),
        Border = Color3.fromRGB(60, 40, 60)
    }
}

function JeraldUi.CreateLib(title, themeName)
    title = title or "Jerald UI"
    themeName = themeName or "DarkTheme"
    local theme = themes[themeName] or themes.DarkTheme

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Parent = game.CoreGui
    ScreenGui.ResetOnSpawn = false

    local Main = Instance.new("Frame")
    Main.Parent = ScreenGui
    Main.Size = UDim2.new(0, 400, 0, 300)
    Main.Position = UDim2.new(0.3, 0, 0.3, 0)
    Main.BackgroundColor3 = theme.Background

    local TabsAPI = {}

    function TabsAPI:NewTab(tabName)
        local Page = Instance.new("ScrollingFrame")
        Page.Parent = Main

        local SectionsAPI = {}

        function SectionsAPI:NewSection(sectionName)
            local SectionFrame = Instance.new("Frame")
            SectionFrame.Parent = Page

            local UIList = Instance.new("UIListLayout")
            UIList.Parent = SectionFrame

            local function UpdateSectionSize()
                SectionFrame.Size = UDim2.new(1, 0, 0, UIList.AbsoluteContentSize.Y + 5)
            end

            UIList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(UpdateSectionSize)

            local ElementsAPI = {}

            function ElementsAPI:NewButton(buttonName, info, callback)
                local Button = Instance.new("TextButton")
                Button.Parent = SectionFrame
                Button.Size = UDim2.new(1, -10, 0, 30)
                Button.Position = UDim2.new(0, 5, 0, 0)
                Button.BackgroundColor3 = theme.Element
                Button.Text = buttonName or "Button"
                Button.MouseButton1Click:Connect(function()
                    pcall(callback)
                end)
                UpdateSectionSize()
            end

            function ElementsAPI:NewDestroyButton(buttonName, info, callback)
                local Button = Instance.new("TextButton")
                Button.Parent = SectionFrame
                Button.Size = UDim2.new(1, -10, 0, 30)
                Button.Position = UDim2.new(0, 5, 0, 0)
                Button.BackgroundColor3 = theme.Element
                Button.Text = buttonName or "Destroy"
                Button.MouseButton1Click:Connect(function()
                    pcall(callback)
                    ScreenGui:Destroy()
                end)
                UpdateSectionSize()
            end

            -- ✅ YOUR NEW TOGGLE BUTTON (PLACED CORRECTLY)
            function ElementsAPI:NewToggleButton(buttonName, onLink, offLink)
                buttonName = buttonName or "Toggle Button"

                local Button = Instance.new("TextButton")
                local ButtonCorner = Instance.new("UICorner")
                local ButtonText = Instance.new("TextLabel")
                local toggled = false

                Button.Name = buttonName
                Button.Parent = SectionFrame
                Button.BackgroundColor3 = theme.Element
                Button.Size = UDim2.new(1, -10, 0, 30)
                Button.Position = UDim2.new(0, 5, 0, 0)
                Button.Text = ""
                Button.AutoButtonColor = false

                ButtonCorner.CornerRadius = UDim.new(0, 4)
                ButtonCorner.Parent = Button

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
                    toggled = not toggled
                    if toggled then
                        TweenObject(Button, {BackgroundColor3 = theme.Accent}, 0.2)
                        if onLink then loadstring(game:HttpGet(onLink))() end
                    else
                        TweenObject(Button, {BackgroundColor3 = theme.Element}, 0.2)
                        if offLink then loadstring(game:HttpGet(offLink))() end
                    end
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
