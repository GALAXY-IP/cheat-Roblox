--==================================================
-- AZKA UI | FISH IT | FIX TOTAL
--==================================================

local Players = game:GetService("Players")
local LP = Players.LocalPlayer

-- PARENT (AMAN UNTUK EXECUTOR)
local parentGui = game:GetService("CoreGui")

-- HAPUS JIKA SUDAH ADA
pcall(function()
    parentGui.AZKA_UI:Destroy()
end)

--==================================================
-- SCREEN GUI
--==================================================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AZKA_UI"
ScreenGui.Parent = parentGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

--==================================================
-- MAIN WINDOW
--==================================================
local Main = Instance.new("Frame", ScreenGui)
Main.Size = UDim2.fromOffset(500, 320)
Main.Position = UDim2.fromScale(0.5, 0.5)
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.BackgroundColor3 = Color3.fromRGB(15,15,25)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0,12)

--==================================================
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
