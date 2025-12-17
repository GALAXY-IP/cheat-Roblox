-- Fish It GUI - 100% WindUI Original Framework
-- Version: 1.0.1 | Features: Auto Perfect, Teleport, Animation Toggles

local WindUI
do
    local ok, result = pcall(function()
        return require("./src/Init")
    end)

    if ok then
        WindUI = result
    else
        WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()
    end
end

-- Window Creation (100% Original WindUI Style)
local Window = WindUI:CreateWindow({
    Title = "TarzBot",
    Author = "by TarzBot",
    Folder = "FishItGUI",
    NewElements = true,
    HideSearchBar = false, -- Biarkan false agar sesuai original

    OpenButton = {
        Title = "Open TarzBot UI",
        CornerRadius = UDim.new(1,0), -- Tombol bulat saat minimize
        StrokeThickness = 3,
        Enabled = true, -- Aktifkan agar ada tombol kecil saat minimize
        Draggable = true, -- Bisa drag tombol minimize
        OnlyMobile = false,
        Color = ColorSequence.new(
            Color3.fromHex("#30FF6A"),
            Color3.fromHex("#e7ff2f")
        )
    }
})

-- Version Tag (Sama seperti example)
Window:Tag({
    Title = "V1.0.1",
    Icon = "github",
    Color = Color3.fromHex("#6b31ff")
})

-- State Management
local States = {
    autoPerfect = false,
    removeRodAnim = false,
    removeFishNotif = false,
    removeRodEffect = false,
    selectedPlayer = nil,
    selectedRegion = nil,
}

-- Data
local FishItRegions = {"Kohana", "Classic Island", "Magma Region", "Ice Region", "Deep Sea", "Coral Bay", "Fisherman's Wharf"}

local function getPlayers()
    local players = {}
    for _, p in ipairs(game.Players:GetPlayers()) do
        if p ~= game.Players.LocalPlayer then
            table.insert(players, p.Name)
        end
    end
    return #players > 0 and players or {"Tidak ada player lain"}
end

local function getFishItLevel()
    local player = game.Players.LocalPlayer
    local success, level = pcall(function()
        if player:FindFirstChild("leaderstats") and player.leaderstats:FindFirstChild("Level") then
            return player.leaderstats.Level.Value
        end
        return 50
    end)
    return success and level or "Memuat..."
end

-- TABS
local ProfileTab = Window:Tab({Title = "[¥] Profile", Icon = "user"})
local TeleportTab = Window:Tab({Title = "[€] Teleport", Icon = "locate"})
local InfoTab = Window:Tab({Title = "[π] Informasi", Icon = "info"})
local LainTab = Window:Tab({Title = "[¢] Lain", Icon = "settings"})

-- [¥] PROFILE
ProfileTab:Section({Title = "Profil Pengguna"})

local profileInfo = ProfileTab:Paragraph({
    Title = string.format("Nama: %s", game.Players.LocalPlayer.Name),
    Desc = string.format("Level: %s\nStatus: Free", tostring(getFishItLevel())),
})

ProfileTab:Button({
    Title = "Refresh Info",
    Icon = "refresh-cw",
    Callback = function()
        profileInfo:Update({
            Title = string.format("Nama: %s", game.Players.LocalPlayer.Name),
            Desc = string.format("Level: %s\nStatus: Free", tostring(getFishItLevel())),
        })
        WindUI:Notify({Title = "Info Diperbarui", Content = "Profil berhasil diperbarui", Icon = "check"})
    end
})

-- [€] TELEPORT
TeleportTab:Section({Title = "Teleport Options"})

local playerDropdown = TeleportTab:Dropdown({
    Title = "Teleport To People →",
    Desc = "Pilih player untuk teleport",
    Values = getPlayers(),
    Value = getPlayers()[1],
    Callback = function(value) States.selectedPlayer = value end
})

TeleportTab:Button({
    Title = "Teleport To People",
    Color = Color3.fromHex("#30FF6A"),
    Icon = "zap",
    Callback = function()
        if States.selectedPlayer and States.selectedPlayer ~= "Tidak ada player lain" then
            local target = game.Players:FindFirstChild(States.selectedPlayer)
            if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
                game.Players.LocalPlayer.Character:PivotTo(target.Character.HumanoidRootPart.CFrame)
                WindUI:Notify({Title = "Teleport Berhasil", Content = "Ke " .. States.selectedPlayer, Icon = "check"})
            else
                WindUI:Notify({Title = "Teleport Gagal", Content = "Player tidak ditemukan", Icon = "x"})
            end
        else
            WindUI:Notify({Title = "Pilih Player", Content = "Silakan pilih player terlebih dahulu", Icon = "alert-circle"})
        end
    end
})

TeleportTab:Space()

local regionDropdown = TeleportTab:Dropdown({
    Title = "Teleport To The Region",
    Desc = "Pilih wilayah Fish It",
    Values = FishItRegions,
    Value = FishItRegions[1],
    Callback = function(value) States.selectedRegion = value end
})

TeleportTab:Button({
    Title = "Teleport To The Region",
    Color = Color3.fromHex("#30FF6A"),
    Icon = "map-pin",
    Callback = function()
        if States.selectedRegion then
            local regionFolder = workspace:FindFirstChild("Regions") or workspace:FindFirstChild("Locations")
            if regionFolder then
                local targetRegion = regionFolder:FindFirstChild(States.selectedRegion)
                if targetRegion and targetRegion:FindFirstChild("Spawn") then
                    game.Players.LocalPlayer.Character:PivotTo(targetRegion.Spawn.CFrame)
                    WindUI:Notify({Title = "Teleport Berhasil", Content = "Ke " .. States.selectedRegion, Icon = "check"})
                else
                    WindUI:Notify({Title = "Info", Content = "Menggunakan posisi default", Icon = "info"})
                end
            else
                WindUI:Notify({Title = "Teleport Gagal", Content = "Folder region tidak ditemukan", Icon = "x"})
            end
        end
    end
})

TeleportTab:Space()

TeleportTab:Button({
    Title = "Refresh",
    Icon = "refresh-cw",
    Callback = function()
        local players = getPlayers()
        playerDropdown:Update({Values = players, Value = players[1]})
        WindUI:Notify({Title = "Refresh Berhasil", Content = "Daftar player diperbarui", Icon = "check"})
    end
})

-- [π] INFORMASI
InfoTab:Section({Title = "Kontak Developer"})

InfoTab:Paragraph({
    Title = "INFORMASI",
    Desc = "Telegram: @tarzbot\nWhatsApp: 0812345678\nTikTok: @_tarzbot",
})

InfoTab:Space()

InfoTab:Button({Title = "Copy Telegram", Icon = "copy", Callback = function() setclipboard("@tarzbot") WindUI:Notify({Title = "Disalin", Content = "Telegram: @tarzbot", Icon = "clipboard"}) end})
InfoTab:Button({Title = "Copy WhatsApp", Icon = "copy", Callback = function() setclipboard("0812345678") WindUI:Notify({Title = "Disalin", Content = "WhatsApp: 0812345678", Icon = "clipboard"}) end})
InfoTab:Button({Title = "Copy TikTok", Icon = "copy", Callback = function() setclipboard("@_tarzbot") WindUI:Notify({Title = "Disalin", Content = "TikTok: @_tarzbot", Icon = "clipboard"}) end})

-- [¢] LAIN
LainTab:Section({Title = "Auto Fishing"})

LainTab:Toggle({
    Title = "Auto Perfect",
    Desc = "Auto fishing dengan perfect throw",
    Icon = "fishing-pole",
    Default = false,
    Callback = function(value)
        States.autoPerfect = value
        WindUI:Notify({Title = "Auto Perfect", Content = value and "Diaktifkan" or "Dimatikan", Icon = value and "check" or "x"})
    end
})

LainTab:Space()

LainTab:Section({Title = "Delete Animation"})

LainTab:Toggle({
    Title = "Animasi Rod",
    Desc = "Menghilangkan animasi melempar rod",
    Icon = "ban",
    Default = false,
    Callback = function(value)
        States.removeRodAnim = value
        local char = game.Players.LocalPlayer.Character or game.Players.LocalPlayer.CharacterAdded:Wait()
        
        if value then
            local animator = char:FindFirstChildOfClass("Humanoid"):FindFirstChildOfClass("Animator")
            if animator then for _, track in ipairs(animator:GetPlayingAnimationTracks()) do track:Stop() end end
            
            local rod = char:FindFirstChild("FishingRod") or game.Players.LocalPlayer.Backpack:FindFirstChild("FishingRod")
            if rod then for _, anim in ipairs(rod:GetDescendants()) do if anim:IsA("Animation") then anim.AnimationId = "" end end end
            
            WindUI:Notify({Title = "Animasi Rod", Content = "Dinonaktifkan", Icon = "check"})
        else
            WindUI:Notify({Title = "Animasi Rod", Content = "Diaktifkan kembali", Icon = "x"})
        end
    end
})

LainTab:Toggle({
    Title = "Notifikasi Fish",
    Desc = "Menghilangkan notifikasi ikan yang didapat",
    Icon = "bell-off",
    Default = false,
    Callback = function(value)
        States.removeFishNotif = value
        local player = game.Players.LocalPlayer
        
        local function toggleNotifUI(state)
            for _, gui in ipairs(player.PlayerGui:GetChildren()) do
                if gui.Name:lower():match("notif") or gui.Name:lower():match("catch") or gui.Name:lower():match("fish") then
                    gui.Enabled = state
                end
                for _, obj in ipairs(gui:GetDescendants()) do
                    if obj:IsA("TextLabel") or obj:IsA("Frame") or obj:IsA("ImageLabel") then
                        if obj.Name:lower():match("notif") or obj.Name:lower():match("catch") then
                            obj.Visible = state
                        end
                    end
                end
            end
        end
        
        if value then
            getgenv().NotifConnection = player.PlayerGui.ChildAdded:Connect(function(child) wait(0.1) toggleNotifUI(false) end)
            toggleNotifUI(false)
            WindUI:Notify({Title = "Notifikasi Fish", Content = "Dinonaktifkan", Icon = "check"})
        else
            if getgenv().NotifConnection then getgenv().NotifConnection:Disconnect() end
            toggleNotifUI(true)
            WindUI:Notify({Title = "Notifikasi Fish", Content = "Diaktifkan kembali", Icon = "x"})
        end
    end
})

LainTab:Toggle({
    Title = "Animasi Efek Rod",
    Desc = "Menghilangkan efek visual pancingan",
    Icon = "eye-off",
    Default = false,
    Callback = function(value)
        States.removeRodEffect = value
        
        local function toggleEffects(state)
            for _, obj in ipairs(game.Workspace:GetDescendants()) do
                if obj:IsA("ParticleEmitter") or obj:IsA("Beam") or obj:IsA("Trail") or obj:IsA("Sparkles") then
                    if obj.Name:lower():match("rod") or obj.Name:lower():match("fish") or 
                       obj.Name:lower():match("water") or obj.Name:lower():match("splash") or
                       obj.Name:lower():match("effect") then
                        obj.Enabled = state
                    end
                end
            end
        end
        
        if value then
            getgenv().EffectConnection = game.Workspace.DescendantAdded:Connect(function(desc)
                wait(0.1)
                if desc:IsA("ParticleEmitter") or desc:IsA("Beam") or desc:IsA("Trail") or desc:IsA("Sparkles") then
                    if desc.Name:lower():match("rod") or desc.Name:lower():match("fish") or 
                       desc.Name:lower():match("water") or desc.Name:lower():match("splash") then
                        desc.Enabled = false
                    end
                end
            end)
            toggleEffects(false)
            WindUI:Notify({Title = "Efek Rod", Content = "Dinonaktifkan", Icon = "check"})
        else
            if getgenv().EffectConnection then getgenv().EffectConnection:Disconnect() end
            toggleEffects(true)
            WindUI:Notify({Title = "Efek Rod", Content = "Diaktifkan kembali", Icon = "x"})
        end
    end
})

-- ========== AUTO FISHING ENGINE ==========
spawn(function()
    while true do
        wait(0.3)
        if States.autoPerfect then
            local player = game.Players.LocalPlayer
            local char = player.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local rod = player.Backpack:FindFirstChild("FishingRod") or char:FindFirstChild("FishingRod")
                if rod then
                    if not char:FindFirstChild("FishingRod") then
                        rod.Parent = char
                        wait(0.2)
                    end
                    
                    local remote = game.ReplicatedStorage:FindFirstChild("FishingRemote") or 
                                 game.ReplicatedStorage:FindFirstChild("RemoteEvent") or
                                 game.ReplicatedStorage:FindFirstChild("FishingEvent") or
                                 game.ReplicatedStorage:FindFirstChild("FishEvent") or
                                 game.ReplicatedStorage:FindFirstChild("CastEvent")
                    
                    if remote then
                        remote:FireServer("Cast", {power = 1, perfect = true, auto = true})
                        wait(1.5)
                        remote:FireServer("Catch", {perfect = true, auto = true})
                        wait(0.5)
                    end
                end
            end
        end
    end
end)

-- ========== ANTI AFK ==========
spawn(function()
    while wait(120) do
        local virtualUser = game:GetService("VirtualUser")
        virtualUser:CaptureController()
        virtualUser:ClickButton2(Vector2.new(0,0))
    end
end)

-- ========== LOAD NOTIFICATIONS ==========
wait(1)
WindUI:Notify({Title = "✅ TarzBot V1.0.1", Content = "Script berhasil dimuat!", Duration = 4})
WindUI:Notify({Title = "⭐ FITUR UTAMA", Content = "🎣 Auto Perfect | ⛔ Anti AFK | 🐟 All Maps | 🔧 Lightweight", Duration = 5})
print("[TarzBot] GUI loaded successfully with WindUI Framework!")

