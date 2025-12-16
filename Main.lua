-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- Local Player
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- Konfigurasi Dasar
local CONFIG = {
    APP_NAME = "TarzBot",
    VERSION = "V1.0.1",
    LOGIN_CRED = {USERNAME = "AZKA", PASSWORD = "AZKA"},
    FREE_ACCESS_DURATION = 3600, -- 1 jam dalam detik
    LOCATIONS = { -- Daftar lokasi Fish It (sesuai informasi publik)
        "Kohana", "Classic Island", "Coral Reef", "Volcanic Zone", 
        "Arctic Ocean", "Desert Oasis", "Mystic Cave", "Sky Lake"
    },
    NEON_COLORS = {
        MAIN = Color3.fromRGB(100, 255, 255), -- Cyan Neon
        ACCENT = Color3.fromRGB(255, 100, 255), -- Magenta Neon
        TEXT = Color3.fromRGB(255, 255, 255), -- Putih
        OFF_BUTTON = Color3.fromRGB(100, 100, 100), -- Abu-abu Mati
        ON_BUTTON = Color3.fromRGB(100, 255, 100) -- Hijau Neon
    }
}

-- Status Aplikasi
local appStatus = {
    isOpen = true,
    isMinimized = false,
    isLoggedIn = false,
    freeAccessStartTime = os.time(),
    activeMenu = "Profile",
    -- Status Submenu
    teleportPeopleSubmenuOpen = false,
    teleportRegionSubmenuOpen = false,
    otherSubmenuOpen = false,
    -- Status Toggle
    animRodDisabled = false,
    notifFishDisabled = false,
    animEffectRodDisabled = false,
    -- Data Teleport
    selectedPlayer = nil,
    selectedLocation = nil
}

-- Membuat ScreenGui Utama
local TarzBotGui = Instance.new("ScreenGui")
TarzBotGui.Name = "TarzBotGui"
TarzBotGui.Parent = PlayerGui
TarzBotGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Membuat Jendela Utama
local MainWindow = Instance.new("Frame")
MainWindow.Name = "MainWindow"
MainWindow.Size = UDim2.new(0, 400, 0, 350)
MainWindow.Position = UDim2.new(0.5, -200, 0.5, -175)
MainWindow.BackgroundColor3 = Color3.fromRGB(10, 10, 30) -- Latar Gelap
MainWindow.BorderSizePixel = 0
MainWindow.ClipsDescendants = true
MainWindow.Parent = TarzBotGui

-- Efek Neon Jendela
local WindowStroke = Instance.new("UIStroke")
WindowStroke.Name = "WindowStroke"
WindowStroke.Color = CONFIG.NEON_COLORS.MAIN
WindowStroke.Thickness = 2
WindowStroke.Parent = MainWindow

local WindowGlow = Instance.new("UIGradient")
WindowGlow.Name = "WindowGlow"
WindowGlow.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, CONFIG.NEON_COLORS.MAIN),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0,0,0)),
    ColorSequenceKeypoint.new(1, CONFIG.NEON_COLORS.MAIN)
})
WindowGlow.Rotation = 90
WindowGlow.Parent = MainWindow

-- Header Jendela
local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Size = UDim2.new(1, 0, 0, 30)
Header.BackgroundColor3 = Color3.fromRGB(15, 15, 40)
Header.BorderSizePixel = 0
Header.Parent = MainWindow

local AppNameText = Instance.new("TextLabel")
AppNameText.Name = "AppNameText"
AppNameText.Size = UDim2.new(0.7, 0, 1, 0)
AppNameText.Position = UDim2.new(0, 10, 0, 0)
AppNameText.BackgroundTransparency = 1
AppNameText.Text = CONFIG.APP_NAME
AppNameText.TextColor3 = CONFIG.NEON_COLORS.MAIN
AppNameText.TextFont = Enum.Font.RobotoMono
AppNameText.TextSize = 18
AppNameText.TextXAlignment = Enum.TextXAlignment.Left
AppNameText.Parent = Header

local VersionText = Instance.new("TextLabel")
VersionText.Name = "VersionText"
VersionText.Size = UDim2.new(0.3, 0, 1, 0)
VersionText.Position = UDim2.new(0.7, 0, 0, 0)
VersionText.BackgroundTransparency = 1
VersionText.Text = CONFIG.VERSION
VersionText.TextColor3 = CONFIG.NEON_COLORS.ACCENT
VersionText.TextFont = Enum.Font.RobotoMono
VersionText.TextSize = 12
VersionText.TextXAlignment = Enum.TextXAlignment.Right
VersionText.Parent = Header

-- Tombol Minimize (-)
local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Name = "MinimizeBtn"
MinimizeBtn.Size = UDim2.new(0, 25, 0, 25)
MinimizeBtn.Position = UDim2.new(1, -60, 0, 2.5)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 50)
MinimizeBtn.Text = "-"
MinimizeBtn.TextColor3 = CONFIG.NEON_COLORS.MAIN
MinimizeBtn.TextFont = Enum.Font.RobotoMono
MinimizeBtn.TextSize = 18
MinimizeBtn.BorderSizePixel = 0
MinimizeBtn.Parent = Header

-- Tombol Close (X)
local CloseBtn = Instance.new("TextButton")
CloseBtn.Name = "CloseBtn"
CloseBtn.Size = UDim2.new(0, 25, 0, 25)
CloseBtn.Position = UDim2.new(1, -30, 0, 2.5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 50)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 100, 100) -- Merah Neon
CloseBtn.TextFont = Enum.Font.RobotoMono
CloseBtn.TextSize = 18
CloseBtn.BorderSizePixel = 0
CloseBtn.Parent = Header

-- Garis Pemisah Header & Menu
local Separator = Instance.new("Frame")
Separator.Name = "Separator"
Separator.Size = UDim2.new(1, 0, 0, 1)
Separator.Position = UDim2.new(0, 0, 0, 30)
Separator.BackgroundColor3 = CONFIG.NEON_COLORS.MAIN
Separator.Parent = MainWindow

-- Panel Menu Utama
local MenuPanel = Instance.new("Frame")
MenuPanel.Name = "MenuPanel"
MenuPanel.Size = UDim2.new(0.35, 0, 1, -31)
MenuPanel.Position = UDim2.new(0, 0, 0, 31)
MenuPanel.BackgroundColor3 = Color3.fromRGB(15, 15, 40)
MenuPanel.BorderSizePixel = 0
MenuPanel.Parent = MainWindow

-- Panel Konten (Tampilkan Isi Menu)
local ContentPanel = Instance.new("Frame")
ContentPanel.Name = "ContentPanel"
ContentPanel.Size = UDim2.new(0.65, 0, 1, -31)
ContentPanel.Position = UDim2.new(0.35, 0, 0, 31)
ContentPanel.BackgroundColor3 = Color3.fromRGB(10, 10, 30)
ContentPanel.BorderSizePixel = 0
ContentPanel.Parent = MainWindow

-- Garis Pemisah Menu & Konten
local MenuSeparator = Instance.new("Frame")
MenuSeparator.Name = "MenuSeparator"
MenuSeparator.Size = UDim2.new(0, 1, 1, -31)
MenuSeparator.Position = UDim2.new(0.35, 0, 0, 31)
MenuSeparator.BackgroundColor3 = CONFIG.NEON_COLORS.MAIN
MenuSeparator.Parent = MainWindow

-- Membuat Menu Utama (5 Item)
local function createMainMenuButton(icon, text, menuName, index)
    local btn = Instance.new("TextButton")
    btn.Name = menuName .. "Btn"
    btn.Size = UDim2.new(1, 0, 0, 40)
    btn.Position = UDim2.new(0, 0, 0, (index-1)*40)
    btn.BackgroundColor3 = (appStatus.activeMenu == menuName) and CONFIG.NEON_COLORS.ACCENT or Color3.fromRGB(20, 20, 50)
    btn.Text = "[" .. icon .. "] " .. text
    btn.TextColor3 = CONFIG.NEON_COLORS.TEXT
    btn.TextFont = Enum.Font.RobotoMono
    btn.TextSize = 14
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.TextYAlignment = Enum.TextYAlignment.Center
    btn.PaddingLeft = UDim.new(0, 10)
    btn.BorderSizePixel = 0
    btn.Parent = MenuPanel

    -- Efek Hover
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

    -- Ganti Konten Saat Ditekan
    btn.MouseButton1Click:Connect(function()
        appStatus.activeMenu = menuName
        -- Reset Warna Semua Tombol
        for _, child in ipairs(MenuPanel:GetChildren()) do
            if child:IsA("TextButton") then
                child.BackgroundColor3 = Color3.fromRGB(20, 20, 50)
            end
        end
        -- Warna Tombol Aktif
        btn.BackgroundColor3 = CONFIG.NEON_COLORS.ACCENT
        -- Perbarui Konten
        updateContentPanel()
    end)

    return btn
end

-- Buat Semua Tombol Menu Utama
createMainMenuButton("¥", "Profile", "Profile", 1)
createMainMenuButton("€", "Teleport", "Teleport", 2)
createMainMenuButton("π", "Informasi", "Informasi", 3)
createMainMenuButton("¢", "Lain", "Lain", 4)
createMainMenuButton("£", "Login", "Login", 5)

-- Fungsi untuk Membuat Toggle Button (Bulat Neon)
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
    textLabel.TextXAlignment = Enum.TextXAlignment.Left
    textLabel.Parent = container

    local toggle = Instance.new("ImageButton")
    toggle.Size = UDim2.new(0, 20, 0, 20)
    toggle.Position = UDim2.new(1, -25, 0, 5)
    toggle.BackgroundColor3 = isActive and CONFIG.NEON_COLORS.ON_BUTTON or CONFIG.NEON_COLORS.OFF_BUTTON
    toggle.ImageTransparency = 1
    toggle.BorderSizePixel = 1
    toggle.BorderColor3 = CONFIG.NEON_COLORS.MAIN
    toggle.CornerRadius = UDim.new(1, 0) -- Bulat
    toggle.Parent = container

    -- Fungsi Toggle
    toggle.MouseButton1Click:Connect(function()
        isActive = not isActive
        toggle.BackgroundColor3 = isActive and CONFIG.NEON_COLORS.ON_BUTTON or CONFIG.NEON_COLORS.OFF_BUTTON
        return isActive
    end)

    return container, toggle, isActive
end

-- Fungsi untuk Membuat Submenu Toggle
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
        updateContentPanel() -- Perbarui Konten
    end)

    return btn, isOpen
end

-- Fungsi untuk Memperbarui Panel Konten
local function updateContentPanel()
    -- Hapus Semua Konten Lama
    for _, child in ipairs(ContentPanel:GetChildren()) do
        child:Destroy()
    end

    -- Cek Akses (jika tidak login & waktu habis)
    local isAccessDenied = not appStatus.isLoggedIn and (os.time() - appStatus.freeAccessStartTime) >= CONFIG.FREE_ACCESS_DURATION
    if isAccessDenied and appStatus.activeMenu ~= "Login" then
        appStatus.activeMenu = "Login"
        -- Tampilkan Pesan Waktu Habis
        local msg = Instance.new("TextLabel")
        msg.Size = UDim2.new(1, 0, 1, 0)
        msg.BackgroundTransparency = 1
        msg.Text = "WAKTU PENGGUNAAN FREE HABIS!\nSilakan Login untuk akses penuh"
        msg.TextColor3 = Color3.fromRGB(255, 100, 100)
        msg.TextFont = Enum.Font.RobotoMono
        msg.TextSize = 12
        msg.TextWrapped = true
        msg.TextYAlignment = Enum.TextYAlignment.Center
        msg.Parent = ContentPanel
        return
    end

    -- Tampilkan Konten Berdasarkan Menu Aktif
    if appStatus.activeMenu == "Profile" then
        -- Konten Profile
        local profileTitle = Instance.new("TextLabel")
        profileTitle.Size = UDim2.new(1, 0, 0, 30)
        profileTitle.BackgroundTransparency = 1
        profileTitle.Text = "[¥] Profile"
        profileTitle.TextColor3 = CONFIG.NEON_COLORS.MAIN
        profileTitle.TextFont = Enum.Font.RobotoMono
        profileTitle.TextSize = 16
        profileTitle.Parent = ContentPanel

        local userName = Instance.new("TextLabel")
        userName.Size = UDim2.new(1, 0, 0, 25)
        userName.Position = UDim2.new(0, 0, 0, 30)
        userName.BackgroundTransparency = 1
        userName.Text = "Nama : " .. LocalPlayer.Name
        userName.Text
-- (Lanjutan dari bagian sebelumnya, letakkan di akhir kode yang tadi terpotong)

        userName.TextColor3 = CONFIG.NEON_COLORS.TEXT
        userName.TextFont = Enum.Font.RobotoMono
        userName.TextSize = 14
        userName.Parent = ContentPanel

        -- Ambil Level dari Game (sesuai hierarki Fish It)
        local playerLevel = 0
        local levelValue = LocalPlayer:FindFirstChild("Level") or LocalPlayer.Character:FindFirstChild("Level")
        if levelValue then playerLevel = levelValue.Value end

        local userLevel = Instance.new("TextLabel")
        userLevel.Size = UDim2.new(1, 0, 0, 25)
        userLevel.Position = UDim2.new(0, 0, 0, 55)
        userLevel.BackgroundTransparency = 1
        userLevel.Text = "Level : " .. playerLevel
        userLevel.TextColor3 = CONFIG.NEON_COLORS.TEXT
        userLevel.TextFont = Enum.Font.RobotoMono
        userLevel.TextSize = 14
        userLevel.Parent = ContentPanel

        local userStatus = Instance.new("TextLabel")
        userStatus.Size = UDim2.new(1, 0, 0, 25)
        userStatus.Position = UDim2.new(0, 0, 0, 80)
        userStatus.BackgroundTransparency = 1
        userStatus.Text = "Status : " .. (appStatus.isLoggedIn and "Unlimited Access" or "Free")
        userStatus.TextColor3 = appStatus.isLoggedIn and CONFIG.NEON_COLORS.ON_BUTTON or CONFIG.NEON_COLORS.ACCENT
        userStatus.TextFont = Enum.Font.RobotoMono
        userStatus.TextSize = 14
        userStatus.Parent = ContentPanel

    elseif appStatus.activeMenu == "Teleport" then
        -- Konten Teleport
        local teleportTitle = Instance.new("TextLabel")
        teleportTitle.Size = UDim2.new(1, 0, 0, 30)
        teleportTitle.BackgroundTransparency = 1
        teleportTitle.Text = "[€] Teleport"
        teleportTitle.TextColor3 = CONFIG.NEON_COLORS.MAIN
        teleportTitle.TextFont = Enum.Font.RobotoMono
        teleportTitle.TextSize = 16
        teleportTitle.Parent = ContentPanel

        -- Submenu Teleport to People
        local peopleSubmenuBtn, appStatus.teleportPeopleSubmenuOpen = createSubmenuToggle("Teleport To People", appStatus.teleportPeopleSubmenuOpen, ContentPanel)
        peopleSubmenuBtn.Position = UDim2.new(0, 0, 0, 30)

        if appStatus.teleportPeopleSubmenuOpen then
            local chooseLabel = Instance.new("TextLabel")
            chooseLabel.Size = UDim2.new(1, 0, 0, 25)
            chooseLabel.Position = UDim2.new(0, 20, 0, 60)
            chooseLabel.BackgroundTransparency = 1
            chooseLabel.Text = "Choose Someone :"
            chooseLabel.TextColor3 = CONFIG.NEON_COLORS.TEXT
            chooseLabel.TextFont = Enum.Font.RobotoMono
            chooseLabel.TextSize = 12
            chooseLabel.Parent = ContentPanel

            -- Dropdown Pemain
            local playerDropdown = Instance.new("TextButton")
            playerDropdown.Size = UDim2.new(0.8, 0, 0, 25)
            playerDropdown.Position = UDim2.new(0, 20, 0, 85)
            playerDropdown.BackgroundColor3 = Color3.fromRGB(20, 20, 50)
            playerDropdown.Text = appStatus.selectedPlayer or "Pilih Pemain"
            playerDropdown.TextColor3 = CONFIG.NEON_COLORS.TEXT
            playerDropdown.TextFont = Enum.Font.RobotoMono
            playerDropdown.TextSize = 12
            playerDropdown.Parent = ContentPanel

            -- Tampilkan Daftar Pemain Saat Ditekan
            playerDropdown.MouseButton1Click:Connect(function()
                -- Hapus Daftar Lama (jika ada)
                for _, child in ipairs(ContentPanel:GetChildren()) do
                    if child.Name == "PlayerList" then child:Destroy() end
                end

                local playerList = Instance.new("ScrollingFrame")
                playerList.Name = "PlayerList"
                playerList.Size = UDim2.new(0.8, 0, 0, 100)
                playerList.Position = UDim2.new(0, 20, 0, 110)
                playerList.BackgroundColor3 = Color3.fromRGB(15, 15, 40)
                playerList.ScrollBarThickness = 5
                playerList.Parent = ContentPanel

                local UIListLayout = Instance.new("UIListLayout")
                UIListLayout.Parent = playerList

                -- Tambahkan Semua Pemain di Game
                for _, player in ipairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer then
                        local playerBtn = Instance.new("TextButton")
                        playerBtn.Size = UDim2.new(1, 0, 0, 20)
                        playerBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 50)
                        playerBtn.Text = player.Name
                        playerBtn.TextColor3 = CONFIG.NEON_COLORS.TEXT
                        playerBtn.TextFont = Enum.Font.RobotoMono
                        playerBtn.TextSize = 12
                        playerBtn.Parent = playerList

                        playerBtn.MouseButton1Click:Connect(function()
                            appStatus.selectedPlayer = player.Name
                            playerDropdown.Text = player.Name
                            playerList:Destroy()
                        end)
                    end
                end
            end)

            -- Tombol Teleport ke Pemain
            local teleportPlayerBtn = Instance.new("TextButton")
            teleportPlayerBtn.Size = UDim2.new(0.3, 0, 0, 25)
            teleportPlayerBtn.Position = UDim2.new(0, 20, 0, 110)
            teleportPlayerBtn.BackgroundColor3 = CONFIG.NEON_COLORS.MAIN
            teleportPlayerBtn.Text = "Teleport"
            teleportPlayerBtn.TextColor3 = Color3.fromRGB(0,0,0)
            teleportPlayerBtn.TextFont = Enum.Font.RobotoMono
            teleportPlayerBtn.TextSize = 12
            teleportPlayerBtn.Parent = ContentPanel

            teleportPlayerBtn.MouseButton1Click:Connect(function()
                if appStatus.selectedPlayer then
                    local targetPlayer = Players:FindFirstChild(appStatus.selectedPlayer)
                    if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
                        -- Teleport ke Pemain (sesuai hierarki Fish It)
                        LocalPlayer.Character.HumanoidRootPart.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,-5)
                    end
                end
            end)
        end

        -- Submenu Teleport to Region
        local regionSubmenuBtn, appStatus.teleportRegionSubmenuOpen = createSubmenuToggle("Teleport To The Region", appStatus.teleportRegionSubmenuOpen, ContentPanel)
        regionSubmenuBtn.Position = UDim2.new(0, 0, 0, appStatus.teleportPeopleSubmenuOpen and 140 or 60)

        if appStatus.teleportRegionSubmenuOpen then
            local chooseLabel = Instance.new("TextLabel")
            chooseLabel.Size = UDim2.new(1, 0, 0, 25)
            chooseLabel.Position = UDim2.new(0, 20, 0, (appStatus.teleportPeopleSubmenuOpen and 170 or 90))
            chooseLabel.BackgroundTransparency = 1
            chooseLabel.Text = "Choose Region :"
            chooseLabel.TextColor3 = CONFIG.NEON_COLORS.TEXT
            chooseLabel.TextFont = Enum.Font.RobotoMono
            chooseLabel.TextSize = 12
            chooseLabel.Parent = ContentPanel

            -- Dropdown Wilayah
            local regionDropdown = Instance.new("TextButton")
            regionDropdown.Size = UDim2.new(0.8, 0, 0, 25)
            regionDropdown.Position = UDim2.new(0, 20, 0, (appStatus.teleportPeopleSubmenuOpen and 195 or 115))
            regionDropdown.BackgroundColor3 = Color3.fromRGB(20, 20, 50)
            regionDropdown.Text = appStatus.selectedLocation or "Pilih Wilayah"
            regionDropdown.TextColor3 = CONFIG.NEON_COLORS.TEXT
            regionDropdown.TextFont = Enum.Font.RobotoMono
            regionDropdown.TextSize = 12
            regionDropdown.Parent = ContentPanel

            -- Tampilkan Daftar Wilayah Saat Ditekan
            regionDropdown.MouseButton1Click:Connect(function()
                -- Hapus Daftar Lama (jika ada)
                for _, child in ipairs(ContentPanel:GetChildren()) do
                    if child.Name == "RegionList" then child:Destroy() end
                end

                local regionList = Instance.new("ScrollingFrame")
                regionList.Name = "RegionList"
                regionList.Size = UDim2.new(0.8, 0, 0, 100)
                regionList.Position = UDim2.new(0, 20, 0, (appStatus.teleportPeopleSubmenuOpen and 220 or 140))
                regionList.BackgroundColor3 = Color3.fromRGB(15, 15, 40)
                regionList.ScrollBarThickness = 5
                regionList.Parent = ContentPanel

                local UIListLayout = Instance.new("UIListLayout")
                UIListLayout.Parent = regionList

                -- Tambahkan Semua Wilayah
                for _, location in ipairs(CONFIG.LOCATIONS) do
                    local locationBtn = Instance.new("TextButton")
                    locationBtn.Size = UDim2.new(1, 0, 0, 20)
                    locationBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 50)
                    locationBtn.Text = location
                    locationBtn.TextColor3 = CONFIG.NEON_COLORS.TEXT
                    locationBtn.TextFont = Enum.Font.RobotoMono
                    locationBtn.TextSize = 12
                    locationBtn.Parent = regionList

                    locationBtn.MouseButton1Click:Connect(function()
                        appStatus.selectedLocation = location
                        regionDropdown.Text = location
                        regionList:Destroy()
                    end)
                end
            end)

            -- Tombol Teleport ke Wilayah
            local teleportRegionBtn = Instance.new("TextButton")
            teleportRegionBtn.Size = UDim2.new(0.3, 0, 0, 25)
            teleportRegionBtn.Position = UDim2.new(0, 20, 0, (appStatus.teleportPeopleSubmenuOpen and 220 or 140))
            teleportRegionBtn.BackgroundColor3 = CONFIG.NEON_COLORS.MAIN
            teleportRegionBtn.Text = "Teleport"
            teleportRegionBtn.TextColor3 = Color3.fromRGB(0,0,0)
            teleportRegionBtn.TextFont = Enum.Font.RobotoMono
            teleportRegionBtn.TextSize = 12
            teleportRegionBtn.Parent = ContentPanel

            teleportRegionBtn.MouseButton1Click:Connect(function()
                if appStatus.selectedLocation then
                    -- Cari Lokasi di Workspace (sesuai hierarki Fish It)
                    local targetLocation = workspace:FindFirstChild(appStatus.selectedLocation) or workspace:FindFirstChild("Locations"):FindFirstChild(appStatus.selectedLocation)
                    if targetLocation and targetLocation:FindFirstChild("SpawnPoint") then
                        LocalPlayer.Character.HumanoidRootPart.CFrame = targetLocation.SpawnPoint.CFrame
                    end
                end
            end)
        end

        -- Tombol Refresh
        local refreshBtn = Instance.new("TextButton")
        refreshBtn.Size = UDim2.new(0.3, 0, 0, 25)
        refreshBtn.Position = UDim2.new(0, 20, 0, (appStatus.teleportPeopleSubmenuOpen or appStatus.teleportRegionSubmenuOpen) and 250 or 90)
        refreshBtn.BackgroundColor3 = CONFIG.NEON_COLORS.ACCENT
        refreshBtn.Text = "Refresh"
        refreshBtn.TextColor3 = Color3.fromRGB(0,0,0)
        refreshBtn.TextFont = Enum.Font.RobotoMono
        refreshBtn.TextSize = 12
        refreshBtn.Parent = ContentPanel

        refreshBtn.MouseButton1Click:Connect(function()
            appStatus.selectedPlayer = nil
            appStatus.selectedLocation = nil
            updateContentPanel()
        end)

    elseif appStatus.activeMenu == "Informasi" then
        -- Konten Informasi
        local infoTitle = Instance.new("TextLabel")
        infoTitle.Size = UDim2.new(1, 0, 0, 30)
        infoTitle.BackgroundTransparency = 1
        infoTitle.Text = "[π] Informasi"
        infoTitle.TextColor3 = CONFIG.NEON_COLORS.MAIN
        infoTitle.TextFont = Enum.Font.RobotoMono
        infoTitle.TextSize = 16
        infoTitle.Parent = ContentPanel

        local infoHeader = Instance.new("TextLabel")
        infoHeader.Size = UDim2.new(1, 0, 0, 25)
        infoHeader.Position = UDim2.new(0, 0, 0, 30)
        infoHeader.BackgroundTransparency = 1
        infoHeader.Text = "INFORMASI"
        infoHeader.TextColor3 = CONFIG.NEON_COLORS.ACCENT
        infoHeader.TextFont = Enum.Font.RobotoMono
        infoHeader.TextSize = 14
        infoHeader.Parent = ContentPanel

        local telegram = Instance.new("TextLabel")
        telegram.Size = UDim2.new(1, 0, 0, 25)
        telegram.Position = UDim2.new(0, 0, 0, 55)
        telegram.BackgroundTransparency = 1
        telegram.Text = "Telegram: @tarzbot"
        telegram.TextColor3 = CONFIG.NEON_COLORS.TEXT
        telegram.TextFont = Enum.Font.RobotoMono
        telegram.TextSize = 12
        telegram.Parent = ContentPanel

        local whatsapp = Instance.new("TextLabel")
        whatsapp.Size = UDim2.new(1, 0, 0, 25)
        whatsapp.Position = UDim2.new(0, 0, 0, 80)
        whatsapp.BackgroundTransparency = 1
        whatsapp.Text = "WhatsApp: 0812345678"
        whatsapp.TextColor3 = CONFIG.NEON_COLORS.TEXT
        whatsapp.TextFont = Enum.Font.RobotoMono
        whatsapp.TextSize = 12
        whatsapp.Parent = ContentPanel

        local tiktok = Instance.new("TextLabel")
        tiktok.Size = UDim2.new(1, 0, 0, 25)
        tiktok.Position = UDim2.new(0, 0, 0, 105)
        tiktok.BackgroundTransparency = 1
        tiktok.Text = "Tiktok: @_tarzbot"
        tiktok.TextColor3 = CONFIG.NEON_COLORS.TEXT
        tiktok.TextFont = Enum.Font.RobotoMono
        tiktok.TextSize = 12
        tiktok.Parent = ContentPanel

    elseif appStatus.activeMenu == "Lain" then
        -- Konten Lain
        local otherTitle = Instance.new("TextLabel")
        otherTitle.Size = UDim2.new(1, 0, 0, 30)
        otherTitle.BackgroundTransparency = 1
        otherTitle.Text = "[¢] Lain"
        otherTitle.TextColor3 = CONFIG.NEON_COLORS.MAIN
        otherTitle.TextFont = Enum.Font.RobotoMono
        otherTitle.TextSize = 16
        otherTitle.Parent = ContentPanel

        -- Submenu Delete Animation
        local otherSubmenuBtn, appStatus.otherSubmenuOpen = createSubmenuToggle("Delete Animation", appStatus.otherSubmenuOpen, ContentPanel)
        otherSubmenuBtn.Position = UDim2.new(0, 0, 0, 30)

        if appStatus.otherSubmenuOpen then
            -- Toggle Animasi Rod
            local animRodContainer, animRodToggle, appStatus.animRodDisabled = createToggleButton("Animasi Rod", appStatus.animRodDisabled, ContentPanel)
            animRodContainer.Position = UDim2.new(0, 20, 0, 60)
            animRodToggle.MouseButton1Click:Connect(function()
                appStatus.animRodDisabled = not appStatus.animRodDisabled
                -- Nonaktifkan Animasi Melempar Rod (sesuai hierarki Fish It)
                local rodAnim = LocalPlayer.Character:FindFirstChild("RodThrowAnim")
                if rodAnim then rodAnim.Enabled = not appStatus.animRodDisabled end
            end)

            -- Toggle Notifikasi Fish
            local notifFishContainer, notifFishToggle, appStatus.notifFishDisabled = createToggleButton("Notifikasi Fish", appStatus.notifFishDisabled, ContentPanel)
            notifFishContainer.Position =
            notifFishContainer.Position = UDim2.new(0, 20, 0, 90)
            notifFishToggle.MouseButton1Click:Connect(function()
                appStatus.notifFishDisabled = not appStatus.notifFishDisabled
                -- Nonaktifkan Notifikasi Ikan (sesuai hierarki Fish It)
                local fishNotif = PlayerGui:FindFirstChild("FishNotification")
                if fishNotif then fishNotif.Visible = not appStatus.notifFishDisabled end
            end)

            -- Toggle Animasi Efek Rod
            local animEffectContainer, animEffectToggle, appStatus.animEffectRodDisabled = createToggleButton("Animasi Efek Rod", appStatus.animEffectRodDisabled, ContentPanel)
            animEffectContainer.Position = UDim2.new(0, 20, 0, 120)
            animEffectToggle.MouseButton1Click:Connect(function()
                appStatus.animEffectRodDisabled = not appStatus.animEffectRodDisabled
                -- Nonaktifkan Efek Pancingan (sesuai hierarki Fish It)
                local rodEffect = LocalPlayer.Character:FindFirstChild("RodEffect")
                if rodEffect then rodEffect.Enabled = not appStatus.animEffectRodDisabled end
            end)
        end

    elseif appStatus.activeMenu == "Login" then
        -- Konten Login
        local loginTitle = Instance.new("TextLabel")
        loginTitle.Size = UDim2.new(1, 0, 0, 30)
        loginTitle.BackgroundTransparency = 1
        loginTitle.Text = "[£] Login"
        loginTitle.TextColor3 = CONFIG.NEON_COLORS.MAIN
        loginTitle.TextFont = Enum.Font.RobotoMono
        loginTitle.TextSize = 16
        loginTitle.Parent = ContentPanel

        -- Input Username
        local userLabel = Instance.new("TextLabel")
        userLabel.Size = UDim2.new(0.3, 0, 0, 25)
        userLabel.Position = UDim2.new(0, 20, 0, 60)
        userLabel.BackgroundTransparency = 1
        userLabel.Text = "Username:"
        userLabel.TextColor3 = CONFIG.NEON_COLORS.TEXT
        userLabel.TextFont = Enum.Font.RobotoMono
        userLabel.TextSize = 12
        userLabel.Parent = ContentPanel

        local userInput = Instance.new("TextBox")
        userInput.Size = UDim2.new(0.6, 0, 0, 25)
        userInput.Position = UDim2.new(0.35, 20, 0, 60)
        userInput.BackgroundColor3 = Color3.fromRGB(20, 20, 50)
        userInput.Text = ""
        userInput.PlaceholderText = "Masukkan Username"
        userInput.TextColor3 = CONFIG.NEON_COLORS.TEXT
        userInput.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
        userInput.TextFont = Enum.Font.RobotoMono
        userInput.TextSize = 12
        userInput.ClearTextOnFocus = true
        userInput.Parent = ContentPanel

        -- Input Password
        local passLabel = Instance.new("TextLabel")
        passLabel.Size = UDim2.new(0.3, 0, 0, 25)
        passLabel.Position = UDim2.new(0, 20, 0, 95)
        passLabel.BackgroundTransparency = 1
        passLabel.Text = "Password:"
        passLabel.TextColor3 = CONFIG.NEON_COLORS.TEXT
        passLabel.TextFont = Enum.Font.RobotoMono
        passLabel.TextSize = 12
        passLabel.Parent = ContentPanel

        local passInput = Instance.new("TextBox")
        passInput.Size = UDim2.new(0.6, 0, 0, 25)
        passInput.Position = UDim2.new(0.35, 20, 0, 95)
        passInput.BackgroundColor3 = Color3.fromRGB(20, 20, 50)
        passInput.Text = ""
        passInput.PlaceholderText = "Masukkan Password"
        passInput.TextColor3 = CONFIG.NEON_COLORS.TEXT
        passInput.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
        passInput.TextFont = Enum.Font.RobotoMono
        passInput.TextSize = 12
        passInput.ClearTextOnFocus = true
        passInput.TextEditable = true
        passInput:GetPropertyChangedSignal("Text"):Connect(function()
            -- Sembunyikan Teks Password dengan *
            local hiddenText = string.rep("*", #passInput.Text)
            passInput.TextTransparency = 1
            local displayText = Instance.new("TextLabel")
            displayText.Name = "DisplayText"
            displayText.Size = UDim2.new(1, 0, 1, 0)
            displayText.BackgroundTransparency = 1
            displayText.Text = hiddenText
            displayText.TextColor3 = CONFIG.NEON_COLORS.TEXT
            displayText.TextFont = Enum.Font.RobotoMono
            displayText.TextSize = 12
            displayText.Parent = passInput
            -- Hapus Teks Lama Saat Mengedit
            passInput.Focused:Connect(function()
                if displayText then displayText:Destroy() end
                passInput.TextTransparency = 0
            end)
        end)
        passInput.Parent = ContentPanel

        -- Pesan Status Login
        local statusMsg = Instance.new("TextLabel")
        statusMsg.Name = "StatusMsg"
        statusMsg.Size = UDim2.new(1, 0, 0, 25)
        statusMsg.Position = UDim2.new(0, 0, 0, 130)
        statusMsg.BackgroundTransparency = 1
        statusMsg.Text = ""
        statusMsg.TextColor3 = Color3.fromRGB(255, 100, 100)
        statusMsg.TextFont = Enum.Font.RobotoMono
        statusMsg.TextSize = 12
        statusMsg.Parent = ContentPanel

        -- Tombol Login
        local loginBtn = Instance.new("TextButton")
        loginBtn.Size = UDim2.new(0.4, 0, 0, 30)
        loginBtn.Position = UDim2.new(0.3, 0, 0, 160)
        loginBtn.BackgroundColor3 = CONFIG.NEON_COLORS.MAIN
        loginBtn.Text = "Login"
        loginBtn.TextColor3 = Color3.fromRGB(0,0,0)
        loginBtn.TextFont = Enum.Font.RobotoMono
        loginBtn.TextSize = 14
        loginBtn.Parent = ContentPanel

        loginBtn.MouseButton1Click:Connect(function()
            local inputUser = userInput.Text
            local inputPass = passInput.Text

            if inputUser == CONFIG.LOGIN_CRED.USERNAME and inputPass == CONFIG.LOGIN_CRED.PASSWORD then
                appStatus.isLoggedIn = true
                statusMsg.Text = "Login Berhasil! Akses Unlimited Aktif"
                statusMsg.TextColor3 = CONFIG.NEON_COLORS.ON_BUTTON
                -- Reset Waktu Akses
                appStatus.freeAccessStartTime = os.time()
                -- Kembali ke Menu Profile
                appStatus.activeMenu = "Profile"
                updateContentPanel()
            else
                statusMsg.Text = "Username/Password Salah! Coba Lagi"
                statusMsg.TextColor3 = Color3.fromRGB(255, 100, 100)
                userInput.Text = ""
                passInput.Text = ""
            end
        end)
    end
end

-- Fungsi Tombol Minimize (-)
local MinimizeLogo = Instance.new("ImageButton")
MinimizeLogo.Name = "MinimizeLogo"
MinimizeLogo.Size = UDim2.new(0, 50, 0, 30)
MinimizeLogo.Position = UDim2.new(0.5, -25, 0.1, 0)
MinimizeLogo.BackgroundColor3 = Color3.fromRGB(15, 15, 40)
MinimizeLogo.ImageTransparency = 1
MinimizeLogo.Text = CONFIG.APP_NAME
MinimizeLogo.TextColor3 = CONFIG.NEON_COLORS.MAIN
MinimizeLogo.TextFont = Enum.Font.RobotoMono
MinimizeLogo.TextSize = 14
MinimizeLogo.BorderSizePixel = 1
MinimizeLogo.BorderColor3 = CONFIG.NEON_COLORS.MAIN
MinimizeLogo.Parent = TarzBotGui
MinimizeLogo.Visible = false

-- Fungsionalitas Minimize
MinimizeBtn.MouseButton1Click:Connect(function()
    appStatus.isMinimized = not appStatus.isMinimized
    MainWindow.Visible = not appStatus.isMinimized
    MinimizeLogo.Visible = appStatus.isMinimized

    -- Bisa Digeser
    local isDragging = false
    local startPos = Vector2.new()
    local startGuiPos = UDim2.new()

    MinimizeLogo.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            isDragging = true
            startPos = input.Position
            startGuiPos = MinimizeLogo.Position
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if isDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - startPos
            MinimizeLogo.Position = UDim2.new(
                startGuiPos.X.Scale, startGuiPos.X.Offset + delta.X,
                startGuiPos.Y.Scale, startGuiPos.Y.Offset + delta.Y
            )
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            isDragging = false
        end
    end)

    -- Klik Logo untuk Buka Kembali
    MinimizeLogo.MouseButton1Click:Connect(function()
        appStatus.isMinimized = false
        MainWindow.Visible = true
        MinimizeLogo.Visible = false
    end)
end)

-- Fungsi Tombol Close (X)
CloseBtn.MouseButton1Click:Connect(function()
    MainWindow.Visible = false
    MinimizeLogo.Visible = false
    appStatus.isOpen = false
    -- Waktu Expired Tetap Berjalan
end)

-- Periksa Waktu Akses Secara Berkelanjutan
RunService.Heartbeat:Connect(function()
    if not appStatus.isLoggedIn then
        local timeLeft = CONFIG.FREE_ACCESS_DURATION - (os.time() - appStatus.freeAccessStartTime)
        if timeLeft <= 0 and appStatus.activeMenu ~= "Login" then
            updateContentPanel()
        end
    end
end)

-- Inisialisasi Tampilan Awal
updateContentPanel()
