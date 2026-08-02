-- ==========================================
-- IKGONAVI HUB - UI LIBRARY MODULE
-- ==========================================
local Library = {}

local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local Theme = {
    MainBg = Color3.fromRGB(10, 10, 14),
    CardBg = Color3.fromRGB(15, 15, 22),
    Accent = Color3.fromRGB(130, 80, 255),
    TabActive = Color3.fromRGB(35, 22, 60),
    TextWhite = Color3.fromRGB(250, 250, 255),
    TextGray = Color3.fromRGB(140, 140, 165),
    Border = Color3.fromRGB(45, 35, 70),
    ToggleOff = Color3.fromRGB(40, 35, 55),
    FontMain = Enum.Font.GothamMedium,
    FontBold = Enum.Font.GothamBold
}

local Icons = {
    Dashboard = "rbxassetid://6023426915",
    Combat = "rbxassetid://6035047409",
    Visuals = "rbxassetid://6028481358",
    Settings = "rbxassetid://6034287593",
    Close = "rbxassetid://6031094678",
    Warning = "rbxassetid://6034818372",
    Shield = "rbxassetid://6031302932"
}

local function Tween(obj, props, info)
    local tweenInfo = info or TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
    local tween = TweenService:Create(obj, tweenInfo, props)
    tween:Play()
    return tween
end

function Library:CreateWindow(config)
    local windowName = config.Name or "IKGHUB"
    local subtitleText = config.Subtitle or "Shield Active • Custom Library"

    if CoreGui:FindFirstChild("IKGHUB") then
        CoreGui:FindFirstChild("IKGHUB"):Destroy()
    end

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "IKGHUB"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    pcall(function() ScreenGui.Parent = CoreGui end)
    if not ScreenGui.Parent then ScreenGui.Parent = PlayerGui end

    -- Sistema de Notificaciones integrado
    local NotificationHolder = Instance.new("Frame")
    NotificationHolder.Size = UDim2.new(0, 300, 1, -40)
    NotificationHolder.Position = UDim2.new(1, -320, 0, 20)
    NotificationHolder.BackgroundTransparency = 1
    NotificationHolder.Parent = ScreenGui

    local NotifLayout = Instance.new("UIListLayout")
    NotifLayout.SortOrder = Enum.SortOrder.LayoutOrder
    NotifLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
    NotifLayout.Padding = UDim.new(0, 10)
    NotifLayout.Parent = NotificationHolder

    function Library:Notify(title, message, duration)
        duration = duration or 3
        local NotifCard = Instance.new("Frame")
        NotifCard.Size = UDim2.new(1, 0, 0, 70)
        NotifCard.BackgroundColor3 = Theme.CardBg
        NotifCard.BackgroundTransparency = 0.1
        NotifCard.Position = UDim2.new(1, 50, 0, 0)
        NotifCard.Parent = NotificationHolder
        
        Instance.new("UICorner", NotifCard).CornerRadius = UDim.new(0, 8)
        local stroke = Instance.new("UIStroke", NotifCard)
        stroke.Color = Theme.Accent
        stroke.Transparency = 0.5
        
        local Icon = Instance.new("ImageLabel")
        Icon.Size = UDim2.new(0, 24, 0, 24)
        Icon.Position = UDim2.new(0, 12, 0, 12)
        Icon.BackgroundTransparency = 1
        Icon.Image = Icons.Warning
        Icon.ImageColor3 = Theme.Accent
        Icon.Parent = NotifCard
        
        local TitleLbl = Instance.new("TextLabel")
        TitleLbl.Size = UDim2.new(1, -50, 0, 20)
        TitleLbl.Position = UDim2.new(0, 44, 0, 12)
        TitleLbl.BackgroundTransparency = 1
        TitleLbl.Text = title
        TitleLbl.TextColor3 = Theme.TextWhite
        TitleLbl.Font = Theme.FontBold
        TitleLbl.TextSize = 13
        TitleLbl.TextXAlignment = Enum.TextXAlignment.Left
        TitleLbl.Parent = NotifCard
        
        local MsgLbl = Instance.new("TextLabel")
        MsgLbl.Size = UDim2.new(1, -50, 0, 30)
        MsgLbl.Position = UDim2.new(0, 44, 0, 32)
        MsgLbl.BackgroundTransparency = 1
        MsgLbl.Text = message
        MsgLbl.TextColor3 = Theme.TextGray
        MsgLbl.Font = Theme.FontMain
        MsgLbl.TextSize = 11
        MsgLbl.TextXAlignment = Enum.TextXAlignment.Left
        MsgLbl.TextWrapped = true
        MsgLbl.Parent = NotifCard
        
        Tween(NotifCard, {Position = UDim2.new(0, 0, 0, 0)})
        
        task.delay(duration, function()
            Tween(NotifCard, {Position = UDim2.new(1, 50, 0, 0)}, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In))
            task.wait(0.3)
            NotifCard:Destroy()
        end)
    end

    -- Marco Principal de la Interfaz
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 840, 0, 550)
    MainFrame.Position = UDim2.new(0.5, -420, 0.5, -275)
    MainFrame.BackgroundColor3 = Theme.MainBg
    MainFrame.BackgroundTransparency = 0.08
    MainFrame.BorderSizePixel = 0
    MainFrame.Active = true
    MainFrame.Parent = ScreenGui

    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)
    local MainStroke = Instance.new("UIStroke", MainFrame)
    MainStroke.Color = Theme.Border
    MainStroke.Thickness = 1.2

    -- Barra Superior
    local TopBar = Instance.new("Frame")
    TopBar.Size = UDim2.new(1, 0, 0, 60)
    TopBar.BackgroundTransparency = 1
    TopBar.Parent = MainFrame

    local HubTitle = Instance.new("TextLabel")
    HubTitle.Size = UDim2.new(0, 560, 0, 22)
    HubTitle.Position = UDim2.new(0, 20, 0, 14)
    HubTitle.BackgroundTransparency = 1
    HubTitle.Text = windowName
    HubTitle.TextColor3 = Theme.TextWhite
    HubTitle.Font = Theme.FontBold
    HubTitle.TextSize = 15
    HubTitle.TextXAlignment = Enum.TextXAlignment.Left
    HubTitle.Parent = TopBar

    local HubSubtitle = Instance.new("TextLabel")
    HubSubtitle.Size = UDim2.new(0, 560, 0, 16)
    HubSubtitle.Position = UDim2.new(0, 20, 0, 36)
    HubSubtitle.BackgroundTransparency = 1
    HubSubtitle.Text = subtitleText
    HubSubtitle.TextColor3 = Theme.Accent
    HubSubtitle.Font = Theme.FontMain
    HubSubtitle.TextSize = 11
    HubSubtitle.TextXAlignment = Enum.TextXAlignment.Left
    HubSubtitle.Parent = TopBar

    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Name = "IKGHUB"
    CloseBtn.Size = UDim2.new(0, 30, 0, 30)
    CloseBtn.Position = UDim2.new(1, -45, 0.5, -15)
    CloseBtn.BackgroundColor3 = Theme.CardBg
    CloseBtn.AutoButtonColor = false
    CloseBtn.Text = ""
    CloseBtn.Parent = TopBar
    Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 6)
    Instance.new("UIStroke", CloseBtn).Color = Theme.Border

    local CloseIcon = Instance.new("ImageLabel")
    CloseIcon.Size = UDim2.new(0, 16, 0, 16)
    CloseIcon.Position = UDim2.new(0.5, -8, 0.5, -8)
    CloseIcon.BackgroundTransparency = 1
    CloseIcon.Image = Icons.Close
    CloseIcon.ImageColor3 = Theme.Accent
    CloseIcon.Parent = CloseBtn

    CloseBtn.MouseButton1Click:Connect(function()
        Tween(MainFrame, {Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1}, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In))
        task.wait(0.3)
        ScreenGui:Destroy()
    end)

    -- Mover ventana (Draggable)
    local dragging, dragStart, startPos
    TopBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)

    -- Contenedores principales
    local Sidebar = Instance.new("ScrollingFrame")
    Sidebar.Size = UDim2.new(0, 190, 1, -80)
    Sidebar.Position = UDim2.new(0, 15, 0, 70)
    Sidebar.BackgroundTransparency = 1
    Sidebar.ScrollBarThickness = 0
    Sidebar.Parent = MainFrame

    local SidebarLayout = Instance.new("UIListLayout")
    SidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
    SidebarLayout.Padding = UDim.new(0, 6)
    SidebarLayout.Parent = Sidebar

    local ContentContainer = Instance.new("Frame")
    ContentContainer.Size = UDim2.new(1, -225, 1, -80)
    ContentContainer.Position = UDim2.new(0, 215, 0, 70)
    ContentContainer.BackgroundTransparency = 1
    ContentContainer.Parent = MainFrame

    local WindowAPI = {}
    local TabsList = {}

    function WindowAPI:AddTab(tabName, iconId)
        local TabButton = Instance.new("TextButton")
        TabButton.Size = UDim2.new(1, 0, 0, 42)
        TabButton.BackgroundColor3 = Theme.TabActive
        TabButton.BackgroundTransparency = 1
        TabButton.Text = ""
        TabButton.AutoButtonColor = false
        TabButton.Parent = Sidebar
        
        Instance.new("UICorner", TabButton).CornerRadius = UDim.new(0, 8)
        
        local TabIcon = Instance.new("ImageLabel")
        TabIcon.Size = UDim2.new(0, 18, 0, 18)
        TabIcon.Position = UDim2.new(0, 14, 0.5, -9)
        TabIcon.BackgroundTransparency = 1
        TabIcon.Image = iconId or Icons.Dashboard
        TabIcon.ImageColor3 = Theme.TextGray
        TabIcon.Parent = TabButton
        
        local TabLabelText = Instance.new("TextLabel")
        TabLabelText.Size = UDim2.new(1, -44, 1, 0)
        TabLabelText.Position = UDim2.new(0, 42, 0, 0)
        TabLabelText.BackgroundTransparency = 1
        TabLabelText.Text = tabName
        TabLabelText.TextColor3 = Theme.TextGray
        TabLabelText.Font = Theme.FontBold
        TabLabelText.TextSize = 13
        TabLabelText.TextXAlignment = Enum.TextXAlignment.Left
        TabLabelText.Parent = TabButton

        local TabPage = Instance.new("ScrollingFrame")
        TabPage.Size = UDim2.new(1, 0, 1, 0)
        TabPage.BackgroundTransparency = 1
        TabPage.ScrollBarThickness = 3
        TabPage.ScrollBarImageColor3 = Theme.Accent
        TabPage.Visible = false
        TabPage.Parent = ContentContainer
        
        local LeftCol = Instance.new("ScrollingFrame")
        LeftCol.Size = UDim2.new(0.5, -8, 1, 0)
        LeftCol.BackgroundTransparency = 1
        LeftCol.ScrollBarThickness = 0
        LeftCol.Parent = TabPage
        local LeftLayout = Instance.new("UIListLayout")
        LeftLayout.SortOrder = Enum.SortOrder.LayoutOrder
        LeftLayout.Padding = UDim.new(0, 12)
        LeftLayout.Parent = LeftCol
        
        local RightCol = Instance.new("ScrollingFrame")
        RightCol.Size = UDim2.new(0.5, -8, 1, 0)
        RightCol.Position = UDim2.new(0.5, 8, 0, 0)
        RightCol.BackgroundTransparency = 1
        RightCol.ScrollBarThickness = 0
        RightCol.Parent = TabPage
        local RightLayout = Instance.new("UIListLayout")
        RightLayout.SortOrder = Enum.SortOrder.LayoutOrder
        RightLayout.Padding = UDim.new(0, 12)
        RightLayout.Parent = RightCol
        
        local isLeft = true
        table.insert(TabsList, {Btn = TabButton, Icon = TabIcon, Label = TabLabelText, Page = TabPage})
        
        TabButton.MouseButton1Click:Connect(function()
            for _, t in ipairs(TabsList) do
                t.Page.Visible = false
                Tween(t.Btn, {BackgroundTransparency = 1})
                Tween(t.Label, {TextColor3 = Theme.TextGray})
                Tween(t.Icon, {ImageColor3 = Theme.TextGray})
            end
            TabPage.Visible = true
            Tween(TabButton, {BackgroundTransparency = 0})
            Tween(TabLabelText, {TextColor3 = Theme.TextWhite})
            Tween(TabIcon, {ImageColor3 = Theme.Accent})
        end)
        
        if #TabsList == 1 then
            TabPage.Visible = true
            TabButton.BackgroundTransparency = 0
            TabLabelText.TextColor3 = Theme.TextWhite
            TabIcon.ImageColor3 = Theme.Accent
        end
        
        local TabAPI = {}
        
        function TabAPI:AddCard(cardTitle, cardIcon)
            local TargetCol = isLeft and LeftCol or RightCol
            isLeft = not isLeft
            
            local Card = Instance.new("Frame")
            Card.Size = UDim2.new(1, 0, 0, 45)
            Card.BackgroundColor3 = Theme.CardBg
            Card.BackgroundTransparency = 0.25
            Card.Parent = TargetCol
            
            Instance.new("UICorner", Card).CornerRadius = UDim.new(0, 10)
            local CardStroke = Instance.new("UIStroke", Card)
            CardStroke.Color = Theme.Border
            
            local CardLayout = Instance.new("UIListLayout")
            CardLayout.SortOrder = Enum.SortOrder.LayoutOrder
            CardLayout.Parent = Card
            
            local Header = Instance.new("Frame")
            Header.Size = UDim2.new(1, 0, 0, 42)
            Header.BackgroundTransparency = 1
            Header.Parent = Card
            
            local ServerIcon = Instance.new("ImageLabel")
            ServerIcon.Size = UDim2.new(0, 16, 0, 16)
            ServerIcon.Position = UDim2.new(0, 14, 0.5, -8)
            ServerIcon.BackgroundTransparency = 1
            ServerIcon.Image = cardIcon or Icons.Shield
            ServerIcon.ImageColor3 = Theme.Accent
            ServerIcon.Parent = Header
            
            local TitleLabel = Instance.new("TextLabel")
            TitleLabel.Size = UDim2.new(1, -45, 1, 0)
            TitleLabel.Position = UDim2.new(0, 38, 0, 0)
            TitleLabel.BackgroundTransparency = 1
            TitleLabel.Text = cardTitle
            TitleLabel.TextColor3 = Theme.TextWhite
            TitleLabel.Font = Theme.FontBold
            TitleLabel.TextSize = 13
            TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
            TitleLabel.Parent = Header
            
            CardLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                Card.Size = UDim2.new(1, 0, 0, CardLayout.AbsoluteContentSize.Y + 10)
                TargetCol.CanvasSize = UDim2.new(0, 0, 0, TargetCol.UIListLayout.AbsoluteContentSize.Y + 20)
            end)
            
            local ElementsAPI = {}
            
            function ElementsAPI:AddLabel(text)
                local LblFrame = Instance.new("Frame")
                LblFrame.Size = UDim2.new(1, 0, 0, 26)
                LblFrame.BackgroundTransparency = 1
                LblFrame.Parent = Card
                
                local Label = Instance.new("TextLabel")
                Label.Size = UDim2.new(1, -32, 1, 0)
                Label.Position = UDim2.new(0, 16, 0, 0)
                Label.BackgroundTransparency = 1
                Label.Text = text
                Label.TextColor3 = Theme.TextGray
                Label.Font = Theme.FontMain
                Label.TextSize = 12
                Label.TextXAlignment = Enum.TextXAlignment.Left
                Label.Parent = LblFrame
                return Label
            end
            
            function ElementsAPI:AddButton(text, callback)
                local BtnFrame = Instance.new("Frame")
                BtnFrame.Size = UDim2.new(1, 0, 0, 38)
                BtnFrame.BackgroundTransparency = 1
                BtnFrame.Parent = Card
                
                local Button = Instance.new("TextButton")
                Button.Size = UDim2.new(1, -32, 0, 30)
                Button.Position = UDim2.new(0, 16, 0.5, -15)
                Button.BackgroundColor3 = Theme.ToggleOff
                Button.Text = text
                Button.TextColor3 = Theme.TextWhite
                Button.Font = Theme.FontBold
                Button.TextSize = 12
                Button.AutoButtonColor = false
                Button.Parent = BtnFrame
                Instance.new("UICorner", Button).CornerRadius = UDim.new(0, 6)
                local btnStroke = Instance.new("UIStroke", Button)
                btnStroke.Color = Theme.Border
                
                Button.MouseEnter:Connect(function() Tween(Button, {BackgroundColor3 = Theme.Accent}) end)
                Button.MouseLeave:Connect(function() Tween(Button, {BackgroundColor3 = Theme.ToggleOff}) end)
                Button.MouseButton1Click:Connect(function() if callback then pcall(callback) end end)
            end
            
            function ElementsAPI:AddToggle(text, default, callback)
                local ToggleFrame = Instance.new("Frame")
                ToggleFrame.Size = UDim2.new(1, 0, 0, 38)
                ToggleFrame.BackgroundTransparency = 1
                ToggleFrame.Parent = Card
                
                local Label = Instance.new("TextLabel")
                Label.Size = UDim2.new(1, -65, 1, 0)
                Label.Position = UDim2.new(0, 16, 0, 0)
                Label.BackgroundTransparency = 1
                Label.Text = text
                Label.TextColor3 = default and Theme.TextWhite or Theme.TextGray
                Label.Font = Theme.FontMain
                Label.TextSize = 12
                Label.TextXAlignment = Enum.TextXAlignment.Left
                Label.Parent = ToggleFrame
                
                local ToggleBtn = Instance.new("TextButton")
                ToggleBtn.Size = UDim2.new(0, 42, 0, 22)
                ToggleBtn.Position = UDim2.new(1, -55, 0.5, -11)
                ToggleBtn.BackgroundColor3 = default and Theme.Accent or Theme.ToggleOff
                ToggleBtn.Text = ""
                ToggleBtn.AutoButtonColor = false
                ToggleBtn.Parent = ToggleFrame
                Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)
                
                local Circle = Instance.new("Frame")
                Circle.Size = UDim2.new(0, 16, 0, 16)
                Circle.Position = UDim2.new(default and 1 or 0, default and -19 or 3, 0.5, -8)
                Circle.BackgroundColor3 = Theme.TextWhite
                Circle.Parent = ToggleBtn
                Instance.new("UICorner", Circle).CornerRadius = UDim.new(1, 0)
                
                local state = default
                ToggleBtn.MouseButton1Click:Connect(function()
                    state = not state
                    Tween(ToggleBtn, {BackgroundColor3 = state and Theme.Accent or Theme.ToggleOff})
                    Tween(Circle, {Position = UDim2.new(state and 1 or 0, state and -19 or 3, 0.5, -8)})
                    Tween(Label, {TextColor3 = state and Theme.TextWhite or Theme.TextGray})
                    if callback then pcall(callback, state) end
                end)
            end
            
            function ElementsAPI:AddSlider(text, default, min, max, callback)
                local SliderFrame = Instance.new("Frame")
                SliderFrame.Size = UDim2.new(1, 0, 0, 52)
                SliderFrame.BackgroundTransparency = 1
                SliderFrame.Parent = Card
                
                local Label = Instance.new("TextLabel")
                Label.Size = UDim2.new(1, -50, 0, 20)
                Label.Position = UDim2.new(0, 16, 0, 4)
                Label.BackgroundTransparency = 1
                Label.Text = text
                Label.TextColor3 = Theme.TextGray
                Label.Font = Theme.FontMain
                Label.TextSize = 12
                Label.TextXAlignment = Enum.TextXAlignment.Left
                Label.Parent = SliderFrame
                
                local ValLabel = Instance.new("TextLabel")
                ValLabel.Size = UDim2.new(0, 40, 0, 20)
                ValLabel.Position = UDim2.new(1, -55, 0, 4)
                ValLabel.BackgroundTransparency = 1
                ValLabel.Text = tostring(default)
                ValLabel.TextColor3 = Theme.TextWhite
                ValLabel.Font = Theme.FontBold
                ValLabel.TextSize = 12
                ValLabel.TextXAlignment = Enum.TextXAlignment.Right
                ValLabel.Parent = SliderFrame
                
                local TrackBtn = Instance.new("TextButton")
                TrackBtn.Size = UDim2.new(1, -32, 0, 20)
                TrackBtn.Position = UDim2.new(0, 16, 0, 26)
                TrackBtn.BackgroundTransparency = 1
                TrackBtn.Text = ""
                TrackBtn.Parent = SliderFrame
                
                local Track = Instance.new("Frame")
                Track.Size = UDim2.new(1, 0, 0, 5)
                Track.Position = UDim2.new(0, 0, 0.5, -2.5)
                Track.BackgroundColor3 = Theme.ToggleOff
                Track.Parent = TrackBtn
                Instance.new("UICorner", Track).CornerRadius = UDim.new(1, 0)
                
                local pct = math.clamp((default - min) / (max - min), 0, 1)
                local Fill = Instance.new("Frame")
                Fill.Size = UDim2.new(pct, 0, 1, 0)
                Fill.BackgroundColor3 = Theme.Accent
                Fill.Parent = Track
                Instance.new("UICorner", Fill).CornerRadius = UDim.new(1, 0)
                
                local Handle = Instance.new("Frame")
                Handle.Size = UDim2.new(0, 10, 0, 14)
                Handle.Position = UDim2.new(1, -5, 0.5, -7)
                Handle.BackgroundColor3 = Theme.TextWhite
                Handle.Parent = Fill
                Instance.new("UICorner", Handle).CornerRadius = UDim.new(0, 3)
                
                local sliding = false
                local function updateSlider(input)
                    local relX = math.clamp(input.Position.X - Track.AbsolutePosition.X, 0, Track.AbsoluteSize.X)
                    local newPct = relX / Track.AbsoluteSize.X
                    local value = math.floor(min + (max - min) * newPct)
                    Tween(Fill, {Size = UDim2.new(newPct, 0, 1, 0)}, TweenInfo.new(0.05))
                    ValLabel.Text = tostring(value)
                    if callback then pcall(callback, value) end
                end
                
                TrackBtn.MouseButton1Down:Connect(function() sliding = true end)
                UserInputService.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then sliding = false end
                end)
                UserInputService.InputChanged:Connect(function(input)
                    if sliding and input.UserInputType == Enum.UserInputType.MouseMovement then updateSlider(input) end
                end)
            end

            function ElementsAPI:AddKeybind(text, defaultKey, callback)
                local KeybindFrame = Instance.new("Frame")
                KeybindFrame.Size = UDim2.new(1, 0, 0, 38)
                KeybindFrame.BackgroundTransparency = 1
                KeybindFrame.Parent = Card
                
                local Label = Instance.new("TextLabel")
                Label.Size = UDim2.new(1, -90, 1, 0)
                Label.Position = UDim2.new(0, 16, 0, 0)
                Label.BackgroundTransparency = 1
                Label.Text = text
                Label.TextColor3 = Theme.TextGray
                Label.Font = Theme.FontMain
                Label.TextSize = 12
                Label.TextXAlignment = Enum.TextXAlignment.Left
                Label.Parent = KeybindFrame
                
                local KeyBtn = Instance.new("TextButton")
                KeyBtn.Size = UDim2.new(0, 70, 0, 24)
                KeyBtn.Position = UDim2.new(1, -82, 0.5, -12)
                KeyBtn.BackgroundColor3 = Theme.ToggleOff
                KeyBtn.Text = defaultKey.Name
                KeyBtn.TextColor3 = Theme.TextWhite
                KeyBtn.Font = Theme.FontBold
                KeyBtn.TextSize = 11
                KeyBtn.AutoButtonColor = false
                KeyBtn.Parent = KeybindFrame
                Instance.new("UICorner", KeyBtn).CornerRadius = UDim.new(0, 6)
                local kbStroke = Instance.new("UIStroke", KeyBtn)
                kbStroke.Color = Theme.Border
                
                local boundKey = defaultKey
                local listening = false
                
                KeyBtn.MouseButton1Click:Connect(function()
                    if listening then return end
                    listening = true
                    KeyBtn.Text = "..."
                    Tween(KeyBtn, {BackgroundColor3 = Theme.Accent})
                end)
                
                UserInputService.InputBegan:Connect(function(input, gameProcessed)
                    if listening then
                        if input.UserInputType == Enum.UserInputType.Keyboard then
                            boundKey = input.KeyCode
                            KeyBtn.Text = boundKey.Name
                            listening = false
                            Tween(KeyBtn, {BackgroundColor3 = Theme.ToggleOff})
                            Library:Notify("Dashboard", "Tecla configurada: " .. boundKey.Name, 2)
                        end
                    else
                        if not gameProcessed and input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == boundKey then
                            if callback then pcall(callback, boundKey) end
                        end
                    end
                end)
            end
            
            return ElementsAPI
        end
        
        return TabAPI
    end

    return WindowAPI
end

return Library
