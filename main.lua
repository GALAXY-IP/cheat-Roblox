-- TarzBot Fish It GUI - 100% Mirip Chloe X
-- Version: 1.0.1
-- Status: FULLY FUNCTIONAL

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local CoreGui = game:GetService("CoreGui")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

-- Sistem Login
local isLoggedIn = false
local startTime = os.time()
local timeLimit = 3600
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

-- CHLOE X COLORS
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

-- FONT
local FONT_BOLD = Enum.Font.GothamBold
local FONT_NORMAL = Enum.Font.Gotham
local FONT_SMALL = Enum.Font.GothamMedium

-- Tambah Shadow
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

-- MAIN GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TarzBotGUI"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 400, 0, 300)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
MainFrame.BackgroundColor3 = COLORS.BG
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 6)
UICorner.Parent = MainFrame

addShadow(MainFrame)

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 30)
TitleBar.BackgroundColor3 = COLORS.TITLEBAR
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 6)
TitleCorner.Parent = TitleBar

-- Title
local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Size = UDim2.new(1, -70, 0, 14)
Title.Position = UDim2.new(0, 12, 0, 8)
Title.BackgroundTransparency = 1
Title.Text = "TarzBot"
Title.TextColor3 = COLORS.TEXT
Title.TextSize = 13
Title.Font = FONT_BOLD
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TitleBar

local Version = Instance.new("TextLabel")
Version.Name = "Version"
Version.Size = UDim2.new(1, -70, 0, 10)
Version.Position = UDim2.new(0, 12, 0, 18)
Version.BackgroundTransparency = 1
Version.Text = "v1.0.1"
Version.TextColor3 = COLORS.TEXT_DIM
Version.TextSize = 8
Version.Font = FONT_SMALL
Version.TextXAlignment = Enum.TextXAlignment.Left
Version.Parent = TitleBar

-- Control Buttons
function makeControlBtn(name, text, color, xPos)
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Size = UDim2.new(0, 26, 0, 16)
    btn.Position = UDim2.new(1, xPos, 0, 7)
    btn.BackgroundColor3 = color
    btn.BorderSizePixel = 0
    btn.Text = text
    btn.TextColor3 = COLORS.TEXT
    btn.TextSize = 11
    btn.Font = FONT_BOLD
    btn.AutoButtonColor = false
    btn.Parent = TitleBar
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 4)
    corner.Parent = btn
    return btn
end

local MinBtn = makeControlBtn("MinBtn", "-", COLORS.BUTTON, -58)
local CloseBtn = makeControlBtn("CloseBtn", "×", COLORS.DANGER, -30)

-- Minimized Logo (48x48 - PAS)
local Logo = Instance.new("TextButton")
Logo.Name = "MinimizedLogo"
Logo.Size = UDim2.new(0, 48, 0, 48)
Logo.Position = UDim2.new(0, 20, 0, 20)
Logo.BackgroundColor3 = COLORS.BG
Logo.BorderSizePixel = 0
Logo.Text = "TB"
Logo.TextColor3 = COLORS.TEXT
Logo.TextSize = 13
Logo.Font = FONT_BOLD
Logo.Visible = false
Logo.Active = true
Logo.Draggable = true
Logo.Parent = ScreenGui

local LogoCorner = Instance.new("UICorner")
LogoCorner.CornerRadius = UDim.new(0, 8)
LogoCorner.Parent = Logo

addShadow(Logo)

-- Menu Container
local MenuContainer = Instance.new("Frame")
MenuContainer.Name = "MenuContainer"
MenuContainer.Size = UDim2.new(1, 0, 1, -30)
MenuContainer.Position = UDim2.new(0, 0, 0, 30)
MenuContainer.BackgroundTransparency = 1
MenuContainer.Parent = MainFrame

-- Menu Buttons (5 Menu)
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
    btn.Size = UDim2.new(1, -20, 0, 34)
    btn.Position = UDim2.new(0, 10, 0, 10 + (i-1)*36)
    btn.BackgroundColor3 = COLORS.BUTTON
    btn.BorderSizePixel = 0
    btn.Text = "[" .. menu.icon .. "] " .. menu.name
    btn.TextColor3 = COLORS.TEXT
    btn.TextSize = 12
    btn.Font = FONT_NORMAL
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Parent = MenuContainer
    
    local pad = Instance.new("UIPadding")
    pad.PaddingLeft = UDim.new(0, 12)
    pad.Parent = btn
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 4)
    corner.Parent = btn
    
    menuBtns[menu.name] = btn
end

-- Separator
local Sep = Instance.new("Frame")
Sep.Size = UDim2.new(1, -20, 0, 1)
Sep.Position = UDim2.new(0, 10, 0, 190)
Sep.BackgroundColor3 = COLORS.BUTTON
Sep.BorderSizePixel = 0
Sep.Parent = MenuContainer

-- Content Display
local ContentDisplay = Instance.new("Frame")
ContentDisplay.Name = "ContentDisplay"
ContentDisplay.Size = UDim2.new(1, -20, 0, 80)
ContentDisplay.Position = UDim2.new(0, 10, 0, 200)
ContentDisplay.BackgroundColor3 = COLORS.CONTENT
ContentDisplay.BorderSizePixel = 0
ContentDisplay.Parent = MenuContainer

local ContentCorner = Instance.new("UICorner")
ContentCorner.CornerRadius = UDim.new(0, 4)
ContentCorner.Parent = ContentDisplay

-- Profile Content
local ProfileContent = Instance.new("TextLabel")
ProfileContent.Name = "ProfileContent"
ProfileContent.Size = UDim2.new(1, -20, 1, -10)
ProfileContent.Position = UDim2.new(0, 10, 0, 5)
ProfileContent.BackgroundTransparency = 1
ProfileContent.Text = "Loading profile..."
ProfileContent.TextColor3 = COLORS.TEXT_DIM
ProfileTextSize = 11
ProfileFont = FONT_SMALL
ProfileTextXAlignment = Enum.TextXAlignment.Left
ProfileTextYAlignment = Enum.TextYAlignment.Top
ProfileContent.Parent = ContentDisplay

-- Teleport Content
local TeleportContent = Instance.new("Frame")
TeleportContent.Name = "TeleportContent"
TeleportContent.Size = UDim2.new(1, 0, 1, 0)
TeleportContent.BackgroundTransparency = 1
TeleportContent.Visible = false
TeleportContent.Parent = ContentDisplay

local TP_PeopleBtn = Instance.new("TextButton")
TP_PeopleBtn.Size = UDim2.new(1, -20, 0, 28)
TP_PeopleBtn.Position = UDim2.new(0, 10, 0, 5)
TP_PeopleBtn.BackgroundColor3 = COLORS.BUTTON
TP_PeopleBtn.Text = "Teleport To People →"
TP_PeopleBtn.TextColor3 = COLORS.TEXT
TP_PeopleBtn.TextSize = 11
TP_PeopleBtn.Font = FONT_NORMAL
TP_PeopleBtn.TextXAlignment = Enum.TextXAlignment.Left
TP_PeopleBtn.Parent = TeleportContent

local PeopleDropdown = Instance.new("ScrollingFrame")
PeopleDropdown.Name = "PeopleDropdown"
PeopleDropdown.Size = UDim2.new(1, -20, 0, 100)
PeopleDropdown.Position = UDim2.new(0, 10, 0, 35)
PeopleDropdown.BackgroundColor3 = COLORS.CONTENT
PeopleDropdown.Visible = false
PeopleDropdown.ScrollBarThickness = 3
PeopleDropdown.Parent = TeleportContent

local TP_PlayerBtn = Instance.new("TextButton")
TP_PlayerBtn.Size = UDim2.new(1, -20, 0, 26)
TP_PlayerBtn.Position = UDim2.new(0, 10, 0, 140)
TP_PlayerBtn.BackgroundColor3 = COLORS.SUCCESS
TP_PlayerBtn.Text = "Teleport"
TP_PlayerBtn.TextColor3 = COLORS.TEXT
TP_PlayerBtn.TextSize = 11
TP_PlayerBtn.Font = FONT_BOLD
TP_PlayerBtn.Parent = TeleportContent

local TP_RegionBtn = Instance.new("TextButton")
TP_RegionBtn.Size = UDim2.new(1, -20, 0, 28)
TP_RegionBtn.Position = UDim2.new(0, 10, 0, 175)
TP_RegionBtn.BackgroundColor3 = COLORS.BUTTON
TP_RegionBtn.Text = "Teleport To The Region"
TP_RegionBtn.TextColor3 = COLORS.TEXT
TP_RegionBtn.TextSize = 11
TP_RegionBtn.Font = FONT_NORMAL
TP_RegionBtn.TextXAlignment = Enum.TextXAlignment.Left
TP_RegionBtn.Parent = TeleportContent

local RegionDropdown = Instance.new("ScrollingFrame")
RegionDropdown.Name = "RegionDropdown"
RegionDropdown.Size = UDim2.new(1, -20, 0, 100)
RegionDropdown.Position = UDim2.new(0, 10, 0, 205)
RegionDropdown.BackgroundColor3 = COLORS.CONTENT
RegionDropdown.Visible = false
RegionDropdown.ScrollBarThickness = 3
RegionDropdown.Parent = TeleportContent

local TP_RegionExeBtn = Instance.new("TextButton")
TP_RegionExeBtn.Size = UDim2.new(1, -20, 0, 26)
TP_RegionExeBtn.Position = UDim2.new(0, 10, 0, 310)
TP_RegionExeBtn.BackgroundColor3 = COLORS.SUCCESS
TP_RegionExeBtn.Text = "Teleport"
TP_RegionExeBtn.TextColor3 = COLORS.TEXT
TP_RegionExeBtn.TextSize = 11
TP_RegionExeBtn.Font = FONT_BOLD
TP_RegionExeBtn.Parent = TeleportContent

local RefreshBtn = Instance.new("TextButton")
RefreshBtn.Size = UDim2.new(1, -20, 0, 26)
RefreshBtn.Position = UDim2.new(0, 10, 0, 340)
RefreshBtn.BackgroundColor3 = COLORS.ACCENT
RefreshBtn.Text = "Refresh"
RefreshBtn.TextColor3 = COLORS.TEXT
RefreshBtn.TextSize = 11
RefreshBtn.Font = FONT_BOLD
RefreshBtn.Parent = TeleportContent

-- Info Content
local InfoContent = Instance.new("TextLabel")
InfoContent.Name = "InfoContent"
InfoContent.Size = UDim2.new(1, -20, 1, -10)
InfoContent.Position = UDim2.new(0, 10, 0, 5)
InfoContent.BackgroundTransparency = 1
InfoContent.Text = "Telegram: @tarzbot\nWhatsApp: 0812345678\nTiktok: @_tarzbot"
InfoContent.TextColor3 = COLORS.TEXT_DIM
InfoContent.TextSize = 11
InfoContent.Font = FONT_NORMAL
InfoContent.TextXAlignment = Enum.TextXAlignment.Left
InfoContent.TextYAlignment = Enum.TextYAlignment.Top
InfoContent.Visible = false
InfoContent.Parent = ContentDisplay

-- Lain Content
local LainContent = Instance.new("Frame")
LainContent.Name = "LainContent"
LainContent.Size = UDim2.new(1, 0, 1, 0)
LainContent.BackgroundTransparency = 1
LainContent.Visible = false
LainContent.Parent = ContentDisplay

function makeToggle(name, text, yPos)
    local frame = Instance.new("Frame")
    frame.Name = name
    frame.Size = UDim2.new(1, -20, 0, 24)
    frame.Position = UDim2.new(0, 10, 0, yPos)
    frame.BackgroundTransparency = 1
    frame.Parent = LainContent
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -50, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = COLORS.TEXT_DIM
    label.TextSize = 11
    label.Font = FONT_NORMAL
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame
    
    local toggle = Instance.new("TextButton")
    toggle.Name = name .. "Toggle"
    toggle.Size = UDim2.new(0, 36, 0, 18)
    toggle.Position = UDim2.new(1, -36, 0.5, -9)
    toggle.BackgroundColor3 = COLORS.BUTTON
    toggle.BorderSizePixel = 0
    toggle.Text = ""
    toggle.Parent = frame
    
    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 9)
    toggleCorner.Parent = toggle
    
    local indicator = Instance.new("Frame")
    indicator.Name = "Indicator"
    indicator.Size = UDim2.new(0, 14, 0, 14)
    indicator.Position = UDim2.new(0, 2, 0.5, -7)
    indicator.BackgroundColor3 = COLORS.TEXT
    indicator.BorderSizePixel = 0
    indicator.Parent = toggle
    
    local indCorner = Instance.new("UICorner")
    indCorner.CornerRadius = UDim.new(0, 7)
    indCorner.Parent = indicator
    
    return toggle
end

local Toggle1 = makeToggle("AnimasiRod", "Animasi Rod", 10)
local Toggle2 = makeToggle("NotifikasiFish", "Notifikasi Fish", 40)
local Toggle3 = makeToggle("AnimasiEfek", "Animasi Efek Rod", 70)

-- Login Content
local LoginContent = Instance.new("Frame")
LoginContent.Name = "LoginContent"
LoginContent.Size = UDim2.new(1, 0, 1, 0)
LoginContent.BackgroundTransparency = 1
LoginContent.Visible = false
LoginContent.Parent = ContentDisplay

local LoginTitle = Instance.new("TextLabel")
LoginTitle.Size = UDim2.new(1, -20, 0, 20)
LoginTitle.Position = UDim2.new(0, 10, 0, 5)
LoginTitle.BackgroundTransparency = 1
LoginTitle.Text = "[£] Login"
LoginTitle.TextColor3 = COLORS.TEXT
LoginTitle.TextSize = 12
LoginTitle.Font = FONT_BOLD
LoginTitle.Parent = LoginContent

local UserBox = Instance.new("TextBox")
UserBox.Name = "Username"
UserBox.Size = UDim2.new(1, -20, 0, 28)
UserBox.Position = UDim2.new(0, 10, 0, 30)
UserBox.BackgroundColor3 = COLORS.BUTTON
UserBox.PlaceholderText = "Username"
UserBox.Text = ""
UserBox.TextColor3 = COLORS.TEXT
UserBox.TextSize = 11
UserBox.Font = FONT_NORMAL
UserBox.Parent = LoginContent

local PassBox = Instance.new("TextBox")
PassBox.Name = "Password"
PassBox.Size = UDim2.new(1, -20, 0, 28)
PassBox.Position = UDim2.new(0, 10, 0, 65)
PassBox.BackgroundColor3 = COLORS.BUTTON
PassBox.PlaceholderText = "Password"
PassBox.Text = ""
PassBox.TextColor3 = COLORS.TEXT
PassBox.TextSize = 11
PassBox.Font = FONT_NORMAL
PassBox.Parent = LoginContent

local LoginBtn = Instance.new("TextButton")
LoginBtn.Size = UDim2.new(1, -20, 0, 28)
LoginBtn.Position = UDim2.new(0, 10, 0, 100)
LoginBtn.BackgroundColor3 = COLORS.ACCENT
LoginBtn.Text = "Login"
LoginBtn.TextColor3 = COLORS.TEXT
LoginBtn.TextSize = 11
LoginBtn.Font = FONT_BOLD
LoginBtn.Parent = LoginContent

-- Padding
for _, obj in pairs({UserBox, PassBox, LoginBtn}) do
    local pad = Instance.new("UIPadding", obj)
    pad.PaddingLeft = UDim.new(0, 8)
end

-- Status Frame
local StatusFrame = Instance.new("Frame")
StatusFrame.Name = "StatusFrame"
StatusFrame.Size = UDim2.new(0, 130, 0, 24)
StatusFrame.Position = UDim2.new(1, -140, 0, 10)
StatusFrame.BackgroundColor3 = COLORS.BG
StatusFrame.BorderSizePixel = 0
StatusFrame.Parent = ScreenGui

local StatusCorner = Instance.new("UICorner", StatusFrame)
StatusCorner.CornerRadius = UDim.new(0, 4)

local StatusText = Instance.new("TextLabel")
StatusText.Size = UDim2.new(1, 0, 1, 0)
StatusText.BackgroundTransparency = 1
StatusText.Text = "Status: Free"
StatusText.TextColor3 = COLORS.TEXT_DIM
StatusText.TextSize = 10
StatusText.Font = FONT_SMALL
StatusText.TextXAlignment = Enum.TextXAlignment.Center
StatusText.Parent = StatusFrame

addShadow(StatusFrame)

-- TOGGLE STATES
local toggles = {
    AnimasiRod = false,
    NotifikasiFish = false,
    AnimasiEfek = false
}

-- FUNCTIONS
function updateToggle(btn, state)
    local ind = btn:FindFirstChild("Indicator")
    btn.BackgroundColor3 = state and COLORS.SUCCESS or COLORS.BUTTON
    ind.Position = state and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)
end

function getLevel()
    local data = player:FindFirstChild("Data") or player:FindFirstChild("leaderstats")
    if data then
        local lvl = data:FindFirstChild("Level") or data:FindFirstChild("level")
        if lvl then return tostring(lvl.Value) end
    end
    return "N/A"
end

function updateProfile()
    ProfileContent.Text = string.format(
        "Nama : %s\nLevel : %s\nStatus : %s",
        player.Name,
        getLevel(),
        isLoggedIn and "Premium" or "Free"
    )
end

function hideAllContent()
    ProfileContent.Visible = false
    TeleportContent.Visible = false
    InfoContent.Visible = false
    LainContent.Visible = false
    LoginContent.Visible = false
end

function showContent(name)
    hideAllContent()
    ContentDisplay.Visible = true
    
    for _, btn in pairs(menuBtns) do
        btn.BackgroundColor3 = COLORS.BUTTON
    end
    
    if name == "Profile" then
        menuBtns["Profile"].BackgroundColor3 = COLORS.BUTTON_HOVER
        ProfileContent.Visible = true
        updateProfile()
    elseif name == "Teleport" then
        menuBtns["Teleport"].BackgroundColor3 = COLORS.BUTTON_HOVER
        TeleportContent.Visible = true
    elseif name == "Informasi" then
        menuBtns["Informasi"].BackgroundColor3 = COLORS.BUTTON_HOVER
        InfoContent.Visible = true
    elseif name == "Lain" then
        menuBtns["Lain"].BackgroundColor3 = COLORS.BUTTON_HOVER
        LainContent.Visible = true
    elseif name == "Login" then
        menuBtns["Login"].BackgroundColor3 = COLORS.BUTTON_HOVER
        LoginContent.Visible = true
    end
end

function populatePlayers()
    PeopleDropdown:ClearAllChildren()
    local y = 0
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, 0, 0, 22)
            btn.Position = UDim2.new(0, 0, 0, y)
            btn.BackgroundTransparency = 1
            btn.Text = "   " .. plr.Name
            btn.TextColor3 = COLORS.TEXT
            btn.TextSize = 10
            btn.Font = FONT_NORMAL
            btn.Parent = PeopleDropdown
            
            btn.MouseButton1Click:Connect(function()
                TP_PeopleBtn.Text = "Teleport To People: " .. plr.Name
                PeopleDropdown.Visible = false
            end)
            
            y = y + 22
        end
    end
    PeopleDropdown.CanvasSize = UDim2.new(0, 0, 0, y)
end

function populateRegions()
    RegionDropdown:ClearAllChildren()
    local y = 0
    for regionName, _ in pairs(regionData) do
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, 0, 0, 22)
        btn.Position = UDim2.new(0, 0, 0, y)
        btn.BackgroundTransparency = 1
        btn.Text = "   " .. regionName
        btn.TextColor3 = COLORS.TEXT
        btn.TextSize = 10
        btn.Font = FONT_NORMAL
        btn.Parent = RegionDropdown
        
        btn.MouseButton1Click:Connect(function()
            TP_RegionBtn.Text = "Teleport To The Region: " .. regionName
            RegionDropdown.Visible = false
        end)
        
        y = y + 22
    end
    RegionDropdown.CanvasSize = UDim2.new(0, 0, 0, y)
end

function teleportTo(pos)
    if not isLoggedIn then
        warn("⛔ Login untuk teleport!")
        return
    end
    humanoidRootPart.CFrame = CFrame.new(pos + Vector3.new(0, 10, 0))
    warn("✅ Teleport berhasil!")
end

-- EVENTS
MinBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    Logo.Visible = true
end)

CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
    Logo.Visible = false
end)

Logo.MouseButton1Click:Connect(function()
    MainFrame.Visible = true
    Logo.Visible = false
end)

menuBtns["Profile"].MouseButton1Click:Connect(function() showContent("Profile") end)
menuBtns["Teleport"].MouseButton1-- UI STYLING (100% Chloe X Style)
local UI = {}
UI.Colors = {
    Background = Color3.fromRGB(18, 18, 18),
    TitleBar = Color3.fromRGB(25, 25, 25),
    Button = Color3.fromRGB(30, 30, 30),
    ButtonHover = Color3.fromRGB(35, 35, 35),
    Content = Color3.fromRGB(22, 22, 22),
    Accent = Color3.fromRGB(52, 152, 219),
    Success = Color3.fromRGB(46, 204, 113),
    Danger = Color3.fromRGB(231, 76, 60),
    Text = Color3.fromRGB(255, 255, 255),
    TextDim = Color3.fromRGB(150, 150, 150)
}

UI.Fonts = {
    Title = Enum.Font.GothamBold,
    Normal = Enum.Font.Gotham,
    Small = Enum.Font.GothamMedium
}

-- Create GUI
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "TarzBotFishIt"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Shadow Effect untuk Chloe X Style
function addShadow(parent)
    local shadow = Instance.new("ImageLabel", parent)
    shadow.Name = "Shadow"
    shadow.Size = UDim2.new(1, 10, 1, 10)
    shadow.Position = UDim2.new(0, -5, 0, -5)
    shadow.BackgroundTransparency = 1
    shadow.Image = "rbxassetid://1316045217"
    shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    shadow.ImageTransparency = 0.6
    shadow.ScaleType = Enum.ScaleType.Slice
    shadow.SliceCenter = Rect.new(10, 10, 118, 118)
    shadow.ZIndex = -1
    return shadow
end

-- Main Frame
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 420, 0, 320)
MainFrame.Position = UDim2.new(0.5, -210, 0.5, -160)
MainFrame.BackgroundColor3 = UI.Colors.Background
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true

-- Rounded Corner
local UICorner = Instance.new("UICorner", MainFrame)
UICorner.CornerRadius = UDim.new(0, 6)

-- Shadow
addShadow(MainFrame)

-- Title Bar
local TitleBar = Instance.new("Frame", MainFrame)
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 32)
TitleBar.BackgroundColor3 = UI.Colors.TitleBar
TitleBar.BorderSizePixel = 0

local TitleCorner = Instance.new("UICorner", TitleBar)
TitleCorner.CornerRadius = UDim.new(0, 6)

-- Title Text
local TitleText = Instance.new("TextLabel", TitleBar)
TitleText.Name = "TitleText"
TitleText.Size = UDim2.new(1, -80, 0, 16)
TitleText.Position = UDim2.new(0, 12, 0, 8)
TitleText.BackgroundTransparency = 1
TitleText.Text = "TarzBot"
TitleText.TextColor3 = UI.Colors.Text
TitleText.TextSize = 14
TitleText.Font = UI.Fonts.Title
TitleText.TextXAlignment = Enum.TextXAlignment.Left

-- Version
local VersionLabel = Instance.new("TextLabel", TitleBar)
VersionLabel.Size = UDim2.new(1, -80, 0, 10)
VersionLabel.Position = UDim2.new(0, 12, 0, 18)
VersionLabel.BackgroundTransparency = 1
VersionLabel.Text = "v1.0.1"
VersionLabel.TextColor3 = UI.Colors.TextDim
VersionLabel.TextSize = 9
VersionLabel.Font = UI.Fonts.Small
VersionLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Control Buttons
function createControlBtn(parent, text, color, pos)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(0, 28, 0, 18)
    btn.Position = pos
    btn.BackgroundColor3 = color
    btn.BorderSizePixel = 0
    btn.Text = text
    btn.TextColor3 = UI.Colors.Text
    btn.TextSize = 12
    btn.Font = UI.Fonts.Title
    btn.AutoButtonColor = false
    
    local corner = Instance.new("UICorner", btn)
    corner.CornerRadius = UDim.new(0, 4)
    
    return btn
end

local MinimizeBtn = createControlBtn(TitleBar, "-", UI.Colors.Button, UDim2.new(1, -62, 0, 7))
local CloseBtn = createControlBtn(TitleBar, "×", UI.Colors.Danger, UDim2.new(1, -32, 0, 7))

-- Minimized Logo (Ukuran Pas - 48x48)
local MinimizedLogo = Instance.new("TextButton", ScreenGui)
MinimizedLogo.Name = "MinimizedLogo"
MinimizedLogo.Size = UDim2.new(0, 48, 0, 48)
MinimizedLogo.Position = UDim2.new(0, 20, 0, 20)
MinimizedLogo.BackgroundColor3 = UI.Colors.Background
MinimizedLogo.BorderSizePixel = 0
MinimizedLogo.Text = "TB"
MinimizedLogo.TextColor3 = UI.Colors.Text
MinimizedLogo.TextSize = 14
MinimizedLogo.Font = UI.Fonts.Title
MinimizedLogo.Visible = false
MinimizedLogo.Active = true
MinimizedLogo.Draggable = true

local LogoCorner = Instance.new("UICorner", MinimizedLogo)
LogoCorner.CornerRadius = UDim.new(0, 8)
addShadow(MinimizedLogo)

-- Content Container
local Content = Instance.new("Frame", MainFrame)
Content.Name = "Content"
Content.Size = UDim2.new(1, 0, 1, -32)
Content.Position = UDim2.new(0, 0, 0, 32)
Content.BackgroundTransparency = 1

-- Menu List
local MenuList = Instance.new("ScrollingFrame", Content)
MenuList.Name = "MenuList"
MenuList.Size = UDim2.new(1, -20, 0, 200)
MenuList.Position = UDim2.new(0, 10, 0, 10)
MenuList.BackgroundTransparency = 1
MenuList.BorderSizePixel = 0
MenuList.ScrollBarThickness = 0
MenuList.CanvasSize = UDim2.new(0, 0, 0, 200)

-- Menu Items
local menuData = {
    {icon = "¥", name = "Profile"},
    {icon = "€", name = "Teleport"},
    {icon = "π", name = "Informasi"},
    {icon = "¢", name = "Lain"},
    {icon = "£", name = "Login"}
}

local menuButtons = {}
local currentMenu = nil

for i, data in ipairs(menuData) do
    local btn = Instance.new("TextButton", MenuList)
    btn.Name = data.name .. "Btn"
    btn.Size = UDim2.new(1, 0, 0, 36)
    btn.Position = UDim2.new(0, 0, 0, (i-1)*38)
    btn.BackgroundColor3 = UI.Colors.Button
    btn.BorderSizePixel = 0
    btn.Text = "[" .. data.icon .. "] " .. data.name
    btn.TextColor3 = UI.Colors.Text
    btn.TextSize = 13
    btn.Font = UI.Fonts.Normal
    btn.TextXAlignment = Enum.TextXAlignment.Left
    
    local padding = Instance.new("UIPadding", btn)
    padding.PaddingLeft = UDim.new(0, 15)
    
    local corner = Instance.new("UICorner", btn)
    corner.CornerRadius = UDim.new(0, 4)
    
    menuButtons[data.name] = btn
    
    -- Hover Effect
    btn.MouseEnter:Connect(function()
        btn.BackgroundColor3 = UI.Colors.ButtonHover
    end)
    btn.MouseLeave:Connect(function()
        if currentMenu ~= data.name then
            btn.BackgroundColor3 = UI.Colors.Button
        end
    end)
end

-- Content View
local ContentView = Instance.new("Frame", Content)
ContentView.Name = "ContentView"
ContentView.Size = UDim2.new(1, -20, 1, -220)
ContentView.Position = UDim2.new(0, 10, 0, 210)
ContentView.BackgroundColor3 = UI.Colors.Content
ContentView.BorderSizePixel = 0
ContentView.Visible = false

local ContentCorner = Instance.new("UICorner", ContentView)
ContentCorner.CornerRadius = UDim.new(0, 4)

-- Profile View
local ProfileView = Instance.new("Frame", ContentView)
ProfileView.Name = "ProfileView"
ProfileView.Size = UDim2.new(1, 0, 1, 0)
ProfileView.BackgroundTransparency = 1
ProfileView.Visible = false

local ProfileTitle = Instance.new("TextLabel", ProfileView)
ProfileTitle.Size = UDim2.new(1, -20, 0, 20)
ProfileTitle.Position = UDim2.new(0, 15, 0, 10)
ProfileTitle.BackgroundTransparency = 1
ProfileTitle.Text = "[¥] Profile"
ProfileTitle.TextColor3 = UI.Colors.Text
ProfileTitle.TextSize = 14
ProfileTitle.Font = UI.Fonts.Title
ProfileTitle.TextXAlignment = Enum.TextXAlignment.Left

local ProfileInfo = Instance.new("TextLabel", ProfileView)
ProfileInfo.Size = UDim2.new(1, -30, 1, -40)
ProfileInfo.Position = UDim2.new(0, 15, 0, 35)
ProfileInfo.BackgroundTransparency = 1
ProfileInfo.Text = "Loading..."
ProfileInfo.TextColor3 = UI.Colors.TextDim
ProfileInfo.TextSize = 12
ProfileInfo.Font = UI.Fonts.Normal
ProfileInfo.TextXAlignment = Enum.TextXAlignment.Left
ProfileInfo.TextYAlignment = Enum.TextYAlignment.Top

-- Teleport View
local TeleportView = Instance.new("Frame", ContentView)
TeleportView.Name = "TeleportView"
TeleportView.Size = UDim2.new(1, 0, 1, 0)
TeleportView.BackgroundTransparency = 1
TeleportView.Visible = false

-- Teleport PEOPLE
local TeleportPeopleBtn = Instance.new("TextButton", TeleportView)
TeleportPeopleBtn.Size = UDim2.new(1, -20, 0, 32)
TeleportPeopleBtn.Position = UDim2.new(0, 10, 0, 10)
TeleportPeopleBtn.BackgroundColor3 = UI.Colors.Button
TeleportPeopleBtn.Text = "Teleport To People →"
TeleportPeopleBtn.TextColor3 = UI.Colors.Text
TeleportPeopleBtn.TextSize = 12
TeleportPeopleBtn.Font = UI.Fonts.Normal
TeleportPeopleBtn.TextXAlignment = Enum.TextXAlignment.Left

local PeoplePadding = Instance.new("UIPadding", TeleportPeopleBtn)
PeoplePadding.PaddingLeft = UDim.new(0, 10)

local PeopleContent = Instance.new("Frame", TeleportView)
PeopleContent.Size = UDim2.new(1, -20, 0, 0)
PeopleContent.Position = UDim2.new(0, 10, 0, 42)
PeopleContent.BackgroundTransparency = 1
PeopleContent.Visible = false

local ChoosePlayer = Instance.new("TextButton", PeopleContent)
ChoosePlayer.Size = UDim2.new(1, 0, 0, 28)
ChoosePlayer.BackgroundColor3 = UI.Colors.Button
ChoosePlayer.Text = "Choose Someone:"
ChoosePlayer.TextColor3 = UI.Colors.Text
ChoosePlayer.TextSize = 11
ChoosePlayer.Font = UI.Fonts.Normal

local PlayerDropdown = Instance.new("ScrollingFrame", PeopleContent)
PlayerDropdown.Size = UDim2.new(1, 0, 0, 120)
PlayerDropdown.Position = UDim2.new(0, 0, 0, 30)
PlayerDropdown.BackgroundColor3 = UI.Colors.Button
PlayerDropdown.Visible = false
PlayerDropdown.ScrollBarThickness = 4
PlayerDropdown.ScrollBarImageColor3 = UI.Colors.TextDim

local TeleportPlayerBtn = Instance.new("TextButton", PeopleContent)
TeleportPlayerBtn.Size = UDim2.new(1, 0, 0, 28)
TeleportPlayerBtn.Position = UDim2.new(0, 0, 0, 155)
TeleportPlayerBtn.BackgroundColor3 = UI.Colors.Accent
TeleportPlayerBtn.Text = "Teleport"
TeleportPlayerBtn.TextColor3 = UI.Colors.Text
TeleportPlayerBtn.TextSize = 12
TeleportPlayerBtn.Font = UI.Fonts.Title

-- Teleport REGION
local TeleportRegionBtn = Instance.new("TextButton", TeleportView)
TeleportRegionBtn.Size = UDim2.new(1, -20, 0, 32)
TeleportRegionBtn.Position = UDim2.new(0, 10, 0, 200)
TeleportRegionBtn.BackgroundColor3 = UI.Colors.Button
TeleportRegionBtn.Text = "Teleport To The Region"
TeleportRegionBtn.TextColor3 = UI.Colors.Text
TeleportRegionBtn.TextSize = 12
TeleportRegionBtn.Font = UI.Fonts.Normal
TeleportRegionBtn.TextXAlignment = Enum.TextXAlignment.Left

local RegionPadding = Instance.new("UIPadding", TeleportRegionBtn)
RegionPadding.PaddingLeft = UDim.new(0, 10)

local RegionContent = Instance.new("Frame", TeleportView)
RegionContent.Size = UDim2.new(1, -20, 0, 0)
RegionContent.Position = UDim2.new(0, 10, 0, 232)
RegionContent.BackgroundTransparency = 1
RegionContent.Visible = false

local ChooseRegion = Instance.new("TextButton", RegionContent)
ChooseRegion.Size = UDim2.new(1, 0, 0, 28)
ChooseRegion.BackgroundColor3 = UI.Colors.Button
ChooseRegion.Text = "Choose Region:"
ChooseRegion.TextColor3 = UI.Colors.Text
ChooseRegion.TextSize = 11
ChooseRegion.Font = UI.Fonts.Normal

local RegionDropdown = Instance.new("ScrollingFrame", RegionContent)
RegionDropdown.Size = UDim2.new(1, 0, 0, 120)
RegionDropdown.Position = UDim2.new(0, 0, 0, 30)
RegionDropdown.BackgroundColor3 = UI.Colors.Button
RegionDropdown.Visible = false
RegionDropdown.ScrollBarThickness = 4
RegionDropdown.ScrollBarImageColor3 = UI.Colors.TextDim

local TeleportRegionExeBtn = Instance.new("TextButton", RegionContent)
TeleportRegionExeBtn.Size = UDim2.new(1, 0, 0, 28)
TeleportRegionExeBtn.Position = UDim2.new(0, 0, 0, 155)
TeleportRegionExeBtn.BackgroundColor3 = UI.Colors.Accent
TeleportRegionExeBtn.Text = "Teleport"
TeleportRegionExeBtn.TextColor3 = UI.Colors.Text
TeleportRegionExeBtn.TextSize = 12
TeleportRegionExeBtn.Font = UI.Fonts.Title

local RefreshBtn = Instance.new("TextButton", TeleportView)
RefreshBtn.Size = UDim2.new(1, -20, 0, 28)
RefreshBtn.Position = UDim2.new(0, 10, 0, 270)
RefreshBtn.BackgroundColor3 = UI.Colors.Success
RefreshBtn.Text = "Refresh"
RefreshBtn.TextColor3 = UI.Colors.Text
RefreshBtn.TextSize = 12
RefreshBtn.Font = UI.Fonts.Title

-- Info View
local InfoView = Instance.new("Frame", ContentView)
InfoView.Name = "InfoView"
InfoView.Size = UDim2.new(1, 0, 1, 0)
InfoView.BackgroundTransparency = 1
InfoView.Visible = false

local InfoTitle = Instance.new("TextLabel", InfoView)
InfoTitle.Size = UDim2.new(1, -20, 0, 20)
InfoTitle.Position = UDim2.new(0, 15, 0, 10)
InfoTitle.BackgroundTransparency = 1
InfoTitle.Text = "INFORMASI"
InfoTitle.TextColor3 = UI.Colors.Text
InfoTitle.TextSize = 14
InfoTitle.Font = UI.Fonts.Title
InfoTitle.TextXAlignment = Enum.TextXAlignment.Left

local InfoText = Instance.new("TextLabel", InfoView)
InfoText.Size = UDim2.new(1, -30, 1, -40)
InfoText.Position = UDim2.new(0, 15, 0, 35)
InfoText.BackgroundTransparency = 1
InfoText.Text = "Telegram: @tarzbot\nWhatsApp: 0812345678\nTiktok: @_tarzbot"
InfoText.TextColor3 = UI.Colors.TextDim
InfoText.TextSize = 12
InfoText.Font = UI.Fonts.Normal
InfoText.TextXAlignment = Enum.TextXAlignment.Left
InfoText.TextYAlignment = Enum.TextYAlignment.Top

-- Lain View
local LainView = Instance.new("Frame", ContentView)
LainView.Name = "LainView"
LainView.Size = UDim2.new(1, 0, 1, 0)
LainView.BackgroundTransparency = 1
InfoView.Visible = false

local LainTitle = Instance.new("TextLabel", LainView)
LainTitle.Size = UDim2.new(1, -20, 0, 20)
LainTitle.Position = UDim2.new(0, 15, 0, 10)
LainTitle.BackgroundTransparency = 1
LainTitle.Text = "[¢] Lain"
LainTitle.TextColor3 = UI.Colors.Text
LainTitle.TextSize = 14
LainTitle.Font = UI.Fonts.Title
LainTitle.TextXAlignment = Enum.TextXAlignment.Left

-- Toggle Function
function createToggle(parent, text, posY)
    local frame = Instance.new("Frame", parent)
    frame.Size = UDim2.new(1, -30, 0, 26)
    frame.Position = UDim2.new(0, 15, 0, posY)
    frame.BackgroundTransparency = 1
    
    local label = Instance.new("TextLabel", frame)
    label.Size = UDim2.new(1, -50, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = UI.Colors.TextDim
    label.TextSize = 11
    label.Font = UI.Fonts.Normal
    label.TextXAlignment = Enum.TextXAlignment.Left
    
    local toggle = Instance.new("TextButton", frame)
    toggle.Name = text .. "Toggle"
    toggle.Size = UDim2.new(0, 36, 0, 18)
    toggle.Position = UDim2.new(1, -36, 0.5, -9)
    toggle.BackgroundColor3 = UI.Colors.Button
    toggle.BorderSizePixel = 0
    toggle.Text = ""
    
    local toggleCorner = Instance.new("UICorner", toggle)
    toggleCorner.CornerRadius = UDim.new(0, 9)
    
    local indicator = Instance.new("Frame", toggle)
    indicator.Name = "Indicator"
    indicator.Size = UDim2.new(0, 14, 0, 14)
    indicator.Position = UDim2.new(0, 2, 0.5, -7)
    indicator.BackgroundColor3 = UI.Colors.Text
    indicator.BorderSizePixel = 0
    
    local indCorner = Instance.new("UICorner", indicator)
    indCorner.CornerRadius = UDim.new(0, 7)
    
    return toggle
end

local AnimasiRodToggle = createToggle(LainView, "Animasi Rod", 40)
local NotifikasiFishToggle = createToggle(LainView, "Notifikasi Fish", 70)
local AnimasiEfekToggle = createToggle(LainView, "Animasi Efek Rod", 100)

-- Login View
local LoginView = Instance.new("Frame", ContentView)
LoginView.Name = "LoginView"
LoginView.Size = UDim2.new(1, 0, 1, 0)
LoginView.BackgroundTransparency = 1
LoginView.Visible = false

local LoginTitle = Instance.new("TextLabel", LoginView)
LoginTitle.Size = UDim2.new(1, -20, 0, 20)
LoginTitle.Position = UDim2.new(0, 15, 0, 10)
LoginTitle.BackgroundTransparency = 1
LoginTitle.Text = "[£] Login"
LoginTitle.TextColor3 = UI.Colors.Text
LoginTitle.TextSize = 14
LoginTitle.Font = UI.Fonts.Title
LoginTitle.TextXAlignment = Enum.TextXAlignment.Left

local UsernameBox = Instance.new("TextBox", LoginView)
UsernameBox.Name = "Username"
UsernameBox.Size = UDim2.new(1, -30, 0, 32)
UsernameBox.Position = UDim2.new(0, 15, 0, 40)
UsernameBox.BackgroundColor3 = UI.Colors.Button
UsernameBox.PlaceholderText = "Username"
UsernameBox.Text = ""
UsernameBox.TextColor3 = UI.Colors.Text
UsernameBox.TextSize = 12
UsernameBox.Font = UI.Fonts.Normal

local PasswordBox = Instance.new("TextBox", LoginView)
PasswordBox.Name = "Password"
PasswordBox.Size = UDim2.new(1, -30, 0, 32)
PasswordBox.Position = UDim2.new(0, 15, 0, 80)
PasswordBox.BackgroundColor3 = UI.Colors.Button
PasswordBox.PlaceholderText = "Password"
PasswordBox.Text = ""
PasswordBox.TextColor3 = UI.Colors.Text
PasswordBox.TextSize = 12
PasswordBox.Font = UI.Fonts.Normal

local LoginExeBtn = Instance.new("TextButton", LoginView)
LoginExeBtn.Size = UDim2.new(1, -30, 0, 32)
LoginExeBtn.Position = UDim2.new(0, 15, 0, 120)
LoginExeBtn.BackgroundColor3 = UI.Colors.Accent
LoginExeBtn.Text = "Login"
LoginExeBtn.TextColor3 = UI.Colors.Text
LoginExeBtn.TextSize = 12
LoginExeBtn.Font = UI.Fonts.Title

-- UI Padding
for _, obj in pairs({UsernameBox, PasswordBox, LoginExeBtn}) do
    local pad = Instance.new("UIPadding", obj)
    pad.PaddingLeft = UDim.new(0, 10)
end

for _, obj in pairs({ChoosePlayer, ChooseRegion}) do
    local pad = Instance.new("UIPadding", obj)
    pad.PaddingLeft = UDim.new(0, 8)
end

-- Status Frame
local StatusFrame = Instance.new("Frame", ScreenGui)
StatusFrame.Name = "StatusFrame"
StatusFrame.Size = UDim2.new(0, 140, 0, 26)
StatusFrame.Position = UDim2.new(1, -150, 0, 15)
StatusFrame.BackgroundColor3 = UI.Colors.Background
StatusFrame.BorderSizePixel = 0

local StatusCorner = Instance.new("UICorner", StatusFrame)
StatusCorner.CornerRadius = UDim.new(0, 4)

local StatusLabel = Instance.new("TextLabel", StatusFrame)
StatusLabel.Size = UDim2.new(1, 0, 1, 0)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = "Status: Free"
StatusLabel.TextColor3 = UI.Colors.TextDim
StatusLabel.TextSize = 10
StatusLabel.Font = UI.Fonts.Small
StatusLabel.TextXAlignment = Enum.TextXAlignment.Center

addShadow(StatusFrame)

-- FUNCTIONS
local function updateToggle(button, state)
    local indicator = button:FindFirstChild("Indicator")
    button.BackgroundColor3 = state and UI.Colors.Success or UI.Colors.Button
    indicator.Position = state and UDim2.new(1, -16, 0.5, -7) or UDim2.new(0, 2, 0.5, -7)
end

local function getPlayerLevel()
    local data = player:FindFirstChild("Data") or player:FindFirstChild("leaderstats")
    if data then
        local level = data:FindFirstChild("Level") or data:FindFirstChild("level")
        if level then return tostring(level.Value) end
    end
    return "N/A"
end

local function updateProfile()
    ProfileInfo.Text = string.format(
        "Nama : %s\nLevel : %s\nStatus : %s",
        player.Name,
        getPlayerLevel(),
        isLoggedIn and "Premium" or "Free"
    )
end

local function switchMenu(menuName)
    currentMenu = menuName
    ContentView.Visible = true
    
    -- Reset button colors
    for _, btn in pairs(menuButtons) do
        btn.BackgroundColor3 = UI.Colors.Button
    end
    
    -- Hide all views
    ProfileView.Visible = false
    TeleportView.Visible = false
        },
    ["Kohana Volcano"] = {
        position = Vector3.new(380, 60, -180),
        description = "Kohana Volcano - Inside the mountain"
    },
    
    -- Ocean Area
    ["The Ocean"] = {
        position = Vector3.new(-200, 50, 100),
        description = "Open Ocean - Deep Sea"
    },
    
    -- Coral Reef
    ["Coral Reef Island"] = {
        position = Vector3.new(600, 50, 300),
        description = "Coral Reef - Colorful fish"
    },
    
    -- Tropical Grove
    ["Tropical Grove Island"] = {
        position = Vector3.new(900, 50, -400),
        description = "Tropical Grove - Palm trees"
    },
    
    -- Crater Island
    ["Crater Island"] = {
        position = Vector3.new(-400, 50, 600),
        description = "Crater Island - Volcanic area"
    },
    
    -- Esoteric Depths
    ["Esoteric Depths"] = {
        position = Vector3.new(1200, 50, 100),
        description = "Esoteric Depths - Enchant area"
    },
    
    -- Lost Isle / Sisyphus
    ["Sisyphus Statue"] = {
        position = Vector3.new(800, 30, -800),
        description = "Sisyphus Statue - Secret area"
    },
    ["Treasure Room"] = {
        position = Vector3.new(850, 30, -750),
        description = "Treasure Room - Diving required"
    },
    
    -- Ancient Jungle
    ["Ancient Jungle"] = {
        position = Vector3.new(-600, 50, -500),
        description = "Ancient Jungle - Temple area"
    },
    ["Sacred Temple"] = {
        position = Vector3.new(-620, 50, -520),
        description = "Sacred Temple - Inside jungle"
    },
    ["Underground Cellar"] = {
        position = Vector3.new(-580, 20, -480),
        description = "Underground Cellar - Secret"
    },
    
    -- Classic Island
    ["Classic Island"] = {
        position = Vector3.new(1500, 50, 0),
        description = "Classic Island - Retro area"
    },
    ["Iron Cavern"] = {
        position = Vector3.new(1480, 40, -50),
        description = "Iron Cavern - Underground"
    }
}

-- Create GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TarzBotGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 450, 0, 350)
MainFrame.Position = UDim2.new(0.5, -225, 0.5, -175)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = true

-- Corner untuk frame
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 6)
UICorner.Parent = MainFrame

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 30)
TitleBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 6)
TitleCorner.Parent = TitleBar

-- Title Text
local TitleText = Instance.new("TextLabel")
TitleText.Name = "TitleText"
TitleText.Size = UDim2.new(1, -80, 1, 0)
TitleText.Position = UDim2.new(0, 10, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = "TarzBot"
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.TextSize = 16
TitleText.Font = Enum.Font.GothamBold
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.Parent = TitleBar

-- Version Label
local VersionLabel = Instance.new("TextLabel")
VersionLabel.Name = "VersionLabel"
VersionLabel.Size = UDim2.new(1, -80, 0, 10)
VersionLabel.Position = UDim2.new(0, 10, 0, 18)
VersionLabel.BackgroundTransparency = 1
VersionLabel.Text = "v1.0.1"
VersionLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
VersionLabel.TextSize = 10
VersionLabel.Font = Enum.Font.Gotham
VersionLabel.TextXAlignment = Enum.TextXAlignment.Left
VersionLabel.Parent = TitleBar

-- Minimize Button
local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Name = "MinimizeBtn"
MinimizeBtn.Size = UDim2.new(0, 30, 0, 20)
MinimizeBtn.Position = UDim2.new(1, -65, 0, 5)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
MinimizeBtn.BorderSizePixel = 0
MinimizeBtn.Text = "-"
MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeBtn.TextSize = 18
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.Parent = TitleBar

local MinimizeCorner = Instance.new("UICorner")
MinimizeCorner.CornerRadius = UDim.new(0, 4)
MinimizeCorner.Parent = MinimizeBtn

-- Close Button
local CloseBtn = Instance.new("TextButton")
CloseBtn.Name = "CloseBtn"
CloseBtn.Size = UDim2.new(0, 30, 0, 20)
CloseBtn.Position = UDim2.new(1, -35, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(231, 76, 60)
CloseBtn.BorderSizePixel = 0
CloseBtn.Text = "×"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 18
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.Parent = TitleBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 4)
CloseCorner.Parent = CloseBtn

-- Minimized Logo
local MinimizedLogo = Instance.new("TextButton")
MinimizedLogo.Name = "MinimizedLogo"
MinimizedLogo.Size = UDim2.new(0, 50, 0, 50)
MinimizedLogo.Position = UDim2.new(0, 10, 0, 10)
MinimizedLogo.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MinimizedLogo.BorderSizePixel = 0
MinimizedLogo.Text = "TB"
MinimizedLogo.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizedLogo.TextSize = 18
MinimizedLogo.Font = Enum.Font.GothamBold
MinimizedLogo.Visible = false
MinimizedLogo.Active = true
MinimizedLogo.Draggable = true

local LogoCorner = Instance.new("UICorner")
LogoCorner.CornerRadius = UDim.new(0, 8)
LogoCorner.Parent = MinimizedLogo

-- Menu Container
local MenuContainer = Instance.new("Frame")
MenuContainer.Name = "MenuContainer"
MenuContainer.Size = UDim2.new(1, 0, 1, -30)
MenuContainer.Position = UDim2.new(0, 0, 0, 30)
MenuContainer.BackgroundTransparency = 1
MenuContainer.BorderSizePixel = 0
MenuContainer.Parent = MainFrame

-- Menu Buttons
local menuButtons = {
    {text = "[¥] Profile", name = "ProfileBtn"},
    {text = "[€] Teleport", name = "TeleportBtn"},
    {text = "[π] Informasi", name = "InfoBtn"},
    {text = "[¢] Lain", name = "LainBtn"},
    {text = "[£] Login", name = "LoginBtn"}
}

local menuYPosition = 10
for i, menu in ipairs(menuButtons) do
    local btn = Instance.new("TextButton")
    btn.Name = menu.name
    btn.Size = UDim2.new(1, -20, 0, 35)
    btn.Position = UDim2.new(0, 10, 0, menuYPosition)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.BorderSizePixel = 0
    btn.Text = menu.text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 14
    btn.Font = Enum.Font.Gotham
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Parent = MenuContainer
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 4)
    btnCorner.Parent = btn
    
    menuYPosition = menuYPosition + 40
end

-- Separator Line
local Separator = Instance.new("Frame")
Separator.Name = "Separator"
Separator.Size = UDim2.new(1, -20, 0, 1)
Separator.Position = UDim2.new(0, 10, 0, menuYPosition)
Separator.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
Separator.BorderSizePixel = 0
Separator.Parent = MenuContainer

-- Content Frame
local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, -20, 1, -menuYPosition - 20)
ContentFrame.Position = UDim2.new(0, 10, 0, menuYPosition + 10)
ContentFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
ContentFrame.BorderSizePixel = 0
ContentFrame.Visible = false
ContentFrame.Parent = MenuContainer

local ContentCorner = Instance.new("UICorner")
ContentCorner.CornerRadius = UDim.new(0, 4)
ContentCorner.Parent = ContentFrame

-- Profile Frame
local ProfileFrame = Instance.new("Frame")
ProfileFrame.Name = "ProfileFrame"
ProfileFrame.Size = UDim2.new(1, 0, 1, 0)
ProfileFrame.BackgroundTransparency = 1
ProfileFrame.BorderSizePixel = 0
ProfileFrame.Visible = false
ProfileFrame.Parent = ContentFrame

local ProfileTitle = Instance.new("TextLabel")
ProfileTitle.Size = UDim2.new(1, 0, 0, 30)
ProfileTitle.BackgroundTransparency = 1
ProfileTitle.Text = "[¥] Profile"
ProfileTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
ProfileTitle.TextSize = 16
ProfileTitle.Font = Enum.Font.GothamBold
ProfileTitle.TextXAlignment = Enum.TextXAlignment.Left
ProfileTitle.Parent = ProfileFrame

local ProfileContent = Instance.new("TextLabel")
ProfileContent.Size = UDim2.new(1, 0, 1, -40)
ProfileContent.Position = UDim2.new(0, 0, 0, 35)
ProfileContent.BackgroundTransparency = 1
ProfileContent.TextColor3 = Color3.fromRGB(200, 200, 200)
ProfileContent.TextSize = 14
ProfileContent.Font = Enum.Font.Gotham
ProfileContent.TextXAlignment = Enum.TextXAlignment.Left
ProfileContent.TextYAlignment = Enum.TextYAlignment.Top
ProfileContent.Parent = ProfileFrame

-- Teleport Frame
local TeleportFrame = Instance.new("Frame")
TeleportFrame.Name = "TeleportFrame"
TeleportFrame.Size = UDim2.new(1, 0, 1, 0)
TeleportFrame.BackgroundTransparency = 1
TeleportFrame.BorderSizePixel = 0
TeleportFrame.Visible = false
TeleportFrame.Parent = ContentFrame

-- TELEPORT TO PEOPLE
local TeleportToPeopleBtn = Instance.new("TextButton")
TeleportToPeopleBtn.Name = "TeleportToPeopleBtn"
TeleportToPeopleBtn.Size = UDim2.new(1, 0, 0, 35)
TeleportToPeopleBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
TeleportToPeopleBtn.BorderSizePixel = 0
TeleportToPeopleBtn.Text = "Teleport To People →"
TeleportToPeopleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
TeleportToPeopleBtn.TextSize = 14
TeleportToPeopleBtn.Font = Enum.Font.Gotham
TeleportToPeopleBtn.TextXAlignment = Enum.TextXAlignment.Left
TeleportToPeopleBtn.Parent = TeleportFrame

local TeleportToPeopleContent = Instance.new("Frame")
TeleportToPeopleContent.Name = "TeleportToPeopleContent"
TeleportToPeopleContent.Size = UDim2.new(1, 0, 0, 180)
TeleportToPeopleContent.Position = UDim2.new(0, 0, 0, 40)
TeleportToPeopleContent.BackgroundTransparency = 1
TeleportToPeopleContent.Visible = false
TeleportToPeopleContent.Parent = TeleportFrame

local ChoosePlayerBtn = Instance.new("TextButton")
ChoosePlayerBtn.Name = "ChoosePlayerBtn"
ChoosePlayerBtn.Size = UDim2.new(1, 0, 0, 30)
ChoosePlayerBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
ChoosePlayerBtn.BorderSizePixel = 0
ChoosePlayerBtn.Text = "Choose Someone:"
ChoosePlayerBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ChoosePlayerBtn.TextSize = 13
ChoosePlayerBtn.Font = Enum.Font.Gotham
ChoosePlayerBtn.Parent = TeleportToPeopleContent

local PlayerDropdown = Instance.new("ScrollingFrame")
PlayerDropdown.Name = "PlayerDropdown"
PlayerDropdown.Size = UDim2.new(1, 0, 0, 150)
PlayerDropdown.Position = UDim2.new(0, 0, 0, 30)
PlayerDropdown.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
PlayerDropdown.BorderSizePixel = 0
PlayerDropdown.Visible = false
PlayerDropdown.ScrollBarThickness = 5
PlayerDropdown.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
PlayerDropdown.Parent = TeleportToPeopleContent

local TeleportPlayerBtn = Instance.new("TextButton")
TeleportPlayerBtn.Name = "TeleportPlayerBtn"
TeleportPlayerBtn.Size = UDim2.new(1, 0, 0, 30)
TeleportPlayerBtn.Position = UDim2.new(0, 0, 0, 185)
TeleportPlayerBtn.BackgroundColor3 = Color3.fromRGB(52, 152, 219)
TeleportPlayerBtn.BorderSizePixel = 0
TeleportPlayerBtn.Text = "Teleport"
TeleportPlayerBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
TeleportPlayerBtn.TextSize = 14
TeleportPlayerBtn.Font = Enum.Font.GothamBold
TeleportPlayerBtn.Parent = TeleportToPeopleContent

-- TELEPORT TO REGION
local TeleportToRegionBtn = Instance.new("TextButton")
TeleportToRegionBtn.Name = "TeleportToRegionBtn"
TeleportToRegionBtn.Size = UDim2.new(1, 0, 0, 35)
TeleportToRegionBtn.Position = UDim2.new(0, 0, 0, 225)
TeleportToRegionBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
TeleportToRegionBtn.BorderSizePixel = 0
TeleportToRegionBtn.Text = "Teleport To The Region"
TeleportToRegionBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
TeleportToRegionBtn.TextSize = 14
TeleportToRegionBtn.Font = Enum.Font.Gotham
TeleportToRegionBtn.TextXAlignment = Enum.TextXAlignment.Left
TeleportToRegionBtn.Parent = TeleportFrame

local TeleportToRegionContent = Instance.new("Frame")
TeleportToRegionContent.Name = "TeleportToRegionContent"
TeleportToRegionContent.Size = UDim2.new(1, 0, 0, 180)
TeleportToRegionContent.Position = UDim2.new(0, 0, 0, 265)
TeleportToRegionContent.BackgroundTransparency = 1
TeleportToRegionContent.Visible = false
TeleportToRegionContent.Parent = TeleportFrame

local ChooseRegionBtn = Instance.new("TextButton")
ChooseRegionBtn.Name = "ChooseRegionBtn"
ChooseRegionBtn.Size = UDim2.new(1, 0, 0, 30)
ChooseRegionBtn.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
ChooseRegionBtn.BorderSizePixel = 0
ChooseRegionBtn.Text = "Choose Region:"
ChooseRegionBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ChooseRegionBtn.TextSize = 13
ChooseRegionBtn.Font = Enum.Font.Gotham
ChoosePlayerBtn.Parent = TeleportToRegionContent

local RegionDropdown = Instance.new("ScrollingFrame")
RegionDropdown.Name = "RegionDropdown"
RegionDropdown.Size = UDim2.new(1, 0, 0, 150)
RegionDropdown.Position = UDim2.new(0, 0, 0, 30)
RegionDropdown.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
RegionDropdown.BorderSizePixel = 0
RegionDropdown.Visible = false
RegionDropdown.ScrollBarThickness = 5
RegionDropdown.ScrollBarImageColor3 = Color3.fromRGB(100, 100, 100)
RegionDropdown.Parent = TeleportToRegionContent

local TeleportRegionBtn = Instance.new("TextButton")
TeleportRegionBtn.Name = "TeleportRegionBtn"
TeleportRegionBtn.Size = UDim2.new(1, 0, 0, 30)
TeleportRegionBtn.Position = UDim2.new(0, 0, 0, 185)
TeleportRegionBtn.BackgroundColor3 = Color3.fromRGB(52, 152, 219)
TeleportRegionBtn.BorderSizePixel = 0
TeleportRegionBtn.Text = "Teleport"
TeleportRegionBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
TeleportRegionBtn.TextSize = 14
TeleportRegionBtn.Font = Enum.Font.GothamBold
TeleportRegionBtn.Parent = TeleportToRegionContent

-- Refresh Button
local RefreshBtn = Instance.new("TextButton")
RefreshBtn.Name = "RefreshBtn"
RefreshBtn.Size = UDim2.new(1, 0, 0, 30)
RefreshBtn.Position = UDim2.new(0, 0, 0, 450)
RefreshBtn.BackgroundColor3 = Color3.fromRGB(46, 204, 113)
RefreshBtn.BorderSizePixel = 0
RefreshBtn.Text = "Refresh"
RefreshBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
RefreshBtn.TextSize = 14
RefreshBtn.Font = Enum.Font.GothamBold
RefreshBtn.Parent = TeleportFrame

-- Info Frame
local InfoFrame = Instance.new("Frame")
InfoFrame.Name = "InfoFrame"
InfoFrame.Size = UDim2.new(1, 0, 1, 0)
InfoFrame.BackgroundTransparency = 1
InfoFrame.BorderSizePixel = 0
InfoFrame.Visible = false
InfoFrame.Parent = ContentFrame

local InfoTitle = Instance.new("TextLabel")
InfoTitle.Size = UDim2.new(1, 0, 0, 30)
InfoTitle.BackgroundTransparency = 1
InfoTitle.Text = "INFORMASI"
InfoTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
InfoTitle.TextSize = 16
InfoTitle.Font = Enum.Font.GothamBold
InfoTitle.TextXAlignment = Enum.TextXAlignment.Left
InfoTitle.Parent = InfoFrame

local InfoContent = Instance.new("TextLabel")
InfoContent.Size = UDim2.new(1, 0, 1, -40)
InfoContent.Position = UDim2.new(0, 0, 0, 35)
InfoContent.BackgroundTransparency = 1
InfoContent.Text = "Telegram: @tarzbot\nWhatsApp: 0812345678\nTiktok: @_tarzbot"
InfoContent.TextColor3 = Color3.fromRGB(200, 200, 200)
InfoContent.TextSize = 14
InfoContent.Font = Enum.Font.Gotham
InfoContent.TextXAlignment = Enum.TextXAlignment.Left
InfoContent.TextYAlignment = Enum.TextYAlignment.Top
InfoContent.Parent = InfoFrame

-- Lain Frame
local LainFrame = Instance.new("Frame")
LainFrame.Name = "LainFrame"
LainFrame.Size = UDim2.new(1, 0, 1, 0)
LainFrame.BackgroundTransparency = 1
LainFrame.BorderSizePixel = 0
LainFrame.Visible = false
InfoFrame.Parent = ContentFrame

local LainTitle = Instance.new("TextLabel")
LainTitle.Size = UDim2.new(1, 0, 0, 30)
LainTitle.BackgroundTransparency = 1
LainTitle.Text = "[¢] Lain"
LainTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
LainTitle.TextSize = 16
LainTitle.Font = Enum.Font.GothamBold
LainTitle.TextXAlignment = Enum.TextXAlignment.Left
LainTitle.Parent = LainFrame

-- Animasi Rod Toggle
local AnimasiRodFrame = Instance.new("Frame")
AnimasiRodFrame.Size = UDim2.new(1, 0, 0, 30)
AnimasiRodFrame.Position = UDim2.new(0, 0, 0, 40)
AnimasiRodFrame.BackgroundTransparency = 1
AnimasiRodFrame.Parent = LainFrame

local AnimasiRodLabel = Instance.new("TextLabel")
AnimasiRodLabel.Size = UDim2.new(1, -50, 1, 0)
AnimasiRodLabel.BackgroundTransparency = 1
AnimasiRodLabel.Text = "Animasi Rod"
AnimasiRodLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
AnimasiRodLabel.TextSize = 14
AnimasiRodLabel.Font = Enum.Font.Gotham
AnimasiRodLabel.TextXAlignment = Enum.TextXAlignment.Left
AnimasiRodLabel.Parent = AnimasiRodFrame

local AnimasiRodToggle = Instance.new("TextButton")
AnimasiRodToggle.Name = "AnimasiRodToggle"
AnimasiRodToggle.Size = UDim2.new(0, 40, 0, 20)
AnimasiRodToggle.Position = UDim2.new(1, -45, 0.5, -10)
AnimasiRodToggle.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
AnimasiRodToggle.BorderSizePixel = 0
AnimasiRodToggle.Text = ""
AnimasiRodToggle.Parent = AnimasiRodFrame

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(0, 10)
ToggleCorner.Parent = AnimasiRodToggle

local ToggleIndicator = Instance.new("Frame")
ToggleIndicator.Size = UDim2.new(0, 16, 0, 16)
ToggleIndicator.Position = UDim2.new(0, 2, 0.5, -8)
ToggleIndicator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ToggleIndicator.BorderSizePixel = 0
ToggleIndicator.Parent = AnimasiRodToggle

local IndicatorCorner = Instance.new("UICorner")
IndicatorCorner.CornerRadius = UDim.new(0, 8)
IndicatorCorner.Parent = ToggleIndicator

-- Notifikasi Fish Toggle
local NotifikasiFishFrame = Instance.new("Frame")
NotifikasiFishFrame.Size = UDim2.new(1, 0, 0, 30)
NotifikasiFishFrame.Position = UDim2.new(0, 0, 0, 75)
NotifikasiFishFrame.BackgroundTransparency = 1
NotifikasiFishFrame.Parent = LainFrame

local NotifikasiFishLabel = Instance.new("TextLabel")
NotifikasiFishLabel.Size = UDim2.new(1, -50, 1, 0)
NotifikasiFishLabel.BackgroundTransparency = 1
NotifikasiFishLabel.Text = "Notifikasi Fish"
NotifikasiFishLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
NotifikasiFishLabel.TextSize = 14
NotifikasiFishLabel.Font = Enum.Font.Gotham
NotifikasiFishLabel.TextXAlignment = Enum.TextXAlignment.Left
NotifikasiFishLabel.Parent = NotifikasiFishFrame

local NotifikasiFishToggle = Instance.new("TextButton")
NotifikasiFishToggle.Name = "NotifikasiFishToggle"
NotifikasiFishToggle.Size = UDim2.new(0, 40, 0, 20)
NotifikasiFishToggle.Position = UDim2.new(1, -45, 0.5, -10)
NotifikasiFishToggle.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
NotifikasiFishToggle.BorderSizePixel = 0
NotifikasiFishToggle.Text = ""
NotifikasiFishToggle.Parent = NotifikasiFishFrame

local ToggleCorner2 = Instance.new("UICorner")--==================================================
-- TOP BAR
--==================================================
local Top = Instance.new("Frame", Main)
Top.Size = UDim2.new(1,0,0,34)
Top.BackgroundColor3 = Color3.fromRGB(22,22,35)
Top.BorderSizePixel = 0
Instance.new("UICorner", Top).CornerRadius = UDim.new(0,12)

local Title = Instance.new("TextLabel", Top)
Title.Size = UDim2.new(1,-80,1,0)
Title.Position = UDim2.fromOffset(12,0)
Title.BackgroundTransparency = 1
Title.Text = "AZKA"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.TextColor3 = Color3.fromRGB(120,200,255)
Title.TextXAlignment = Left

-- MINIMIZE
local Min = Instance.new("TextButton", Top)
Min.Size = UDim2.fromOffset(24,18)
Min.Position = UDim2.fromOffset(448,8)
Min.Text = "-"
Min.Font = Enum.Font.GothamBold
Min.TextSize = 18
Min.TextColor3 = Color3.new(1,1,1)
Min.BackgroundColor3 = Color3.fromRGB(70,70,100)
Min.BorderSizePixel = 0
Instance.new("UICorner", Min).CornerRadius = UDim.new(0,6)

-- CLOSE
local Close = Instance.new("TextButton", Top)
Close.Size = UDim2.fromOffset(24,18)
Close.Position = UDim2.fromOffset(472,8)
Close.Text = "X"
Close.Font = Enum.Font.GothamBold
Close.TextSize = 14
Close.TextColor3 = Color3.new(1,1,1)
Close.BackgroundColor3 = Color3.fromRGB(160,60,60)
Close.BorderSizePixel = 0
Instance.new("UICorner", Close).CornerRadius = UDim.new(0,6)

--==================================================
-- SIDEBAR
--==================================================
local Side = Instance.new("Frame", Main)
Side.Position = UDim2.fromOffset(0,34)
Side.Size = UDim2.new(0,130,1,-34)
Side.BackgroundColor3 = Color3.fromRGB(18,18,28)
Side.BorderSizePixel = 0

--==================================================
-- CONTENT
--==================================================
local Content = Instance.new("Frame", Main)
Content.Position = UDim2.fromOffset(140,44)
Content.Size = UDim2.new(1,-150,1,-54)
Content.BackgroundTransparency = 1

local Layout = Instance.new("UIListLayout", Content)
Layout.Padding = UDim.new(0,6)

--==================================================
-- LOGO MINIMIZE
--==================================================
local Logo = Instance.new("TextButton", ScreenGui)
Logo.Size = UDim2.fromOffset(54,54)
Logo.Position = UDim2.fromOffset(40,300)
Logo.Text = "AZKA"
Logo.Visible = false
Logo.Font = Enum.Font.GothamBold
Logo.TextSize = 12
Logo.TextColor3 = Color3.fromRGB(120,200,255)
Logo.BackgroundColor3 = Color3.fromRGB(20,20,30)
Logo.Active = true
Logo.Draggable = true
Logo.BorderSizePixel = 0
Instance.new("UICorner", Logo).CornerRadius = UDim.new(1,0)

--==================================================
-- BUTTON ACTIONS
--==================================================
Close.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

Min.MouseButton1Click:Connect(function()
    Main.Visible = false
    Logo.Visible = true
end)

Logo.MouseButton1Click:Connect(function()
    Main.Visible = true
    Logo.Visible = false
end)

--==================================================
-- UI HELPERS
--==================================================
local function Clear()
    for _,v in ipairs(Content:GetChildren()) do
        if v:IsA("TextButton") then
            v:Destroy()
        end
    end
end

local function Button(txt, cb)
    local b = Instance.new("TextButton", Content)
    b.Size = UDim2.new(1,0,0,28)
    b.Text = txt
    b.Font = Enum.Font.Gotham
    b.TextSize = 12
    b.TextColor3 = Color3.fromRGB(235,235,255)
    b.BackgroundColor3 = Color3.fromRGB(30,30,45)
    b.BorderSizePixel = 0
    Instance.new("UICorner", b).CornerRadius = UDim.new(0,8)
    if cb then b.MouseButton1Click:Connect(cb) end
end

--==================================================
-- TELEPORT DATA (LENGKAP)
--==================================================
local TP = {
    ["Starter Pier"] = CFrame.new(0,8,50),
    ["Fisherman Island"] = CFrame.new(220,9,40),
    ["Ocean"] = CFrame.new(0,5,-300),
    ["Sandy Bay"] = CFrame.new(-150,8,120),
    ["Forest River"] = CFrame.new(-320,8,40),
    ["Deep Reef"] = CFrame.new(0,-40,-450),
    ["Mystic Valley"] = CFrame.new(300,12,-200),
    ["Frozen Depths"] = CFrame.new(-500,-30,-600),
    ["Lava Cavern"] = CFrame.new(480,-20,320),
    ["Kohana Island"] = CFrame.new(120,10,-60),
    ["Kohana Volcano"] = CFrame.new(160,40,-90),
    ["Tropical Grove"] = CFrame.new(-60,10,260),
    ["Crater Island"] = CFrame.new(400,20,420),
    ["Lost Isle - Patung SysPush"] = CFrame.new(0,10,0),
    ["Lost Isle - Ruang Harta Karun"] = CFrame.new(40,10,120),
}

--==================================================
-- TELEPORT MENU
--==================================================
local function TeleportMenu()
    Clear()
    Button("== TELEPORT TEMPAT ==")

    for name,cf in pairs(TP) do
        Button("📍 "..name,function()
            local hrp = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
            if hrp then hrp.CFrame = cf end
        end)
    end

    Button("== TELEPORT PLAYER ==")

    for _,plr in ipairs(Players:GetPlayers()) do
        if plr ~= LP then
            Button("👤 "..plr.Name,function()
                local my = LP.Character and LP.Character:FindFirstChild("HumanoidRootPart")
                local tg = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
                if my and tg then
                    my.CFrame = tg.CFrame * CFrame.new(0,0,3)
                end
            end)
        end
    end
end

--==================================================
-- INFO MENU
--==================================================
local function InfoMenu()
    Clear()
    Button("AZKA Script")
    Button("Game : Fish It")
    Button("Style : Chloe X Inspired")
    Button("Status : Stable")
end

--==================================================
-- SIDEBAR BUTTONS
--==================================================
local function SideButton(text, y, cb)
    local b = Instance.new("TextButton", Side)
    b.Size = UDim2.new(1,0,0,34)
    b.Position = UDim2.fromOffset(0,y)
    b.Text = text
    b.Font = Enum.Font.GothamBold
    b.TextSize = 13
    b.TextColor3 = Color3.fromRGB(120,200,255)
    b.BackgroundColor3 = Color3.fromRGB(22,22,35)
    b.BorderSizePixel = 0
    Instance.new("UICorner", b).CornerRadius = UDim.new(0,8)
    b.MouseButton1Click:Connect(cb)
end

SideButton("Teleport", 10, TeleportMenu)
SideButton("Informasi", 52, InfoMenu)

-- DEFAULT
TeleportMenu()Title.TextXAlignment = Left

local MinBtn = Instance.new("TextButton", Top)
MinBtn.Size = UDim2.new(0,30,0,30)
MinBtn.Position = UDim2.new(1,-70,0,5)
MinBtn.Text = "-"
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 22
MinBtn.BackgroundColor3 = Color3.fromRGB(60,60,60)
MinBtn.TextColor3 = Color3.new(1,1,1)

local CloseBtn = Instance.new("TextButton", Top)
CloseBtn.Size = UDim2.new(0,30,0,30)
CloseBtn.Position = UDim2.new(1,-35,0,5)
CloseBtn.Text = "X"
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 18
CloseBtn.BackgroundColor3 = Color3.fromRGB(170,50,50)
CloseBtn.TextColor3 = Color3.new(1,1,1)

--================ TAB BAR =========================
local TabBar = Instance.new("Frame", Main)
TabBar.Size = UDim2.new(1,0,0,35)
TabBar.Position = UDim2.new(0,0,0,40)
TabBar.BackgroundColor3 = Color3.fromRGB(30,30,30)

local function MakeTab(text, x)
	local b = Instance.new("TextButton", TabBar)
	b.Size = UDim2.new(0.33,0,1,0)
	b.Position = UDim2.new(x,0,0,0)
	b.Text = text
	b.Font = Enum.Font.GothamBold
	b.TextSize = 14
	b.TextColor3 = Color3.new(1,1,1)
	b.BackgroundTransparency = 1
	return b
end

local TabTP = MakeTab("Teleport",0)
local TabPL = MakeTab("Player",0.33)
local TabIN = MakeTab("Info",0.66)

--================ CONTENT FRAMES ==================
local function MakeFrame()
	local f = Instance.new("Frame", Main)
	f.Size = UDim2.new(1,0,1,-75)
	f.Position = UDim2.new(0,0,0,75)
	f.BackgroundTransparency = 1
	f.Visible = false
	return f
end

local TPFrame = MakeFrame()
local PlayerFrame = MakeFrame()
local InfoFrame = MakeFrame()
TPFrame.Visible = true

--================ SCROLL TEMPLATE =================
local function MakeScroll(parent)
	local s = Instance.new("ScrollingFrame", parent)
	s.Size = UDim2.new(1,-10,1,-10)
	s.Position = UDim2.new(0,5,0,5)
	s.AutomaticCanvasSize = Enum.AutomaticSize.Y
	s.CanvasSize = UDim2.new(0,0,0,0)
	s.ScrollBarThickness = 6
	s.ClipsDescendants = true
	Instance.new("UIListLayout", s).Padding = UDim.new(0,6)
	return s
end

--================ TELEPORT WILAYAH ================
local TPS = {
	["Starter Pier"] = CFrame.new(120,15,-300),
	["Fisherman Island"] = CFrame.new(300,18,-520),
	["Ocean"] = CFrame.new(-450,10,820),
	["Sandy Bay"] = CFrame.new(650,14,-200),
	["Forest River"] = CFrame.new(980,20,-120),
	["Deep Reef"] = CFrame.new(-820,-10,1450),
	["Mystic Valley"] = CFrame.new(1200,25,600),
	["Frozen Depths"] = CFrame.new(-1350,8,2100),
	["Lava Cavern"] = CFrame.new(1850,-5,-1600),
	["Kohana Island"] = CFrame.new(1650,25,-900),
	["Kohana Volcano"] = CFrame.new(1720,60,-880),
	["Tropical Grove"] = CFrame.new(2200,20,300),
	["Crater Island"] = CFrame.new(-2100,18,500),
	["Lost Isle"] = CFrame.new(2600,30,-2000),
}

local TPScroll = MakeScroll(TPFrame)
for name,cf in pairs(TPS) do
	local b = Instance.new("TextButton", TPScroll)
	b.Size = UDim2.new(1,-10,0,36)
	b.Text = name
	b.Font = Enum.Font.Gotham
	b.TextSize = 14
	b.TextColor3 = Color3.new(1,1,1)
	b.BackgroundColor3 = Color3.fromRGB(45,45,45)
	b.MouseButton1Click:Connect(function()
		hrp.CFrame = cf
	end)
end

--================ TELEPORT PLAYER =================
local PLScroll = MakeScroll(PlayerFrame)

local function RefreshPlayers()
	PLScroll:ClearAllChildren()
	Instance.new("UIListLayout", PLScroll).Padding = UDim.new(0,6)

	for _,plr in pairs(Players:GetPlayers()) do
		if plr ~= player and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
			local b = Instance.new("TextButton", PLScroll)
			b.Size = UDim2.new(1,-10,0,36)
			b.Text = plr.Name
			b.Font = Enum.Font.Gotham
			b.TextSize = 14
			b.TextColor3 = Color3.new(1,1,1)
			b.BackgroundColor3 = Color3.fromRGB(45,45,45)
			b.MouseButton1Click:Connect(function()
				hrp.CFrame = plr.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,-3)
			end)
		end
	end
end

RefreshPlayers()
Players.PlayerAdded:Connect(RefreshPlayers)
Players.PlayerRemoving:Connect(RefreshPlayers)

--================ INFO ============================
local Info = Instance.new("TextLabel", InfoFrame)
Info.Size = UDim2.new(1,-20,1,-20)
Info.Position = UDim2.new(0,10,0,10)
Info.TextWrapped = true
Info.TextYAlignment = Top
Info.Text = "TarzBot\n\nTeleport Wilayah\nTeleport ke Player\nGUI Minimize & Drag\n\nFish It Roblox"
Info.TextColor3 = Color3.new(1,1,1)
Info.Font = Enum.Font.Gotham
Info.TextSize = 14
Info.BackgroundTransparency = 1

--================ TAB FUNCTION ====================
local function Show(f)
	TPFrame.Visible = false
	PlayerFrame.Visible = false
	InfoFrame.Visible = false
	f.Visible = true
end

TabTP.MouseButton1Click:Connect(function() Show(TPFrame) end)
TabPL.MouseButton1Click:Connect(function() Show(PlayerFrame) end)
TabIN.MouseButton1Click:Connect(function() Show(InfoFrame) end)

--================ MINI LOGO =======================
local Mini = Instance.new("Frame", gui)
Mini.Size = UDim2.new(0,120,0,40)
Mini.Position = UDim2.new(0,20,0.5,0)
Mini.BackgroundColor3 = Color3.fromRGB(35,35,35)
Mini.Visible = false
Mini.Active = true
Mini.Draggable = true
Instance.new("UICorner", Mini).CornerRadius = UDim.new(0,8)

local MiniBtn = Instance.new("TextButton", Mini)
MiniBtn.Size = UDim2.new(1,0,1,0)
MiniBtn.Text = "TarzBot"
MiniBtn.Font = Enum.Font.GothamBold
MiniBtn.TextSize = 16
MiniBtn.TextColor3 = Color3.new(1,1,1)
MiniBtn.BackgroundTransparency = 1

--================ BUTTON ACTION ===================
MinBtn.MouseButton1Click:Connect(function()
	Main.Visible = false
	Mini.Visible = true
end)

MiniBtn.MouseButton1Click:Connect(function()
	Main.Visible = true
	Mini.Visible = false
end)

CloseBtn.MouseButton1Click:Connect(function()
	gui:Destroy()
end)
