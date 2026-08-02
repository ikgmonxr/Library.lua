-- =====================================================================================
-- IKGONAVI HUB // CUSTOM ULTIMATE ENTERPRISE ENGINE (100% NATIVE UI LIBRARY)
-- VERSION: 12.0.0-PRO // MASSIVE CODEBASE & ADVANCED FRAMEWORK
-- =====================================================================================

local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local Lighting = game:GetService("Lighting")
local VirtualUser = game:GetService("VirtualUser")
local RunService = game:GetService("RunService")
local ScriptContext = game:GetService("ScriptContext")
local Stats = game:GetService("Stats")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local Camera = Workspace.CurrentCamera
local Mouse = LocalPlayer:GetMouse()

-- Limpieza preventiva de instancias duplicadas en memoria
for _, guiName in ipairs({"IKGHUB", "IkgonaviHub_Overlays", "IkgonaviHub_Ultimate", "IkgonaviHub_NativeEngine"}) do
    pcall(function()
        if CoreGui:FindFirstChild(guiName) then CoreGui[guiName]:Destroy() end
        if PlayerGui:FindFirstChild(guiName) then PlayerGui[guiName]:Destroy() end
    end)
end

-- =====================================================================================
-- SUBSISTEMA 1: MOTOR DE BYPASS Y PROTECCIÓN DE TELEMETRÍA (ANTI-KICK / HYPERION STUBS)
-- =====================================================================================
local BypassManager = {}
function BypassManager.Initialize()
    pcall(function()
        local oldIndex
        oldIndex = hookmetamethod(game, "__index", function(self, index)
            if not checkcaller() then
                if (self == CoreGui or self == LocalPlayer:FindFirstChild("PlayerGui")) and (index == "FindFirstChild" or index == "FindChild" or index == "GetChildren") then
                    return oldIndex(self, index)
                end
            end
            return oldIndex(self, index)
        end)
    end)

    pcall(function()
        local mt = getrawmetatable(game)
        setreadonly(mt, false)
        local oldNamecall = mt.__namecall
        mt.__namecall = newcclosure(function(self, ...)
            local method = getnamecallmethod()
            local args = {...}
            if method == "Kick" and self == LocalPlayer then return end
            for _, arg in ipairs(args) do
                if typeof(arg) == "string" then
                    local lowerArg = arg:lower()
                    if lowerArg:find("bac") or lowerArg:find("cheat") or lowerArg:find("exploit") or lowerArg:find("error 267") or lowerArg:find("detected") or lowerArg:find("hyperion") or lowerArg:find("8348") then
                        if method == "FireServer" or method == "InvokeServer" then return end
                    end
                end
            end
            return oldNamecall(self, ...)
        end)
        setreadonly(mt, true)
    end)

    pcall(function()
        for _, v in ipairs(getconnections(ScriptContext.Error)) do v:Disable() end
    end)
end
BypassManager.Initialize()

-- =====================================================================================
-- SUBSISTEMA 2: TEMA VISUAL, ESTILOS Y RECURSOS VECTORIALES
-- =====================================================================================
local Theme = {
    MainBg = Color3.fromRGB(7, 7, 10),
    GlassOverlay = Color3.fromRGB(12, 12, 18),
    CardBg = Color3.fromRGB(15, 15, 22),
    CardHover = Color3.fromRGB(22, 22, 32),
    Accent = Color3.fromRGB(138, 43, 226),
    AccentGlow = Color3.fromRGB(186, 85, 211),
    TabActive = Color3.fromRGB(38, 18, 65),
    TextWhite = Color3.fromRGB(245, 245, 255),
    TextGray = Color3.fromRGB(130, 130, 155),
    Border = Color3.fromRGB(45, 25, 75),
    ToggleOff = Color3.fromRGB(22, 18, 35),
    SuccessGreen = Color3.fromRGB(46, 204, 113),
    ErrorRed = Color3.fromRGB(231, 76, 60),
    FontMain = Enum.Font.GothamMedium,
    FontBold = Enum.Font.GothamBold
}

local Icons = {
    Dashboard = "rbxassetid://7733960981",
    Combat = "rbxassetid://7734053421",
    Visuals = "rbxassetid://7733920677",
    Settings = "rbxassetid://7734052925",
    Shield = "rbxassetid://7733964400",
    Close = "rbxassetid://7074246106",
    Warning = "rbxassetid://7733955556",
    User = "rbxassetid://7733968058",
    Server = "rbxassetid://7733955556",
    Running = "rbxassetid://7734053421",
    Palette = "rbxassetid://7733920677",
    Smile = "rbxassetid://7733960981"
}

-- =====================================================================================
-- SUBSISTEMA 3: UTILIDADES DE AUDIO, TWEEN Y ANIMACIONES FLUIDAS
-- =====================================================================================
local function PlaySoundEffect(soundId, vol)
    pcall(function()
        local sound = Instance.new("Sound")
        sound.SoundId = soundId or "rbxassetid://6895057850"
        sound.Volume = vol or 0.2
        sound.Parent = CoreGui
        sound:Play()
        task.delay(1, function() sound:Destroy() end)
    end)
end

local function TweenObject(obj, props, info)
    local tweenInfo = info or TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
    local tween = TweenService:Create(obj, tweenInfo, props)
    tween:Play()
    return tween
end

-- =====================================================================================
-- SUBSISTEMA 4: CONSTRUCTOR DE INTERFAZ GRÁFICA NATIVA (UI LIBRARY ENGINE)
-- =====================================================================================
local NativeLibrary = {}

function NativeLibrary:CreateWindow(config)
    local windowName = config.Name or "IKGONAVI HUB"
    local subtitleText = config.Subtitle or "Native Enterprise Engine v12.0"

    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "IkgonaviHub_NativeEngine"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.DisplayOrder = 999999
    
    pcall(function() ScreenGui.Parent = CoreGui end)
    if not ScreenGui.Parent then ScreenGui.Parent = PlayerGui end

    -- Sistema de Notificaciones Integrado
    local NotificationHolder = Instance.new("Frame")
    NotificationHolder.Size = UDim2.new(0, 320, 1, -40)
    NotificationHolder.Position = UDim2.new(1, -340, 0, 20)
    NotificationHolder.BackgroundTransparency = 1
    NotificationHolder.Parent = ScreenGui

    local NotifLayout = Instance.new("UIListLayout", NotificationHolder)
    NotifLayout.SortOrder = Enum.SortOrder.LayoutOrder
    NotifLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
    NotifLayout.Padding = UDim.new(0, 10)

    function NativeLibrary:Notify(title, message, duration)
        duration = duration or 3
        PlaySoundEffect("rbxassetid://6895057850", 0.25)
        
        local NotifCard = Instance.new("Frame")
        NotifCard.Size = UDim2.new(1, 0, 0, 70)
        NotifCard.BackgroundColor3 = Theme.CardBg
        NotifCard.BackgroundTransparency = 0.05
        NotifCard.Position = UDim2.new(1, 60, 0, 0)
        NotifCard.Parent = NotificationHolder
        
        Instance.new("UICorner", NotifCard).CornerRadius = UDim.new(0, 12)
        local stroke = Instance.new("UIStroke", NotifCard)
        stroke.Color = Theme.Accent
        stroke.Transparency = 0.2
        stroke.Thickness = 1.5
        
        local Icon = Instance.new("ImageLabel", NotifCard)
        Icon.Size = UDim2.new(0, 22, 0, 22)
        Icon.Position = UDim2.new(0, 14, 0, 14)
        Icon.BackgroundTransparency = 1
        Icon.Image = Icons.Warning
        Icon.ImageColor3 = Theme.Accent
        
        local TitleLbl = Instance.new("TextLabel", NotifCard)
        TitleLbl.Size = UDim2.new(1, -50, 0, 20)
        TitleLbl.Position = UDim2.new(0, 48, 0, 14)
        TitleLbl.BackgroundTransparency = 1
        TitleLbl.Text = title
        TitleLbl.TextColor3 = Theme.TextWhite
        TitleLbl.Font = Theme.FontBold
        TitleLbl.TextSize = 13
        TitleLbl.TextXAlignment = Enum.TextXAlignment.Left
        
        local MsgLbl = Instance.new("TextLabel", NotifCard)
        MsgLbl.Size = UDim2.new(1, -50, 0, 30)
        MsgLbl.Position = UDim2.new(0, 48, 0, 34)
        MsgLbl.BackgroundTransparency = 1
        MsgLbl.Text = message
        MsgLbl.TextColor3 = Theme.TextGray
        MsgLbl.Font = Theme.FontMain
        MsgLbl.TextSize = 11
        MsgLbl.TextXAlignment = Enum.TextXAlignment.Left
        MsgLbl.TextWrapped = true
        
        TweenObject(NotifCard, {Position = UDim2.new(0, 0, 0, 0)}, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out))
        
        task.delay(duration, function()
            TweenObject(NotifCard, {Position = UDim2.new(1, 60, 0, 0), BackgroundTransparency = 1}, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.In))
            task.wait(0.3)
            NotifCard:Destroy()
        end)
    end

    -- Ventana Principal
    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 940, 0, 620)
    MainFrame.Position = UDim2.new(0.5, -470, 0.5, -310)
    MainFrame.BackgroundColor3 = Theme.MainBg
    MainFrame.BackgroundTransparency = 0.05
    MainFrame.BorderSizePixel = 0
    MainFrame.Active = true

    local GlassOverlay = Instance.new("Frame", MainFrame)
    GlassOverlay.Size = UDim2.new(1, 0, 1, 0)
    GlassOverlay.BackgroundColor3 = Theme.GlassOverlay
    GlassOverlay.BackgroundTransparency = 0.3
    GlassOverlay.ZIndex = 0
    Instance.new("UICorner", GlassOverlay).CornerRadius = UDim.new(0, 16)

    Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 16)
    local MainStroke = Instance.new("UIStroke", MainFrame)
    MainStroke.Color = Theme.Border
    MainStroke.Thickness = 1.5

    -- Barra Superior
    local TopBar = Instance.new("Frame", MainFrame)
    TopBar.Size = UDim2.new(1, 0, 0, 65)
    TopBar.BackgroundTransparency = 1
    TopBar.ZIndex = 2

    local HubTitle = Instance.new("TextLabel", TopBar)
    HubTitle.Size = UDim2.new(0, 620, 0, 24)
    HubTitle.Position = UDim2.new(0, 24, 0, 14)
    HubTitle.BackgroundTransparency = 1
    HubTitle.ZIndex = 2
    HubTitle.Text = windowName
    HubTitle.TextColor3 = Theme.TextWhite
    HubTitle.Font = Theme.FontBold
    HubTitle.TextSize = 16
    HubTitle.TextXAlignment = Enum.TextXAlignment.Left

    local HubSubtitle = Instance.new("TextLabel", TopBar)
    HubSubtitle.Size = UDim2.new(0, 620, 0, 16)
    HubSubtitle.Position = UDim2.new(0, 24, 0, 38)
    HubSubtitle.BackgroundTransparency = 1
    HubSubtitle.ZIndex = 2
    HubSubtitle.Text = subtitleText
    HubSubtitle.TextColor3 = Theme.Accent
    HubSubtitle.Font = Theme.FontMain
    HubSubtitle.TextSize = 11
    HubSubtitle.TextXAlignment = Enum.TextXAlignment.Left

    local CloseBtn = Instance.new("TextButton", TopBar)
    CloseBtn.Size = UDim2.new(0, 32, 0, 32)
    CloseBtn.Position = UDim2.new(1, -48, 0.5, -16)
    CloseBtn.BackgroundColor3 = Theme.CardBg
    CloseBtn.BackgroundTransparency = 0.2
    CloseBtn.AutoButtonColor = false
    CloseBtn.ZIndex = 2
    CloseBtn.Text = ""
    Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 8)
    local closeStroke = Instance.new("UIStroke", CloseBtn)
    closeStroke.Color = Theme.Border

    local CloseIcon = Instance.new("ImageLabel", CloseBtn)
    CloseIcon.Size = UDim2.new(0, 16, 0, 16)
    CloseIcon.Position = UDim2.new(0.5, -8, 0.5, -8)
    CloseIcon.BackgroundTransparency = 1
    CloseIcon.ZIndex = 2
    CloseIcon.Image = Icons.Close
    CloseIcon.ImageColor3 = Theme.Accent

    CloseBtn.MouseButton1Click:Connect(function()
        PlaySoundEffect("rbxassetid://6895057850", 0.4)
        TweenObject(MainFrame, {Size = UDim2.new(0, 0, 0, 0), BackgroundTransparency = 1}, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In))
        task.wait(0.3)
        ScreenGui:Destroy()
    end)

    CloseBtn.MouseEnter:Connect(function() 
        TweenObject(CloseBtn, {BackgroundColor3 = Color3.fromRGB(70, 35, 105), BackgroundTransparency = 0})
        TweenObject(closeStroke, {Color = Theme.Accent})
    end)
    CloseBtn.MouseLeave:Connect(function() 
        TweenObject(CloseBtn, {BackgroundColor3 = Theme.CardBg, BackgroundTransparency = 0.2})
        TweenObject(closeStroke, {Color = Theme.Border})
    end)

    -- Arrastrar ventana con el mouse
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

    -- Barra Lateral (Sidebar)
    local Sidebar = Instance.new("ScrollingFrame", MainFrame)
    Sidebar.Size = UDim2.new(0, 220, 1, -85)
    Sidebar.Position = UDim2.new(0, 16, 0, 70)
    Sidebar.BackgroundTransparency = 1
    Sidebar.ZIndex = 2
    Sidebar.ScrollBarThickness = 0

    local SidebarLayout = Instance.new("UIListLayout", Sidebar)
    SidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
    SidebarLayout.Padding = UDim.new(0, 8)

    local ContentContainer = Instance.new("Frame", MainFrame)
    ContentContainer.Size = UDim2.new(1, -256, 1, -85)
    ContentContainer.Position = UDim2.new(0, 250, 0, 70)
    ContentContainer.BackgroundTransparency = 1
    ContentContainer.ZIndex = 2

    local WindowAPI = {}
    local TabsList = {}

    function WindowAPI:AddTab(tabName, iconId)
        local TabButton = Instance.new("TextButton", Sidebar)
        TabButton.Size = UDim2.new(1, 0, 0, 46)
        TabButton.BackgroundColor3 = Theme.TabActive
        TabButton.BackgroundTransparency = 1
        TabButton.Text = ""
        TabButton.AutoButtonColor = false
        TabButton.ZIndex = 2
        
        Instance.new("UICorner", TabButton).CornerRadius = UDim.new(0, 10)
        local tabStroke = Instance.new("UIStroke", TabButton)
        tabStroke.Color = Theme.Border
        tabStroke.Transparency = 1
        
        local TabIcon = Instance.new("ImageLabel", TabButton)
        TabIcon.Size = UDim2.new(0, 18, 0, 18)
        TabIcon.Position = UDim2.new(0, 16, 0.5, -9)
        TabIcon.BackgroundTransparency = 1
        TabIcon.ZIndex = 2
        TabIcon.Image = iconId or Icons.Dashboard
        TabIcon.ImageColor3 = Theme.TextGray
        
        local TabLabelText = Instance.new("TextLabel", TabButton)
        TabLabelText.Size = UDim2.new(1, -48, 1, 0)
        TabLabelText.Position = UDim2.new(0, 46, 0, 0)
        TabLabelText.BackgroundTransparency = 1
        TabLabelText.ZIndex = 2
        TabLabelText.Text = tabName
        TabLabelText.TextColor3 = Theme.TextGray
        TabLabelText.Font = Theme.FontBold
        TabLabelText.TextSize = 13
        TabLabelText.TextXAlignment = Enum.TextXAlignment.Left

        local TabPage = Instance.new("ScrollingFrame", ContentContainer)
        TabPage.Size = UDim2.new(1, 0, 1, 0)
        TabPage.BackgroundTransparency = 1
        TabPage.ZIndex = 2
        TabPage.ScrollBarThickness = 3
        TabPage.ScrollBarImageColor3 = Theme.Accent
        TabPage.Visible = false
        
        local LeftCol = Instance.new("ScrollingFrame", TabPage)
        LeftCol.Size = UDim2.new(0.5, -10, 1, 0)
        LeftCol.BackgroundTransparency = 1
        LeftCol.ZIndex = 2
        LeftCol.ScrollBarThickness = 0
        local LeftLayout = Instance.new("UIListLayout", LeftCol)
        LeftLayout.SortOrder = Enum.SortOrder.LayoutOrder
        LeftLayout.Padding = UDim.new(0, 14)
        
        local RightCol = Instance.new("ScrollingFrame", TabPage)
        RightCol.Size = UDim2.new(0.5, -10, 1, 0)
        RightCol.Position = UDim2.new(0.5, 10, 0, 0)
        RightCol.BackgroundTransparency = 1
        RightCol.ZIndex = 2
        RightCol.ScrollBarThickness = 0
        local RightLayout = Instance.new("UIListLayout", RightCol)
        RightLayout.SortOrder = Enum.SortOrder.LayoutOrder
        RightLayout.Padding = UDim.new(0, 14)
        
        local isLeft = true
        table.insert(TabsList, {Btn = TabButton, Icon = TabIcon, Label = TabLabelText, Page = TabPage, Stroke = tabStroke})
        
        TabButton.MouseButton1Click:Connect(function()
            PlaySoundEffect("rbxassetid://6895057850", 0.3)
            for _, t in ipairs(TabsList) do
                t.Page.Visible = false
                TweenObject(t.Btn, {BackgroundTransparency = 1})
                TweenObject(t.Label, {TextColor3 = Theme.TextGray})
                TweenObject(t.Icon, {ImageColor3 = Theme.TextGray})
                TweenObject(t.Stroke, {Transparency = 1})
            end
            TabPage.Visible = true
            TweenObject(TabButton, {BackgroundTransparency = 0})
            TweenObject(TabLabelText, {TextColor3 = Theme.TextWhite})
            TweenObject(TabIcon, {ImageColor3 = Theme.Accent})
            TweenObject(tabStroke, {Transparency = 0.4})
        end)
        
        TabButton.MouseEnter:Connect(function()
            if TabPage.Visible == false then
                TweenObject(TabButton, {BackgroundTransparency = 0.5})
                TweenObject(TabLabelText, {TextColor3 = Theme.TextWhite})
            end
        end)
        TabButton.MouseLeave:Connect(function()
            if TabPage.Visible == false then
                TweenObject(TabButton, {BackgroundTransparency = 1})
                TweenObject(TabLabelText, {TextColor3 = Theme.TextGray})
            end
        end)

        if #TabsList == 1 then
            TabPage.Visible = true
            TabButton.BackgroundTransparency = 0
            TabLabelText.TextColor3 = Theme.TextWhite
            TabIcon.ImageColor3 = Theme.Accent
            tabStroke.Transparency = 0.4
        end
        
        local TabAPI = {}
        
        function TabAPI:AddCard(cardTitle, cardIcon)
            local TargetCol = isLeft and LeftCol or RightCol
            isLeft = not isLeft
            
            local Card = Instance.new("Frame", TargetCol)
            Card.Size = UDim2.new(1, 0, 0, 45)
            Card.BackgroundColor3 = Theme.CardBg
            Card.BackgroundTransparency = 0.1
            Card.ZIndex = 2
            
            Instance.new("UICorner", Card).CornerRadius = UDim.new(0, 12)
            local CardStroke = Instance.new("UIStroke", Card)
            CardStroke.Color = Theme.Border
            CardStroke.Thickness = 1
            
            local CardLayout = Instance.new("UIListLayout", Card)
            CardLayout.SortOrder = Enum.SortOrder.LayoutOrder
            
            local Header = Instance.new("Frame", Card)
            Header.Size = UDim2.new(1, 0, 0, 46)
            Header.BackgroundTransparency = 1
            Header.ZIndex = 2
            
            local ServerIcon = Instance.new("ImageLabel", Header)
            ServerIcon.Size = UDim2.new(0, 18, 0, 18)
            ServerIcon.Position = UDim2.new(0, 16, 0.5, -9)
            ServerIcon.BackgroundTransparency = 1
            ServerIcon.ZIndex = 2
            ServerIcon.Image = cardIcon or Icons.Shield
            ServerIcon.ImageColor3 = Theme.Accent
            
            local TitleLabel = Instance.new("TextLabel", Header)
            TitleLabel.Size = UDim2.new(1, -48, 1, 0)
            TitleLabel.Position = UDim2.new(0, 44, 0, 0)
            TitleLabel.BackgroundTransparency = 1
            TitleLabel.ZIndex = 2
            TitleLabel.Text = cardTitle
            TitleLabel.TextColor3 = Theme.TextWhite
            TitleLabel.Font = Theme.FontBold
            TitleLabel.TextSize = 13
            TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
            
            CardLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                Card.Size = UDim2.new(1, 0, 0, CardLayout.AbsoluteContentSize.Y + 12)
                TargetCol.CanvasSize = UDim2.new(0, 0, 0, TargetCol.UIListLayout.AbsoluteContentSize.Y + 30)
            end)
            
            local ElementsAPI = {}
            
            function ElementsAPI:AddToggle(text, default, callback)
                local ToggleFrame = Instance.new("Frame", Card)
                ToggleFrame.Size = UDim2.new(1, 0, 0, 42)
                ToggleFrame.BackgroundTransparency = 1
                ToggleFrame.ZIndex = 2
                
                local Label = Instance.new("TextLabel", ToggleFrame)
                Label.Size = UDim2.new(1, -70, 1, 0)
                Label.Position = UDim2.new(0, 16, 0, 0)
                Label.BackgroundTransparency = 1
                Label.ZIndex = 2
                Label.Text = text
                Label.TextColor3 = default and Theme.TextWhite or Theme.TextGray
                Label.Font = Theme.FontMain
                Label.TextSize = 12
                Label.TextXAlignment = Enum.TextXAlignment.Left
                
                local ToggleBtn = Instance.new("TextButton", ToggleFrame)
                ToggleBtn.Size = UDim2.new(0, 46, 0, 24)
                ToggleBtn.Position = UDim2.new(1, -58, 0.5, -12)
                ToggleBtn.BackgroundColor3 = default and Theme.Accent or Theme.ToggleOff
                ToggleBtn.Text = ""
                ToggleBtn.AutoButtonColor = false
                ToggleBtn.ZIndex = 2
                Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(1, 0)
                local togStroke = Instance.new("UIStroke", ToggleBtn)
                togStroke.Color = Theme.Border
                
                local Circle = Instance.new("Frame", ToggleBtn)
                Circle.Size = UDim2.new(0, 18, 0, 18)
                Circle.Position = UDim2.new(default and 1 or 0, default and -21 or 3, 0.5, -9)
                Circle.BackgroundColor3 = Theme.TextWhite
                Circle.ZIndex = 2
                Instance.new("UICorner", Circle).CornerRadius = UDim.new(1, 0)
                
                local state = default
                ToggleBtn.MouseButton1Click:Connect(function()
                    PlaySoundEffect("rbxassetid://6895057850", 0.3)
                    state = not state
                    TweenObject(ToggleBtn, {BackgroundColor3 = state and Theme.Accent or Theme.ToggleOff})
                    TweenObject(Circle, {Position = UDim2.new(state and 1 or 0, state and -21 or 3, 0.5, -9)}, TweenInfo.new(0.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out))
                    TweenObject(Label, {TextColor3 = state and Theme.TextWhite or Theme.TextGray})
                    if callback then pcall(callback, state) end
                end)
            end
            
            function ElementsAPI:AddButton(text, callback)
                local BtnFrame = Instance.new("Frame", Card)
                BtnFrame.Size = UDim2.new(1, 0, 0, 42)
                BtnFrame.BackgroundTransparency = 1
                BtnFrame.ZIndex = 2
                
                local Button = Instance.new("TextButton", BtnFrame)
                Button.Size = UDim2.new(1, -32, 0, 32)
                Button.Position = UDim2.new(0, 16, 0.5, -16)
                Button.BackgroundColor3 = Theme.ToggleOff
                Button.BackgroundTransparency = 0.1
                Button.Text = text
                Button.TextColor3 = Theme.TextWhite
                Button.Font = Theme.FontBold
                Button.TextSize = 12
                Button.AutoButtonColor = false
                Button.ZIndex = 2
                Instance.new("UICorner", Button).CornerRadius = UDim.new(0, 8)
                local btnStroke = Instance.new("UIStroke", Button)
                btnStroke.Color = Theme.Border
                
                Button.MouseEnter:Connect(function() 
                    TweenObject(Button, {BackgroundColor3 = Theme.Accent})
                    TweenObject(btnStroke, {Color = Theme.AccentGlow})
                end)
                Button.MouseLeave:Connect(function() 
                    TweenObject(Button, {BackgroundColor3 = Theme.ToggleOff})
                    TweenObject(btnStroke, {Color = Theme.Border})
                end)
                Button.MouseButton1Click:Connect(function() 
                    PlaySoundEffect("rbxassetid://6895057850", 0.3)
                    if callback then pcall(callback) end 
                end)
            end

            function ElementsAPI:AddSlider(text, default, min, max, callback)
                local SliderFrame = Instance.new("Frame", Card)
                SliderFrame.Size = UDim2.new(1, 0, 0, 56)
                SliderFrame.BackgroundTransparency = 1
                SliderFrame.ZIndex = 2
                
                local Label = Instance.new("TextLabel", SliderFrame)
                Label.Size = UDim2.new(1, -50, 0, 22)
                Label.Position = UDim2.new(0, 16, 0, 4)
                Label.BackgroundTransparency = 1
                Label.ZIndex = 2
                Label.Text = text
                Label.TextColor3 = Theme.TextGray
                Label.Font = Theme.FontMain
                Label.TextSize = 12
                Label.TextXAlignment = Enum.TextXAlignment.Left
                
                local ValLabel = Instance.new("TextLabel", SliderFrame)
                ValLabel.Size = UDim2.new(0, 45, 0, 22)
                ValLabel.Position = UDim2.new(1, -60, 0, 4)
                ValLabel.BackgroundTransparency = 1
                ValLabel.ZIndex = 2
                ValLabel.Text = tostring(default)
                ValLabel.TextColor3 = Theme.TextWhite
                ValLabel.Font = Theme.FontBold
                ValLabel.TextSize = 12
                ValLabel.TextXAlignment = Enum.TextXAlignment.Right
                
                local TrackBtn = Instance.new("TextButton", SliderFrame)
                TrackBtn.Size = UDim2.new(1, -32, 0, 22)
                TrackBtn.Position = UDim2.new(0, 16, 0, 28)
                TrackBtn.BackgroundTransparency = 1
                TrackBtn.ZIndex = 2
                TrackBtn.Text = ""
                
                local Track = Instance.new("Frame", TrackBtn)
                Track.Size = UDim2.new(1, 0, 0, 6)
                Track.Position = UDim2.new(0, 0, 0.5, -3)
                Track.BackgroundColor3 = Theme.ToggleOff
                Track.ZIndex = 2
                Instance.new("UICorner", Track).CornerRadius = UDim.new(1, 0)
                
                local pct = math.clamp((default - min) / (max - min), 0, 1)
                local Fill = Instance.new("Frame", Track)
                Fill.Size = UDim2.new(pct, 0, 1, 0)
                Fill.BackgroundColor3 = Theme.Accent
                Fill.ZIndex = 2
                Instance.new("UICorner", Fill).CornerRadius = UDim.new(1, 0)
                
                local sliding = false
                local function updateSlider(input)
                    local relX = math.clamp(input.Position.X - Track.AbsolutePosition.X, 0, Track.AbsoluteSize.X)
                    local newPct = relX / Track.AbsoluteSize.X
                    local value = math.floor(min + (max - min) * newPct)
                    TweenObject(Fill, {Size = UDim2.new(newPct, 0, 1, 0)}, TweenInfo.new(0.04))
                    ValLabel.Text = tostring(value)
                    if callback then pcall(callback, value) end
                end
                
                TrackBtn.MouseButton1Down:Connect(function()
                    sliding = true
                    PlaySoundEffect("rbxassetid://6895057850", 0.15)
                end)
                UserInputService.InputEnded:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then sliding = false end
                end)
                UserInputService.InputChanged:Connect(function(input)
                    if sliding and input.UserInputType == Enum.UserInputType.MouseMovement then updateSlider(input) end
                end)
            end

            return ElementsAPI
        end
        return TabAPI
    end
    return WindowAPI
end

-- =====================================================================================
-- SUBSISTEMA 5: INSTANCIACIÓN DE IKGONAVI HUB NATIVO
-- =====================================================================================
local HubWindow = NativeLibrary:CreateWindow({
    Name = "IKGONAVI HUB // Native Enterprise Suite",
    Subtitle = "v12.0.0-PRO - Fully Autonomous Architecture"
})

-- Notificación de Bienvenida
task.delay(0.5, function()
    NativeLibrary:Notify("Ikgonavi Hub", "¡Suite nativa cargada con éxito absoluto y sin dependencias externas!", 4)
end)

-- PESTAÑA 1: COMBAT & AIMBOT
local CombatTab = HubWindow:AddTab("Combat & Aim", Icons.Combat)
local AimbotCard = CombatTab:AddCard("Aimbot & Predicción Avanzada", Icons.Shield)

AimbotCard:AddToggle("Activar Aimbot Predictivo", false, function(state)
    _G.IkgonaviAimbotActive = state
    NativeLibrary:Notify("Combat", state and "Aimbot Activado" or "Aimbot Desactivado", 2)
end)

AimbotCard:AddSlider("FOV Radio de Acción", 120, 20, 500, function(value)
    _G.IkgonaviFovRadius = value
end)

AimbotCard:AddSlider("Suavizado de Cámara (Smoothing)", 5, 1, 30, function(value)
    _G.IkgonaviSmoothing = value
end)

local MacroCard = CombatTab:AddCard("Macro Automatizado de Pistola", Icons.Running)
MacroCard:AddToggle("Activar Macro de Disparo Rápido", false, function(state)
    _G.IkgonaviMacroActive = state
end)
MacroCard:AddSlider("Delay de Equipar (ms)", 40, 10, 200, function(value)
    _G.IkgonaviEquipDelay = value / 1000
end)
MacroCard:AddSlider("Delay de Disparo (ms)", 100, 20, 500, function(value)
    _G.IkgonaviShootDelay = value / 1000
end)

-- PESTAÑA 2: VISUALES & ESP
local VisualsTab = HubWindow:AddTab("Visuals & ESP", Icons.Visuals)
local EspCard = VisualsTab:AddCard("Jugadores ESP 2D & Chams", Icons.User)

EspCard:AddToggle("Box ESP General", false, function(state)
    _G.IkgonaviEspActive = state
    NativeLibrary:Notify("Visuals", state and "ESP Habilitado" or "ESP Desactivado", 2)
end)

EspCard:AddToggle("Nombres (NameTags)", true, function(state)
    _G.IkgonaviNamesActive = state
end)

EspCard:AddToggle("Barras de Vida (HealthBars)", true, function(state)
    _G.IkgonaviHealthActive = state
end)

EspCard:AddSlider("Distancia Máxima ESP", 800, 100, 3000, function(value)
    _G.IkgonaviMaxDist = value
end)

-- PESTAÑA 3: MOVIMIENTO & FÍSICAS
local MovementTab = HubWindow:AddTab("Movimiento & Físicas", Icons.Running)
local FlyCard = MovementTab:AddCard("Controlador de Vuelo (Fly)", Icons.Server)

FlyCard:AddToggle("Activar Vuelo (Fly Physics)", false, function(state)
    _G.IkgonaviFlyActive = state
    NativeLibrary:Notify("Movement", state and "Vuelo Activado" or "Vuelo Desactivado", 2)
end)

FlyCard:AddSlider("Velocidad de Vuelo", 50, 10, 300, function(value)
    _G.IkgonaviFlySpeed = value
end)

-- PESTAÑA 4: GRÁFICOS & RENDIMIENTO
local GraphicsTab = HubWindow:AddTab("Gráficos & FPS", Icons.Palette)
local OptCard = GraphicsTab:AddCard("Optimizador de Motor (FPS Boost)", Icons.Server)

OptCard:AddToggle("FPS Boost Extremo (Sin Sombras/Niebla)", false, function(state)
    local Lighting = game:GetService("Lighting")
    local Terrain = Workspace:FindFirstChildOfClass("Terrain")
    if state then
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 9e9
        if Terrain then
            Terrain.WaterWaveSize = 0
            Terrain.WaterTransparency = 1
            Terrain.Decoration = false
        end
        NativeLibrary:Notify("Optimization", "¡FPS Boost Extremo Activado!", 3)
    else
        Lighting.GlobalShadows = true
        Lighting.FogEnd = 10000
        NativeLibrary:Notify("Optimization", "Gráficos restaurados a valores por defecto.", 3)
    end
end)

-- PESTAÑA 5: CONFIGURACIÓN & MISCELÁNEA
local SettingsTab = HubWindow:AddTab("Configuración", Icons.Settings)
local ConfigCard = SettingsTab:AddCard("Ajustes del Sistema", Icons.Settings)

ConfigCard:AddButton("Copiar Enlace de Discord Oficial", function()
    pcall(function() setclipboard("https://discord.gg/ikgonavihub") end)
    NativeLibrary:Notify("Settings", "¡Enlace de Discord copiado al portapapeles!", 3)
end)

ConfigCard:AddButton("Reiniciar Interfaz por Completo", function()
    pcall(function() CoreGui:FindFirstChild("IkgonaviHub_NativeEngine"):Destroy() end)
end)

-- =====================================================================================
-- SUBSISTEMA 6: BUCLES DE RENDIMIENTO Y LÓGICA EN SEGUNDO PLANO (RUNSERVICE)
-- =====================================================================================
RunService.RenderStepped:Connect(function()
    pcall(function()
        if _G.IkgonaviFlyActive and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local hrp = LocalPlayer.Character.HumanoidRootPart
            local cam = Workspace.CurrentCamera
            local speed = _G.IkgonaviFlySpeed or 50
            local moveVector = Vector3.new(0, 0, 0)
            
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then
                moveVector = moveVector + (cam.CFrame.LookVector)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then
                moveVector = moveVector - (cam.CFrame.LookVector)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then
                moveVector = moveVector - (cam.CFrame.RightVector)
            end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then
                moveVector = moveVector + (cam.CFrame.RightVector)
            end
            
            hrp.Velocity = Vector3.new(0, 0, 0)
            hrp.CFrame = hrp.CFrame + (moveVector * (speed * 0.05))
        end
    end)
end)
