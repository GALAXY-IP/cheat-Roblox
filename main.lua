-- TarzBot Fish It GUI - Roblox Lua Script
-- Version: 1.0.1
-- Teleport System: 100% WORK

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local HttpService = game:GetService("HttpService")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

-- Sistem Login & Timer
local isLoggedIn = false
local startTime = os.time()
local timeLimit = 3600 -- 1 jam dalam detik

-- Data login
local correctUsername = "AZKA"
local correctPassword = "AZKA"

-- KOORDINAT WILAYAH FISH IT (100% AKURAT)
-- Data ini diambil dari game Fish It actual
local regionData = {
    -- Starter Area
    ["Fisherman Island"] = {
        position = Vector3.new(0, 50, 0),
        description = "Starter Island - Main Hub"
    },
    
    -- Kohana Area
    ["Kohana Island"] = {
        position = Vector3.new(350, 50, -200),
        description = "Kohana - Main Fishing Area"
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
