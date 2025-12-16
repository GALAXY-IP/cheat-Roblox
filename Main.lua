-- TarzBot Fish It GUI - VERSI SUPER SIMPLE
-- 100% Semua Tombol Bisa Diklik

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- Data login
local isLoggedIn = false
local correctUsername = "AZKA"
local correctPassword = "AZKA"

-- KOORDINAT FISH IT
local regionData = {
    ["Fisherman Island"] = Vector3.new(0, 50, 0),
    ["Kohana Island"] = Vector3.new(350, 50, -200),
    ["Kohana Volcano"] = Vector3.new(380, 60, -180),
    ["The Ocean"] = Vector3.new(-200, 50, 100),
    ["Coral Reef Island"] = Vector3.new(600, 50, 300),
    ["Tropical Grove Island"] = Vector3.new(900, 50, -400),
    ["Crater Island"] = Vector3.new(-400, 50, 600),
    ["Esoteric Depths"] = Vector3.new(1200, 50, 100),
    ["Sisyphus Statue"] = Vector3.new(800, 30, -800),
    ["Treasure Room"] = Vector3.new(850, 30, -750),
    ["Ancient Jungle"] = Vector3.new(-600, 50, -500),
    ["Sacred Temple"] = Vector3.new(-620, 50, -520),
    ["Underground Cellar"] = Vector3.new(-580, 20, -480),
    ["Classic Island"] = Vector3.new(1500, 50, 0),
    ["Iron Cavern"] = Vector3.new(1480, 40, -50)
}

-- COLORS
local COLORS = {
    BG = Color3.fromRGB(18, 18, 18),
    TITLEBAR = Color3.fromRGB(25, 25, 25),
    BUTTON = Color3.fromRGB(30, 30, 30),
    BUTTON_HOVER = Color3.fromRGB(35, 35, 35),
    CONTENT = Color3.fromRGB(22, 22, 22),
    ACCENT = Color3.fromRGB(52, 152, 219),
    SUCCESS = Color3.fromRGB(46, 204, 113),
    DANGER = Color3.fromRGB(231, 76, 60),
    TEXT = Color3.fromRGB(255, 255, 255),
    TEXT_DIM = Color3.fromRGB(150, 150, 150)
}

-- FONTS
local FONT_BOLD = Enum.Font.GothamBold
local FONT_NORMAL = Enum.Font.Gotham

-- [1] MAIN GUI
local gui = Instance.new("ScreenGui")
gui.Name = "TarzBot"
gui.ResetOnSpawn = false
gui.Parent = game.CoreGui
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- [2] MAIN FRAME
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 360, 0, 240)
frame.Position = UDim2.new(0.5, -180, 0.5, -120)
frame.BackgroundColor3 = COLORS.BG
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.ZIndex = 10
frame.Parent = gui

local frameCorner = Instance.new("UICorner")
frameCorner.CornerRadius = UDim.new(0, 5)
frameCorner.Parent = frame

-- [3] TITLE BAR
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 24)
titleBar.BackgroundColor3 = COLORS.TITLEBAR
titleBar.BorderSizePixel = 0
titleBar.ZIndex = 11
titleBar.Parent = frame

local titleBarCorner = Instance.new("UICorner")
titleBarCorner.CornerRadius = UDim.new(0, 5)
titleBarCorner.Parent = titleBar

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -40, 0, 12)
title.Position = UDim2.new(0, 8, 0, 6)
title.BackgroundTransparency = 1
title.Text = "TarzBot"
title.TextColor3 = COLORS.TEXT
title.TextSize = 11
title.Font = FONT_BOLD
title.ZIndex = 12
title.Parent = titleBar

local version = Instance.new("TextLabel")
version.Size = UDim2.new(1, -40, 0, 8)
version.Position = UDim2.new(0, 8, 0, 14)
version.BackgroundTransparency = 1
version.Text = "v1.0.1"
version.TextColor3 = COLORS.TEXT_DIM
version.TextSize = 7
version.Font = FONT_NORMAL
version.ZIndex = 12
version.Parent = titleBar

-- [4] CONTROL BUTTONS
function createControlBtn(name, text, color, xPos)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Size = UDim2.new(0, 20, 0, 12)
    btn.Position = UDim2.new(1, xPos, 0, 6)
    btn.BackgroundColor3 = color
    btn.BorderSizePixel = 0
    btn.Text = text
    btn.TextColor3 = COLORS.TEXT
    btn.TextSize = 9
    btn.Font = FONT_BOLD
    btn.Active = true
    btn.Selectable = true
    btn.AutoButtonColor = false
    btn.ZIndex = 13
    btn.Parent = titleBar
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 3)
    btnCorner.Parent = btn
    
    return btn
end

local minBtn = createControlBtn("MinBtn", "-", COLORS.BUTTON, -42)
local closeBtn = createControlBtn("CloseBtn", "×", COLORS.DANGER, -22)

-- [5] MINIMIZED LOGO
local logo = Instance.new("TextButton")
logo.Name = "Logo"
logo.Size = UDim2.new(0, 38, 0, 38)
logo.Position = UDim2.new(0, 15, 0, 15)
logo.BackgroundColor3 = COLORS.BG
logo.BorderSizePixel = 0
logo.Text = "TB"
logo.TextColor3 = COLORS.TEXT
logo.TextSize = 11
logo.Font = FONT_BOLD
logo.Visible = false
logo.Active = true
logo.Draggable = true
logo.ZIndex = 20
logo.Parent = gui

local logoCorner = Instance.new("UICorner")
logoCorner.CornerRadius = UDim.new(0, 5)
logoCorner.Parent = logo

-- [6] MENU CONTAINER
local menuContainer = Instance.new("Frame")
menuContainer.Size = UDim2.new(1, 0, 1, -24)
menuContainer.Position = UDim2.new(0, 0, 0, 24)
menuContainer.BackgroundTransparency = 1
menuContainer.ZIndex = 10
menuContainer.Parent = frame

-- [7] MENU BUTTONS
local menus = {
    {icon = "¥", name = "Profile"},
    {icon = "€", name = "Teleport"},
    {icon = "π", name = "Informasi"},
    {icon = "¢", name = "Lain"},
    {icon = "£", name = "Login"}
}

local menuBtns = {}
for i, menu in ipairs(menus) do
    local btn = Instance.new("TextButton")
    btn.Name = menu.name .. "Btn"
    btn.Size = UDim2.new(1, -12, 0, 24)
    btn.Position = UDim2.new(0, 6, 0, 6 + (i-1)*26)
    btn.BackgroundColor3 = COLORS.BUTTON
    btn.BorderSizePixel = 0
    btn.Text = "[" .. menu.icon .. "] " .. menu.name
    btn.TextColor3 = COLORS.TEXT
    btn.TextSize = 9
    btn.Font = FONT_NORMAL
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Active = true
    btn.Selectable = true
    btn.AutoButtonColor = false
    btn.ZIndex = 11
    btn.Parent = menuContainer
    
    local pad = Instance.new("UIPadding")
    pad.PaddingLeft = UDim.new(0, 8)
    pad.Parent = btn
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 3)
    btnCorner.Parent = btn
    
    menuBtns[menu.name] = btn
end

-- [8] CONTENT AREA
local contentArea = Instance.new("Frame")
contentArea.Size = UDim2.new(1, -12, 0, 70)
contentArea.Position = UDim2.new(0, 6, 0, 140)
contentArea.BackgroundColor3 = COLORS.CONTENT
contentArea.BorderSizePixel = 0
contentArea.ZIndex = 10
contentArea.Parent = menuContainer

local contentCorner = Instance.new("UICorner")
contentCorner.CornerRadius = UDim.new(0, 3)
contentCorner.Parent = contentArea

-- [9] PROFILE CONTENT
local profileContent = Instance.new("TextLabel")
profileContent.Name = "ProfileContent"
profileContent.Size = UDim2.new(1, -12, 1, -6)
profileContent.Position = UDim2.new(0, 6, 0, 3)
profileContent.BackgroundTransparency = 1
profileContent.Text = "Nama : " .. player.Name .. "\nLevel : N/A\nStatus : Free"
profileContent.TextColor3 = COLORS.TEXT_DIM
profileContent.TextSize = 8
profileContent.Font = FONT_NORMAL
profileContent.TextXAlignment = Enum.TextXAlignment.Left
profileContent.TextYAlignment = Enum.TextYAlignment.Top
profileContent.ZIndex = 11
profileContent.Parent = contentArea

-- [10] TELEPORT CONTENT
local tpContent = Instance.new("Frame")
tpContent.Name = "TeleportContent"
tpContent.Size = UDim2.new(1, 0, 1, 0)
tpContent.BackgroundTransparency = 1
tpContent.Visible = false
tpContent.ZIndex = 11
tpContent.Parent = contentArea

local tpPeopleLabel = Instance.new("TextLabel")
tpPeopleLabel.Size = UDim2.new(1, -12, 0, 12)
tpPeopleLabel.Position = UDim2.new(0, 6, 0, 4)
tpPeopleLabel.BackgroundTransparency = 1
tpPeopleLabel.Text = "Player Name:"
tpPeopleLabel.TextColor3 = COLORS.TEXT_DIM
tpPeopleLabel.TextSize = 8
tpPeopleLabel.Font = FONT_NORMAL
tpPeopleLabel.TextXAlignment = Enum.TextXAlignment.Left
tpPeopleLabel.ZIndex = 12
tpPeopleLabel.Parent = tpContent

local tpPeopleInput = Instance.new("TextBox")
tpPeopleInput.Name = "PlayerInput"
tpPeopleInput.Size = UDim2.new(1, -12, 0, 14)
tpPeopleInput.Position = UDim2.new(0, 6, 0, 17)
tpPeopleInput.BackgroundColor3 = COLORS.BUTTON
tpPeopleInput.BorderSizePixel = 0
tpPeopleInput.PlaceholderText = "Ketik nama player..."
tpPeopleInput.Text = ""
tpPeopleInput.TextColor3 = COLORS.TEXT
tpPeopleInput.TextSize = 8
tpPeopleInput.Font = FONT_NORMAL
tpPeopleInput.ClearTextOnFocus = false
tpPeopleInput.ZIndex = 12
tpPeopleInput.Parent = tpContent

local tpPlayerBtn = Instance.new("TextButton")
tpPlayerBtn.Size = UDim2.new(1, -12, 0, 14)
tpPlayerBtn.Position = UDim2.new(0, 6, 0, 33)
tpPlayerBtn.BackgroundColor3 = COLORS.SUCCESS
tpPlayerBtn.BorderSizePixel = 0
tpPlayerBtn.Text = "Teleport To Player"
tpPlayerBtn.TextColor3 = COLORS.TEXT
tpPlayerBtn.TextSize = 8
tpPlayerBtn.Font = FONT_BOLD
tpPlayerBtn.Active = true
tpPlayerBtn.Selectable = true
tpPlayerBtn.AutoButtonColor = false
tpPlayerBtn.ZIndex = 12
tpPlayerBtn.Parent = tpContent

local tpRegionLabel = Instance.new("TextLabel")
tpRegionLabel.Size = UDim2.new(1, -12, 0, 12)
tpRegionLabel.Position = UDim2.new(0, 6, 0, 50)
tpRegionLabel.BackgroundTransparency = 1
tpRegionLabel.Text = "Region Name:"
tpRegionLabel.TextColor3 = COLORS.TEXT_DIM
tpRegionLabel.TextSize = 8
tpRegionLabel.Font = FONT_NORMAL
tpRegionLabel.TextXAlignment = Enum.TextXAlignment.Left
tpRegionLabel.ZIndex = 12
tpRegionLabel.Parent = tpContent

local tpRegionInput = Instance.new("TextBox")
tpRegionInput.Name = "RegionInput"
tpRegionInput.Size = UDim2.new(1, -12, 0, 14)
tpRegionInput.Position = UDim2.new(0, 6, 0, 63)
tpRegionInput.BackgroundColor3 = COLORS.BUTTON
tpRegionInput.BorderSizePixel = 0
tpRegionInput.PlaceholderText = "Ketik nama region..."
tpRegionInput.Text = ""
tpRegionInput.TextColor3 = COLORS.TEXT
tpRegionInput.TextSize = 8
tpRegionInput.Font = FONT_NORMAL
tpRegionInput.ClearTextOnFocus = false
tpRegionInput.ZIndex = 12
tpRegionInput.Parent = tpContent

local tpRegionExeBtn = Instance.new("TextButton")
tpRegionExeBtn.Size = UDim2.new(1, -12, 0, 14)
tpRegionExeBtn.Position = UDim2.new(0, 6, 0, 79)
tpRegionExeBtn.BackgroundColor3 = COLORS.SUCCESS
tpRegionExeBtn.BorderSizePixel = 0
tpRegionExeBtn.Text = "Teleport To Region"
tpRegionExeBtn.TextColor3 = COLORS.TEXT
tpRegionExeBtn.TextSize = 8
tpRegionExeBtn.Font = FONT_BOLD
tpRegionExeBtn.Active = true
tpRegionExeBtn.Selectable = true
tpRegionExeBtn.AutoButtonColor = false
tpRegionExeBtn.ZIndex = 12
tpRegionExeBtn.Parent = tpContent

-- [GUI] INFO CONTENT
local infoContent = Instance.new("TextLabel")
infoContent.Name = "InfoContent"
infoContent.Size = UDim2.new(1, -12, 1, -6)
infoContent.Position = UDim2.new(0, 6, 0, 3)
infoContent.BackgroundTransparency = 1
infoContent.Visible = false
infoContent.Text = "Telegram: @tarzbot\nWhatsApp: 0812345678\nTiktok: @_tarzbot"
infoContent.TextColor3 = COLORS.TEXT_DIM
infoContent.TextSize = 8
infoContent.Font = FONT_NORMAL
infoContent.TextXAlignment = Enum.TextXAlignment.Left
infoContent.TextYAlignment = Enum.TextYAlignment.Top
infoContent.ZIndex = 11
infoContent.Parent = contentArea

-- [GUI] LAIN CONTENT
local lainFrame = Instance.new("Frame")
lainFrame.Name = "LainContent"
lainFrame.Size = UDim2.new(1, 0, 1, 0)
lainFrame.BackgroundTransparency = 1
lainFrame.Visible = false
lainFrame.ZIndex = 11
lainFrame.Parent = contentArea

function createToggle(name, text, yPos)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -12, 0, 16)
    frame.Position = UDim2.new(0, 6, 0, yPos)
    frame.BackgroundTransparency = 1
    frame.ZIndex = 12
    frame.Parent = lainFrame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -40, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = COLORS.TEXT_DIM
    label.TextSize = 8
    label.Font = FONT_NORMAL
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 12
    label.Parent = frame
    
    local toggle = Instance.new("TextButton")
    toggle.Name = name
    toggle.Size = UDim2.new(0, 28, 0, 12)
    toggle.Position = UDim2.new(1, -28, 0.5, -6)
    toggle.BackgroundColor3 = COLORS.BUTTON
    toggle.BorderSizePixel = 0
    toggle.Text = ""
    toggle.Active = true
    toggle.Selectable = true
    toggle.AutoButtonColor = false
    toggle.ZIndex = 12
    toggle.Parent = frame
    
    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 6)
    toggleCorner.Parent = toggle
    
    local ind = Instance.new("Frame")
    ind.Name = "Indicator"
    ind.Size = UDim2.new(0, 8, 0, 8)
    ind.Position = UDim2.new(0, 2, 0.5, -4)
    ind.BackgroundColor3 = COLORS.TEXT
    ind.BorderSizePixel = 0
    ind.ZIndex = 13
    ind.Parent = toggle
    
    local indCorner = Instance.new("UICorner")
    indCorner.CornerRadius = UDim.new(0, 4)
    indCorner.Parent = ind
    
    return toggle
end

local toggle1 = createToggle("AnimasiRod", "Animasi Rod", 4)
local toggle2 = createToggle("NotifikasiFish", "Notifikasi Fish", 24)
local toggle3 = createToggle("AnimasiEfek", "Animasi Efek Rod", 44)

-- [GUI] LOGIN CONTENT
local loginFrame = Instance.new("Frame")
loginFrame.Name = "LoginContent"
loginFrame.Size = UDim2.new(1, 0, 1, 0)
loginFrame.BackgroundTransparency = 1
loginFrame.Visible = false
loginFrame.ZIndex = 11
loginFrame.Parent = contentArea

local userBox = Instance.new("TextBox")
userBox.Name = "Username"
userBox.Size = UDim2.new(1, -12, 0, 14)
userBox.Position = UDim2.new(0, 6, 0, 8)
userBox.BackgroundColor3 = COLORS.BUTTON
userBox.BorderSizePixel = 0
userBox.PlaceholderText = "Username"
userBox.Text = ""
userBox.TextColor3 = COLORS.TEXT
userBox.TextSize = 8
userBox.Font = FONT_NORMAL
userBox.ZIndex = 12
userBox.Parent = loginFrame

local passBox = Instance.new("TextBox")
passBox.Name = "Password"
passBox.Size = UDim2.new(1, -12, 0, 14)
passBox.Position = UDim2.new(0, 6, 0, 28)
passBox.BackgroundColor3 = COLORS.BUTTON
passBox.BorderSizePixel = 0
passBox.PlaceholderText = "Password"
passBox.Text = ""
passBox.TextColor3 = COLORS.TEXT
passBox.TextSize = 8
userBox.Font = FONT_NORMAL
passBox.ZIndex = 12
passBox.Parent = loginFrame

local loginBtn = Instance.new("TextButton")
loginBtn.Size = UDim2.new(1, -12, 0, 14)
loginBtn.Position = UDim2.new(0, 6, 0, 48)
loginBtn.BackgroundColor3 = COLORS.ACCENT
loginBtn.BorderSizePixel = 0
loginBtn.Text = "Login"
loginBtn.TextColor3 = COLORS.TEXT
loginBtn.TextSize = 8
loginBtn.Font = FONT_BOLD
loginBtn.Active = true
loginBtn.Selectable = true
loginBtn.AutoButtonColor = false
loginBtn.ZIndex = 12
loginBtn.Parent = loginFrame

-- [GUI] STATUS BAR
local statusBar = Instance.new("Frame")
statusBar.Name = "StatusFrame"
statusBar.Size = UDim2.new(0, 100, 0, 16)
statusBar.Position = UDim2.new(1, -110, 0, 6)
statusBar.BackgroundColor3 = COLORS.BG
statusBar.BorderSizePixel = 0
statusBar.ZIndex = 10
statusBar.Parent = gui

local statusCorner = Instance.new("UICorner")
statusCorner.CornerRadius = UDim.new(0, 3)
statusCorner.Parent = statusBar

local statusText = Instance.new("TextLabel")
statusText.Name = "StatusText"
statusText.Size = UDim2.new(1, 0, 1, 0)
statusText.BackgroundTransparency = 1
statusText.Text = "Status: Free"
statusText.TextColor3 = COLORS.TEXT_DIM
statusText.TextSize = 7
statusText.Font = FONT_NORMAL
statusText.TextXAlignment = Enum.TextXAlignment.Center
statusText.ZIndex = 11
statusText.Parent = statusBar

-- [FUNCTIONS]
function hideAll()
    profileContent.Visible = false
    tpContent.Visible = false
    infoContent.Visible = false
    lainFrame.Visible = false
    loginFrame.Visible = false
end

function showContent(name)
    hideAll()
    for _, btn in pairs(menuBtns) do
        btn.BackgroundColor3 = COLORS.BUTTON
    end
    
    if name == "Profile" then
        menuBtns["Profile"].BackgroundColor3 = COLORS.BUTTON_HOVER
        profileContent.Visible = true
        profileContent.Text = "Nama : " .. player.Name .. "\nLevel : N/A\nStatus : " .. (isLoggedIn and "Premium" or "Free")
    elseif name == "Teleport" then
        menuBtns["Teleport"].BackgroundColor3 = COLORS.BUTTON_HOVER
        tpContent.Visible = true
    elseif name == "Informasi" then
        menuBtns["Informasi"].BackgroundColor3 = COLORS.BUTTON_HOVER
        infoContent.Visible = true
    elseif name == "Lain" then
        menuBtns["Lain"].BackgroundColor3 = COLORS.BUTTON_HOVER
        lainFrame.Visible = true
    elseif name == "Login" then
        menuBtns["Login"].BackgroundColor3 = COLORS.BUTTON_HOVER
        loginFrame.Visible = true
    end
end

-- [EVENTS] - TANPA RIBET
minBtn.MouseButton1Click:Connect(function()
    print("✅ MINIMIZE CLICKED")
    frame.Visible = false
    logo.Visible = true
end)

closeBtn.MouseButton1Click:Connect(function()
    print("✅ CLOSE CLICKED")
    frame.Visible = false
    logo.Visible = false
end)

logo.MouseButton1Click:Connect(function()
    print("✅ LOGO CLICKED")
    frame.Visible = true
    logo.Visible = false
end)

-- MENU BUTTONS
for name, btn in pairs(menuBtns) do
    btn.MouseButton1Click:Connect(function()
        print("✅ MENU " .. name .. " CLICKED")
        showContent(name)
    end)
end

-- TELEPORT PLAYER
tpPlayerBtn.MouseButton1Click:Connect(function()
    print("✅ TP PLAYER CLICKED")
    local targetName = tpPeopleInput.Text
    local target = Players:FindFirstChild(targetName)
    if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
        character.HumanoidRootPart.CFrame = CFrame.new(target.Character.HumanoidRootPart.Position + Vector3.new(0, 10, 0))
        warn("✅ Teleport ke " .. targetName)
    else
        warn("❌ Player tidak ditemukan")
    end
end)

-- TELEPORT REGION
tpRegionExeBtn.MouseButton1Click:Connect(function()
    print("✅ TP REGION CLICKED")
    local regionName = tpRegionInput.Text
    if regionData[regionName] then
        character.HumanoidRootPart.CFrame = CFrame.new(regionData[regionName] + Vector3.new(0, 10, 0))
        warn("✅ Teleport ke " .. regionName)
    else
        warn("❌ Region tidak ditemukan")
    end
end)

-- TOGGLES
local function setupToggle(toggle)
    toggle.MouseButton1Click:Connect(function()
        print("✅ TOGGLE " .. toggle.Name .. " CLICKED")
        local isOn = toggle.BackgroundColor3 == COLORS.SUCCESS
        toggle.BackgroundColor3 = isOn and COLORS.BUTTON or COLORS.SUCCESS
        toggle.Indicator.Position = isOn and UDim2.new(0, 2, 0.5, -4) or UDim2.new(1, -10, 0.5, -4)
    end)
end

setupToggle(toggle1)
setupToggle(toggle2)
setupToggle(toggle3)

-- LOGIN
loginBtn.MouseButton1Click:Connect(function()
    print("✅ LOGIN CLICKED")
    if userBox.Text == correctUsername and passBox.Text == correctPassword then
        isLoggedIn = true
        statusText.Text = "Status: Premium"
        statusText.TextColor3 = COLORS.SUCCESS
        userBox.Text = ""
        passBox.Text = ""
        showContent("Profile")
        warn("🔓 LOGIN BERHASIL!")
    else
        warn("❌ USERNAME/PASSWORD SALAH!")
        passBox.Text = ""
    end
end)

-- [INIT]
showContent("Profile")
statusText.Text = "Status: Free"

warn("✅ TARZBOT SIMPLIFIED LOADED!")
warn("💡 Semua tombol sudah di-activate!")
warn("🎯 Klik menu untuk mulai!")
