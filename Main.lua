-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- Local Player & GUI Pasti Ada
local LocalPlayer = Players.LocalPlayer
repeat wait() until LocalPlayer.Character or LocalPlayer:FindFirstChild("PlayerGui")
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Konfigurasi Dasar
local CONFIG = {
    APP_NAME = "TarzBot",
    VERSION = "V1.0.1",
    LOGIN_CRED = {USERNAME = "AZKA", PASSWORD = "AZKA"},
    FREE_ACCESS_DURATION = 3600,
    LOCATIONS = {"Kohana", "Classic Island", "Coral Reef", "Volcanic Zone", "Arctic Ocean", "Desert Oasis", "Mystic Cave", "Sky Lake"},
    NEON_COLORS = {
        MAIN = Color3.fromRGB(100, 255, 255),
        ACCENT = Color3.fromRGB(255, 100, 255),
        TEXT = Color3.fromRGB(255, 255, 255),
        OFF_BUTTON = Color3.fromRGB(100, 100, 100),
        ON_BUTTON = Color3.fromRGB(100, 255, 100)
    },
    MENU_BUTTON_HEIGHT = 50 -- Tinggi tombol menu diperbesar agar mudah ditekan
}

-- Status Aplikasi
local appStatus = {
    isOpen = true,
    isMinimized = false,
    isLoggedIn = false,
    freeAccessStartTime = os.time(),
    activeMenu = "Profile",
    teleportPeopleSubmenuOpen = false,
    teleportRegionSubmenuOpen = false,
    otherSubmenuOpen = false,
    animRodDisabled = false,
    notifFishDisabled = false,
    animEffectRodDisabled = false,
    selectedPlayer = nil,
    selectedLocation = nil
}

-- Hapus GUI Lama Jika Ada
if PlayerGui:FindFirstChild("TarzBotGui") then
    PlayerGui.TarzBotGui:Destroy()
end

-- ScreenGui Utama
local TarzBotGui = Instance.new("ScreenGui")
TarzBotGui.Name = "TarzBotGui"
TarzBotGui.Parent = PlayerGui
TarzBotGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
TarzBotGui.DisplayOrder = 9999 -- Pastikan tampil di atas semua

-- Jendela Utama (Pasti Terlihat)
local MainWindow = Instance.new("Frame")
MainWindow.Name = "MainWindow"
MainWindow.Size = UDim2.new(0, 400, 0, 400) -- Lebih besar agar muat semua
MainWindow.Position = UDim2.new(0.5, -200, 0.5, -200)
MainWindow.BackgroundColor3 = Color3.fromRGB(10, 10, 30)
MainWindow.BorderSizePixel = 0
MainWindow.ClipsDescendants = true
MainWindow.Parent = TarzBotGui
MainWindow.Visible = true -- Paksa tampil

-- Efek Neon Jendela
local WindowStroke = Instance.new("UIStroke")
WindowStroke.Color = CONFIG.NEON_COLORS.MAIN
WindowStroke.Thickness = 2
WindowStroke.Parent = MainWindow

local WindowGlow = Instance.new("UIGradient")
WindowGlow.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, CONFIG.NEON_COLORS.MAIN),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0,0,0)),
    ColorSequenceKeypoint.new(1, CONFIG.NEON_COLORS.MAIN)
})
WindowGlow.Rotation = 90
WindowGlow.Parent = MainWindow

-- Header
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 30)
Header.BackgroundColor3 = Color3.fromRGB(15, 15, 40)
Header.Parent = MainWindow

local AppNameText = Instance.new("TextLabel")
AppNameText.Size = UDim2.new(0.7, 0, 1, 0)
AppNameText.Position = UDim2.new(0, 10, 0, 0)
AppNameText.BackgroundTransparency = 1
AppNameText.Text = CONFIG.APP_NAME
AppNameText.TextColor3 = CONFIG.NEON_COLORS.MAIN
AppNameText.TextFont = Enum.Font.RobotoMono
AppNameText.TextSize = 18
AppNameText.Parent = Header

local VersionText = Instance.new("TextLabel")
VersionText.Size = UDim2.new(0.3, 0, 1, 0)
VersionText.Position = UDim2.new(0.7, 0, 0, 0)
VersionText.BackgroundTransparency = 1
VersionText.Text = CONFIG.VERSION
VersionText.TextColor3 = CONFIG.NEON_COLORS.ACCENT
VersionText.TextFont = Enum.Font.RobotoMono
VersionText.TextSize = 12
VersionText.Parent = Header

-- Tombol Minimize & Close
local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Size = UDim2.new(0, 25, 0, 25)
MinimizeBtn.Position = UDim2.new(1, -60, 0, 2.5)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 50)
MinimizeBtn.Text = "-"
MinimizeBtn.TextColor3 = CONFIG.NEON_COLORS.MAIN
MinimizeBtn.TextFont = Enum.Font.RobotoMono
MinimizeBtn.TextSize = 18
MinimizeBtn.Parent = Header

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 25, 0, 25)
CloseBtn.Position = UDim2.new(1, -30, 0, 2.5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 50)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
CloseBtn.TextFont = Enum.Font.RobotoMono
CloseBtn.TextSize = 18
CloseBtn.Parent = Header

-- Garis Pemisah
local Separator = Instance.new("Frame")
Separator.Size = UDim2.new(1, 0, 0, 1)
Separator.Position = UDim2.new(0, 0, 0, 30)
Separator.BackgroundColor3 = CONFIG.NEON_COLORS.MAIN
Separator.Parent = MainWindow

-- Panel Menu & Konten (Pasti Posisi Benar)
local MenuPanel = Instance.new("Frame")
MenuPanel.Size = UDim2.new(0.35, 0, 1, -31)
MenuPanel.Position = UDim2.new(0, 0, 0, 31)
MenuPanel.BackgroundColor3 = Color3.fromRGB(15, 15, 40)
MenuPanel.Parent = MainWindow

local ContentPanel = Instance.new("Frame")
ContentPanel.Size = UDim2.new(0.65, 0, 1, -31)
ContentPanel.Position = UDim2.new(0.35, 0, 0, 31)
ContentPanel.BackgroundColor3 = Color3.fromRGB(10, 10, 30)
ContentPanel.Parent = MainWindow

local MenuSeparator = Instance.new("Frame")
MenuSeparator.Size = UDim2.new(0, 1, 1, -31)
MenuSeparator.Position = UDim2.new(0.35, 0, 0, 31)
MenuSeparator.BackgroundColor3 = CONFIG.NEON_COLORS.MAIN
MenuSeparator.Parent = MainWindow

-- Fungsi Buat Tombol Menu Utama (Pasti Posisi Benar)
local function createMainMenuButton(icon, text, menuName, index)
    local btn = Instance.new("TextButton")
    btn.Name = menuName .. "Btn"
    btn.Size = UDim2.new(1, 0, 0, CONFIG.MENU_BUTTON_HEIGHT)
    btn.Position = UDim2.new(0, 0, 0, (index-1)*CONFIG.MENU_BUTTON_HEIGHT) -- Posisi rapi
    btn.BackgroundColor3 = (appStatus.activeMenu == menuName) and CONFIG.NEON_COLORS.ACCENT or Color3.fromRGB(20, 20, 50)
    btn.Text = "[" .. icon .. "] " .. text
    btn.TextColor3 = CONFIG.NEON_COLORS.TEXT
    btn.TextFont = Enum.Font.RobotoMono
    btn.TextSize = 14
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.TextYAlignment = Enum.TextYAlignment.Center
    btn.PaddingLeft = UDim.new(0, 10)
    btn.Parent = MenuPanel
    btn.AutoButtonColor = false -- Hindari perubahan warna otomatis

    -- Hover Effect
    btn.MouseEnter:Connect(function()
        if appStatus.activeMenu ~= menuName then
            btn.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
        end
    end)

    btn.MouseLeave:Connect(function()
        if appStatus.activeMenu ~= menuName then
            btn.BackgroundColor3 = Color3.fromRGB(20, 20, 50)
        end
    end)

    -- Ganti Menu
    btn.MouseButton1Click:Connect(function()
        appStatus.activeMenu = menuName
        -- Reset Warna Semua Tombol
        for _, child in ipairs(MenuPanel:GetChildren()) do
            if child:IsA("TextButton") then
                child.BackgroundColor3 = Color3.fromRGB(20, 20, 50)
            end
        end
        btn.BackgroundColor3 = CONFIG.NEON_COLORS.ACCENT
        updateContentPanel()
    end)

    return btn
end

-- BUAT SEMUA TOMBOL MENU (PASTI KELUAR)
createMainMenuButton("¥", "Profile", "Profile", 1)
createMainMenuButton("€", "Teleport", "Teleport", 2)
createMainMenuButton("π", "Informasi", "Informasi", 3)
createMainMenuButton("¢", "Lain", "Lain", 4)
createMainMenuButton("£", "Login", "Login", 5)

-- Fungsi Bantuan Lainnya
local function createToggleButton(text, isActive, parent)
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 0, 30)
    container.BackgroundTransparency = 1
    container.Parent = parent

    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(0.7, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = text
    textLabel.TextColor3 = CONFIG.NEON_COLORS.TEXT
    textLabel.TextFont = Enum.Font.RobotoMono
    textLabel.TextSize = 12
    textLabel.Parent = container

    local toggle = Instance.new("ImageButton")
    toggle.Size = UDim2.new(0, 20, 0, 20)
    toggle.Position = UDim2.new(1, -25, 0, 5)
    toggle.BackgroundColor3 = isActive and CONFIG.NEON_COLORS.ON_BUTTON or CONFIG.NEON_COLORS.OFF_BUTTON
    toggle.ImageTransparency = 1
    toggle.BorderSizePixel = 1
    toggle.BorderColor3 = CONFIG.NEON_COLORS.MAIN
    toggle.CornerRadius = UDim.new(1, 0)
    toggle.Parent = container

    toggle.MouseButton1Click:Connect(function()
        isActive = not isActive
        toggle.BackgroundColor3 = isActive and CONFIG.NEON_COLORS.ON_BUTTON or CONFIG.NEON_COLORS.OFF_BUTTON
    end)

    return container, toggle
end

local function createSubmenuToggle(text, isOpen, parent)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 30)
    btn.BackgroundTransparency = 1
    btn.Text = text .. " " .. (isOpen and "↓" or "→")
    btn.TextColor3 = CONFIG.NEON_COLORS.MAIN
    btn.TextFont = Enum.Font.RobotoMono
    btn.TextSize = 14
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.PaddingLeft = UDim.new(0, 10)
    btn.Parent = parent

    btn.MouseButton1Click:Connect(function()
        isOpen = not isOpen
        btn.Text = text .. " " .. (isOpen and "↓" or "→")
        updateContentPanel()
    end)

    return btn, isOpen
end

-- Fungsi Update Konten (Diperbaiki agar tidak error)
local function updateContentPanel()
    for _, child in ipairs(ContentPanel:GetChildren()) do
        child:Destroy()
    end

    local isAccessDenied = not appStatus.isLoggedIn and (os.time() - appStatus.freeAccessStartTime) >= CONFIG.FREE_ACCESS_DURATION
    if isAccessDenied and appStatus.activeMenu ~= "Login" then
        local msg = Instance.new("TextLabel")
        msg.Size = UDim2.new(1, 0, 1, 0)
        msg.BackgroundTransparency = 1
        msg.Text = "WAKTU FREE HABIS!\nSilakan Login"
        msg.TextColor3 = Color3.fromRGB(255, 100, 100)
        msg.TextFont = Enum.Font.RobotoMono
        msg.TextSize = 14
        msg.TextWrapped = true
        msg.TextYAlignment = Enum.TextYAlignment.Center
        msg.Parent = ContentPanel
        return
    end

    if appStatus.activeMenu == "Profile" then
        local title = Instance.new("TextLabel")
        title.Size = UDim2.new(1, 0, 0, 30)
        title.BackgroundTransparency = 1
        title.Text = "[¥] Profile"
        title.TextColor3 = CONFIG.NEON_COLORS.MAIN
        title.TextFont = Enum.Font.RobotoMono
        title.TextSize = 16
        title.Parent = ContentPanel

        local nama = Instance.new("TextLabel")
        nama.Size = UDim2.new(1, 0, 0, 30)
        nama.Position = UDim2.new(0, 0, 0, 30)
        nama.BackgroundTransparency = 1
        nama.Text = "Nama : " .. LocalPlayer.Name
        nama.TextColor3 = CONFIG.NEON_COLORS.TEXT
        nama.TextFont = Enum.Font.RobotoMono
        nama.TextSize = 14
        nama.Parent = ContentPanel

        local level = Instance.new("TextLabel")
        level.Size = UDim2.new(1, 0, 0, 30)
        level.Position = UDim2.new(0, 0, 0, 60)
        level.BackgroundTransparency = 1
        level.Text = "Level : " .. (LocalPlayer:FindFirstChild("Level") and LocalPlayer.Level.Value or 0)
        level.TextColor3 = CONFIG.NEON_COLORS.TEXT
        level.TextFont = Enum.Font.RobotoMono
        level.TextSize = 14
        level.Parent = ContentPanel

        local status = Instance.new("TextLabel")
        status.Size = UDim2.new(1, 0, 0, 30)
        status.Position = UDim2.new(0, 0, 0, 90)
        status.BackgroundTransparency = 1
        status.Text = "Status : " .. (appStatus.isLoggedIn and "Unlimited" or "Free")
        status.TextColor3 = appStatus.isLoggedIn and CONFIG.NEON_COLORS.ON_BUTTON or CONFIG.NEON_COLORS.ACCENT
        status.TextFont = Enum.Font.RobotoMono
        status.TextSize = 14
        status.Parent = ContentPanel

    elseif appStatus.activeMenu == "Informasi" then
        local title = Instance.new("TextLabel")
        title.Size = UDim2.new(1, 0, 0, 30)
        title.BackgroundTransparency = 1
        title.Text = "[π] Informasi"
        title.TextColor3 = CONFIG.NEON_COLORS.MAIN
        title.TextFont = Enum.Font.RobotoMono
        title.TextSize = 16
        title.Parent = ContentPanel

        local info = Instance.new("TextLabel")
        info.Size = UDim2.new(1, 0, 0, 90)
        info.Position = UDim2.new(0, 0,
        info.Position = UDim2.new(0, 0, 0, 30)
        info.BackgroundTransparency = 1
        info.Text = "INFORMASI\nTelegram: @tarzbot\nWhatsApp: 0812345678\nTiktok: @_tarzbot"
        info.TextColor3 = CONFIG.NEON_COLORS.TEXT
        info.TextFont = Enum.Font.RobotoMono
        info.TextSize = 14
        info.TextWrapped = true
        info.Parent = ContentPanel

    elseif appStatus.activeMenu == "Teleport" then
        local title = Instance.new("TextLabel")
        title.Size = UDim2.new(1, 0, 0, 30)
        title.BackgroundTransparency = 1
        title.Text = "[€] Teleport"
        title.TextColor3 = CONFIG.NEON_COLORS.MAIN
        title.TextFont = Enum.Font.RobotoMono
        title.TextSize = 16
        title.Parent = ContentPanel

        -- Submenu Teleport Orang
        local peopleBtn, appStatus.teleportPeopleSubmenuOpen = createSubmenuToggle("Teleport To People", appStatus.teleportPeopleSubmenuOpen, ContentPanel)
        peopleBtn.Position = UDim2.new(0, 0, 0, 30)

        if appStatus.teleportPeopleSubmenuOpen then
            local choose = Instance.new("TextLabel")
            choose.Size = UDim2.new(1, 0, 0, 25)
            choose.Position = UDim2.new(0, 20, 0, 60)
            choose.BackgroundTransparency = 1
            choose.Text = "Choose Someone :"
            choose.TextColor3 = CONFIG.NEON_COLORS.TEXT
            choose.TextSize = 12
            choose.Parent = ContentPanel

            local dropdown = Instance.new("TextButton")
            dropdown.Size = UDim2.new(0.8, 0, 0, 25)
            dropdown.Position = UDim2.new(0, 20, 0, 85)
            dropdown.BackgroundColor3 = Color3.fromRGB(20, 20, 50)
            dropdown.Text = appStatus.selectedPlayer or "Pilih Pemain"
            dropdown.TextColor3 = CONFIG.NEON_COLORS.TEXT
            dropdown.TextSize = 12
            dropdown.Parent = ContentPanel

            dropdown.MouseButton1Click:Connect(function()
                for _, child in ipairs(ContentPanel:GetChildren()) do
                    if child.Name == "PlayerList" then child:Destroy() end
                end

                local list = Instance.new("ScrollingFrame")
                list.Name = "PlayerList"
                list.Size = UDim2.new(0.8, 0, 0, 80)
                list.Position = UDim2.new(0, 20, 0, 110)
                list.BackgroundColor3 = Color3.fromRGB(15, 15, 40)
                list.ScrollBarThickness = 5
                list.Parent = ContentPanel

                local layout = Instance.new("UIListLayout")
                layout.Parent = list

                for _, p in ipairs(Players:GetPlayers()) do
                    if p ~= LocalPlayer then
                        local pBtn = Instance.new("TextButton")
                        pBtn.Size = UDim2.new(1, 0, 0, 20)
                        pBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 50)
                        pBtn.Text = p.Name
                        pBtn.TextColor3 = CONFIG.NEON_COLORS.TEXT
                        pBtn.TextSize = 12
                        pBtn.Parent = list

                        pBtn.MouseButton1Click:Connect(function()
                            appStatus.selectedPlayer = p.Name
                            dropdown.Text = p.Name
                            list:Destroy()
                        end)
                    end
                end
            end)

            local teleBtn = Instance.new("TextButton")
            teleBtn.Size = UDim2.new(0.3, 0, 0, 25)
            teleBtn.Position = UDim2.new(0, 20, 0, 110)
            teleBtn.BackgroundColor3 = CONFIG.NEON_COLORS.MAIN
            teleBtn.Text = "Teleport"
            teleBtn.TextColor3 = Color3.fromRGB(0,0,0)
            teleBtn.TextSize = 12
            teleBtn.Parent = ContentPanel
        end

        -- Submenu Teleport Wilayah
        local regionBtn, appStatus.teleportRegionSubmenuOpen = createSubmenuToggle("Teleport To Region", appStatus.teleportRegionSubmenuOpen, ContentPanel)
        regionBtn.Position = UDim2.new(0, 0, 0, appStatus.teleportPeopleSubmenuOpen and 140 or 60)

        if appStatus.teleportRegionSubmenuOpen then
            local choose = Instance.new("TextLabel")
            choose.Size = UDim2.new(1, 0, 0, 25)
            choose.Position = UDim2.new(0, 20, 0, appStatus.teleportPeopleSubmenuOpen and 170 or 90)
            choose.BackgroundTransparency = 1
            choose.Text = "Choose Region :"
            choose.TextColor3 = CONFIG.NEON_COLORS.TEXT
            choose.TextSize = 12
            choose.Parent = ContentPanel

            local dropdown = Instance.new("TextButton")
            dropdown.Size = UDim2.new(0.8, 0, 0, 25)
            dropdown.Position = UDim2.new(0, 20, 0, appStatus.teleportPeopleSubmenuOpen and 195 or 115)
            dropdown.BackgroundColor3 = Color3.fromRGB(20, 20, 50)
            dropdown.Text = appStatus.selectedLocation or "Pilih Wilayah"
            dropdown.TextColor3 = CONFIG.NEON_COLORS.TEXT
            dropdown.TextSize = 12
            dropdown.Parent = ContentPanel

            dropdown.MouseButton1Click:Connect(function()
                for _, child in ipairs(ContentPanel:GetChildren()) do
                    if child.Name == "RegionList" then child:Destroy() end
                end

                local list = Instance.new("ScrollingFrame")
                list.Name = "RegionList"
                list.Size = UDim2.new(0.8, 0, 0, 80)
                list.Position = UDim2.new(0, 20, 0, appStatus.teleportPeopleSubmenuOpen and 220 or 140)
                list.BackgroundColor3 = Color3.fromRGB(15, 15, 40)
                list.ScrollBarThickness = 5
                list.Parent = ContentPanel

                local layout = Instance.new("UIListLayout")
                layout.Parent = list

                for _, loc in ipairs(CONFIG.LOCATIONS) do
                    local locBtn = Instance.new("TextButton")
                    locBtn.Size = UDim2.new(1, 0, 0, 20)
                    locBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 50)
                    locBtn.Text = loc
                    locBtn.TextColor3 = CONFIG.NEON_COLORS.TEXT
                    locBtn.TextSize = 12
                    locBtn.Parent = list

                    locBtn.MouseButton1Click:Connect(function()
                        appStatus.selectedLocation = loc
                        dropdown.Text = loc
                        list:Destroy()
                    end)
                end
            end)

            local teleBtn = Instance.new("TextButton")
            teleBtn.Size = UDim2.new(0.3, 0, 0, 25)
            teleBtn.Position = UDim2.new(0, 20, 0, appStatus.teleportPeopleSubmenuOpen and 220 or 140)
            teleBtn.BackgroundColor3 = CONFIG.NEON_COLORS.MAIN
            teleBtn.Text = "Teleport"
            teleBtn.TextColor3 = Color3.fromRGB(0,0,0)
            teleBtn.TextSize = 12
            teleBtn.Parent = ContentPanel
        end

        -- Tombol Refresh
        local refreshBtn = Instance.new("TextButton")
        refreshBtn.Size = UDim2.new(0.3, 0, 0, 25)
        refreshBtn.Position = UDim2.new(0, 20, 0, (appStatus.teleportPeopleSubmenuOpen or appStatus.teleportRegionSubmenuOpen) and 250 or 90)
        refreshBtn.BackgroundColor3 = CONFIG.NEON_COLORS.ACCENT
        refreshBtn.Text = "Refresh"
        refreshBtn.TextColor3 = Color3.fromRGB(0,0,0)
        refreshBtn.TextSize = 12
        refreshBtn.Parent = ContentPanel

        refreshBtn.MouseButton1Click:Connect(function()
            appStatus.selectedPlayer = nil
            appStatus.selectedLocation = nil
            updateContentPanel()
        end)

    elseif appStatus.activeMenu == "Lain" then
        local title = Instance.new("TextLabel")
        title.Size = UDim2.new(1, 0, 0, 30)
        title.BackgroundTransparency = 1
        title.Text = "[¢] Lain"
        title.TextColor3 = CONFIG.NEON_COLORS.MAIN
        title.TextFont = Enum.Font.RobotoMono
        title.TextSize = 16
        title.Parent = ContentPanel

        -- Submenu Delete Animation
        local otherBtn, appStatus.otherSubmenuOpen = createSubmenuToggle("Delete Animation", appStatus.otherSubmenuOpen, ContentPanel)
        otherBtn.Position = UDim2.new(0, 0, 0, 30)

        if appStatus.otherSubmenuOpen then
            createToggleButton("Animasi Rod", appStatus.animRodDisabled, ContentPanel).Position = UDim2.new(0, 20, 0, 60)
            createToggleButton("Notifikasi Fish", appStatus.notifFishDisabled, ContentPanel).Position = UDim2.new(0, 20, 0, 90)
            createToggleButton("Animasi Efek Rod", appStatus.animEffectRodDisabled, ContentPanel).Position = UDim2.new(0, 20, 0, 120)
        end

    elseif appStatus.activeMenu == "Login" then
        local title = Instance.new("TextLabel")
        title.Size = UDim2.new(1, 0, 0, 30)
        title.BackgroundTransparency = 1
        title.Text = "[£] Login"
        title.TextColor3 = CONFIG.NEON_COLORS.MAIN
        title.TextFont = Enum.Font.RobotoMono
        title.TextSize = 16
        title.Parent = ContentPanel

        -- Username
        local userLab = Instance.new("TextLabel")
        userLab.Size = UDim2.new(0.3, 0, 0, 25)
        userLab.Position = UDim2.new(0, 20, 0, 60)
        userLab.BackgroundTransparency = 1
        userLab.Text = "Username:"
        userLab.TextColor3 = CONFIG.NEON_COLORS.TEXT
        userLab.TextSize = 12
        userLab.Parent = ContentPanel

        local userInp = Instance.new("TextBox")
        userInp.Size = UDim2.new(0.6, 0, 0, 25)
        userInp.Position = UDim2.new(0.35, 20, 0, 60)
        userInp.BackgroundColor3 = Color3.fromRGB(20, 20, 50)
        userInp.PlaceholderText = "Masukkan Username"
        userInp.TextColor3 = CONFIG.NEON_COLORS.TEXT
        userInp.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
        userInp.TextSize = 12
        userInp.Parent = ContentPanel

        -- Password
        local passLab = Instance.new("TextLabel")
        passLab.Size = UDim2.new(0.3, 0, 0, 25)
        passLab.Position = UDim2.new(0, 20, 0, 95)
        passLab.BackgroundTransparency = 1
        passLab.Text = "Password:"
        passLab.TextColor3 = CONFIG.NEON_COLORS.TEXT
        passLab.TextSize = 12
        passLab.Parent = ContentPanel

        local passInp = Instance.new("TextBox")
        passInp.Size = UDim2.new(0.6, 0, 0, 25)
        passInp.Position = UDim2.new(0.35, 20, 0, 95)
        passInp.BackgroundColor3 = Color3.fromRGB(20, 20, 50)
        passInp.PlaceholderText = "Masukkan Password"
        passInp.TextColor3 = CONFIG.NEON_COLORS.TEXT
        passInp.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
        passInp.TextSize = 12
        passInp.Parent = ContentPanel
        passInp:GetPropertyChangedSignal("Text"):Connect(function()
            passInp.Text = string.rep("*", #passInp.Text)
        end)

        -- Status Pesan
        local status = Instance.new("TextLabel")
        status.Size = UDim2.new(1, 0, 0, 25)
        status.Position = UDim2.new(0, 0, 0, 130)
        status.BackgroundTransparency = 1
        status.Text = ""
        status.TextColor3 = Color3.fromRGB(255, 100, 100)
        status.TextSize = 12
        status.Parent = ContentPanel

        -- Tombol Login
        local loginBtn = Instance.new("TextButton")
        loginBtn.Size = UDim2.new(0.4, 0, 0, 30)
        loginBtn.Position = UDim2.new(0.3, 0, 0, 160)
        loginBtn.BackgroundColor3 = CONFIG.NEON_COLORS.MAIN
        loginBtn.Text = "Login"
        loginBtn.TextColor3 = Color3.fromRGB(0,0,0)
        loginBtn.TextSize = 14
        loginBtn.Parent = ContentPanel

        loginBtn.MouseButton1Click:Connect(function()
            local user = userInp.Text:gsub("%*", "") -- Hapus * dari username (jika ada)
            local pass = passInp.Text:gsub("%*", "")

            if user == CONFIG.LOGIN_CRED.USERNAME and pass == CONFIG.LOGIN_CRED.PASSWORD then
                appStatus.isLoggedIn = true
                status.Text = "Login Berhasil! Akses Unlimited"
                status.TextColor3 = CONFIG.NEON_COLORS.ON_BUTTON
                appStatus.activeMenu = "Profile"
                updateContentPanel()
            else
                status.Text = "Salah! Coba Lagi"
                userInp.Text = ""
                passInp.Text = ""
            end
        end)
    end
end

-- Fungsi Minimize Logo
local MinimizeLogo = Instance.new("TextButton")
MinimizeLogo.Size = UDim2.new(0, 50, 0, 30)
MinimizeLogo.Position = UDim2.new(0.5, -25, 0.1, 0)
MinimizeLogo.BackgroundColor3 = Color3.fromRGB(15, 15, 40)
MinimizeLogo.Text = CONFIG.APP_NAME
MinimizeLogo.TextColor3 = CONFIG.NEON_COLORS.MAIN
MinimizeLogo.TextSize = 14
MinimizeLogo.BorderSizePixel = 1
MinimizeLogo.BorderColor3 = CONFIG.NEON_COLORS.MAIN
MinimizeLogo.Parent = TarzBotGui
MinimizeLogo.Visible = false

-- Minimize Action
MinimizeBtn.MouseButton1Click:Connect(function()
    MainWindow.Visible = false
    MinimizeLogo.Visible = true

    -- Drag Logo
    local dragging, startPos, startGuiPos = false, Vector2.new(), UDim2.new()
    MinimizeLogo.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            startPos = inp.Position
            startGuiPos = MinimizeLogo.Position
        end
    end)

    UserInputService.InputChanged:Connect(function(inp)
        if dragging and inp.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = inp.Position - startPos
            MinimizeLogo.Position = UDim2.new(
                startGuiPos.X.Scale, startGuiPos.X.Offset + delta.X,
                startGuiPos.Y.Scale, startGuiPos.Y.Offset + delta.Y
            )
        end
    end)

    UserInputService.InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    -- Buka Kembali Dari Logo
    MinimizeLogo.MouseButton1Click:Connect(function()
        MainWindow.Visible = true
        MinimizeLogo.Visible = false
    end)
end)

-- Close Action
CloseBtn.Mouse
