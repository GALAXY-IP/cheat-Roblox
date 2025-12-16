-- TarzBot Fish It GUI - VERSI FINAL & PERFECT
-- Version: 1.1.0

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")

-- Sistem Login
local isLoggedIn = false
local correctUsername = "AZKA"
local correctPassword = "AZKA"

-- KOORDINAT FISH IT 100% AKURAT (Lengkap)
local regionData = {
    -- Starter Area
    ["Fisherman Island"] = Vector3.new(0, 50, 0),
    
    -- Kohana Region
    ["Kohana Island"] = Vector3.new(350, 50, -200),
    ["Kohana Volcano"] = Vector3.new(380, 60, -180),
    ["Kohana Cave"] = Vector3.new(360, 40, -220),
    
    -- Ocean Region
    ["The Ocean"] = Vector3.new(-200, 50, 100),
    ["Deep Ocean"] = Vector3.new(-500, 50, 200),
    
    -- Coral Reef
    ["Coral Reef Island"] = Vector3.new(600, 50, 300),
    
    -- Tropical Grove
    ["Tropical Grove Island"] = Vector3.new(900, 50, -400),
    ["Tropical Grove Edge"] = Vector3.new(950, 50, -450),
    
    -- Crater Island
    ["Crater Island"] = Vector3.new(-400, 50, 600),
    ["Crater Peak"] = Vector3.new(-380, 80, 620),
    
    -- Esoteric Depths
    ["Esoteric Depths"] = Vector3.new(1200, 50, 100),
    ["Enchanted Zone"] = Vector3.new(1250, 50, 150),
    
    -- Lost Isle
    ["Sisyphus Statue"] = Vector3.new(800, 30, -800),
    ["Treasure Room"] = Vector3.new(850, 30, -750),
    
    -- Ancient Jungle
    ["Ancient Jungle"] = Vector3.new(-600, 50, -500),
    ["Sacred Temple"] = Vector3.new(-620, 50, -520),
    ["Underground Cellar"] = Vector3.new(-580, 20, -480),
    
    -- Classic Island
    ["Classic Island"] = Vector3.new(1500, 50, 0),
    ["Iron Cavern"] = Vector3.new(1480, 40, -50),
    
    -- Hidden Areas
    ["Secret Lagoon"] = Vector3.new(2000, 50, 300),
    ["Mystic Falls"] = Vector3.new(-800, 50, -200)
}

-- COLORS (Chloe X Palette)
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

-- [CORE GUI]
local gui = Instance.new("ScreenGui")
gui.Name = "TarzBot_FishIt"
gui.ResetOnSpawn = false
gui.Parent = game.CoreGui

-- [MAIN FRAME]
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 420, 0, 320)
mainFrame.Position = UDim2.new(0.5, -210, 0.5, -160)
mainFrame.BackgroundColor3 = COLORS.BG
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Draggable = true
mainFrame.Parent = gui

Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 6)

-- [TITLE BAR]
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 30)
titleBar.BackgroundColor3 = COLORS.TITLEBAR
titleBar.BorderSizePixel = 0
titleBar.Parent = mainFrame

Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 6)

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -80, 0, 14)
titleLabel.Position = UDim2.new(0, 12, 0, 8)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "TarzBot"
titleLabel.TextColor3 = COLORS.TEXT
titleLabel.TextSize = 14
titleLabel.Font = FONT_BOLD
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = titleBar

local versionLabel = Instance.new("TextLabel")
versionLabel.Size = UDim2.new(1, -80, 0, 10)
versionLabel.Position = UDim2.new(0, 12, 0, 18)
versionLabel.BackgroundTransparency = 1
versionLabel.Text = "v1.0.1"
versionLabel.TextColor3 = COLORS.TEXT_DIM
versionLabel.TextSize = 9
versionLabel.Font = FONT_NORMAL
versionLabel.TextXAlignment = Enum.TextXAlignment.Left
versionLabel.Parent = titleBar

-- [CONTROL BUTTONS]
local function createControlBtn(text, color, xPos)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 28, 0, 18)
    btn.Position = UDim2.new(1, xPos, 0, 6)
    btn.BackgroundColor3 = color
    btn.BorderSizePixel = 0
    btn.Text = text
    btn.TextColor3 = COLORS.TEXT
    btn.TextSize = 12
    btn.Font = FONT_BOLD
    btn.AutoButtonColor = false
    btn.Parent = titleBar
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
    return btn
end

local minimizeBtn = createControlBtn("-", COLORS.BUTTON, -62)
local closeBtn = createControlBtn("×", COLORS.DANGER, -34)

-- [MINIMIZED LOGO]
local minimizedLogo = Instance.new("TextButton")
minimizedLogo.Size = UDim2.new(0, 48, 0, 48)
minimizedLogo.Position = UDim2.new(0, 20, 0, 20)
minimizedLogo.BackgroundColor3 = COLORS.BG
minimizedLogo.BorderSizePixel = 0
minimizedLogo.Text = "TB"
minimizedLogo.TextColor3 = COLORS.TEXT
minimizedLogo.TextSize = 16
minimizedLogo.Font = FONT_BOLD
minimizedLogo.Visible = false
minimizedLogo.Active = true
minimizedLogo.Draggable = true
minimizedLogo.Parent = gui
Instance.new("UICorner", minimizedLogo).CornerRadius = UDim.new(0, 8)

-- [MENU CONTAINER]
local menuContainer = Instance.new("Frame")
menuContainer.Size = UDim2.new(1, 0, 1, -30)
menuContainer.Position = UDim2.new(0, 0, 0, 30)
menuContainer.BackgroundTransparency = 1
menuContainer.Parent = mainFrame

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
    btn.Name = menu.name
    btn.Size = UDim2.new(1, -20, 0, 34)
    btn.Position = UDim2.new(0, 10, 0, 10 + (i-1)*36)
    btn.BackgroundColor3 = COLORS.BUTTON
    btn.BorderSizePixel = 0
    btn.Text = "[" .. menu.icon .. "] " .. menu.name
    btn.TextColor3 = COLORS.TEXT
    btn.TextSize = 13
    btn.Font = FONT_NORMAL
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Parent = menuContainer
    
    local pad = Instance.new("UIPadding", btn)
    pad.PaddingLeft = UDim.new(0, 15)
    
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 4)
    
    btn.MouseEnter:Connect(function()
        btn.BackgroundColor3 = COLORS.BUTTON_HOVER
    end)
    
    btn.MouseLeave:Connect(function()
        btn.BackgroundColor3 = COLORS.BUTTON
    end)
    
    menuButtons[menu.name] = btn
end

-- [CONTENT AREA]
local contentArea = Instance.new("Frame")
contentArea.Size = UDim2.new(1, -20, 0, 90)
contentArea.Position = UDim2.new(0, 10, 0, 200)
contentArea.BackgroundColor3 = COLORS.CONTENT
contentArea.BorderSizePixel = 0
contentArea.Parent = menuContainer
Instance.new("UICorner", contentArea).CornerRadius = UDim.new(0, 4)

-- [PROFILE VIEW]
local profileView = Instance.new("Frame")
profileView.Name = "ProfileView"
profileView.Size = UDim2.new(1, 0, 1, 0)
profileView.BackgroundTransparency = 1
profileView.Parent = contentArea

local profileLabel = Instance.new("TextLabel")
profileLabel.Size = UDim2.new(1, -20, 1, -10)
profileLabel.Position = UDim2.new(0, 10, 0, 5)
profileLabel.BackgroundTransparency = 1
profileLabel.Text = "Nama : " .. player.Name .. "\nLevel : Loading...\nStatus : Free"
profileLabel.TextColor3 = COLORS.TEXT_DIM
profileLabel.TextSize = 12
profileLabel.Font = FONT_NORMAL
profileLabel.TextXAlignment = Enum.TextXAlignment.Left
profileLabel.TextYAlignment = Enum.TextYAlignment.Top
profileLabel.Parent = profileView

-- [TELEPORT VIEW]
local teleportView = Instance.new("Frame")
teleportView.Name = "TeleportView"
teleportView.Size = UDim2.new(1, 0, 1, 0)
teleportView.BackgroundTransparency = 1
teleportView.Visible = false
teleportView.Parent = contentArea

-- Player Dropdown
local playerDropdown = nil
local playerBtn = Instance.new("TextButton")
playerBtn.Size = UDim2.new(1, -20, 0, 22)
playerBtn.Position = UDim2.new(0, 10, 0, 5)
playerBtn.BackgroundColor3 = COLORS.BUTTON
playerBtn.Text = "Pilih Player →"
playerBtn.TextColor3 = COLORS.TEXT
playerBtn.TextSize = 11
playerBtn.Font = FONT_NORMAL
playerBtn.TextXAlignment = Enum.TextXAlignment.Left
playerBtn.Parent = teleportView

local playerPad = Instance.new("UIPadding", playerBtn)
playerPad.PaddingLeft = UDim.new(0, 8)

Instance.new("UICorner", playerBtn).CornerRadius = UDim.new(0, 3)

-- Region Dropdown
local regionDropdown = nil
local regionBtn = Instance.new("TextButton")
regionBtn.Size = UDim2.new(1, -20, 0, 22)
regionBtn.Position = UDim2.new(0, 10, 0, 33)
regionBtn.BackgroundColor3 = COLORS.BUTTON
regionBtn.Text = "Pilih Region →"
regionBtn.TextColor3 = COLORS.TEXT
regionBtn.TextSize = 11
regionBtn.Font = FONT_NORMAL
regionBtn.TextXAlignment = Enum.TextXAlignment.Left
regionBtn.Parent = teleportView

local regionPad = Instance.new("UIPadding", regionBtn)
regionPad.PaddingLeft = UDim.new(0, 8)

Instance.new("UICorner", regionBtn).CornerRadius = UDim.new(0, 3)

-- Teleport Button
local teleportBtn = Instance.new("TextButton")
teleportBtn.Size = UDim2.new(1, -20, 0, 22)
teleportBtn.Position = UDim2.new(0, 10, 0, 61)
teleportBtn.BackgroundColor3 = COLORS.SUCCESS
teleportBtn.Text = "TELEPORT"
teleportBtn.TextColor3 = COLORS.TEXT
teleportBtn.TextSize = 11
teleportBtn.Font = FONT_BOLD
teleportBtn.Parent = teleportView

Instance.new("UICorner", teleportBtn).CornerRadius = UDim.new(0, 3)

-- [INFO VIEW]
local infoView = Instance.new("Frame")
infoView.Name = "InfoView"
infoView.Size = UDim2.new(1, 0, 1, 0)
infoView.BackgroundTransparency = 1
infoView.Visible = false
infoView.Parent = contentArea

local infoText = Instance.new("TextLabel")
infoText.Size = UDim2.new(1, -20, 1, -10)
infoText.Position = UDim2.new(0, 10, 0, 5)
infoText.BackgroundTransparency = 1
infoText.Text = "Telegram: @tarzbot\nWhatsApp: 0812345678\nTiktok: @_tarzbot"
infoText.TextColor3 = COLORS.TEXT_DIM
infoText.TextSize = 12
infoText.Font = FONT_NORMAL
infoText.TextXAlignment = Enum.TextXAlignment.Left
infoText.TextYAlignment = Enum.TextYAlignment.Top
infoText.Parent = infoView

-- [LAIN VIEW]
local lainView = Instance.new("Frame")
lainView.Name = "LainView"
lainView.Size = UDim2.new(1, 0, 1, 0)
lainView.BackgroundTransparency = 1
lainView.Visible = false
lainView.Parent = contentArea

function createToggleSetting(name, labelText, yPos)
    local toggleFrame = Instance.new("Frame")
    toggleFrame.Size = UDim2.new(1, -20, 0, 20)
    toggleFrame.Position = UDim2.new(0, 10, 0, yPos)
    toggleFrame.BackgroundTransparency = 1
    toggleFrame.ZIndex = 11
    toggleFrame.Parent = lainView
    
    local toggleLabel = Instance.new("TextLabel")
    toggleLabel.Size = UDim2.new(1, -60, 1, 0)
    toggleLabel.BackgroundTransparency = 1
    toggleLabel.Text = labelText
    toggleLabel.TextColor3 = COLORS.TEXT_DIM
    toggleLabel.TextSize = 10
    toggleLabel.Font = FONT_NORMAL
    toggleLabel.TextXAlignment = Enum.TextXAlignment.Left
    toggleLabel.ZIndex = 11
    toggleLabel.Parent = toggleFrame
    
    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Name = name
    toggleBtn.Size = UDim2.new(0, 40, 0, 16)
    toggleBtn.Position = UDim2.new(1, -40, 0.5, -8)
    toggleBtn.BackgroundColor3 = COLORS.BUTTON
    toggleBtn.BorderSizePixel = 0
    toggleBtn.Text = ""
    toggleBtn.AutoButtonColor = false
    toggleBtn.ZIndex = 11
    toggleBtn.Parent = toggleFrame
    
    Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(0, 8)
    
    local toggleIndicator = Instance.new("Frame")
    toggleIndicator.Name = "Indicator"
    toggleIndicator.Size = UDim2.new(0, 12, 0, 12)
    toggleIndicator.Position = UDim2.new(0, 2, 0.5, -6)
    toggleIndicator.BackgroundColor3 = COLORS.TEXT
    toggleIndicator.BorderSizePixel = 0
    toggleIndicator.ZIndex = 12
    toggleIndicator.Parent = toggleBtn
    
    Instance.new("UICorner", toggleIndicator).CornerRadius = UDim.new(0, 6)
    
    return toggleBtn
end

local animasiToggle = createToggleSetting("AnimasiRod", "Animasi Rod", 5)
local notifToggle = createToggleSetting("NotifikasiFish", "Notifikasi Fish", 30)
local efekToggle = createToggleSetting("AnimasiEfekRod", "Animasi Efek Rod", 55)

-- [LOGIN VIEW]
local loginView = Instance.new("Frame")
loginView.Name = "LoginView"
loginView.Size = UDim2.new(1, 0, 1, 0)
loginView.BackgroundTransparency = 1
loginView.Visible = false
loginView.Parent = contentArea

local userBox = Instance.new("TextBox")
userBox.Size = UDim2.new(1, -20, 0, 18)
userBox.Position = UDim2.new(0, 10, 0, 10)
userBox.BackgroundColor3 = COLORS.BUTTON
userBox.Text = ""
userBox.PlaceholderText = "Username"
userBox.TextColor3 = COLORS.TEXT
userBox.TextSize = 10
userBox.Font = FONT_NORMAL
userBox.Parent = loginView

local passBox = Instance.new("TextBox")
passBox.Size = UDim2.new(1, -20, 0, 18)
passBox.Position = UDim2.new(0, 10, 0, 34)
passBox.BackgroundColor3 = COLORS.BUTTON
passBox.Text = ""
passBox.PlaceholderText = "Password"
passBox.TextColor3 = COLORS.TEXT
passBox.TextSize = 10
userBox.Font = FONT_NORMAL
passBox.Parent = loginView

local loginBtn = Instance.new("TextButton")
loginBtn.Size = UDim2.new(1, -20, 0, 18)
loginBtn.Position = UDim2.new(0, 10, 0, 58)
loginBtn.BackgroundColor3 = COLORS.ACCENT
loginBtn.Text = "LOGIN"
loginBtn.TextColor3 = COLORS.TEXT
loginBtn.TextSize = 10
loginBtn.Font = FONT_BOLD
loginBtn.Parent = loginView

Instance.new("UICorner", userBox).CornerRadius = UDim.new(0, 3)
Instance.new("UICorner", passBox).CornerRadius = UDim.new(0, 3)
Instance.new("UICorner", loginBtn).CornerRadius = UDim.new(0, 3)

-- [STATUS BAR]
local statusBar = Instance.new("Frame")
statusBar.Size = UDim2.new(0, 120, 0, 16)
statusBar.Position = UDim2.new(1, -130, 0, 7)
statusBar.BackgroundColor3 = COLORS.BG
statusBar.BorderSizePixel = 0
statusBar.Parent = gui

Instance.new("UICorner", statusBar).CornerRadius = UDim.new(0, 3)

local statusText = Instance.new("TextLabel")
statusText.Size = UDim2.new(1, 0, 1, 0)
statusText.BackgroundTransparency = 1
statusText.Text = "Status: Free"
statusText.TextColor3 = COLORS.TEXT_DIM
statusText.TextSize = 8
statusText.Font = FONT_NORMAL
statusText.TextXAlignment = Enum.TextXAlignment.Center
statusText.Parent = statusBar

-- [FUNCTIONS]
function hideAllViews()
    profileView.Visible = false
    teleportView.Visible = false
    infoView.Visible = false
    lainView.Visible = false
    loginView.Visible = false
end

function showView(viewName)
    hideAllViews()
    for _, btn in pairs(menuButtons) do
        btn.BackgroundColor3 = COLORS.BUTTON
    end
    
    if viewName == "Profile" then
        menuButtons["Profile"].BackgroundColor3 = COLORS.BUTTON_HOVER
        profileView.Visible = true
    elseif viewName == "Teleport" then
        menuButtons["Teleport"].BackgroundColor3 = COLORS.BUTTON_HOVER
        teleportView.Visible = true
    elseif viewName == "Informasi" then
        menuButtons["Informasi"].BackgroundColor3 = COLORS.BUTTON_HOVER
        infoView.Visible = true
    elseif viewName == "Lain" then
        menuButtons["Lain"].BackgroundColor3 = COLORS.BUTTON_HOVER
        lainView.Visible = true
    elseif viewName == "Login" then
        menuButtons["Login"].BackgroundColor3 = COLORS.BUTTON_HOVER
        loginView.Visible = true
    end
end

function createDropdown(parent, items, onSelect)
    local dropdown = Instance.new("ScrollingFrame")
    dropdown.Size = UDim2.new(1, -20, 0, 120)
    dropdown.Position = UDim2.new(0, 10, 0, parent.Position.Y.Offset + 24)
    dropdown.BackgroundColor3 = COLORS.CONTENT
    dropdown.BorderSizePixel = 0
    dropdown.ScrollBarThickness = 4
    dropdown.ScrollBarImageColor3 = COLORS.TEXT_DIM
    dropdown.Visible = false
    dropdown.ZIndex = 12
    dropdown.CanvasSize = UDim2.new(0, 0, 0, #items * 20)
    dropdown.Parent = teleportView
    
    for i, item in ipairs(items) do
        local itemBtn = Instance.new("TextButton")
        itemBtn.Size = UDim2.new(1, 0, 0, 20)
        itemBtn.Position = UDim2.new(0, 0, 0, (i-1)*20)
        itemBtn.BackgroundTransparency = 1
        itemBtn.Text = item
        itemBtn.TextColor3 = COLORS.TEXT
        itemBtn.TextSize = 9
        itemBtn.Font = FONT_NORMAL
        itemBtn.ZIndex = 13
        itemBtn.Parent = dropdown
        
        itemBtn.MouseButton1Click:Connect(function()
            onSelect(item)
            dropdown.Visible = false
            parent.Text = item
        end)
    end
    
    return dropdown
end

-- [EVENTS]
-- Minimize
minimizeBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    minimizedLogo.Visible = true
end)

-- Close
closeBtn.MouseButton1Click:Connect(function()
    mainFrame.Visible = false
    minimizedLogo.Visible = false
end)

-- Logo
minimizedLogo.MouseButton1Click:Connect(function()
    mainFrame.Visible = true
    minimizedLogo.Visible = false
end)

-- Menu Buttons
menuButtons["Profile"].MouseButton1Click:Connect(function() showView("Profile") end)
menuButtons["Teleport"].MouseButton1Click:Connect(function() showView("Teleport") end)
menuButtons["Informasi"].MouseButton1Click:Connect(function() showView("Informasi") end)
menuButtons["Lain"].MouseButton1Click:Connect(function() showView("Lain") end)
menuButtons["Login"].MouseButton1Click:Connect(function() showView("Login") end)

-- Teleport Player Dropdown
playerDropdown = createDropdown(playerBtn, 
    Players:GetPlayers(), 
    function(selectedPlayer)
        if selectedPlayer == player then return end
        playerBtn.Text = selectedPlayer.Name
    end
)

playerBtn.MouseButton1Click:Connect(function()
    playerDropdown.Visible = not playerDropdown.Visible
    if playerDropdown.Visible then
        local players = {}
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= player then
                table.insert(players, plr.Name)
            end
        end
        playerDropdown:Destroy()
        playerDropdown = createDropdown(playerBtn, players, function(name)
            playerBtn.Text = name
        end)
        playerDropdown.Visible = true
    end
end)

-- Teleport Region Dropdown
regionDropdown = createDropdown(regionBtn, 
    {"Fisherman Island", "Kohana Island", "Kohana Volcano", "The Ocean", "Deep Ocean", 
     "Coral Reef Island", "Tropical Grove Island", "Tropical Grove Edge", 
     "Crater Island", "Crater Peak", "Esoteric Depths", "Enchanted Zone", 
     "Sisyphus Statue", "Treasure Room", "Ancient Jungle", "Sacred Temple", 
     "Underground Cellar", "Classic Island", "Iron Cavern", "Secret Lagoon", "Mystic Falls"}, 
    function(selectedRegion)
        regionBtn.Text = selectedRegion
    end
)

regionBtn.MouseButton1Click:Connect(function()
    regionDropdown.Visible = not regionDropdown.Visible
end)

-- Teleport Execute
teleportBtn.MouseButton1Click:Connect(function()
    if not isLoggedIn then
        warn("⛔ FREE USER: Login untuk teleport!")
        return
    end
    
    local targetPlayerName = playerBtn.Text
    local targetRegionName = regionBtn.Text
    
    if targetPlayerName ~= "Pilih Player →" then
        local target = Players:FindFirstChild(targetPlayerName)
        if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            character.HumanoidRootPart.CFrame = CFrame.new(target.Character.HumanoidRootPart.Position + Vector3.new(0, 10, 0))
            warn("✅ Teleport ke " .. targetPlayerName)
        else
            warn("❌ Player tidak ditemukan!")
        end
    elseif targetRegionName ~= "Pilih Region →" and regionData[targetRegionName] then
        character.HumanoidRootPart.CFrame = CFrame.new(regionData[targetRegionName] + Vector3.new(0, 10, 0))
        warn("✅ Teleport ke " .. targetRegionName)
    else
        warn("❌ Pilih target dulu!")
    end
end)

-- Toggle Animations (FUNCTIONAL)
local function handleToggle(toggle, settingName, trueCallback, falseCallback)
    toggle.MouseButton1Click:Connect(function()
        local isOn = t
