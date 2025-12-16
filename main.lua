--// SERVICES
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

--// GUI
local Gui = Instance.new("ScreenGui")
Gui.Name = "AZKA_UI"
Gui.ResetOnSpawn = false
Gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

--// MAIN
local Main = Instance.new("Frame", Gui)
Main.Size = UDim2.fromOffset(600, 420)
Main.Position = UDim2.fromScale(0.5,0.5) - UDim2.fromOffset(300,210)
Main.BackgroundColor3 = Color3.fromRGB(16,16,16)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0,18)

--// TOP BAR
local Top = Instance.new("Frame", Main)
Top.Size = UDim2.new(1,0,0,44)
Top.BackgroundColor3 = Color3.fromRGB(22,22,22)
Top.BorderSizePixel = 0
Instance.new("UICorner", Top).CornerRadius = UDim.new(0,18)

local Title = Instance.new("TextLabel", Top)
Title.Size = UDim2.new(1,-100,1,0)
Title.Position = UDim2.fromOffset(14,0)
Title.BackgroundTransparency = 1
Title.Text = "AZKA"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 17
Title.TextColor3 = Color3.new(1,1,1)
Title.TextXAlignment = Left

-- Close & Minimize (ikon)
local Close = Instance.new("TextButton", Top)
Close.Size = UDim2.fromOffset(28,24)
Close.Position = UDim2.fromOffset(560,10)
Close.Text = "⨉"
Close.Font = Enum.Font.GothamBold
Close.TextSize = 14
Close.TextColor3 = Color3.new(1,1,1)
Close.BackgroundColor3 = Color3.fromRGB(120,35,35)
Close.BorderSizePixel = 0
Instance.new("UICorner", Close).CornerRadius = UDim.new(0,6)

local Min = Instance.new("TextButton", Top)
Min.Size = UDim2.fromOffset(28,24)
Min.Position = UDim2.fromOffset(526,10)
Min.Text = "▢"
Min.Font = Enum.Font.GothamBold
Min.TextSize = 14
Min.TextColor3 = Color3.new(1,1,1)
Min.BackgroundColor3 = Color3.fromRGB(55,55,55)
Min.BorderSizePixel = 0
Instance.new("UICorner", Min).CornerRadius = UDim.new(0,6)

-- CONTENT
local Content = Instance.new("Frame", Main)
Content.Position = UDim2.fromOffset(12,56)
Content.Size = UDim2.new(1,-24,1,-68)
Content.BackgroundTransparency = 1

local List = Instance.new("UIListLayout", Content)
List.Padding = UDim.new(0,10)

-- MINIMIZE BALL
local Ball = Instance.new("TextButton", Gui)
Ball.Size = UDim2.fromOffset(48,48)
Ball.Position = UDim2.fromOffset(40,300)
Ball.Text = "AZ"
Ball.Visible = false
Ball.Font = Enum.Font.GothamBold
Ball.TextSize = 14
Ball.TextColor3 = Color3.new(1,1,1)
Ball.BackgroundColor3 = Color3.fromRGB(30,30,30)
Ball.BorderSizePixel = 0
Ball.Active = true
Ball.Draggable = true
Instance.new("UICorner", Ball).CornerRadius = UDim.new(1,0)

Close.MouseButton1Click:Connect(function() Gui:Destroy() end)
Min.MouseButton1Click:Connect(function() Main.Visible=false Ball.Visible=true end)
Ball.MouseButton1Click:Connect(function() Main.Visible=true Ball.Visible=false end)

--// HELPERS
local function Section(title)
    local head = Instance.new("TextButton")
    head.Size = UDim2.new(1,0,0,42)
    head.Text = title.."  >"
    head.Font = Enum.Font.Gotham
    head.TextSize = 14
    head.TextColor3 = Color3.new(1,1,1)
    head.BackgroundColor3 = Color3.fromRGB(28,28,28)
    head.BorderSizePixel = 0
    head.Parent = Content
    Instance.new("UICorner", head).CornerRadius = UDim.new(0,14)

    local body = Instance.new("Frame")
    body.Size = UDim2.new(1,0,0,0)
    body.ClipsDescendants = true
    body.BackgroundTransparency = 1
    body.Parent = Content

    local bl = Instance.new("UIListLayout", body)
    bl.Padding = UDim.new(0,6)

    local open=false
    head.MouseButton1Click:Connect(function()
        open = not open
        head.Text = title..(open and "  v" or "  >")
        body.Size = open and UDim2.new(1,0,0,240) or UDim2.new(1,0,0,0)
    end)
    return body
end

local function Item(parent, text, cb)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1,0,0,36)
    b.Text = text
    b.Font = Enum.Font.Gotham
    b.TextSize = 13
    b.TextColor3 = Color3.fromRGB(230,230,230)
    b.BackgroundColor3 = Color3.fromRGB(36,36,36)
    b.BorderSizePixel = 0
    b.Parent = parent
    Instance.new("UICorner", b).CornerRadius = UDim.new(0,10)
    if cb then b.MouseButton1Click:Connect(cb) end
    return b
end

--// TELEPORT (REAL) + REFRESH
local Teleport = Section("Teleport")

--// DATA TELEPORT FISH IT (WILAYAH LENGKAP)
local FishItLocations = {
    ["Lost Isle"] = {
        ["Statue SysPush"] = CFrame.new(0, 10, 0),
        ["Treasure Room"] = CFrame.new(45, 12, 120),
        ["Dock Lost Isle"] = CFrame.new(-30, 8, 60),
        ["Fishing Spot Utama"] = CFrame.new(20, 8, -40),
    },

    ["Kohana Island"] = {
        ["Pelabuhan Kohana"] = CFrame.new(120, 9, -60),
        ["Fishing Area Kohana"] = CFrame.new(150, 8, -20),
        ["Pasar Kohana"] = CFrame.new(100, 8, -90),
    },

    ["Classic Island"] = {
        ["Dermaga Classic"] = CFrame.new(-80, 9, 200),
        ["Fishing Area Classic"] = CFrame.new(-60, 8, 160),
        ["Rumah NPC Classic"] = CFrame.new(-110, 8, 230),
    },

    ["Fisherman Area"] = {
        ["Dermaga Fisherman"] = CFrame.new(200, 9, 40),
        ["Toko Fisherman"] = CFrame.new(230, 8, 70),
        ["Spot Mancing Fisherman"] = CFrame.new(210, 8, 10),
    },
}

local SelectedCF
local SelectedPlayer

local function Clear(frame)
    for _,v in ipairs(frame:GetChildren()) do
        if v:IsA("TextButton") then
            v:Destroy()
        end
    end
end

--// LOAD TELEPORT MENU
local function LoadTeleport()
    Clear(Teleport)

    -- === TELEPORT TEMPAT ===
    Item(Teleport,"— TELEPORT WILAYAH —")

    for wilayah, places in pairs(FishItLocations) do
        -- Header wilayah (expand / collapse)
        local wilayahBtn = Item(Teleport,"📌 "..wilayah.."  >",nil)
        local opened = false

        wilayahBtn.MouseButton1Click:Connect(function()
            opened = not opened
            wilayahBtn.Text = "📌 "..wilayah..(opened and "  v" or "  >")

            if opened then
                for place, cf in pairs(places) do
                    Item(Teleport,"   ▸ "..place,function()
                        SelectedCF = cf
                    end)
                end
            else
                LoadTeleport()
            end
        end)
    end

    Item(Teleport,"🔄 Refresh Tempat",function()
        LoadTeleport()
    end)

    Item(Teleport,"🚀 Teleport ke Tempat",function()
        local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp and SelectedCF then
            hrp.CFrame = SelectedCF
        end
    end)

    -- === TELEPORT PLAYER ===
    Item(Teleport,"— TELEPORT PLAYER —")

    for _,plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            Item(Teleport,"👤 "..plr.Name,function()
                SelectedPlayer = plr
            end)
        end
    end

    Item(Teleport,"🔄 Refresh Player",function()
        LoadTeleport()
    end)

    Item(Teleport,"🚀 Teleport ke Player",function()
        if SelectedPlayer and SelectedPlayer.Character then
            local t = SelectedPlayer.Character:FindFirstChild("HumanoidRootPart")
            local m = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if t and m then
                m.CFrame = t.CFrame * CFrame.new(0,0,3)
            end
        end
    end)
end

-- INIT
LoadTeleport()

--// FARMING KOIN (UI / TOGGLE)
local Farm = Section("Farming Koin")
Item(Farm,"Select Wilayah: Fisherman / Classic / Lost Isle")
local farmOn=false
Item(Farm,"Aktifkan Fitur (OFF)",function(btn)
    farmOn = not farmOn
    btn.Text = "Aktifkan Fitur ("..(farmOn and "ON" or "OFF")..")"
end)
