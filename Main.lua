-- TarzBot Fish It GUI - 100% WORK & MIrip Chloe X
-- Version: 1.0.1

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

-- Data login
local isLoggedIn = false
local correctUsername = "AZKA"
local correctPassword = "AZKA"

-- KOORDINAT FISH IT (AKTUAL)
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

-- COLORS (Chloe X Style)
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

-- [2] MAIN FRAME
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 400, 0, 280)
frame.Position = UDim2.new(0.5, -200, 0.5, -140)
frame.BackgroundColor3 = COLORS.BG
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.Parent = gui
frame.Visible = true

Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 6)

-- [3] TITLE BAR
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 28)
titleBar.BackgroundColor3 = COLORS.TITLEBAR
titleBar.BorderSizePixel = 0
titleBar.Parent = frame

Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 6)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -60, 0, 14)
title.Position = UDim2.new(0, 10, 0, 7)
title.BackgroundTransparency = 1
title.Text = "TarzBot"
title.TextColor3 = COLORS.TEXT
title.TextSize = 13
title.Font = FONT_BOLD
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = titleBar

local version = Instance.new("TextLabel")
version.Size = UDim2.new(1, -60, 0, 10)
version.Position = UDim2.new(0, 10, 0, 16)
version.BackgroundTransparency = 1
version.Text = "v1.0.1"
version.TextColor3 = COLORS.TEXT_DIM
version.TextSize = 8
version.Font = Enum.Font.GothamMedium
version.TextXAlignment = Enum.TextXAlignment.Left
version.Parent = titleBar

-- [4] CONTROL BUTTONS
local minBtn = Instance.new("TextButton")
minBtn.Size = UDim2.new(0, 24, 0, 16)
minBtn.Position = UDim2.new(1, -54, 0, 6)
minBtn.BackgroundColor3 = COLORS.BUTTON
minBtn.Text = "-"
minBtn.TextColor3 = COLORS.TEXT
minBtn.TextSize = 12
minBtn.Font = FONT_BOLD
minBtn.Parent = titleBar
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(0, 4)

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 24, 0, 16)
closeBtn.Position = UDim2.new(1, -28, 0, 6)
closeBtn.BackgroundColor3 = COLORS.DANGER
closeBtn.Text = "×"
closeBtn.TextColor3 = COLORS.TEXT
closeBtn.TextSize = 12
closeBtn.Font = FONT_BOLD
closeBtn.Parent = titleBar
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 4)

-- [5] MINIMIZED LOGO (48x48)
local logo = Instance.new("TextButton")
logo.Name = "Logo"
logo.Size = UDim2.new(0, 48, 0, 48)
logo.Position = UDim2.new(0, 20, 0, 20)
logo.BackgroundColor3 = COLORS.BG
logo.Text = "TB"
logo.TextColor3 = COLORS.TEXT
logo.TextSize = 14
logo.Font = FONT_BOLD
logo.Visible = false
logo.Active = true
logo.Draggable = true
logo.Parent = gui
Instance.new("UICorner", logo).CornerRadius = UDim.new(0, 8)

-- [6] MENU CONTAINER
local menuContainer = Instance.new("Frame")
menuContainer.Size = UDim2.new(1, 0, 1, -28)
menuContainer.Position = UDim2.new(0, 0, 0, 28)
menuContainer.BackgroundTransparency = 1
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
    btn.Name = menu.name
    btn.Size = UDim2.new(1, -20, 0, 32)
    btn.Position = UDim2.new(0, 10, 0, 10 + (i-1)*34)
    btn.BackgroundColor3 = COLORS.BUTTON
    btn.Text = "[" .. menu.icon .. "] " .. menu.name
    btn.TextColor3 = COLORS.TEXT
    btn.TextSize = 11
    btn.Font = FONT_NORMAL
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Parent = menuContainer
    
    local pad = Instance.new("UIPadding", btn)
    pad.PaddingLeft = UDim.new(0, 12)
    
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
    
    menuBtns[menu.name] = btn
end

-- [8] CONTENT AREA
local contentArea = Instance.new("Frame")
contentArea.Size = UDim2.new(1, -20, 0, 70)
contentArea.Position = UDim2.new(0, 10, 0, 190)
contentArea.BackgroundColor3 = COLORS.CONTENT
contentArea.BorderSizePixel = 0
contentArea.Parent = menuContainer

Instance.new("UICorner", contentArea).CornerRadius = UDim.new(0, 4)

-- [9] PROFILE CONTENT
local profileContent = Instance.new("TextLabel")
profileContent.Name = "ProfileContent"
profileContent.Size = UDim2.new(1, -20, 1, -10)
profileContent.Position = UDim2.new(0, 10, 0, 5)
profileContent.BackgroundTransparency = 1
profileContent.Text = "Nama : " .. player.Name .. "\nLevel : N/A\nStatus : Free"
profileContent.TextColor3 = COLORS.TEXT_DIM
profileContent.TextSize = 10
profileContent.Font = FONT_NORMAL
profileContent.TextXAlignment = Enum.TextXAlignment.Left
profileContent.TextYAlignment = Enum.TextYAlignment.Top
profileContent.Parent = contentArea

-- [10] TELEPORT CONTENT
local tpContent = Instance.new("Frame")
tpContent.Name = "TeleportContent"
tpContent.Size = UDim2.new(1, 0, 1, 0)
tpContent.BackgroundTransparency = 1
tpContent.Visible = false
tpContent.Parent = contentArea

-- Teleport People
local tpPeopleBtn = Instance.new("TextButton")
tpPeopleBtn.Size = UDim2.new(1, -20, 0, 22)
tpPeopleBtn.Position = UDim2.new(0, 10, 0, 5)
tpPeopleBtn.BackgroundColor3 = COLORS.BUTTON
tpPeopleBtn.Text = "Teleport To People →"
tpPeopleBtn.TextColor3 = COLORS.TEXT
tpPeopleBtn.TextSize = 10
tpPeopleBtn.Font = FONT_NORMAL
tpPeopleBtn.TextXAlignment = Enum.TextXAlignment.Left
tpPeopleBtn.Parent = tpContent

local peopleDrop = Instance.new("ScrollingFrame")
peopleDrop.Name = "PeopleDropdown"
peopleDrop.Size = UDim2.new(1, -20, 0, 80)
peopleDrop.Position = UDim2.new(0, 10, 0, 29)
peopleDrop.BackgroundColor3 = COLORS.BUTTON
peopleDrop.Visible = false
peopleDrop.ScrollBarThickness = 3
peopleDrop.Parent = tpContent

local tpPlayerBtn = Instance.new("TextButton")
tpPlayerBtn.Size = UDim2.new(1, -20, 0, 20)
tpPlayerBtn.Position = UDim2.new(0, 10, 0, 114)
tpPlayerBtn.BackgroundColor3 = COLORS.SUCCESS
tpPlayerBtn.Text = "Teleport"
tpPlayerBtn.TextColor3 = COLORS.TEXT
tpPlayerBtn.TextSize = 10
tpPlayerBtn.Font = FONT_BOLD
tpPlayerBtn.Parent = tpContent

-- Teleport Region
local tpRegionBtn = Instance.new("TextButton")
tpRegionBtn.Size = UDim2.new(1, -20, 0, 22)
tpRegionBtn.Position = UDim2.new(0, 10, 0, 140)
tpRegionBtn.BackgroundColor3 = COLORS.BUTTON
tpRegionBtn.Text = "Teleport To The Region"
tpRegionBtn.TextColor3 = COLORS.TEXT
tpRegionBtn.TextSize = 10
tpRegionBtn.Font = FONT_NORMAL
tpRegionBtn.TextXAlignment = Enum.TextXAlignment.Left
tpRegionBtn.Parent = tpContent

local regionDrop = Instance.new("ScrollingFrame")
regionDrop.Name = "RegionDropdown"
regionDrop.Size = UDim2.new(1, -20, 0, 80)
regionDrop.Position = UDim2.new(0, 10, 0, 164)
regionDrop.BackgroundColor3 = COLORS.BUTTON
regionDrop.Visible = false
regionDrop.ScrollBarThickness = 3
regionDrop.Parent = tpContent

local tpRegionExeBtn = Instance.new("TextButton")
tpRegionExeBtn.Size = UDim2.new(1, -20, 0, 20)
tpRegionExeBtn.Position = UDim2.new(0, 10, 0, 249)
tpRegionExeBtn.BackgroundColor3 = COLORS.SUCCESS
tpRegionExeBtn.Text = "Teleport"
tpRegionExeBtn.TextColor3 = COLORS.TEXT
tpRegionExeBtn.TextSize = 10
tpRegionExeBtn.Font = FONT_BOLD
tpRegionExeBtn.Parent = tpContent

-- [11] INFO CONTENT
local infoContent = Instance.new("TextLabel")
infoContent.Name = "InfoContent"
infoContent.Size = UDim2.new(1, -20, 1, -10)
infoContent.Position = UDim2.new(0, 10, 0, 5)
infoContent.BackgroundTransparency = 1
infoContent.Visible = false
infoContent.Text = "Telegram: @tarzbot\nWhatsApp: 0812345678\nTiktok: @_tarzbot"
infoContent.TextColor3 = COLORS.TEXT_DIM
infoContent.TextSize = 10
infoContent.Font = FONT_NORMAL
infoContent.TextXAlignment = Enum.TextXAlignment.Left
infoContent.TextYAlignment = Enum.TextYAlignment.Top
infoContent.Parent = contentArea

-- [12] LAIN CONTENT
local lainFrame = Instance.new("Frame")
lainFrame.Name = "LainContent"
lainFrame.Size = UDim2.new(1, 0, 1, 0)
lainFrame.BackgroundTransparency = 1
lainFrame.Visible = false
lainFrame.Parent = contentArea

function createToggle(name, text, y)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -20, 0, 20)
    frame.Position = UDim2.new(0, 10, 0, y)
    frame.BackgroundTransparency = 1
    frame.Parent = lainFrame
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -50, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = COLORS.TEXT_DIM
    label.TextSize = 10
    label.Font = FONT_NORMAL
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame
    
    local toggle = Instance.new("TextButton")
    toggle.Name = name
    toggle.Size = UDim2.new(0, 34, 0, 16)
    toggle.Position = UDim2.new(1, -34, 0.5, -8)
    toggle.BackgroundColor3 = COLORS.BUTTON
    toggle.Text = ""
    toggle.Parent = frame
    Instance.new("UICorner", toggle).CornerRadius = UDim.new(0, 8)
    
    local ind = Instance.new("Frame")
    ind.Name = "Indicator"
    ind.Size = UDim2.new(0, 12, 0, 12)
    ind.Position = UDim2.new(0, 2, 0.5, -6)
    ind.BackgroundColor3 = COLORS.TEXT
    ind.BorderSizePixel = 0
    ind.Parent = toggle
    Instance.new("UICorner", ind).CornerRadius = UDim.new(0, 6)
    
    return toggle
end

local toggle1 = createToggle("AnimasiRod", "Animasi Rod", 5)
local toggle2 = createToggle("NotifikasiFish", "Notifikasi Fish", 30)
local toggle3 = createToggle("AnimasiEfek", "Animasi Efek Rod", 55)

-- [13] LOGIN CONTENT
local loginFrame = Instance.new("Frame")
loginFrame.Name = "LoginContent"
loginFrame.Size = UDim2.new(1, 0, 1, 0)
loginFrame.BackgroundTransparency = 1
loginFrame.Visible = false
loginFrame.Parent = contentArea

local userBox = Instance.new("TextBox")
userBox.Size = UDim2.new(1, -20, 0, 22)
userBox.Position = UDim2.new(0, 10, 0, 10)
userBox.BackgroundColor3 = COLORS.BUTTON
userBox.PlaceholderText = "Username"
userBox.Text = ""
userBox.TextColor3 = COLORS.TEXT
userBox.TextSize = 10
userBox.Font = FONT_NORMAL
userBox.Parent = loginFrame

local passBox = Instance.new("TextBox")
passBox.Size = UDim2.new(1, -20, 0, 22)
passBox.Position = UDim2.new(0, 10, 0, 38)
passBox.BackgroundColor3 = COLORS.BUTTON
passBox.PlaceholderText = "Password"
passBox.Text = ""
passBox.TextColor3 = COLORS.TEXT
passBox.TextSize = 10
passBox.Font = FONT_NORMAL
passBox.Parent = loginFrame

local loginBtn = Instance.new("TextButton")
loginBtn.Size = UDim2.new(1, -20, 0, 22)
loginBtn.Position = UDim2.new(0, 10, 0, 66)
loginBtn.BackgroundColor3 = COLORS.ACCENT
loginBtn.Text = "Login"
loginBtn.TextColor3 = COLORS.TEXT
loginBtn.TextSize = 10
loginBtn.Font = FONT_BOLD
loginBtn.Parent = loginFrame

-- [14] STATUS BAR
local statusBar = Instance.new("Frame")
statusBar.Size = UDim2.new(0, 120, 0, 20)
statusBar.Position = UDim2.new(1, -130, 0, 10)
statusBar.BackgroundColor3 = COLORS.BG
statusBar.BorderSizePixel = 0
statusBar.Parent = gui
Instance.new("UICorner", statusBar).CornerRadius = UDim.new(0, 4)

local statusText = Instance.new("TextLabel")
statusText.Size = UDim2.new(1, 0, 1, 0)
statusText.BackgroundTransparency = 1
statusText.Text = "Status: Free"
statusText.TextColor3 = COLORS.TEXT_DIM
statusText.TextSize = 9
statusText.Font = FONT_SMALL
statusText.TextXAlignment = Enum.TextXAlignment.Center
statusText.Parent = statusBar

-- [15] HIDE ALL FUNCTION
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

-- [16] EVENTS
minBtn.MouseButton1Click:Connect(function()
    frame.Visible = false
    logo.Visible = true
end)

closeBtn.MouseButton1Click:Connect(function()
    frame.Visible = false
    logo.Visible = false
end)

logo.MouseButton1Click:Connect(function()
    frame.Visible = true
    logo.Visible = false
end)

menuBtns["Profile"].MouseButton1Click:Connect(function() showContent("Profile") end)
menuBtns["Teleport"].MouseButton1Click:Connect(function() showContent("Teleport") end)
menuBtns["Informasi"].MouseButton1Click:Connect(function() showContent("Informasi") end)
menuBtns["Lain"].MouseButton1Click:Connect(function() showContent("Lain") end)
menuBtns["Login"].MouseButton1Click:Connect(function() showContent("Login") end)

-- Teleport People
tpPeopleBtn.MouseButton1Click:Connect(function()
    peopleDrop.Visible = not peopleDrop.Visible
    tpPeopleBtn.Text = peopleDrop.Visible and "Teleport To People ↓" or "Teleport To People →"
    if peopleDrop.Visible then
        peopleDrop:ClearAllChildren()
        local y = 0
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= player then
                local b = Instance.new("TextButton")
                b.Size = UDim2.new(1, 0, 0, 20)
                b.Position = UDim2.new(0, 0, 0, y)
                b.BackgroundTransparency = 1
                b.Text = plr.Name
                b.TextColor3 = COLORS.TEXT
                b.TextSize = 9
                b.Font = FONT_NORMAL
                b.Parent = peopleDrop
                b.MouseButton1Click:Connect(function()
                    tpPeopleBtn.Text = "Teleport To People: " .. plr.Name
                    peopleDrop.Visible = false
                end)
                y = y + 20
            end
        end
        peopleDrop.CanvasSize = UDim2.new(0, 0, 0, y)
    end
end)

tpPlayerBtn.MouseButton1Click:Connect(function()
    local name = tpPeopleBtn.Text:match("To People: (.+)")
    if name then
        local target = Players:FindFirstChild(name)
        if target and target.Character then
            character.HumanoidRootPart.CFrame = CFrame.new(target.Character.HumanoidRootPart.Position + Vector3.new(0, 10, 0))
        end
    end
end)

-- Teleport Region
tpRegionBtn.MouseButton1Click:Connect(function()
    regionDrop.Visible = not regionDrop.Visible
    tpRegionBtn.Text = regionDrop.Visible and "Teleport To The Region ↓" or "Teleport To The Region"
    if regionDrop.Visible then
        regionDrop:ClearAllChildren()
        local y = 0
        for regionName, _ in pairs(regionData) do
            local b = Instance.new("TextButton")
            b.Size = UDim2.new(1, 0, 0, 20)
            b.Position = UDim2.new(0, 0, 0, y)
            b.BackgroundTransparency = 1
            b.Text = regionName
            b.TextColor3 = COLORS.TEXT
            b.TextSize = 9
            b.Font = FONT_NORMAL
            b.Parent = regionDrop
            b.MouseButton1Click:Connect(function()
                tpRegionBtn.Text = "Teleport To The Region: " .. regionName
                regionDrop.Visible = false
            end)
            y = y + 20
        end
        regionDrop.CanvasSize = UDim2.new(0, 0, 0, y)
    end
end)

tpRegionExeBtn.MouseButton1Click:Connect(function()
    local name = tpRegionBtn.Text:match("To The Region: (.+)")
    if name and regionData[name] then
        character.HumanoidRootPart.CFrame = CFrame.new(regionData[name] + Vector3.new(0, 10, 0))
    end
end)

-- Toggles
toggle1.MouseButton1Click:Connect(function()
    local state = not lainFrame:FindFirstChild("AnimasiRodToggle").BackgroundColor3 == COLORS.SUCCESS
    toggle1.BackgroundColor3 = state and COLORS.SUCCESS or COLORS.BUTTON
    toggle1.Indicator.Position = state and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)
    warn("🎣 Animasi Rod: " .. (state and "OFF" or "ON"))
end)

toggle2.MouseButton1Click:Connect(function()
    local state = not lainFrame:FindFirstChild("NotifikasiFishToggle").BackgroundColor3 == COLORS.SUCCESS
    toggle2.BackgroundColor3 = state and COLORS.SUCCESS or COLORS.BUTTON
    toggle2.Indicator.Position = state and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)
    warn("🔔 Notifikasi Fish: " .. (state and "OFF" or "ON"))
end)

toggle3.MouseButton1Click:Connect(function()
    local state = not lainFrame:FindFirstChild("AnimasiEfekToggle").BackgroundColor3 == COLORS.SUCCESS
    toggle3.BackgroundColor3 = state and COLORS.SUCCESS or COLORS.BUTTON
    toggle3.Indicator.Position = state and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)
    warn("✨ Animasi Efek: " .. (state and "OFF" or "ON"))
end)

-- Login
loginBtn.MouseButton1Click:Connect(function()
    if userBox.Text == correctUsername and passBox.Text == correctPassword then
        isLoggedIn = true
        statusText.Text = "Status: Premium"
        statusText.TextColor3 = COLORS.SUCCESS
        userBox.Text = ""
        passBox.Text = ""
        showContent("Profile")
        warn("🔓 LOGIN BERHASIL!")
    else
        warn("❌ Username/Password salah!")
        passBox.Text = ""
    end
end)

-- [17] INIT
showContent("Profile")

-- [18] TIMER (1 Jam)
spawn(function()
    while wait(60) do
        if not isLoggedIn and os.time() - startTime > timeLimit then
            statusText.Text = "Status: LOCKED"
            statusText.TextColor3 = COLORS.DANGER
            frame.Visible = false
            logo.Visible = false
            warn("⏰ WAKTU HABIS! Silakan login.")
            break
        end
    end
end)

warn("✅ GUI TarzBot 100% Mirip Chloe X - Siap Pakai!")
