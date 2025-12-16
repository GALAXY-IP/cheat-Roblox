-- TarzBot Fish It GUI - ULTRA MINIMAL
-- Version: 1.2.0 (100% Work)

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
    SUCCESS = Color3.fromRGB(46, 204, 113),
    DANGER = Color3.fromRGB(231, 76, 60),
    TEXT = Color3.fromRGB(255, 255, 255),
    TEXT_DIM = Color3.fromRGB(150, 150, 150)
}

-- FONTS
local FONT_BOLD = Enum.Font.GothamBold
local FONT_NORMAL = Enum.Font.Gotham

-- [1] MAIN GUI (PASTI MUNCUL)
local gui = Instance.new("ScreenGui")
gui.Name = "TarzBot"
gui.ResetOnSpawn = false
gui.Parent = game.CoreGui
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

warn("✅ Step 1: ScreenGui created")

-- [2] MAIN FRAME
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 360, 0, 260)
frame.Position = UDim2.new(0.5, -180, 0.5, -130)
frame.BackgroundColor3 = COLORS.BG
frame.BorderSizePixel = 0
frame.Active = true
frame.Draggable = true
frame.ZIndex = 10
frame.Parent = gui

warn("✅ Step 2: MainFrame created")

-- [3] TITLE BAR
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 24)
titleBar.BackgroundColor3 = COLORS.TITLEBAR
titleBar.BorderSizePixel = 0
titleBar.ZIndex = 11
titleBar.Parent = frame

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

-- [4] CONTROL BUTTONS
local function createControlBtn(text, color, xPos)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 20, 0, 12)
    btn.Position = UDim2.new(1, xPos, 0, 6)
    btn.BackgroundColor3 = color
    btn.BorderSizePixel = 0
    btn.Text = text
    btn.TextColor3 = COLORS.TEXT
    btn.TextSize = 9
    btn.Font = FONT_BOLD
    btn.AutoButtonColor = false
    btn.ZIndex = 13
    btn.Parent = titleBar
    return btn
end

local minBtn = createControlBtn("-", COLORS.BUTTON, -34)
local closeBtn = createControlBtn("×", COLORS.DANGER, -18)

-- [5] MINIMIZED LOGO
local logo = Instance.new("TextButton")
logo.Size = UDim2.new(0, 36, 0, 36)
logo.Position = UDim2.new(0, 15, 0, 15)
logo.BackgroundColor3 = COLORS.BG
logo.Text = "TB"
logo.TextColor3 = COLORS.TEXT
logo.TextSize = 12
logo.Font = FONT_BOLD
logo.Visible = false
logo.Active = true
logo.Draggable = true
logo.ZIndex = 20
logo.Parent = gui

-- [6] MENU CONTAINER
local menuContainer = Instance.new("Frame")
menuContainer.Size = UDim2.new(1, 0, 1, -24)
menuContainer.Position = UDim2.new(0, 0, 0, 24)
menuContainer.BackgroundTransparency = 1
menuContainer.ZIndex = 10
menuContainer.Parent = frame

warn("✅ Step 3: MenuContainer created")

-- [7] MENU BUTTONS (5 BUTTON PASTI MUNCUL)
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
    btn.Size = UDim2.new(1, -10, 0, 28)
    btn.Position = UDim2.new(0, 5, 0, 6 + (i-1)*30)
    btn.BackgroundColor3 = COLORS.BUTTON
    btn.BorderSizePixel = 0
    btn.Text = "[" .. menu.icon .. "] " .. menu.name
    btn.TextColor3 = COLORS.TEXT
    btn.TextSize = 10
    btn.Font = FONT_NORMAL
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.AutoButtonColor = false
    btn.ZIndex = 11
    btn.Parent = menuContainer
    
    local pad = Instance.new("UIPadding", btn)
    pad.PaddingLeft = UDim.new(0, 10)
    
    warn("✅ Menu button " .. menu.name .. " created")
    menuBtns[menu.name] = btn
end

-- [8] CONTENT AREA
local contentArea = Instance.new("Frame")
contentArea.Size = UDim2.new(1, -10, 0, 70)
contentArea.Position = UDim2.new(0, 5, 0, 160)
contentArea.BackgroundColor3 = COLORS.CONTENT
contentArea.BorderSizePixel = 0
contentArea.ZIndex = 10
contentArea.Parent = menuContainer

warn("✅ Step 4: ContentArea created")

-- [9] PROFILE VIEW (DEFAULT)
local profileView = Instance.new("Frame")
profileView.Name = "ProfileView"
profileView.Size = UDim2.new(1, 0, 1, 0)
profileView.BackgroundTransparency = 1
profileView.ZIndex = 11
profileView.Parent = contentArea

local profileText = Instance.new("TextLabel")
profileText.Size = UDim2.new(1, -10, 1, -5)
profileText.Position = UDim2.new(0, 5, 0, 3)
profileText.BackgroundTransparency = 1
profileText.Text = "Nama : " .. player.Name .. "\nLevel : Loading...\nStatus : Free"
profileText.TextColor3 = COLORS.TEXT_DIM
profileText.TextSize = 9
profileText.Font = FONT_NORMAL
profileText.TextXAlignment = Enum.TextXAlignment.Left
profileText.TextYAlignment = Enum.TextYAlignment.Top
profileText.Parent = profileView

warn("✅ Step 5: ProfileView created")

-- [10] TELEPORT VIEW
local teleportView = Instance.new("Frame")
teleportView.Name = "TeleportView"
teleportView.Size = UDim2.new(1, 0, 1, 0)
teleportView.BackgroundTransparency = 1
teleportView.Visible = false
teleportView.ZIndex = 11
teleportView.Parent = contentArea

-- Player Input
local playerInput = Instance.new("TextBox")
playerInput.Name = "PlayerInput"
playerInput.Size = UDim2.new(1, -10, 0, 14)
playerInput.Position = UDim2.new(0, 5, 0, 5)
playerInput.BackgroundColor3 = COLORS.BUTTON
playerInput.BorderSizePixel = 0
playerInput.Text = ""
playerInput.PlaceholderText = "Nama player..."
playerInput.TextColor3 = COLORS.TEXT
playerInput.TextSize = 8
playerInput.Font = FONT_NORMAL
playerInput.ZIndex = 12
playerInput.Parent = teleportView

local teleportPlayerBtn = Instance.new("TextButton")
teleportPlayerBtn.Size = UDim2.new(1, -10, 0, 14)
teleportPlayerBtn.Position = UDim2.new(0, 5, 0, 21)
teleportPlayerBtn.BackgroundColor3 = COLORS.SUCCESS
teleportPlayerBtn.BorderSizePixel = 0
teleportPlayerBtn.Text = "TELEPORT PLAYER"
teleportPlayerBtn.TextColor3 = COLORS.TEXT
teleportPlayerBtn.TextSize = 8
teleportPlayerBtn.Font = FONT_BOLD
teleportPlayerBtn.ZIndex = 12
teleportPlayerBtn.Parent = teleportView

-- Region Input
local regionInput = Instance.new("TextBox")
regionInput.Name = "RegionInput"
regionInput.Size = UDim2.new(1, -10, 0, 14)
regionInput.Position = UDim2.new(0, 5, 0, 39)
regionInput.BackgroundColor3 = COLORS.BUTTON
regionInput.BorderSizePixel = 0
regionInput.Text = ""
regionInput.PlaceholderText = "Nama region..."
regionInput.TextColor3 = COLORS.TEXT
regionInput.TextSize = 8
regionInput.Font = FONT_NORMAL
regionInput.ZIndex = 12
regionInput.Parent = teleportView

local teleportRegionBtn = Instance.new("TextButton")
teleportRegionBtn.Size = UDim2.new(1, -10, 0, 14)
teleportRegionBtn.Position = UDim2.new(0, 5, 0, 55)
teleportRegionBtn.BackgroundColor3 = COLORS.SUCCESS
teleportRegionBtn.BorderSizePixel = 0
teleportRegionBtn.Text = "TELEPORT REGION"
teleportRegionBtn.TextColor3 = COLORS.TEXT
teleportRegionBtn.TextSize = 8
teleportRegionBtn.Font = FONT_BOLD
teleportRegionBtn.ZIndex = 12
teleportRegionBtn.Parent = teleportView

warn("✅ Step 6: TeleportView created")

-- [11] INFO VIEW
local infoView = Instance.new("Frame")
infoView.Name = "InfoView"
infoView.Size = UDim2.new(1, 0, 1, 0)
infoView.BackgroundTransparency = 1
infoView.Visible = false
infoView.ZIndex = 11
infoView.Parent = contentArea

local infoText = Instance.new("TextLabel")
infoText.Size = UDim2.new(1, -10, 1, -5)
infoText.Position = UDim2.new(0, 5, 0, 3)
infoText.BackgroundTransparency = 1
infoText.Text = "Telegram: @tarzbot\nWhatsApp: 0812345678\nTiktok: @_tarzbot"
infoText.TextColor3 = COLORS.TEXT_DIM
infoText.TextSize = 9
infoText.Font = FONT_NORMAL
infoText.TextXAlignment = Enum.TextXAlignment.Left
infoText.TextYAlignment = Enum.TextYAlignment.Top
infoText.Parent = infoView

warn("✅ Step 7: InfoView created")

-- [12] LAIN VIEW
local lainView = Instance.new("Frame")
lainView.Name = "LainView"
lainView.Size = UDim2.new(1, 0, 1, 0)
lainView.BackgroundTransparency = 1
lainView.Visible = false
lainView.ZIndex = 11
lainView.Parent = contentArea

function createToggle(name, text, yPos)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -10, 0, 16)
    frame.Position = UDim2.new(0, 5, 0, yPos)
    frame.BackgroundTransparency = 1
    frame.ZIndex = 12
    frame.Parent = lainView
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -50, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = COLORS.TEXT_DIM
    label.TextSize = 8
    label.Font = FONT_NORMAL
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame
    
    local toggle = Instance.new("TextButton")
    toggle.Name = name
    toggle.Size = UDim2.new(0, 30, 0, 12)
    toggle.Position = UDim2.new(1, -30, 0.5, -6)
    toggle.BackgroundColor3 = COLORS.BUTTON
    toggle.BorderSizePixel = 0
    toggle.Text = ""
    toggle.AutoButtonColor = false
    toggle.ZIndex = 12
    toggle.Parent = frame
    
    Instance.new("UICorner", toggle).CornerRadius = UDim.new(0, 6)
    
    local ind = Instance.new("Frame")
    ind.Name = "Indicator"
    ind.Size = UDim2.new(0, 8, 0, 8)
    ind.Position = UDim2.new(0, 2, 0.5, -4)
    ind.BackgroundColor3 = COLORS.TEXT
    ind.BorderSizePixel = 0
    ind.ZIndex = 13
    ind.Parent = toggle
    
    Instance.new("UICorner", ind).CornerRadius = UDim.new(0, 4)
    
    return toggle
end

local toggle1 = createToggle("AnimasiRod", "Animasi Rod", 5)
local toggle2 = createToggle("NotifikasiFish", "Notifikasi Fish", 25)
local toggle3 = createToggle("AnimasiEfekRod", "Animasi Efek Rod", 45)

warn("✅ Step 8: LainView created")

-- [13] LOGIN VIEW
local loginView = Instance.new("Frame")
loginView.Name = "LoginView"
loginView.Size = UDim2.new(1, 0, 1, 0)
loginView.BackgroundTransparency = 1
loginView.Visible = false
loginView.ZIndex = 11
loginView.Parent = contentArea

local userBox = Instance.new("TextBox")
userBox.Size = UDim2.new(1, -10, 0, 14)
userBox.Position = UDim2.new(0, 5, 0, 8)
userBox.BackgroundColor3 = COLORS.BUTTON
userBox.BorderSizePixel = 0
userBox.PlaceholderText = "Username..."
userBox.Text = ""
userBox.TextColor3 = COLORS.TEXT
userBox.TextSize = 8
userBox.Font = FONT_NORMAL
userBox.ZIndex = 12
userBox.Parent = loginView

local passBox = Instance.new("TextBox")
passBox.Size = UDim2.new(1, -10, 0, 14)
passBox.Position = UDim2.new(0, 5, 0, 26)
passBox.BackgroundColor3 = COLORS.BUTTON
passBox.BorderSizePixel = 0
passBox.PlaceholderText = "Password..."
passBox.Text = ""
userBox.Font = FONT_NORMAL
passBox.TextColor3 = COLORS.TEXT
passBox.TextSize = 8
passBox.ZIndex = 12
passBox.Parent = loginView

local loginExeBtn = Instance.new("TextButton")
loginExeBtn.Size = UDim2.new(1, -10, 0, 14)
loginExeBtn.Position = UDim2.new(0, 5, 0, 44)
loginExeBtn.BackgroundColor3 = COLORS.SUCCESS
loginExeBtn.BorderSizePixel = 0
loginExeBtn.Text = "LOGIN"
loginExeBtn.TextColor3 = COLORS.TEXT
loginExeBtn.TextSize = 8
loginExeBtn.Font = FONT_BOLD
loginExeBtn.ZIndex = 12
loginExeBtn.Parent = loginView

warn("✅ Step 9: LoginView created")

-- [14] STATUS BAR
local statusBar = Instance.new("Frame")
statusBar.Size = UDim2.new(0, 100, 0, 14)
statusBar.Position = UDim2.new(1, -108, 0, 5)
statusBar.BackgroundColor3 = COLORS.BG
statusBar.BorderSizePixel = 0
statusBar.ZIndex = 10
statusBar.Parent = gui

Instance.new("UICorner", statusBar).CornerRadius = UDim.new(0, 3)

local statusText = Instance.new("TextLabel")
statusText.Size = UDim2.new(1, 0, 1, 0)
statusText.BackgroundTransparency = 1
statusText.Text = "Status: Free"
statusText.TextColor3 = COLORS.TEXT_DIM
statusText.TextSize = 7
statusText.Font = FONT_NORMAL
statusText.TextXAlignment = Enum.TextXAlignment.Center
statusText.ZIndex = 11
statusText.Parent = statusBar

warn("✅ Step 10: StatusBar created")

-- [15] FUNCTIONS
function hideAllViews()
    profileView.Visible = false
    teleportView.Visible = false
    infoView.Visible = false
    lainView.Visible = false
    loginView.Visible = false
end

function showView(viewName)
    hideAllViews()
    for _, btn in pairs(menuBtns) do
        btn.BackgroundColor3 = COLORS.BUTTON
    end
    
    if viewName == "Profile" then
        menuBtns["Profile"].BackgroundColor3 = COLORS.BUTTON_HOVER
        profileView.Visible = true
    elseif viewName == "Teleport" then
        menuBtns["Teleport"].BackgroundColor3 = COLORS.BUTTON_HOVER
        teleportView.Visible = true
    elseif viewName == "Informasi" then
        menuBtns["Informasi"].BackgroundColor3 = COLORS.BUTTON_HOVER
        infoView.Visible = true
    elseif viewName == "Lain" then
        menuBtns["Lain"].BackgroundColor3 = COLORS.BUTTON_HOVER
        lainView.Visible = true
    elseif viewName == "Login" then
        menuBtns["Login"].BackgroundColor3 = COLORS.BUTTON_HOVER
        loginView.Visible = true
    end
end

warn("✅ Step 11: Functions created")

-- [16] EVENTS (SIMPLE & ROBUST)
minBtn.MouseButton1Click:Connect(function()
    warn("MINIMIZE CLICKED")
    frame.Visible = false
    logo.Visible = true
end)

closeBtn.MouseButton1Click:Connect(function()
    warn("CLOSE CLICKED")
    frame.Visible = false
    logo.Visible = false
end)

logo.MouseButton1Click:Connect(function()
    warn("LOGO CLICKED")
    frame.Visible = true
    logo.Visible = false
end)

-- Menu Events
for name, btn in pairs(menuBtns) do
    btn.MouseButton1Click:Connect(function()
        warn("MENU " .. name .. " CLICKED")
        showView(name)
    end)
end

-- Teleport Player
teleportPlayerBtn.MouseButton1Click:Connect(function()
    local playerName = playerInput.Text
    if playerName == "" then
        warn("❌ Isi nama player!")
        return
    end
    
    local target = Players:FindFirstChild(playerName)
    if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
        character.HumanoidRootPart.CFrame = CFrame.new(target.Character.HumanoidRootPart.Position + Vector3.new(0, 10, 0))
        warn("✅ Teleport ke " .. playerName)
    else
        warn("❌ Player tidak ditemukan!")
    end
end)

-- Teleport Region
teleportRegionBtn.MouseButton1Click:Connect(function()
    local regionName = regionInput.Text
    if regionName == "" then
        warn("❌ Isi nama region!")
        return
    end
    
    if regionData[regionName] then
        character.HumanoidRootPart.CFrame = CFrame.new(regionData[regionName] + Vector3.new(0, 10, 0))
        warn("✅ Teleport ke " .. regionName)
    else
        warn("❌ Region tidak ditemukan!")
        warn("📍 List region: " .. table.concat(table.keys(regionData), ", "))
    end
end)

-- Toggles
local function setupToggle(toggle, settingName)
    toggle.MouseButton1Click:Connect(function()
        local isOn = toggle.BackgroundColor3 == COLORS.SUCCESS
        toggle.BackgroundColor3 = isOn and COLORS.BUTTON or COLORS.SUCCESS
        toggle.Indicator.Position = isOn and UDim2.new(0, 2, 0.5, -4) or UDim2.new(1, -10, 0.5, -4)
        
        if settingName == "Animasi Rod" then
            if not isOn then
                -- Disable
                local rod = character:FindFirstChild("Rod") or character:FindFirstChild("FishingRod")
                if rod then
                    for _, obj in ipairs(rod:GetDescendants()) do
                        if obj:IsA("Animation") or obj:IsA("Animator") then
                            obj:Destroy()
                        end
                    end
                end
                warn("✅ Animasi Rod OFF")
            else
                warn("⚠️ Re-equip rod untuk mengembalikan animasi")
            end
        elseif settingName == "Notifikasi Fish" then
            if not isOn then
                -- Disable notifications
                local notifGui = player.PlayerGui:FindFirstChild("FishNotification")
                if notifGui then notifGui.Enabled = false end
                warn("✅ Notifikasi Fish OFF")
            else
                local notifGui = player.PlayerGui:FindFirstChild("FishNotification")
                if notifGui then notifGui.Enabled = true end
                warn("✅ Notifikasi Fish ON")
            end
        elseif settingName == "Animasi Efek Rod" then
            if not isOn then
                -- Disable effects
                for _, obj in ipairs(character:GetDescendants()) do
                    if obj:IsA("ParticleEmitter") or obj:IsA("Beam") or obj:IsA("Trail") then
                        obj.Enabled = false
                    end
                end
                warn("✅ Efek Rod OFF")
            else
                for _, obj in ipairs(character:GetDescendants()) do
                    if obj:IsA("ParticleEmitter") or obj:IsA("Beam") or obj:IsA("Trail") then
                        obj.Enabled = true
                    end
                end
                warn("✅ Efek Rod ON")
            end
        end
    end)
end

setupToggle(toggle1, "Animasi Rod")
setupToggle(toggle2, "Notifikasi Fish")
setupToggle(toggle3, "Animasi Efek Rod")

-- Login
loginBtn.MouseButton1Click:Connect(function()
    if userBox.Text == correctUsername and passBox.Text == correctPassword then
        isLoggedIn = true
        statusText.Text = "Status: Premium"
        statusText.TextColor3 = COLORS.SUCCESS
        userBox.Text = ""
        passBox.Text = ""
        showView("Profile")
        warn("🔓 LOGIN BERHASIL! Semua fitur aktif!")
    else
        warn("❌ USERNAME/PASSWORD SALAH!")
        passBox.Text = ""
    end
end)

warn("✅ Step 12: Events connected")

-- [17] INIT
showView("Profile")
statusText.Text = "Status: Free"

warn("✅ Step 13: GUI INIT DONE!")
warn("🎉 TarzBot Fish It GUI v1.2.0 siap pakai!")
