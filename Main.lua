-- main.lua
-- TarzBot v1.0.1 for Roblox Fish It

-- Services
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")

-- Player
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Fish It Game Specific (adjust if needed)
local FishItGui = LocalPlayer.PlayerGui:FindFirstChild("FishItGui") or LocalPlayer.PlayerGui:FindFirstChild("MainGui")
local LevelValue = LocalPlayer:FindFirstChild("Level") or {Value = "N/A"}
local GameLocations = {
    ["Kohana"] = Vector3.new(0, 50, 0),
    ["Classic Island"] = Vector3.new(500, 50, 0),
    ["Atlantis"] = Vector3.new(-500, 50, 0),
    ["Coral Reef"] = Vector3.new(0, 50, 500),
    ["Deep Sea"] = Vector3.new(0, -50, 0),
    ["Fishing Spot A"] = Vector3.new(200, 50, 200),
    ["Fishing Spot B"] = Vector3.new(-200, 50, -200),
    ["Market"] = Vector3.new(300, 50, 300),
    ["Spawn"] = Vector3.new(0, 50, 0)
}

-- State Management
local TarzBot = {
    isLoggedIn = false,
    loginTime = nil,
    trialStartTime = tick(),
    trialDuration = 3600, -- 1 hour in seconds
    isMinimized = false,
    currentMenu = nil,
    status = "Free",
    toggles = {
        rodAnimation = false,
        fishNotification = false,
        rodEffect = false
    }
}

-- UI Library (Chloe X Style)
local UI = {}

function UI:CreateInstance(class, props)
    local instance = Instance.new(class)
    for prop, value in pairs(props) do
        if prop == "Parent" then
            instance.Parent = value
        else
            pcall(function() instance[prop] = value end)
        end
    end
    return instance
end

function UI:CreateGradient(parent, color1, color2)
    local gradient = self:CreateInstance("UIGradient", {
        Color = ColorSequence.new({
            ColorSequenceKeypoint.new(0, color1),
            ColorSequenceKeypoint.new(1, color2)
        }),
        Rotation = 45,
        Parent = parent
    })
    return gradient
end

function UI:CreateShadow(parent)
    local shadow = self:CreateInstance("Frame", {
        Size = parent.Size + UDim2.new(0, 10, 0, 10),
        Position = parent.Position + UDim2.new(0, 5, 0, 5),
        BackgroundColor3 = Color3.fromRGB(0, 0, 0),
        BackgroundTransparency = 0.7,
        BorderSizePixel = 0,
        ZIndex = parent.ZIndex - 1,
        Parent = parent.Parent
    })
    return shadow
end

function UI:Tween(obj, props, duration)
    local tweenInfo = TweenInfo.new(
        duration or 0.3,
        Enum.EasingStyle.Quad,
        Enum.EasingDirection.Out
    )
    local tween = TweenService:Create(obj, tweenInfo, props)
    tween:Play()
    return tween
end

-- Main GUI
function UI:CreateMainGui()
    local ScreenGui = self:CreateInstance("ScreenGui", {
        Name = "TarzBot",
        Parent = PlayerGui,
        ResetOnSpawn = false,
        DisplayOrder = 999
    })

    -- Main Window
    local MainFrame = self:CreateInstance("Frame", {
        Name = "MainFrame",
        Size = UDim2.new(0, 450, 0, 350),
        Position = UDim2.new(0.5, -225, 0.5, -175),
        BackgroundColor3 = Color3.fromRGB(30, 30, 40),
        BorderSizePixel = 0,
        Parent = ScreenGui
    })

    -- Rounded Corners
    self:CreateInstance("UICorner", {
        CornerRadius = UDim.new(0, 8),
        Parent = MainFrame
    })

    -- Gradient Background
    self:CreateGradient(MainFrame, Color3.fromRGB(40, 40, 50), Color3.fromRGB(20, 20, 30))

    -- Title Bar
    local TitleBar = self:CreateInstance("Frame", {
        Name = "TitleBar",
        Size = UDim2.new(1, 0, 0, 35),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundColor3 = Color3.fromRGB(25, 25, 35),
        BorderSizePixel = 0,
        Parent = MainFrame
    })

    self:CreateInstance("UICorner", {
        CornerRadius = UDim.new(0, 8),
        Parent = TitleBar
    })

    local TitleText = self:CreateInstance("TextLabel", {
        Name = "TitleText",
        Size = UDim2.new(1, -80, 1, 0),
        Position = UDim2.new(0, 10, 0, 0),
        BackgroundTransparency = 1,
        Text = "TarzBot",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 16,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = TitleBar
    })

    local VersionText = self:CreateInstance("TextLabel", {
        Name = "VersionText",
        Size = UDim2.new(1, -80, 0, 15),
        Position = UDim2.new(0, 10, 0, 20),
        BackgroundTransparency = 1,
        Text = "V1.0.1",
        TextColor3 = Color3.fromRGB(200, 200, 200),
        TextSize = 10,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = TitleBar
    })

    -- Control Buttons
    local MinimizeBtn = self:CreateInstance("TextButton", {
        Name = "MinimizeBtn",
        Size = UDim2.new(0, 30, 0, 25),
        Position = UDim2.new(1, -65, 0, 5),
        BackgroundColor3 = Color3.fromRGB(40, 40, 50),
        Text = "[-]",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 14,
        Font = Enum.Font.GothamBold,
        BorderSizePixel = 0,
        Parent = TitleBar
    })

    local CloseBtn = self:CreateInstance("TextButton", {
        Name = "CloseBtn",
        Size = UDim2.new(0, 30, 0, 25),
        Position = UDim2.new(1, -35, 0, 5),
        BackgroundColor3 = Color3.fromRGB(40, 40, 50),
        Text = "[x]",
        TextColor3 = Color3.fromRGB(255, 100, 100),
        TextSize = 14,
        Font = Enum.Font.GothamBold,
        BorderSizePixel = 0,
        Parent = TitleBar
    })

    self:CreateInstance("UICorner", {
        CornerRadius = UDim.new(0, 4),
        Parent = MinimizeBtn
    })

    self:CreateInstance("UICorner", {
        CornerRadius = UDim.new(0, 4),
        Parent = CloseBtn
    })

    -- Separator
    self:CreateInstance("Frame", {
        Name = "Separator",
        Size = UDim2.new(1, 0, 0, 1),
        Position = UDim2.new(0, 0, 0, 35),
        BackgroundColor3 = Color3.fromRGB(60, 60, 70),
        BorderSizePixel = 0,
        Parent = MainFrame
    })

    -- Menu Buttons Container
    local MenuContainer = self:CreateInstance("Frame", {
        Name = "MenuContainer",
        Size = UDim2.new(1, 0, 1, -35),
        Position = UDim2.new(0, 0, 0, 35),
        BackgroundTransparency = 1,
        Parent = MainFrame
    })

    local MenuList = self:CreateInstance("UIListLayout", {
        Padding = UDim.new(0, 5),
        Parent = MenuContainer
    })

    -- Content Container
    local ContentContainer = self:CreateInstance("Frame", {
        Name = "ContentContainer",
        Size = UDim2.new(1, 0, 1, -70),
        Position = UDim2.new(0, 0, 0, 70),
        BackgroundTransparency = 1,
        Visible = false,
        Parent = MainFrame
    })

    -- Create Menu Buttons
    local menus = {
        {name = "Profile", icon = "[¥]"},
        {name = "Teleport", icon = "[€]"},
        {name = "Informasi", icon = "[π]"},
        {name = "Lain", icon = "[¢]"},
        {name = "Login", icon = "[£]"}
    }

    for _, menu in ipairs(menus) do
        local MenuBtn = self:CreateInstance("TextButton", {
            Name = menu.name .. "Btn",
            Size = UDim2.new(1, 0, 0, 40),
            BackgroundColor3 = Color3.fromRGB(35, 35, 45),
            Text = menu.icon .. " " .. menu.name,
            TextColor3 = Color3.fromRGB(255, 255, 255),
            TextSize = 14,
            Font = Enum.Font.GothamBold,
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = MenuContainer
        })

        self:CreateInstance("UICorner", {
            CornerRadius = UDim.new(0, 6),
            Parent = MenuBtn
        })

        self:CreateInstance("UIPadding", {
            PaddingLeft = UDim.new(0, 10),
            Parent = MenuBtn
        })

        MenuBtn.MouseEnter:Connect(function()
            self:Tween(MenuBtn, {BackgroundColor3 = Color3.fromRGB(45, 45, 55)}, 0.2)
        end)

        MenuBtn.MouseLeave:Connect(function()
            self:Tween(MenuBtn, {BackgroundColor3 = Color3.fromRGB(35, 35, 45)}, 0.2)
        end)

        MenuBtn.MouseButton1Click:Connect(function()
            self:ShowMenu(menu.name)
        end)
    end

    -- Draggable
    local dragging, dragInput, dragStart, startPos
    TitleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
        end
    end)

    TitleBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    UserInputService = game:GetService("UserInputService")
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    -- Control Functions
    MinimizeBtn.MouseButton1Click:Connect(function()
        self:Minimize()
    end)

    CloseBtn.MouseButton1Click:Connect(function()
        self:Close()
    end)

    self.MainFrame = MainFrame
    self.ScreenGui = ScreenGui
    self.ContentContainer = ContentContainer
    self.MenuContainer = MenuContainer

    return self
end

function UI:ShowMenu(menuName)
    -- Clear content
    self.ContentContainer:ClearAllChildren()
    self.ContentContainer.Visible = true

    -- Hide menu buttons
    self.MenuContainer.Visible = false

    -- Create back button
    local BackBtn = self:CreateInstance("TextButton", {
        Name = "BackBtn",
        Size = UDim2.new(0, 80, 0, 25),
        Position = UDim2.new(0, 10, 0, 10),
        BackgroundColor3 = Color3.fromRGB(35, 35, 45),
        Text = "< Back",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 12,
        Font = Enum.Font.GothamBold,
        BorderSizePixel = 0,
        Parent = self.MainFrame
    })

    self:CreateInstance("UICorner", {
        CornerRadius = UDim.new(0, 4),
        Parent = BackBtn
    })

    BackBtn.MouseButton1Click:Connect(function()
        self:ShowMainMenu()
    end)

    -- Show menu content
    if menuName == "Profile" then
        self:ShowProfile()
    elseif menuName == "Teleport" then
        self:ShowTeleport()
    elseif menuName == "Informasi" then
        self:ShowInformasi()
    elseif menuName == "Lain" then
        self:ShowLain()
    elseif menuName == "Login" then
        self:ShowLogin()
    end

    TarzBot.currentMenu = menuName
end

function UI:ShowMainMenu()
    self.ContentContainer.Visible = false
    self.MenuContainer.Visible = true
    self.MainFrame:FindFirstChild("BackBtn"):Destroy()
    TarzBot.currentMenu = nil
end

function UI:ShowProfile()
    local container = self.ContentContainer

    local Title = self:CreateInstance("TextLabel", {
        Size = UDim2.new(1, -20, 0, 30),
        Position = UDim2.new(0, 10, 0, 0),
        BackgroundTransparency = 1,
        Text = "[¥] Profile",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 18,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = container
    })

    local InfoContainer = self:CreateInstance("Frame", {
        Size = UDim2.new(1, -20, 0, 150),
        Position = UDim2.new(0, 10, 0, 40),
        BackgroundColor3 = Color3.fromRGB(35, 35, 45),
        BorderSizePixel = 0,
        Parent = container
    })

    self:CreateInstance("UICorner", {
        CornerRadius = UDim.new(0, 6),
        Parent = InfoContainer
    })

    self:CreateInstance("UIPadding", {
        PaddingTop = UDim.new(0, 10),
        PaddingLeft = UDim.new(0, 10),
        Parent = InfoContainer
    })

    local NameLabel = self:CreateInstance("TextLabel", {
        Size = UDim2.new(1, 0, 0, 25),
        BackgroundTransparency = 1,
        Text = "Nama: " .. LocalPlayer.Name,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 14,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = InfoContainer
    })

    local LevelLabel = self:CreateInstance("TextLabel", {
        Size = UDim2.new(1, 0, 0, 25),
        Position = UDim2.new(0, 0, 0, 30),
        BackgroundTransparency = 1,
        Text = "Level: " .. tostring(LevelValue.Value),
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 14,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = InfoContainer
    })

    local StatusLabel = self:CreateInstance("TextLabel", {
        Size = UDim2.new(1, 0, 0, 25),
        Position = UDim2.new(0, 0, 0, 60),
        BackgroundTransparency = 1,
        Text = "Status: " .. TarzBot.status,
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 14,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = InfoContainer
    })

    -- Update status color
    if TarzBot.isLoggedIn then
        StatusLabel.TextColor3 = Color3.fromRGB(100, 255, 100)
    else
        StatusLabel.TextColor3 = Color3.fromRGB(255, 200, 100)
    end
end

function UI:ShowTeleport()
    local container = self.ContentContainer

    local Title = self:CreateInstance("TextLabel", {
        Size = UDim2.new(1, -20, 0, 30),
        Position = UDim2.new(0, 10, 0, 0),
        BackgroundTransparency = 1,
        Text = "[€] Teleport",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 18,
        Font = Enum.Font.GothamBold,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = container
    })

    local Scroll = self:CreateInstance("ScrollingFrame", {
        Size = UDim2.new(1, -20, 1, -40),
        Position = UDim2.new(0, 10, 0, 40),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 4,
        ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100),
        Parent = container
    })

    self:CreateInstance("UIListLayout", {
        Padding = UDim.new(0, 10),
        Parent = Scroll
    })

    -- Teleport To People
    local PeopleSection = self:CreateInstance("Frame", {
        Size = UDim2.new(1, 0, 0, 35),
        BackgroundColor3 = Color3.fromRGB(35, 35, 45),
        BorderSizePixel = 0,
        Parent = Scroll
    })

    self:CreateInstance("UICorner", {
        CornerRadius = UDim.new(0, 6),
        Parent = PeopleSection
    })

    self:CreateInstance("UIPadding", {
        PaddingLeft = UDim.new(0, 10),
        Parent = PeopleSection
    })

    local PeopleBtn = self:CreateInstance("TextButton", {
        Size = UDim2.new(1, -10, 1, 0),
        BackgroundTransparency = 1,
        Text = "Teleport To People →",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 14,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = PeopleSection
    })

    local PeopleList = self:CreateInstance("Frame", {
        Size = UDim2.new(1, 0, 0, 0),
        Position = UDim2.new(0, 0, 0, 35),
        BackgroundTransparency = 1,
        Visible = false,
        Parent = PeopleSection
    })

    local expanded1 = false
    PeopleBtn.MouseButton1Click:Connect(function()
        expanded1 = not expanded1
        PeopleBtn.Text = expanded1 and "Teleport To People ↓" or "Teleport To People →"
        PeopleList.Visible = expanded1
        
        if expanded1 then
            self:UpdatePlayerList(PeopleList)
            self:Tween(PeopleSection, {Size = UDim2.new(1, 0, 0, 200)}, 0.3)
        else
            self:Tween(PeopleSection, {Size = UDim2.new(1, 0, 0, 35)}, 0.3)
        end
    end)

    self:CreateInstance("TextLabel", {
        Size = UDim2.new(1, -20, 0, 20),
        Position = UDim2.new(0, 10, 0, 5),
        BackgroundTransparency = 1,
        Text = "Choose Someone:",
        TextColor3 = Color3.fromRGB(200, 200, 200),
        TextSize = 12,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = PeopleList
    })

    local PlayerDropdown = self:CreateInstance("TextButton", {
        Size = UDim2.new(1, -20, 0, 30),
        Position = UDim2.new(0, 10, 0, 30),
        BackgroundColor3 = Color3.fromRGB(25, 25, 35),
        Text = "Select Player",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 12,
        Font = Enum.Font.Gotham,
        Parent = PeopleList
    })

    self:CreateInstance("UICorner", {
        CornerRadius = UDim.new(0, 4),
        Parent = PlayerDropdown
    })

    local selectedPlayer = nil
    PlayerDropdown.MouseButton1Click:Connect(function()
        self:ShowPlayerDropdown(PlayerDropdown, function(player)
            selectedPlayer = player
            PlayerDropdown.Text = player.Name
        end)
    end)

    local TeleportBtn1 = self:CreateInstance("TextButton", {
        Size = UDim2.new(1, -20, 0, 30),
        Position = UDim2.new(0, 10, 0, 65),
        BackgroundColor3 = Color3.fromRGB(80, 200, 120),
        Text = "Teleport",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 14,
        Font = Enum.Font.GothamBold,
        BorderSizePixel = 0,
        Parent = PeopleList
    })

    self:CreateInstance("UICorner", {
        CornerRadius = UDim.new(0, 4),
        Parent = TeleportBtn1
    })

    TeleportBtn1.MouseButton1Click:Connect(function()
        if selectedPlayer then
            self:TeleportToPlayer(selectedPlayer)
        end
    end)

    -- Teleport To Region
    local RegionSection = self:CreateInstance("Frame", {
        Size = UDim2.new(1, 0, 0, 35),
        BackgroundColor3 = Color3.fromRGB(35, 35, 45),
        BorderSizePixel = 0,
        Parent = Scroll
    })

    self:CreateInstance("UICorner", {
        CornerRadius = UDim.new(0, 6),
        Parent = RegionSection
    })

    self:CreateInstance("UIPadding", {
        PaddingLeft = UDim.new(0, 10),
        Parent = RegionSection
    })

    local RegionBtn = self:CreateInstance("TextButton", {
        Size = UDim2.new(1, -10, 1, 0),
        BackgroundTransparency = 1,
        Text = "Teleport To The Region →",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 14,
        Font = Enum.Font.Gotham,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = RegionSection
    })

    local RegionList = self:CreateInstance("Frame", {
        Size = UDim2.new(1, 0, 0, 0),
        Position = UDim2.new(0, 0, 0, 35),
        BackgroundTransparency = 1,
        Visible = false,
        Parent = RegionSection
    })

    local expanded2 = false
    RegionBtn.MouseButton1Click:Connect(function()
        expanded2 = not expanded2
        RegionBtn.Text = expanded2 and "Teleport To The Region ↓" or "Teleport To The Region →"
        RegionList.Visible = expanded2
        
        if expanded2 then
            self:UpdateRegionList(RegionList)
            self:Tween(RegionSection, {Size = UDim2.new(1, 0, 0, 220)}, 0.3)
        else
            self:Tween(RegionSection, {Size = UDim2.new(1, 0, 0, 35)}, 0.3)
        end
    end)

    local RegionDropdown = self:CreateInstance("TextButton", {
        Size = UDim2.new(1, -20, 0, 30),
        Position = UDim2.new(0, 10, 0, 5),
        BackgroundColor3 = Color3.fromRGB(25, 25, 35),
        Text = "Select Location",
        TextColor3 = Color3.fromRGB(255, 255, 255),
        TextSize = 12,
        Font = Enum.Font.Gotham,
        Parent = RegionList
    })

    self:CreateInstance("UICorner", {
   
