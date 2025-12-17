-- main.lua untuk Fish It GUI
-- Created by: TarzBot

-- Variables
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Configuration
local CONFIG = {
    version = "V1.0.1",
    correctUsername = "AZKA",
    correctPassword = "AZKA",
    timeLimit = 3600, -- 1 jam dalam detik
    telegram = "@tarzbot",
    whatsapp = "0812345678",
    tiktok = "@_tarzbot"
}

-- Main GUI Creation
local function createMainGUI()
    -- ScreenGui
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "FishItGUI"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.Parent = playerGui

    -- Main Frame
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 400, 0, 300)
    MainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
    MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MainFrame.BorderSizePixel = 0
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.Parent = ScreenGui

    -- Corner
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 8)
    UICorner.Parent = MainFrame

    -- Title Bar
    local TitleBar = Instance.new("Frame")
    TitleBar.Name = "TitleBar"
    TitleBar.Size = UDim2.new(1, 0, 0, 35)
    TitleBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    TitleBar.BorderSizePixel = 0
    TitleBar.Parent = MainFrame

    local TitleCorner = Instance.new("UICorner")
    TitleCorner.CornerRadius = UDim.new(0, 8)
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
    TitleText.TextXAlignment = Enum.TextXAlignment.Left
    TitleText.Font = Enum.Font.GothamBold
    TitleText.Parent = TitleBar

    -- Version Label
    local VersionLabel = Instance.new("TextLabel")
    VersionLabel.Name = "VersionLabel"
    VersionLabel.Size = UDim2.new(1, -80, 0, 15)
    VersionLabel.Position = UDim2.new(0, 10, 0, 20)
    VersionLabel.BackgroundTransparency = 1
    VersionLabel.Text = CONFIG.version
    VersionLabel.TextColor3 = Color3.fromRGB(180, 180, 180)
    VersionLabel.TextSize = 10
    VersionLabel.TextXAlignment = Enum.TextXAlignment.Left
    VersionLabel.Font = Enum.Font.Gotham
    VersionLabel.Parent = TitleBar

    -- Minimize Button
    local MinimizeBtn = Instance.new("TextButton")
    MinimizeBtn.Name = "MinimizeBtn"
    MinimizeBtn.Size = UDim2.new(0, 30, 0, 25)
    MinimizeBtn.Position = UDim2.new(1, -65, 0, 5)
    MinimizeBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    MinimizeBtn.Text = "[-]"
    MinimizeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    MinimizeBtn.TextSize = 14
    MinimizeBtn.Font = Enum.Font.GothamBold
    MinimizeBtn.Parent = TitleBar

    local MinimizeCorner = Instance.new("UICorner")
    MinimizeCorner.CornerRadius = UDim.new(0, 4)
    MinimizeCorner.Parent = MinimizeBtn

    -- Close Button
    local CloseBtn = Instance.new("TextButton")
    CloseBtn.Name = "CloseBtn"
    CloseBtn.Size = UDim2.new(0, 30, 0, 25)
    CloseBtn.Position = UDim2.new(1, -35, 0, 5)
    CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 60, 60)
    CloseBtn.Text = "[x]"
    CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseBtn.TextSize = 14
    CloseBtn.Font = Enum.Font.GothamBold
    CloseBtn.Parent = TitleBar

    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(0, 4)
    CloseCorner.Parent = CloseBtn

    -- Content Frame
    local ContentFrame = Instance.new("Frame")
    ContentFrame.Name = "ContentFrame"
    ContentFrame.Size = UDim2.new(1, 0, 1, -35)
    ContentFrame.Position = UDim2.new(0, 0, 0, 35)
    ContentFrame.BackgroundTransparency = 1
    ContentFrame.Parent = MainFrame

    -- Menu Buttons
    local menuButtons = {}
    local menuNames = {"[¥] Profile", "[€] Teleport", "[π] Informasi", "[¢] Lain", "[£] Login"}
    
    for i, menuName in ipairs(menuNames) do
        local MenuBtn = Instance.new("TextButton")
        MenuBtn.Name = menuName
        MenuBtn.Size = UDim2.new(1, -20, 0, 40)
        MenuBtn.Position = UDim2.new(0, 10, 0, 10 + (i-1)*45)
        MenuBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        MenuBtn.Text = menuName
        MenuBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
        MenuBtn.TextSize = 14
        MenuBtn.Font = Enum.Font.GothamBold
        MenuBtn.Parent = ContentFrame

        local MenuCorner = Instance.new("UICorner")
        MenuCorner.CornerRadius = UDim.new(0, 6)
        MenuCorner.Parent = MenuBtn

        table.insert(menuButtons, MenuBtn)
    end

    -- Pages
    local Pages = Instance.new("Folder")
    Pages.Name = "Pages"
    Pages.Parent = ContentFrame

    -- Profile Page
    local ProfilePage = Instance.new("Frame")
    ProfilePage.Name = "ProfilePage"
    ProfilePage.Size = UDim2.new(1, 0, 1, 0)
    ProfilePage.BackgroundTransparency = 1
    ProfilePage.Visible = false
    ProfilePage.Parent = Pages

    local ProfileLabel = Instance.new("TextLabel")
    ProfileLabel.Name = "ProfileLabel"
    ProfileLabel.Size = UDim2.new(1, -20, 0, 20)
    ProfileLabel.Position = UDim2.new(0, 10, 0, 10)
    ProfileLabel.BackgroundTransparency = 1
    ProfileLabel.Text = "[¥] Profile"
    ProfileLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    ProfileLabel.TextSize = 16
    ProfileLabel.Font = Enum.Font.GothamBold
    ProfileLabel.Parent = ProfilePage

    local ProfileInfo = Instance.new("TextLabel")
    ProfileInfo.Name = "ProfileInfo"
    ProfileInfo.Size = UDim2.new(1, -20, 0, 100)
    ProfileInfo.Position = UDim2.new(0, 10, 0, 40)
    ProfileInfo.BackgroundTransparency = 1
    ProfileInfo.Text = "Nama: " .. player.Name .. "\nLevel: Memuat...\nStatus: Free"
    ProfileInfo.TextColor3 = Color3.fromRGB(200, 200, 200)
    ProfileInfo.TextSize = 14
    ProfileInfo.TextXAlignment = Enum.TextXAlignment.Left
    ProfileInfo.TextYAlignment = Enum.TextYAlignment.Top
    ProfileInfo.Font = Enum.Font.Gotham
    ProfileInfo.Parent = ProfilePage

    -- Teleport Page
    local TeleportPage = Instance.new("Frame")
    TeleportPage.Name = "TeleportPage"
    TeleportPage.Size = UDim2.new(1, 0, 1, 0)
    TeleportPage.BackgroundTransparency = 1
    TeleportPage.Visible = false
    TeleportPage.Parent = Pages

    local TeleportLabel = Instance.new("TextLabel")
    TeleportLabel.Name = "TeleportLabel"
    TeleportLabel.Size = UDim2.new(1, -20, 0, 20)
    TeleportLabel.Position = UDim2.new(0, 10, 0, 10)
    TeleportLabel.BackgroundTransparency = 1
    TeleportLabel.Text = "[€] Teleport"
    TeleportLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TeleportLabel.TextSize = 16
    TeleportLabel.Font = Enum.Font.GothamBold
    TeleportLabel.Parent = TeleportPage

    -- Teleport to People
    local TPPeopleBtn = Instance.new("TextButton")
    TPPeopleBtn.Name = "TPPeopleBtn"
    TPPeopleBtn.Size = UDim2.new(1, -20, 0, 35)
    TPPeopleBtn.Position = UDim2.new(0, 10, 0, 40)
    TPPeopleBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    TPPeopleBtn.Text = "Teleport To People →"
    TPPeopleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    TPPeopleBtn.TextSize = 12
    TPPeopleBtn.Font = Enum.Font.Gotham
    TPPeopleBtn.Parent = TeleportPage

    local TPPeopleFrame = Instance.new("Frame")
    TPPeopleFrame.Name = "TPPeopleFrame"
    TPPeopleFrame.Size = UDim2.new(1, -20, 0, 120)
    TPPeopleFrame.Position = UDim2.new(0, 10, 0, 80)
    TPPeopleFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    TPPeopleFrame.Visible = false
    TPPeopleFrame.Parent = TeleportPage

    local TPPeopleInfo = Instance.new("TextLabel")
    TPPeopleInfo.Name = "TPPeopleInfo"
    TPPeopleInfo.Size = UDim2.new(1, -10, 0, 20)
    TPPeopleInfo.Position = UDim2.new(0, 5, 0, 5)
    TPPeopleInfo.BackgroundTransparency = 1
    TPPeopleInfo.Text = "Choose Someone:"
    TPPeopleInfo.TextColor3 = Color3.fromRGB(200, 200, 200)
    TPPeopleInfo.TextSize = 12
    TPPeopleInfo.Font = Enum.Font.Gotham
    TPPeopleInfo.Parent = TPPeopleFrame

    local PlayerDropdown = Instance.new("TextButton")
    PlayerDropdown.Name = "PlayerDropdown"
    PlayerDropdown.Size = UDim2.new(1, -10, 0, 30)
    PlayerDropdown.Position = UDim2.new(0, 5, 0, 30)
    PlayerDropdown.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    PlayerDropdown.Text = "Pilih Player..."
    PlayerDropdown.TextColor3 = Color3.fromRGB(255, 255, 255)
    PlayerDropdown.TextSize = 12
    PlayerDropdown.Font = Enum.Font.Gotham
    PlayerDropdown.Parent = TPPeopleFrame

    local TPTargetBtn = Instance.new("TextButton")
    TPTargetBtn.Name = "TPTargetBtn"
    TPTargetBtn.Size = UDim2.new(1, -10, 0, 30)
    TPTargetBtn.Position = UDim2.new(0, 5, 0, 65)
    TPTargetBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    TPTargetBtn.Text = "Teleport"
    TPTargetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    TPTargetBtn.TextSize = 12
    TPTargetBtn.Font = Enum.Font.GothamBold
    TPTargetBtn.Parent = TPPeopleFrame

    -- Teleport to Region
    local TPRegionBtn = Instance.new("TextButton")
    TPRegionBtn.Name = "TPRegionBtn"
    TPRegionBtn.Size = UDim2.new(1, -20, 0, 35)
    TPRegionBtn.Position = UDim2.new(0, 10, 0, 210)
    TPRegionBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    TPRegionBtn.Text = "Teleport To The Region"
    TPRegionBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    TPRegionBtn.TextSize = 12
    TPRegionBtn.Font = Enum.Font.Gotham
    TPRegionBtn.Parent = TeleportPage

    local TPRegionFrame = Instance.new("Frame")
    TPRegionFrame.Name = "TPRegionFrame"
    TPRegionFrame.Size = UDim2.new(1, -20, 0, 100)
    TPRegionFrame.Position = UDim2.new(0, 10, 0, 250)
    TPRegionFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    TPRegionFrame.Visible = false
    TPRegionFrame.Parent = TeleportPage

    local RegionDropdown = Instance.new("TextButton")
    RegionDropdown.Name = "RegionDropdown"
    RegionDropdown.Size = UDim2.new(1, -10, 0, 30)
    RegionDropdown.Position = UDim2.new(0, 5, 0, 5)
    RegionDropdown.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    RegionDropdown.Text = "Pilih Wilayah..."
    RegionDropdown.TextColor3 = Color3.fromRGB(255, 255, 255)
    RegionDropdown.TextSize = 12
    RegionDropdown.Font = Enum.Font.Gotham
    RegionDropdown.Parent = TPRegionFrame

    local TPRegionExecute = Instance.new("TextButton")
    TPRegionExecute.Name = "TPRegionExecute"
    TPRegionExecute.Size = UDim2.new(1, -10, 0, 30)
    TPRegionExecute.Position = UDim2.new(0, 5, 0, 40)
    TPRegionExecute.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    TPRegionExecute.Text = "Teleport"
    TPRegionExecute.TextColor3 = Color3.fromRGB(255, 255, 255)
    TPRegionExecute.TextSize = 12
    TPRegionExecute.Font = Enum.Font.GothamBold
    TPRegionExecute.Parent = TPRegionFrame

    -- Refresh Button
    local RefreshBtn = Instance.new("TextButton")
    RefreshBtn.Name = "RefreshBtn"
    RefreshBtn.Size = UDim2.new(0, 80, 0, 30)
    RefreshBtn.Position = UDim2.new(1, -90, 0, 360)
    RefreshBtn.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
    RefreshBtn.Text = "Refresh"
    RefreshBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    RefreshBtn.TextSize = 12
    RefreshBtn.Font = Enum.Font.GothamBold
    RefreshBtn.Parent = TeleportPage

    -- Info Page
    local InfoPage = Instance.new("Frame")
    InfoPage.Name = "InfoPage"
    InfoPage.Size = UDim2.new(1, 0, 1, 0)
    InfoPage.BackgroundTransparency = 1
    InfoPage.Visible = false
    InfoPage.Parent = Pages

    local InfoLabel = Instance.new("TextLabel")
    InfoLabel.Name = "InfoLabel"
    InfoLabel.Size = UDim2.new(1, -20, 0, 20)
    InfoLabel.Position = UDim2.new(0, 10, 0, 10)
    InfoLabel.BackgroundTransparency = 1
    InfoLabel.Text = "[π] Informasi"
    InfoLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    InfoLabel.TextSize = 16
    InfoLabel.Font = Enum.Font.GothamBold
    InfoLabel.Parent = InfoPage

    local InfoText = Instance.new("TextLabel")
    InfoText.Name = "InfoText"
    InfoText.Size = UDim2.new(1, -20, 0, 150)
    InfoText.Position = UDim2.new(0, 10, 0, 40)
    InfoText.BackgroundTransparency = 1
    InfoText.Text = "INFORMASI\nTelegram: " .. CONFIG.telegram .. "\nWhatsApp: " .. CONFIG.whatsapp .. "\nTikTok: " .. CONFIG.tiktok
    InfoText.TextColor3 = Color3.fromRGB(200, 200, 200)
    InfoText.TextSize = 14
    InfoText.TextXAlignment = Enum.TextXAlignment.Left
    InfoText.TextYAlignment = Enum.TextYAlignment.Top
    InfoText.Font = Enum.Font.Gotham
    InfoText.Parent = InfoPage

    -- Lain Page
    local LainPage = Instance.new("Frame")
    LainPage.Name = "LainPage"
    LainPage.Size = UDim2.new(1, 0, 1, 0)
    LainPage.BackgroundTransparency = 1
    LainPage.Visible = false
    LainPage.Parent = Pages

    local LainLabel = Instance.new("TextLabel")
    LainLabel.Name = "LainLabel"
    LainLabel.Size = UDim2.new(1, -20, 0, 20)
    LainLabel.Position = UDim2.new(0, 10, 0, 10)
    LainLabel.BackgroundTransparency = 1
    LainLabel.Text = "[¢] Lain"
    LainLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    LainLabel.TextSize = 16
    LainLabel.Font = Enum.Font.GothamBold
    LainLabel.Parent = LainPage

    -- Delete Animation Section
    local DeleteAnimBtn = Instance.new("TextButton")
    DeleteAnimBtn.Name = "DeleteAnimBtn"
    DeleteAnimBtn.Size = UDim2.new(1, -20, 0, 35)
    DeleteAnimBtn.Position = UDim2.new(0, 10, 0, 40)
    DeleteAnimBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    DeleteAnimBtn.Text = "Delete Animation →"
    DeleteAnimBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    DeleteAnimBtn.TextSize = 12
    DeleteAnimBtn.Font = Enum.Font.Gotham
    DeleteAnimBtn.Parent = LainPage

    local AnimFrame = Instance.new("Frame")
    AnimFrame.Name = "AnimFrame"
    AnimFrame.Size = UDim2.new(1, -20, 0, 150)
    AnimFrame.Position = UDim2.new(0, 10, 0, 80)
    AnimFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    AnimFrame.Visible = false
    AnimFrame.Parent = LainPage

    -- Toggle Switch Function
    local function createToggle(name, position, parent)
        local ToggleFrame = Instance.new("Frame")
        ToggleFrame.Name = name .. "Frame"
        ToggleFrame.Size = UDim2.new(1, -10, 0, 30)
        ToggleFrame.Position = position
        ToggleFrame.BackgroundTransparency = 1
        ToggleFrame.Parent = parent

        local ToggleLabel = Instance.new("TextLabel")
        ToggleLabel.Name = "Label"
        ToggleLabel.Size = UDim2.new(1, -40, 1, 0)
        ToggleLabel.BackgroundTransparency = 1
        ToggleLabel.Text = name
        ToggleLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
        ToggleLabel.TextSize = 12
        ToggleLabel.Font = Enum.Font.Gotham
        ToggleLabel.Parent = ToggleFrame

        local ToggleBtn = Instance.new("TextButton")
        ToggleBtn.Name = "ToggleBtn"
        ToggleBtn.Size = UDim2.new(0, 30, 0, 20)
        ToggleBtn.Position = UDim2.new(1, -35, 0.5, -10)
        ToggleBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        ToggleBtn.Text = ""
        ToggleBtn.Parent = ToggleFrame

        local ToggleCorner = Instance.new("UICorner")
        ToggleCorner.CornerRadius = UDim.new(0, 10)
        ToggleCorner.Parent = ToggleBtn

        local ToggleIndicator = Instance.new("Frame")
        ToggleIndicator.Name = "Indicator"
        ToggleIndicator.Size = UDim2.new(0, 16, 0, 16)
        ToggleIndicator.Position = UDim2.new(0, 2, 0.5, -8)
        ToggleIndicator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        ToggleIndicator.Parent = ToggleBtn

        local IndicatorCorner = Instance.new("UICorner")
        IndicatorCorner.CornerRadius = UDim.new(0, 8)
        IndicatorCorner.Parent = ToggleIndicator

        return ToggleBtn
    end

    local AnimRodToggle = createToggle("Animasi Rod", UDim2.new(0, 5, 0, 5), AnimFrame)
    local NotifToggle = createToggle("Notifikasi Fish", UDim2.new(0, 5, 0, 40), AnimFrame)
    local EffectToggle = createToggle("Animasi Efek Rod", UDim2.new(0, 5, 0, 75), AnimFrame)

    -- Login Page
    local LoginPage = Instance.new("Frame")
    LoginPage.Name = "LoginPage"
    LoginPage.Size = UDim2.new(1, 0, 1, 0)
    LoginPage.BackgroundTransparency = 1
    LoginPage.Visible = false
    LoginPage.Parent = Pages

    local LoginLabel = Instance.new("TextLabel")
    LoginLabel.Name = "LoginLabel"
    LoginLabel.Size = UDim2.new(1, -20, 0, 20)
    LoginLabel.Position = UDim2.new(0, 10, 0, 10)
    LoginLabel.BackgroundTransparency = 1
    LoginLabel.Text = "[£] Login"
    LoginLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    LoginLabel.TextSize = 16
    LoginLabel.Font = Enum.Font.GothamBold
    LoginLabel.Parent = LoginPage

    local LoginFrame = Instance.new("Frame")
    LoginFrame.Name = "LoginFrame"
    LoginFrame.Size = UDim2.new(1, -20, 0, 200)
    LoginFrame.Position = UDim2.new(0, 10, 0, 40)
    LoginFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    LoginFrame.Parent = LoginPage

    local LoginCorner = Instance.new("UICorner")
    LoginCorner.CornerRadius = UDim.new(0, 6)
    LoginCorner.Parent = LoginFrame

    local UsernameLabel = Instance.new("TextLabel")
    UsernameLabel.Name = "UsernameLabel"
    UsernameLabel.Size = UDim2.new(1, -20, 0, 20)
    UsernameLabel.Position = UDim2.new(0, 10, 0, 10)
    UsernameLabel.BackgroundTransparency = 1
    UsernameLabel.Text = "Username:"
    UsernameLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    UsernameLabel.TextSize = 12
    UsernameLabel.Font = Enum.Font.Gotham
    UsernameLabel.TextXAlignment = Enum.TextXAlignment.Left
    UsernameLabel.Parent = LoginFrame

    local UsernameInput = Instance.new("TextBox")
    UsernameInput.Name = "UsernameInput"
    UsernameInput.Size = UDim2.new(1, -20, 0, 30)
    UsernameInput.Position = UDim2.new(0, 10, 0, 35)
    UsernameInput.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    UsernameInput.Text = ""
    UsernameInput.PlaceholderText = "Masukkan username"
    UsernameInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    UsernameInput.TextSize = 12
    UsernameInput.Font = Enum.Font.Gotham
    UsernameInput.Parent = LoginFrame

    local PasswordLabel = Instance.new("TextLabel")
    PasswordLabel.Name = "PasswordLabel"
    PasswordLabel.Size = UDim2.new(1, -20, 0, 20)
    PasswordLabel.Position = UDim2.new(0, 10, 0, 75)
    PasswordLabel.BackgroundTransparency = 1
    PasswordLabel.Text = "Password:"
    PasswordLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    PasswordLabel.TextSize = 12
    PasswordLabel.Font = Enum.Font.Gotham
    PasswordLabel.TextXAlignment = Enum.TextXAlignment.Left
    PasswordLabel.Parent = LoginFrame

    local PasswordInput = Instance.new("TextBox")
    PasswordInput.Name = "PasswordInput"
    PasswordInput.Size = UDim2.new(1, -20, 0, 30)
    PasswordInput.Position = UDim2.new(0, 10, 0, 100)
    PasswordInput.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    PasswordInput.Text = ""
    PasswordInput.PlaceholderText = "Masukkan password"
    PasswordInput.TextColor3 = Color3.fromRGB(255, 255, 255)
    PasswordInput.TextSize = 12
    PasswordInput.Font = Enum.Font.Gotham
    PasswordInput.Parent = LoginFrame

    local LoginBtn = Instance.new("TextButton")
    LoginBtn.Name = "LoginBtn"
    LoginBtn.Size = UDim2.new(1, -20, 0, 35)
    LoginBtn.Position = UDim2.new(0, 10, 0, 145)
    LoginBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    LoginBtn.Text = "Login"
    LoginBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    LoginBtn.TextSize = 14
    LoginBtn.Font = Enum.Font.GothamBold
    LoginBtn.Parent = LoginFrame

    -- Minimized Icon
    local MinimizedIcon = Instance.new(
