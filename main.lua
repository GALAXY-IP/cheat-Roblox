-- LOCALSCRIPT: TarzBot Fish It UI
-- Letakkan di: StarterGui > ScreenGui > LocalScript

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer

-- CONFIGURASI
local CONFIG = {
    Colors = {
        Background = Color3.fromRGB(15, 15, 25),
        Accent = Color3.fromRGB(0, 255, 255),
        Accent2 = Color3.fromRGB(255, 0, 255),
        Text = Color3.fromRGB(255, 255, 255),
        Disabled = Color3.fromRGB(80, 80, 100),
        Success = Color3.fromRGB(0, 255, 100),
        Danger = Color3.fromRGB(255, 50, 50)
    },
    IsLoggedIn = false,
    TimeRemaining = 3600, -- 1 jam dalam detik
    StartTime = tick(),
    Animations = {
        Rod = false,
        Notification = false,
        Effect = false
    },
    SelectedPlayer = nil,
    SelectedLocation = nil
}

-- LOKASI FISH IT (UPDATE SESUAI GAME)
local FISH_IT_LOCATIONS = {
    "Classic Island Spawn",
    "Kohana Island",
    "Misty Bay",
    "Coral Reef",
    "Deep Sea Trench",
    "Arctic Waters",
    "Jungle River",
    "Volcano Lake",
    "Sunset Beach",
    "Moonlight Pier"
}

-- FUNGSI UTAMA
local function createUI()
    -- ScreenGui
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "TarzBotUI"
    screenGui.ResetOnSpawn = false
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    -- Main Frame
    local mainFrame = Instance.new("Frame")
    mainFrame.Name = "MainFrame"
    mainFrame.Size = UDim2.new(0, 420, 0, 520)
    mainFrame.Position = UDim2.new(0.5, -210, 0.5, -260)
    mainFrame.BackgroundColor3 = CONFIG.Colors.Background
    mainFrame.BorderSizePixel = 0
    mainFrame.BackgroundTransparency = 0.05
    mainFrame.Parent = screenGui
    
    -- UIStroke dengan gradient effect
    local stroke = Instance.new("UIStroke")
    stroke.Color = CONFIG.Colors.Accent
    stroke.Thickness = 2
    stroke.Parent = mainFrame
    
    -- UICorner
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 8)
    corner.Parent = mainFrame
    
    -- Title Bar
    local titleBar = Instance.new("Frame")
    titleBar.Name = "TitleBar"
    titleBar.Size = UDim2.new(1, 0, 0, 45)
    titleBar.BackgroundColor3 = CONFIG.Colors.Background
    titleBar.BorderSizePixel = 0
    titleBar.Parent = mainFrame
    
    local titleBarStroke = stroke:Clone()
    titleBarStroke.Parent = titleBar
    
    -- Title Text dengan gradient
    local titleText = Instance.new("TextLabel")
    titleText.Name = "TitleText"
    titleText.Size = UDim2.new(1, -80, 0, 30)
    titleText.Position = UDim2.new(0, 15, 0, 5)
    titleText.BackgroundTransparency = 1
    titleText.Text = "TarzBot."
    titleText.Font = Enum.Font.GothamBold
    titleText.TextSize = 22
    titleText.TextColor3 = CONFIG.Colors.Accent
    titleText.TextXAlignment = Enum.TextXAlignment.Left
    titleText.Parent = titleBar
    
    -- Version
    local versionText = Instance.new("TextLabel")
    versionText.Name = "VersionText"
    versionText.Size = UDim2.new(0, 200, 0, 15)
    versionText.Position = UDim2.new(0, 15, 0, 28)
    versionText.BackgroundTransparency = 1
    versionText.Text = "V1.0.1"
    versionText.Font = Enum.Font.Gotham
    versionText.TextSize = 12
    versionText.TextColor3 = CONFIG.Colors.Disabled
    versionText.TextXAlignment = Enum.TextXAlignment.Left
    versionText.Parent = titleBar
    
    -- Minimize Button [-]
    local minBtn = Instance.new("TextButton")
    minBtn.Name = "MinimizeBtn"
    minBtn.Size = UDim2.new(0, 32, 0, 32)
    minBtn.Position = UDim2.new(1, -74, 0, 6)
    minBtn.BackgroundColor3 = CONFIG.Colors.Background
    minBtn.Text = "-"
    minBtn.Font = Enum.Font.GothamBold
    minBtn.TextSize = 20
    minBtn.TextColor3 = CONFIG.Colors.Text
    minBtn.Parent = titleBar
    
    local minCorner = corner:Clone()
    minCorner.Parent = minBtn
    
local minStroke = stroke:Clone()
    minStroke.Color = CONFIG.Colors.Accent2
    minStroke.Parent = minBtn
    
    -- Close Button [x]
    local closeBtn = minBtn:Clone()
    closeBtn.Name = "CloseBtn"
    closeBtn.Position = UDim2.new(1, -37, 0, 6)
    closeBtn.Text = "x"
    closeBtn.Parent = titleBar
    
    -- Separator Line
    local separator = Instance.new("Frame")
    separator.Name = "Separator"
    separator.Size = UDim2.new(1, 0, 0, 2)
    separator.Position = UDim2.new(0, 0, 0, 45)
    separator.BackgroundColor3 = CONFIG.Colors.Accent
    separator.BorderSizePixel = 0
    separator.Parent = mainFrame
    
    -- Menu Container
    local menuContainer = Instance.new("Frame")
    menuContainer.Name = "MenuContainer"
    menuContainer.Size = UDim2.new(1, 0, 0, 275)
    menuContainer.Position = UDim2.new(0, 0, 0, 47)
    menuContainer.BackgroundTransparency = 1
    menuContainer.Parent = mainFrame
    
    local menuLayout = Instance.new("UIListLayout")
    menuLayout.Padding = UDim.new(0, 8)
    menuLayout.Parent = menuContainer
    
    -- Content Display
    local contentFrame = Instance.new("Frame")
    contentFrame.Name = "ContentFrame"
    contentFrame.Size = UDim2.new(1, 0, 0, 198)
    contentFrame.Position = UDim2.new(0, 0, 0, 322)
    contentFrame.BackgroundTransparency = 1
    contentFrame.Parent = mainFrame
    
    -- Current Menu Tracker
    local currentMenu = nil
    
    -- FUNGSI BUAT MENU BUTTON
    local function createMenuButton(icon, name, color, order)
        local btn = Instance.new("TextButton")
        btn.Name = name .. "MenuBtn"
        btn.Size = UDim2.new(1, -20, 0, 45)
        btn.BackgroundColor3 = color
        btn.BackgroundTransparency = 0.8
        btn.Text = icon .. " " .. name
        btn.Font = Enum.Font.GothamBold
        btn.TextSize = 16
        btn.TextColor3 = CONFIG.Colors.Text
        btn.Parent = menuContainer
        
        local btnCorner = corner:Clone()
        btnCorner.Parent = btn
        
        local btnStroke = stroke:Clone()
        btnStroke.Color = color
        btnStroke.Parent = btn
        
        -- Hover Effect
        btn.MouseEnter:Connect(function()
            TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundTransparency = 0.6}):Play()
        end)
        
        btn.MouseLeave:Connect(function()
            TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundTransparency = 0.8}):Play()
        end)
        
        btn.MouseButton1Click:Connect(function()
            -- Hapus menu lama
            if currentMenu then
                currentMenu:Destroy()
            end
            
            -- Bersihkan content
            for _, child in ipairs(contentFrame:GetChildren()) do
                child:Destroy()
            end
            
            -- Buat menu baru
            currentMenu = createContent(name, contentFrame)
            
            -- Animasi klik
            TweenService:Create(btn, TweenInfo.new(0.1), {Size = UDim2.new(1, -20, 0, 42)}):Play()
            wait(0.1)
            TweenService:Create(btn, TweenInfo.new(0.1), {Size = UDim2.new(1, -20, 0, 45)}):Play()
        end)
        
        return btn
    end
    
    -- BUAT 5 MENU UTAMA
    createMenuButton("[¥]", "Profile", CONFIG.Colors.Accent, 1)
    createMenuButton("[€]", "Teleport", CONFIG.Colors.Accent2, 2)
    createMenuButton("[π]", "Informasi", CONFIG.Colors.Accent, 3)
    createMenuButton("[¢]", "Lain", CONFIG.Colors.Accent2, 4)
    createMenuButton("[£]", "Login", CONFIG.Colors.Accent, 5)
    
    -- FUNGSI KONTEN MENU
    local function createContent(menuName, parent)
        local container = Instance.new("ScrollingFrame")
        container.Size = UDim2.new(1, 0, 1, 0)
        container.BackgroundTransparency = 1
        container.BorderSizePixel = 0
        container.ScrollBarThickness = 3
        container.ScrollBarImageColor3 = CONFIG.Colors.Accent
        container.Parent = parent
        
        local contentLayout = Instance.new("UIListLayout")
        contentLayout.Padding = UDim.new(0, 10)
        contentLayout.Parent = container
        
        if menuName == "Profile" then
            -- [¥] PROFILE
            local profileTitle = Instance.new("TextLabel")
            profileTitle.Size = UDim2.new(1, 0, 0, 30)
            profileTitle.BackgroundTransparency = 1
            profileTitle.Text = "[¥] Profile"
            profileTitle.Font = Enum.Font.GothamBold
            profileTitle.TextSize = 18
            profileTitle.TextColor3 = CONFIG.Colors.Accent
            profileTitle.TextXAlignment = Enum.TextXAlignment.Left
            profileTitle.Parent = container
            
            -- Nama
            local nameLabel = Instance.new("TextLabel")
            nameLabel.Size = UDim2.new(1, 0, 0, 25)
            nameLabel.Position = UDim2.new(0, 0, 0, 35)
            nameLabel.BackgroundTransparency = 1
            nameLabel.Text = "Nama: " .. player.Name
            nameLabel.Font = Enum.Font.Gotham
            nameLabel.TextSize = 14
            nameLabel.TextColor3 = CONFIG.Colors.Text
            nameLabel.TextXAlignment = Enum.TextXAlignment.Left
            nameLabel.Parent = container
            
            -- Level (AMBIL DARI LEADERSTATS)
            local levelLabel = Instance.new("TextLabel")
            levelLabel.Size = UDim2.new(1, 0, 0, 25)
            levelLabel.BackgroundTransparency = 1
            levelLabel.Text = "Level: Loading..."
            levelLabel.Font = Enum.Font.Gotham
            levelLabel.TextSize = 14
            levelLabel.TextColor3 = CONFIG.Colors.Text
            levelLabel.TextXAlignment = Enum.TextXAlignment.Left
            levelLabel.Parent = container
            
            -- Ambil level dari leaderstats
            coroutine.wrap(function()
                wait(2)
                local leaderstats = player:FindFirstChild("leaderstats")
                if leaderstats then
                    local level = leaderstats:FindFirstChild("Level") or leaderstats:FindFirstChild("level")
                    if level then
                        levelLabel.Text = "Level: " .. tostring(level.Value)
                    else
                        levelLabel.Text = "Level: Tidak ditemukan"
                    end
                else
                    levelLabel.Text = "Level: Data tidak tersedia"
                end
            end)()
            
            -- Status
            local statusLabel = Instance.new("TextLabel")
            statusLabel.Size = UDim2.new(1, 0, 0, 25)
            statusLabel.BackgroundTransparency = 1
            statusLabel.Text = "Status: " .. (CONFIG.IsLoggedIn and "Premium" or "Free")
            statusLabel.Font = Enum.Font.Gotham
            statusLabel.TextSize = 14
            statusLabel.TextColor3 = CONFIG.Colors.Text
            statusLabel.TextXAlignment = Enum.TextXAlignment.Left
            statusLabel.Parent = container
            
        elseif menuName == "Teleport" then
            -- [€] TELEPORT
            local teleportTitle = Instance.new("TextLabel")
            teleportTitle.Size = UDim2.new(1, 0, 0, 30)
            teleportTitle.BackgroundTransparency = 1
            teleportTitle.Text = "[€] Teleport"
            teleportTitle.Font = Enum.Font.GothamBold
            teleportTitle.TextSize = 18
            teleportTitle.TextColor3 = CONFIG.Colors.Accent2
            teleportTitle.TextXAlignment = Enum.TextXAlignment.Left
            teleportTitle.Parent = container
            
            -- Dropdown Teleport To People
            local peopleDropdown = Instance.new("TextButton")
            peopleDropdown.Name = "PeopleDropdown"
            peopleDropdown.Size = UDim2.new(1, 0, 0, 40)
            peopleDropdown.BackgroundColor3 = CONFIG.Colors.Background
            peopleDropdown.BackgroundTransparency = 0.5
            peopleDropdown.Text = "Teleport To People →"
            peopleDropdown.Font = Enum.Font.GothamBold
            peopleDropdown.TextSize = 14
            peopleDropdown.TextColor3 = CONFIG.Colors.Text
            peopleDropdown.Parent = container
            
            local peopleCorner = corner:Clone()
            peopleCorner.Parent = peopleDropdown
            
            local peopleStroke = stroke:Clone()
            peopleStroke.Color = CONFIG.Colors.Accent2
            peopleStroke.Parent = peopleDropdown
            
            -- Frame untuk daftar pemain
            local playerListFrame = nil
            
            peopleDropdown.MouseButton1Click:Connect(function()
                if playerListFrame then
                    playerListFrame:Destroy()
                    playerListFrame = nil
                    peopleDropdown.Text = "Teleport To People →"
                    return
                end
                
                peopleDropdown.Text = "Teleport To People ↓"
                
                playerListFrame = Instance.new("Frame")
                playerListFrame.Size = UDim2.new(1, 0, 0, 200)
                playerListFrame.BackgroundColor3 = CONFIG.Colors.Background
                playerListFrame.BackgroundTransparency = 0.1
                playerListFrame.BorderSizePixel = 0
                playerListFrame.Parent = container
                
                local listLayout = Instance.new("UIListLayout")
                listLayout.Parent = playerListFrame
                
                local title = Instance.new("TextLabel")
                title.Size = UDim2.new(1, 0, 0, 30)
                title.BackgroundColor3 = CONFIG.Colors.Accent2
                title.BackgroundTransparency = 0.7
                title.Text = "Choose Someone:"
                title.Font = Enum.Font.GothamBold
                title.TextSize = 14
                title.TextColor3 = CONFIG.Colors.Text
                title.Parent = playerListFrame
                
                for _, plr in ipairs(Players:GetPlayers()) do
                    if plr ~= player then
                        local plrBtn = Instance.new("TextButton")
                        plrBtn.Size = UDim2.new(1, 0, 0, 35)
                        plrBtn.BackgroundTransparency = 0.6
                        plrBtn.Text = "  " .. plr.Name
                        plrBtn.Font = Enum.Font.Gotham
                        plrBtn.TextSize = 13
                        plrBtn.TextColor3 = CONFIG.Colors.Text
                        plrBtn.TextXAlignment = Enum.TextXAlignment.Left
                        plrBtn.Parent = playerListFrame
                        
                        plrBtn.MouseButton1Click:Connect(function()
                            CONFIG.SelectedPlayer = plr
                            title.Text = "Selected: " .. plr.Name
                        end)
                    end
                end
            end)
            
            -- Teleport To Region
            local regionDropdown = Instance.new("TextButton")
            regionDropdown.Name = "RegionDropdown"
            regionDropdown.Size = UDim2.new(1, 0, 0, 40)
            regionDropdown.BackgroundColor3 = CONFIG.Colors.Background
            regionDropdown.BackgroundTransparency = 0.5
            regionDropdown.Text = "Teleport To The Region"
            regionDropdown.Font = Enum.Font.GothamBold
            regionDropdown.TextSize = 14
            regionDropdown.TextColor3 = CONFIG.Colors.Text
            regionDropdown.Parent = container
            
            local regionCorner = corner:Clone()
            regionCorner.Parent = regionDropdown
            
            local regionStroke = stroke:Clone()
            regionStroke.Color = CONFIG.Colors.Accent
            regionStroke.Parent = regionDropdown
            
            local regionListFrame = nil
            
            regionDropdown.MouseButton1Click:Connect(function()
                if regionListFrame then
                    regionListFrame:Destroy()
                    regionListFrame = nil
                    return
                end
                
                regionListFrame = Instance.new("Frame")
                regionListFrame.Size = UDim2.new(1, 0, 0, 320)
                regionListFrame.BackgroundColor3 = CONFIG.Colors.Background
                regionListFrame.BackgroundTransparency = 0.1
                regionListFrame.BorderSizePixel = 0
                regionListFrame.Parent = container
                
                local listLayout = Instance.new("UIListLayout")
                listLayout.Parent = regionListFrame
                
                for _, location in ipairs(FISH_IT_LOCATIONS) do
                    local locBtn = Instance.new("TextButton")
                    locBtn.Size = UDim2.new(1, 0, 0, 35)
                    locBtn.BackgroundTransparency = 0.6
                    locBtn.Text = "  " .. location
                    locBtn.Font = Enum.Font.Gotham
                    locBtn.TextSize = 13
                    locBtn.TextColor3 = CONFIG.Colors.Text
                    locBtn.TextXAlignment = Enum.TextXAlignment.Left
                    locBtn.Parent = regionListFrame
                    
                    locBtn.MouseButton1Click:Connect(function()
                        CONFIG.SelectedLocation = location
                        regionDropdown.Text = "Selected: " .. location
                    end)
                end
            end)
            
            -- Tombol Teleport
            local teleportBtn = Instance.new("TextButton")
            teleportBtn.Size = UDim2.new(1, 0, 0, 45)
            teleportBtn.BackgroundColor3 = CONFIG.Colors.Success
            teleportBtn.Text = "Teleport"
            teleportBtn.Font = Enum.Font.GothamBold
            teleportBtn.TextSize = 16
            teleportBtn.TextColor3 = CONFIG.Colors.Background
            teleportBtn.Parent = container
            
            teleportBtn.MouseButton1Click:Connect(function()
                if not CONFIG.IsLoggedIn then
                    createNotification("Login diperlukan!", CONFIG)
                    return
                end
                
                if CONFIG.SelectedPlayer then
                    -- TELEPORT KE PLAYER
                    local targetChar = CONFIG.SelectedPlayer.Character
                    if targetChar and targetChar:FindFirstChild("HumanoidRootPart") then
                        local playerChar = player.Character
                        if playerChar and playerChar:FindFirstChild("HumanoidRootPart") then
                            playerChar.HumanoidRootPart.CFrame = targetChar.HumanoidRootPart.CFrame * CFrame.new(0, 0, -5)
                            createNotification("Teleported to " .. CONFIG.SelectedPlayer.Name, CONFIG)
                        end
                    end
                elseif CONFIG.SelectedLocation then
                    -- TELEPORT KE LOKASI (sesuaikan dengan game)
                    local playerChar = player.Character
                    if playerChar and playerChar:FindFirstChild("HumanoidRootPart") then
                        -- CONTOH: Cari lokasi di workspace
                        local locationPart = workspace:FindFirstChild(CONFIG.SelectedLocation)
                        if locationPart then
                            playerChar.HumanoidRootPart.CFrame = locationPart.CFrame * CFrame.new(0, 5, 0)
                            createNotification("Teleported to " .. CONFIG.SelectedLocation, CONFIG)
                        else
                            createNotification("Lokasi tidak ditemukan!", CONFIG)
                        end
                    end
                else
                    createNotification("Pilih target dulu!", CONFIG)
                end
            end)
            
            -- Tombol Refresh
            local refreshBtn = Instance.new("TextButton")
            refreshBtn.Size = UDim2.new(1, 0, 0, 40)
            refreshBtn.BackgroundColor3 = CONFIG.Colors.Accent
            refreshBtn.Text = "Refresh"
            refreshBtn.Font = Enum.Font.GothamBold
            refreshBtn.TextSize = 1
