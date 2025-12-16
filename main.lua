---==================================================
-- AZKA UI | Fish It Teleport Script
-- Style : Chloe X Inspired
--==================================================

--// SERVICES
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

--// GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AZKA_UI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

--// MAIN WINDOW
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.fromOffset(520, 360)
Main.Position = UDim2.fromScale(0.5, 0.5) - UDim2.fromOffset(260, 180)
Main.BackgroundColor3 = Color3.fromRGB(14, 14, 22)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 14)

--// TOP BAR
local Top = Instance.new("Frame", Main)
Top.Size = UDim2.new(1, 0, 0, 36)
Top.BackgroundColor3 = Color3.fromRGB(20, 20, 32)
Top.BorderSizePixel = 0
Instance.new("UICorner", Top).CornerRadius = UDim.new(0, 14)

local Title = Instance.new("TextLabel", Top)
Title.Size = UDim2.new(1, -80, 1, 0)
Title.Position = UDim2.fromOffset(12, 0)
Title.BackgroundTransparency = 1
Title.Text = "AZKA"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 15
Title.TextColor3 = Color3.fromRGB(120, 200, 255)
Title.TextXAlignment = Enum.TextXAlignment.Left

-- MINIMIZE BUTTON
local Minimize = Instance.new("TextButton", Top)
Minimize.Size = UDim2.fromOffset(24, 20)
Minimize.Position = UDim2.fromOffset(468, 8)
Minimize.Text = "-"
Minimize.Font = Enum.Font.GothamBold
Minimize.TextSize = 18
Minimize.TextColor3 = Color3.new(1,1,1)
Minimize.BackgroundColor3 = Color3.fromRGB(60,60,90)
Minimize.BorderSizePixel = 0
Instance.new("UICorner", Minimize).CornerRadius = UDim.new(0, 6)

-- CLOSE BUTTON
local Close = Instance.new("TextButton", Top)
Close.Size = UDim2.fromOffset(24, 20)
Close.Position = UDim2.fromOffset(496, 8)
Close.Text = "X"
Close.Font = Enum.Font.GothamBold
Close.TextSize = 14
Close.TextColor3 = Color3.new(1,1,1)
Close.BackgroundColor3 = Color3.fromRGB(150,60,60)
Close.BorderSizePixel = 0
Instance.new("UICorner", Close).CornerRadius = UDim.new(0, 6)

--// SIDEBAR
local Sidebar = Instance.new("Frame", Main)
Sidebar.Position = UDim2.fromOffset(0, 36)
Sidebar.Size = UDim2.new(0, 140, 1, -36)
Sidebar.BackgroundColor3 = Color3.fromRGB(18,18,28)
Sidebar.BorderSizePixel = 0

--// CONTENT
local Content = Instance.new("Frame", Main)
Content.Position = UDim2.fromOffset(150, 46)
Content.Size = UDim2.new(1, -160, 1, -56)
Content.BackgroundTransparency = 1

local Layout = Instance.new("UIListLayout", Content)
Layout.Padding = UDim.new(0, 6)

--// MINIMIZED LOGO
local Logo = Instance.new("TextButton", ScreenGui)
Logo.Size = UDim2.fromOffset(60,60)
Logo.Position = UDim2.fromOffset(40,300)
Logo.Text = "AZKA"
Logo.Font = Enum.Font.GothamBold
Logo.TextSize = 12
Logo.TextColor3 = Color3.fromRGB(120,200,255)
Logo.BackgroundColor3 = Color3.fromRGB(20,20,30)
Logo.Visible = false
Logo.Active = true
Logo.Draggable = true
Logo.BorderSizePixel = 0
Instance.new("UICorner", Logo).CornerRadius = UDim.new(1,0)

--==================================================
-- BUTTON FUNCTIONS
--==================================================
Close.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

Minimize.MouseButton1Click:Connect(function()
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
local function ClearContent()
    for _,v in ipairs(Content:GetChildren()) do
        if v:IsA("TextButton") then
            v:Destroy()
        end
    end
end

local function CreateButton(text, callback)
    local Btn = Instance.new("TextButton", Content)
    Btn.Size = UDim2.new(1,0,0,30)
    Btn.Text = text
    Btn.Font = Enum.Font.Gotham
    Btn.TextSize = 12
    Btn.TextColor3 = Color3.fromRGB(235,235,255)
    Btn.BackgroundColor3 = Color3.fromRGB(30,30,46)
    Btn.BorderSizePixel = 0
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0,8)
    if callback then
        Btn.MouseButton1Click:Connect(callback)
    end
    return Btn
end

--==================================================
-- TELEPORT DATA (FULL)
--==================================================
local Teleports = {
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
    ClearContent()
    CreateButton("== TELEPORT TEMPAT ==")

    for name,cf in pairs(Teleports) do
        CreateButton("📍 "..name, function()
            local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                hrp.CFrame = cf
            end
        end)
    end

    CreateButton("== TELEPORT PLAYER ==")

    for _,plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            CreateButton("👤 "..plr.Name, function()
                local my = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                local target = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
                if my and target then
                    my.CFrame = target.CFrame * CFrame.new(0,0,3)
                end
            end)
        end
    end

    CreateButton("🔄 Refresh Player", TeleportMenu)
end

--==================================================
-- INFO MENU
--==================================================
local function InfoMenu()
    ClearContent()
    CreateButton("AZKA Script")
    CreateButton("Game : Fish It")
    CreateButton("Style : Chloe X Inspired")
    CreateButton("UI : Neon Modern")
    CreateButton("Feature : Teleport Place & Player")
end

--==================================================
-- SIDEBAR BUTTONS
--==================================================
local function SidebarButton(text, y, callback)
    local Btn = Instance.new("TextButton", Sidebar)
    Btn.Size = UDim2.new(1,0,0,36)
    Btn.Position = UDim2.fromOffset(0,y)
    Btn.Text = text
    Btn.Font = Enum.Font.GothamBold
    Btn.TextSize = 13
    Btn.TextColor3 = Color3.fromRGB(120,200,255)
    Btn.BackgroundColor3 = Color3.fromRGB(22,22,35)
    Btn.BorderSizePixel = 0
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0,8)
    Btn.MouseButton1Click:Connect(callback)
end

SidebarButton("Teleport", 12, TeleportMenu)
SidebarButton("Informasi", 56, InfoMenu)

-- DEFAULT MENU
TeleportMenu()
