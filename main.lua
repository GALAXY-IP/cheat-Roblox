--// SERVICES
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local LocalPlayer = Players.LocalPlayer

--// GUI
local Gui = Instance.new("ScreenGui")
Gui.Name = "ChloeX_RealUI"
Gui.ResetOnSpawn = false
Gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

--// MAIN WINDOW
local Main = Instance.new("Frame", Gui)
Main.Size = UDim2.fromOffset(600, 380)
Main.Position = UDim2.fromScale(0.5,0.5) - UDim2.fromOffset(300,190)
Main.BackgroundColor3 = Color3.fromRGB(15,15,15)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0,18)

-- Glow
local stroke = Instance.new("UIStroke", Main)
stroke.Thickness = 1.5
stroke.Color = Color3.fromRGB(90,90,90)
stroke.Transparency = 0.4

--// SIDEBAR
local Sidebar = Instance.new("Frame", Main)
Sidebar.Size = UDim2.fromOffset(160, 380)
Sidebar.BackgroundColor3 = Color3.fromRGB(20,20,20)
Sidebar.BorderSizePixel = 0
Instance.new("UICorner", Sidebar).CornerRadius = UDim.new(0,18)

--// TITLE
local Title = Instance.new("TextLabel", Sidebar)
Title.Size = UDim2.fromOffset(160,60)
Title.Text = "CHLOE X"
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 20
Title.TextColor3 = Color3.new(1,1,1)
Title.BackgroundTransparency = 1

--// CONTENT
local Content = Instance.new("Frame", Main)
Content.Position = UDim2.fromOffset(170,20)
Content.Size = UDim2.fromOffset(410,340)
Content.BackgroundTransparency = 1

--// MENU SYSTEM
local Menus = {}
local function NewMenu()
    local f = Instance.new("Frame", Content)
    f.Size = UDim2.fromScale(1,1)
    f.Visible = false
    f.BackgroundTransparency = 1
    return f
end

local TeleportMenu = NewMenu()
TeleportMenu.Visible = true
Menus.Teleport = TeleportMenu

local function ShowMenu(name)
    for _,m in pairs(Menus) do m.Visible = false end
    Menus[name].Visible = true
end

--// SIDEBAR BUTTON
local function SideButton(text,y,callback)
    local b = Instance.new("TextButton", Sidebar)
    b.Size = UDim2.fromOffset(140,42)
    b.Position = UDim2.fromOffset(10,y)
    b.Text = text
    b.Font = Enum.Font.Gotham
    b.TextSize = 14
    b.TextColor3 = Color3.new(1,1,1)
    b.BackgroundColor3 = Color3.fromRGB(30,30,30)
    b.BorderSizePixel = 0
    Instance.new("UICorner", b).CornerRadius = UDim.new(0,12)

    b.MouseEnter:Connect(function()
        TweenService:Create(b,TweenInfo.new(0.15),
            {BackgroundColor3 = Color3.fromRGB(45,45,45)}):Play()
    end)
    b.MouseLeave:Connect(function()
        TweenService:Create(b,TweenInfo.new(0.15),
            {BackgroundColor3 = Color3.fromRGB(30,30,30)}):Play()
    end)

    b.MouseButton1Click:Connect(callback)
end

SideButton("Teleport",80,function()
    ShowMenu("Teleport")
end)

SideButton("Hide Name",130,function()
    local char = LocalPlayer.Character
    if not char then return end
    for _,v in pairs(char:GetDescendants()) do
        if v:IsA("BillboardGui") then
            v.Enabled = false
        end
    end
end)

--// BASIC UI CREATOR
local function BaseButton(parent,text,y)
    local b = Instance.new("TextButton", parent)
    b.Size = UDim2.fromOffset(390,42)
    b.Position = UDim2.fromOffset(10,y)
    b.Text = text
    b.Font = Enum.Font.Gotham
    b.TextSize = 14
    b.TextColor3 = Color3.new(1,1,1)
    b.BackgroundColor3 = Color3.fromRGB(32,32,32)
    b.BorderSizePixel = 0
    Instance.new("UICorner", b).CornerRadius = UDim.new(0,12)
    return b
end

--// DROPDOWN
local function Dropdown(parent,y,title)
    local box = BaseButton(parent,title,y)

    local list = Instance.new("ScrollingFrame", parent)
    list.Position = UDim2.fromOffset(10,y+46)
    list.Size = UDim2.fromOffset(390,0)
    list.CanvasSize = UDim2.new(0,0,0,0)
    list.ScrollBarThickness = 4
    list.Visible = false
    list.BackgroundColor3 = Color3.fromRGB(25,25,25)
    list.BorderSizePixel = 0
    Instance.new("UICorner", list).CornerRadius = UDim.new(0,12)

    box.MouseButton1Click:Connect(function()
        list.Visible = not list.Visible
        list.Size = list.Visible and UDim2.fromOffset(390,140) or UDim2.fromOffset(390,0)
    end)

    return box,list
end

--// DATA
local Locations = {
    Dock = CFrame.new(0,10,0),
    Market = CFrame.new(120,10,-40),
    FishingSpot = CFrame.new(-80,10,200)
}

local SelectedLocation
local SelectedPlayer

--// LOCATION DROPDOWN
local LocBox,LocList = Dropdown(TeleportMenu,0,"Select Location")

--// PLAYER DROPDOWN
local PlayerBox,PlayerList = Dropdown(TeleportMenu,170,"Select Player")

--// REFRESH
local function Refresh()
    LocList:ClearAllChildren()
    PlayerList:ClearAllChildren()

    local y = 0
    for name,cf in pairs(Locations) do
        local b = BaseButton(LocList,name,y)
        b.MouseButton1Click:Connect(function()
            SelectedLocation = cf
            LocBox.Text = "Location: "..name
            LocList.Visible = false
        end)
        y += 46
    end
    LocList.CanvasSize = UDim2.fromOffset(0,y)

    y = 0
    for _,p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            local b = BaseButton(PlayerList,p.Name,y)
            b.MouseButton1Click:Connect(function()
                SelectedPlayer = p
                PlayerBox.Text = "Player: "..p.Name
                PlayerList.Visible = false
            end)
            y += 46
        end
    end
    PlayerList.CanvasSize = UDim2.fromOffset(0,y)
end

Refresh()

--// EXEC TELEPORT
BaseButton(TeleportMenu,"EXECUTE TELEPORT",300).MouseButton1Click:Connect(function()
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    if SelectedLocation then
        hrp.CFrame = SelectedLocation
    elseif SelectedPlayer and SelectedPlayer.Character then
        hrp.CFrame =
            SelectedPlayer.Character.HumanoidRootPart.CFrame * CFrame.new(0,0,2)
    end
end)

--// REFRESH BUTTON
BaseButton(TeleportMenu,"REFRESH LIST",350).MouseButton1Click:Connect(Refresh)
