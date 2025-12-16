-- TarzBot Fish It GUI - VERSI FINAL PREMIUM
-- Version: 2.0.0 - 100% Mirip Chloe X

-- CORE SERVICES
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

-- SISTEM LOGIN
local isLoggedIn = false
local startTime = os.time()
local timeLimit = 3600
local correctUsername = "AZKA"
local correctPassword = "AZKA"

-- KOORDINAT FISH IT (LENGKAP & AKURAT)
local regionData = {
    ["Fisherman Island"] = Vector3.new(0, 50, 0),
    ["Kohana Island"] = Vector3.new(350, 50, -200),
    ["Kohana Volcano"] = Vector3.new(380, 60, -180),
    ["Kohana Cave"] = Vector3.new(360, 40, -220),
    ["The Ocean"] = Vector3.new(-200, 50, 100),
    ["Deep Ocean"] = Vector3.new(-500, 50, 200),
    ["Coral Reef Island"] = Vector3.new(600, 50, 300),
    ["Tropical Grove Island"] = Vector3.new(900, 50, -400),
    ["Tropical Grove Edge"] = Vector3.new(950, 50, -450),
    ["Crater Island"] = Vector3.new(-400, 50, 600),
    ["Crater Peak"] = Vector3.new(-380, 80, 620),
    ["Esoteric Depths"] = Vector3.new(1200, 50, 100),
    ["Enchanted Zone"] = Vector3.new(1250, 50, 150),
    ["Sisyphus Statue"] = Vector3.new(800, 30, -800),
    ["Treasure Room"] = Vector3.new(850, 30, -750),
    ["Ancient Jungle"] = Vector3.new(-600, 50, -500),
    ["Sacred Temple"] = Vector3.new(-620, 50, -520),
    ["Underground Cellar"] = Vector3.new(-580, 20, -480),
    ["Classic Island"] = Vector3.new(1500, 50, 0),
    ["Iron Cavern"] = Vector3.new(1480, 40, -50),
    ["Secret Lagoon"] = Vector3.new(2000, 50, 300),
    ["Mystic Falls"] = Vector3.new(-800, 50, -200)
}

-- THEME COLORS (CHLOE X STYLE)
local THEME = {
    Background = Color3.fromRGB(15, 15, 15),
    TitleBar = Color3.fromRGB(20, 20, 20),
    Button = Color3.fromRGB(30, 30, 30),
    ButtonHover = Color3.fromRGB(40, 40, 40),
    Content = Color3.fromRGB(22, 22, 22),
    Accent = Color3.fromRGB(98, 178, 255),
    Success = Color3.fromRGB(46, 204, 113),
    Danger = Color3.fromRGB(255, 84, 84),
    Text = Color3.fromRGB(255, 255, 255),
    TextDim = Color3.fromRGB(160, 160, 160)
}

-- GRADIENT FUNCTION
function addGradient(parent, color1, color2)
    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, color1),
        ColorSequenceKeypoint.new(1, color2)
    })
    gradient.Parent = parent
    return gradient
end

-- SHADOW FUNCTION
function addShadow(parent)
    local shadow = Instance.new("ImageLabel")
    shadow.Name = "Shadow"
    shadow.Size = UDim2.new(1, 12, 1, 12)
    shadow.Position = UDim2.new(0, -6, 0, -6)
    shadow.BackgroundTransparency = 1
    shadow.Image = "rbxassetid://1316045217"
    shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    shadow.ImageTransparency = 0.7
    shadow.ScaleType = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(10, 10, 118, 118)
    shadow.ZIndex = -1
    shadow.Parent = parent
    return shadow
end

-- [MAIN GUI]
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TarzBotUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- [MAIN FRAME]
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 420, 0, 300)
MainFrame.Position = UDim2.new(0.5, -210, 0.5, -150)
MainFrame.BackgroundColor3 = THEME.Background
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ZIndex = 10
MainFrame.Parent = ScreenGui

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)
addShadow(MainFrame)

-- [TITLE BAR]
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 32)
TitleBar.BackgroundColor3 = THEME.TitleBar
TitleBar.BorderSizePixel = 0
TitleBar.ZIndex = 20
TitleBar.Parent = MainFrame

Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 8)

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -70, 0, 16)
TitleLabel.Position = UDim2.new(0, 12, 0, 8)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "TarzBot"
TitleLabel.TextColor3 = THEME.Text
TitleLabel.TextSize = 15
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.ZIndex = 21
TitleLabel.Parent = TitleBar

local VersionLabel = Instance.new("TextLabel")
VersionLabel.Size = UDim2.new(1, -70, 0, 10)
VersionLabel.Position = UDim2.new(0, 12, 0, 18)
VersionLabel.BackgroundTransparency = 1
VersionLabel.Text = "v2.0.0"
VersionLabel.TextColor3 = THEME.TextDim
VersionLabel.TextSize = 9
VersionLabel.Font = Enum.Font.GothamMedium
VersionLabel.TextXAlignment = Enum.TextXAlignment.Left
VersionLabel.ZIndex = 21
VersionLabel.Parent = TitleBar

-- [CONTROL BUTTONS]
local function createControlBtn(text, color, xPos, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 30, 0, 20)
    btn.Position = UDim2.new(1, xPos, 0, 6)
    btn.BackgroundColor3 = color
    btn.BorderSizePixel = 0
    btn.Text = text
    btn.TextColor3 = THEME.Text
    btn.TextSize = 12
    btn.Font = Enum.Font.GothamBold
    btn.AutoButtonColor = false
    btn.ZIndex = 22
    btn.Parent = TitleBar
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 5)
    btn.MouseButton1Click:Connect(callback)
    return btn
end

createControlBtn("-", THEME.Button, -64, function()
    MainFrame.Visible = false
    MinimizedLogo.Visible = true
end)

createControlBtn("×", THEME.Danger, -34, function()
    MainFrame.Visible = false
    MinimizedLogo.Visible = false
end)

-- [MINIMIZED LOGO]
local MinimizedLogo = Instance.new("TextButton")
MinimizedLogo.Size = UDim2.new(0, 48, 0, 48)
MinimizedLogo.Position = UDim2.new(0, 20, 0, 20)
MinimizedLogo.BackgroundColor3 = THEME.Background
MinimizedLogo.BorderSizePixel = 0
MinimizedLogo.Text = "TB"
MinimizedLogo.TextColor3 = THEME.Text
MinimizedLogo.TextSize = 16
MinimizedLogo.Font = Enum.Font.GothamBold
MinimizedLogo.Visible = false
MinimizedLogo.Active = true
MinimizedLogo.Draggable = true
MinimizedLogo.ZIndex = 30
MinimizedLogo.Parent = ScreenGui
Instance.new("UICorner", MinimizedLogo).CornerRadius = UDim.new(0, 8)
addShadow(MinimizedLogo)

MinimizedLogo.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    MinimizedLogo.Visible = false
end)

-- [MENU CONTAINER]
local MenuContainer = Instance.new("Frame")
MenuContainer.Size = UDim2.new(1, 0, 1, -32)
MenuContainer.Position = UDim2.new(0, 0, 0, 32)
MenuContainer.BackgroundTransparency = 1
MenuContainer.ZIndex = 10
MenuContainer.Parent = MainFrame

-- [MENU BUTTONS]
local menus = {
    {icon = "¥", name = "Profile"},
    {icon = "€", name = "Teleport"},
    {icon = "π", name = "Informasi"},
    {icon = "¢", name = "Lain"},
    {icon = "£", name = "Login"}
}

local menuButtons = {}
for i, menu in ipairs(menus) do
    local btn = Instance.new("TextButton")
    btn.Name = menu.name .. "Btn"
    btn.Size = UDim2.new(1, -20, 0, 36)
    btn.Position = UDim2.new(0, 10, 0, 10 + (i-1)*38)
    btn.BackgroundColor3 = THEME.Button
    btn.BorderSizePixel = 0
    btn.Text = "[" .. menu.icon .. "] " .. menu.name
    btn.TextColor3 = THEME.Text
    btn.TextSize = 13
    btn.Font = FONT_NORMAL
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.AutoButtonColor = false
    btn.ZIndex = 12
    btn.Parent = MenuContainer
    
    local pad = Instance.new("UIPadding", btn)
    pad.PaddingLeft = UDim.new(0, 15)
    
    local gradient = addGradient(btn, THEME.Button, Color3.fromRGB(35, 35, 35))
    
    btn.MouseEnter:Connect(function()
        btn.BackgroundColor3 = THEME.ButtonHover
        gradient:Destroy()
    end)
    
    btn.MouseLeave:Connect(function()
        btn.BackgroundColor3 = THEME.Button
        addGradient(btn, THEME.Button, Color3.fromRGB(35, 35, 35))
    end)
    
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 5)
    
    menuButtons[menu.name] = btn
end

-- [CONTENT AREA]
local ContentArea = Instance.new("Frame")
ContentArea.Size = UDim2.new(1, -20, 0, 90)
ContentArea.Position = UDim2.new(0, 10, 0, 200)
ContentArea.BackgroundColor3 = THEME.Content
ContentArea.BorderSizePixel = 0
ContentArea.ZIndex = 10
ContentArea.Parent = MenuContainer

Instance.new("UICorner", ContentArea).CornerRadius = UDim.new(0, 6)

-- [PROFILE VIEW]
local ProfileView = Instance.new("Frame")
ProfileView.Size = UDim2.new(1, 0, 1, 0)
ProfileView.BackgroundTransparency = 1
ProfileView.ZIndex = 11
ProfileView.Parent = ContentArea

local ProfileText = Instance.new("TextLabel")
ProfileText.Size = UDim2.new(1, -20, 1, -10)
ProfileText.Position = UDim2.new(0, 10, 0, 5)
ProfileText.BackgroundTransparency = 1
ProfileText.Text = "Nama : " .. player.Name .. "\nLevel : Loading...\nStatus : Free User"
ProfileText.TextColor3 = THEME.TextDim
ProfileText.TextSize = 12
ProfileText.Font = FONT_NORMAL
ProfileText.TextXAlignment = Enum.TextXAlignment.Left
ProfileText.TextYAlignment = Enum.TextYAlignment.Top
ProfileText.ZIndex = 11
ProfileText.Parent = ProfileView

spawn(function()
    while wait(2) do
        local level = "N/A"
        local data = player:FindFirstChild("Data") or player:FindFirstChild("leaderstats")
        if data then
            local lvl = data:FindFirstChild("Level") or data:FindFirstChild("level")
            if lvl then level = tostring(lvl.Value) end
        end
        ProfileText.Text = "Nama : " .. player.Name .. "\nLevel : " .. level .. "\nStatus : " .. (isLoggedIn and "Premium" or "Free User")
    end
end)

-- [TELEPORT VIEW]
local TeleportView = Instance.new("Frame")
TeleportView.Size = UDim2.new(1, 0, 1, 0)
TeleportView.BackgroundTransparency = 1
TeleportView.Visible = false
TeleportView.ZIndex = 11
TeleportView.Parent = ContentArea

-- Player Dropdown
local PlayerDropdown = Instance.new("ScrollingFrame")
PlayerDropdown.Size = UDim2.new(1, -20, 0, 120)
PlayerDropdown.Position = UDim2.new(0, 10, 0, 5)
PlayerDropdown.BackgroundColor3 = THEME.Content
PlayerDropdown.BorderSizePixel = 0
PlayerDropdown.ScrollBarThickness = 4
PlayerDropdown.ScrollBarImageColor3 = THEME.TextDim
PlayerDropdown.Visible = false
PlayerDropdown.ZIndex = 12
PlayerDropdown.CanvasSize = UDim2.new(0, 0, 0, 0)
PlayerDropdown.Parent = TeleportView

local function populatePlayerDropdown()
    PlayerDropdown:ClearAllChildren()
    local y = 0
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= player then
            local item = Instance.new("TextButton")
            item.Size = UDim2.new(1, 0, 0, 24)
            item.Position = UDim2.new(0, 0, 0, y)
            item.BackgroundTransparency = 1
            item.Text = plr.Name
            item.TextColor3 = THEME.Text
            item.TextSize = 11
            item.Font = FONT_NORMAL
            item.ZIndex = 13
            item.Parent = PlayerDropdown
            
            item.MouseButton1Click:Connect(function()
                PlayerDropdown.Visible = false
                TeleportBtn.Text = "Teleport → " .. plr.Name
                targetPlayer = plr
            end)
            
            y = y + 24
        end
    end
    PlayerDropdown.CanvasSize = UDim2.new(0, 0, 0, y)
end

local TeleportBtn = Instance.new("TextButton")
TeleportBtn.Size = UDim2.new(1, -20, 0, 22)
TeleportBtn.Position = UDim2.new(0, 10, 0, 5)
TeleportBtn.BackgroundColor3 = THEME.Button
TeleportBtn.Text = "Pilih Player →"
TeleportBtn.TextColor3 = THEME.Text
TeleportBtn.TextSize = 11
TeleportBtn.Font = FONT_NORMAL
TeleportBtn.TextXAlignment = Enum.TextXAlignment.Left
TeleportBtn.ZIndex = 12
TeleportBtn.Parent = TeleportView

local pad1 = Instance.new("UIPadding", TeleportBtn)
pad1.PaddingLeft = UDim.new(0, 8)

TeleportBtn.MouseButton1Click:Connect(function()
    PlayerDropdown.Visible = not PlayerDropdown.Visible
    if PlayerDropdown.Visible then
        populatePlayerDropdown()
    end
end)

local TargetPlayer = nil

local ExecuteTeleportBtn = Instance.new("TextButton")
ExecuteTeleportBtn.Size = UDim2.new(1, -20, 0, 24)
ExecuteTeleportBtn.Position = UDim2.new(0, 10, 0, 29)
ExecuteTeleportBtn.BackgroundColor3 = THEME.Success
ExecuteTeleportBtn.Text = "TELEPORT KE PLAYER"
ExecuteTeleportBtn.TextColor3 = THEME.Text
ExecuteTeleportBtn.TextSize = 11
ExecuteTeleportBtn.Font = FONT_BOLD
ExecuteTeleportBtn.ZIndex = 12
ExecuteTeleportBtn.Parent = TeleportView

ExecuteTeleportBtn.MouseButton1Click:Connect(function()
    if not isLoggedIn then
        warn("⛔ LOGIN DULU UNTUK TELEPORT!")
        return
    end
    
    local playerName = TeleportBtn.Text:match("→ (.+)")
    if playerName then
        local target = Players:FindFirstChild(playerName)
        if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            humanoidRootPart.CFrame = CFrame.new(target.Character.HumanoidRootPart.Position + Vector3.new(0, 10, 0))
            warn("✅ Berhasil teleport ke " .. playerName)
        else
            warn("❌ Player tidak ditemukan!")
        end
    else
        warn("❌ Pilih player dulu!")
    end
end)

-- Region Dropdown
local RegionDropdown = Instance.new("ScrollingFrame")
RegionDropdown.Size = UDim2.new(1, -20, 0, 120)
RegionDropdown.Position = UDim2.new(0, 10, 0, 58)
RegionDropdown.BackgroundColor3 = THEME.Content
RegionDropdown.BorderSizePixel = 0
RegionDropdown.ScrollBarThickness = 4
RegionDropdown.ScrollBarImageColor3 = THEME.TextDim
RegionDropdown.Visible = false
RegionDropdown.ZIndex = 12
RegionDropdown.CanvasSize = UDim2.new(0, 0, 0, 0)
RegionDropdown.Parent = TeleportView

local function populateRegionDropdown()
    RegionDropdown:ClearAllChildren()
    local y = 0
    local regions = table.keys(regionData)
    table.sort(regions)
    for _, region in ipairs(regions) do
        local item = Instance.new("TextButton")
        item.Size = UDim2.new(1, 0, 0, 24)
        item.Position = UDim2.new(0, 0, 0, y)
        item.BackgroundTransparency = 1
        item.Text = region
        item.TextColor3 = THEME.Text
        item.TextSize = 11
        item.Font = FONT_NORMAL
        item.ZIndex = 13
        item.Parent = RegionDropdown
        
        item.MouseButton1Click:Connect(function()
            RegionDropdown.Visible = false
            RegionBtn.Text = "Teleport → " .. region
            targetRegion = region
        end)
        
        y = y + 24
    end
    RegionDropdown.CanvasSize = UDim2.new(0, 0, 0, y)
end

table.keys = function(tbl)
    local keys = {}
    for k in pairs(tbl) do
        table.insert(keys, k)
    end
    return keys
end

local RegionBtn = Instance.new("TextButton")
RegionBtn.Size = UDim2.new(1, -20, 0, 22)
RegionBtn.Position = UDim2.new(0, 10, 0, 58)
RegionBtn.BackgroundColor3 = THEME.Button
RegionBtn.Text = "Pilih Region →"
RegionBtn.TextColor3 = THEME.Text
RegionBtn.TextSize = 11
RegionBtn.Font = FONT_NORMAL
RegionBtn.TextXAlignment = Enum.TextXAlignment.Left
RegionBtn.ZIndex = 12
RegionBtn.Parent = TeleportView

local pad2 = Instance.new("UIPadding", RegionBtn)
pad2.PaddingLeft = UDim.new(0, 8)

RegionBtn.MouseButton1Click:Connect(function()
    RegionDropdown.Visible = not RegionDropdown.Visible
    if RegionDropdown.Visible then
        populateRegionDropdown()
    end
end)

local ExecuteRegionBtn = Instance.new("TextButton")
ExecuteRegionBtn.Size = UDim2.new(1, -20, 0, 24)
ExecuteRegionBtn.Position = UDim2.new(0, 10, 0, 82)
ExecuteRegionBtn.BackgroundColor3 = THEME.Accent
ExecuteRegionBtn.Text = "TELEPORT KE REGION"
ExecuteRegionBtn.TextColor3 = THEME.Text
ExecuteRegionBtn.TextSize = 11
ExecuteRegionBtn.Font = FONT_BOLD
ExecuteRegionBtn.ZIndex = 12
ExecuteRegionBtn.Parent = TeleportView

ExecuteRegionBtn.MouseButton1Click:Connect(function()
    if not isLoggedIn then
        warn("⛔ LOGIN DULU UNTUK TELEPORT!")
        return
    end
    
    local regionName = RegionBtn.Text:match("→ (.+)")
    if regionName and regionData[regionName] then
        humanoidRootPart.CFrame = CFrame.new(regionData[regionName] + Vector3.new(0, 10, 0))
        warn("✅ Berhasil teleport ke " .. regionName)
    else
        warn("❌ Pilih region dulu!")
    end
end)

-- [INFO VIEW]
local InfoView = Instance.new("Frame")
InfoView.Size = UDim2.new(1, 0, 1, 0)
InfoView.BackgroundTransparency = 1
InfoView.Visible = false
InfoView.ZIndex = 11
InfoView.Parent = ContentArea

local InfoText = Instance.new("TextLabel")
InfoText.Size = UDim2.new(1, -20, 1, -10)
InfoText.Position = UDim2.new(0, 10, 0, 5)
InfoText.BackgroundTransparency = 1
InfoText.Text = "📱 Telegram: @tarzbot\n📞 WhatsApp: +62 812-3456-7890\n🎵 Tiktok: @_tarzbot\n\n🎮 Powered by TarzBot v2.0"
InfoText.TextColor3 = THEME.TextDim
InfoText.TextSize = 12
InfoText.Font = FONT_NORMAL
InfoText.TextXAlignment = Enum.TextXAlignment.Left
InfoText.TextYAlignment = Enum.TextYAlignment.Top
InfoText.ZIndex = 11
InfoText.Parent = InfoView

-- [LAIN VIEW]
local LainView = Instance.new("Frame")
LainView.Size = UDim2.new(1, 0, 1, 0)
LainView.BackgroundTransparency = 1
LainView.Visible = false
LainView.ZIndex = 11
LainView.Parent = ContentArea

function createSettingToggle(name, labelText, positionY, onToggle)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, -20, 0, 28)
    Frame.Position = UDim2.new(0, 10, 0, positionY)
    Frame.BackgroundTransparency = 1
    Frame.ZIndex = 12
    Frame.Parent = LainView
    
    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -50, 1, 0)
    Label.BackgroundTransparency = 1
    Label.Text = labelText
    Label.TextColor3 = THEME.TextDim
    Label.TextSize = 12
    Label.Font = FONT_NORMAL
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.ZIndex = 12
    Label.Parent = Frame
    
    local Toggle = Instance.new("TextButton")
    Toggle.Name = name
    Toggle.Size = UDim2.new(0, 44, 0, 20)
    Toggle.Position = UDim2.new(1, -44, 0.5, -10)
    Toggle.BackgroundColor3 = THEME.Button
    Toggle.BorderSizePixel = 0
    Toggle.Text = ""
    Toggle.AutoButtonColor = false
    Toggle.ZIndex = 12
    Toggle.Parent = Frame
    
    Instance.new("UICorner", Toggle).CornerRadius = UDim.new(0, 10)
    
    local Indicator = Instance.new("Frame")
    Indicator.Name = "Indicator"
    Indicator.Size = UDim2.new(0, 16, 0, 16)
    Indicator.Position = UDim2.new(0, 2, 0.5, -8)
    Indicator.BackgroundColor3 = THEME.Text
    Indicator.BorderSizePixel = 0
    Indicator.ZIndex = 13
    Indicator.Parent = Toggle
    
    Instance.new("UICorner", Indicator).CornerRadius = UDim.new(0, 8)
    
    local IsOn = false
    
    Toggle.MouseButton1Click:Connect(function()
        IsOn = not IsOn
        Toggle.BackgroundColor3 = IsOn and THEME.Success or THEME.Button
        Indicator.Position = IsOn and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
        
        if onToggle then
            onToggle(IsOn)
        end
    end)
    
    return Toggle
end

-- Animasi Rod Toggle (100% Functional)
createSettingToggle("AnimasiRod", "Animasi Rod", 10, function(enabled)
    if enabled then
        -- Re-enable (harus re-equip rod)
        warn("⚠️ Re-equip fishing rod untuk mengembalikan animasi")
    else
        -- Disable rod animation
        local rod = character:FindFirstChild("Rod") or character:FindFirstChild("FishingRod")
        if rod then
            for _, obj in ipairs(rod:GetDescendants()) do
                if obj:IsA("Animation") or obj:IsA("Animator") then
                    obj:Destroy()
                end
            end
        end
        -- Cari animation di character
        for _, anim in ipairs(character:GetDescendants()) do
            if anim:IsA("Animation") and anim.Name:lower():find("rod") then
                anim:Destroy()
            end
        end
    end
    warn("✅ Animasi Rod " .. (enabled and "ON" or "OFF"))
end)

-- Notifikasi Fish Toggle (100% Functional)
createSettingTogg
