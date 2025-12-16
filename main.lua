--==================================================
-- TARZBOT FISH IT GUI (ALL IN ONE)
--==================================================

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

--================ SCREEN GUI ======================
local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.Name = "TarzBotGUI"
gui.ResetOnSpawn = false

--================ MAIN FRAME ======================
local Main = Instance.new("Frame", gui)
Main.Size = UDim2.new(0,360,0,430)
Main.Position = UDim2.new(0.5,-180,0.5,-215)
Main.BackgroundColor3 = Color3.fromRGB(25,25,25)
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0,10)

--================ TOP BAR =========================
local Top = Instance.new("Frame", Main)
Top.Size = UDim2.new(1,0,0,40)
Top.BackgroundColor3 = Color3.fromRGB(35,35,35)

local Title = Instance.new("TextLabel", Top)
Title.Size = UDim2.new(1,-90,1,0)
Title.Position = UDim2.new(0,10,0,0)
Title.Text = "Azka"
Title.TextColor3 = Color3.new(1,1,1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.BackgroundTransparency = 1
Title.TextXAlignment = Left

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
