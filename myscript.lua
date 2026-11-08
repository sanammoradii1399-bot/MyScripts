--[[ XXXXREDF7 Ring Panel | 2-Step Password ]]
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local TextChatService = game:GetService("TextChatService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer

local NAVY = Color3.fromRGB(0, 0, 128)
local NAVY_DARK = Color3.fromRGB(0, 0, 80)
local BTN_DARK = Color3.fromRGB(0, 0, 60)
local ACCENT = Color3.fromRGB(50, 80, 200)
local TEXT_COLOR = Color3.fromRGB(240, 245, 255)
local DANGER = Color3.fromRGB(180, 40, 40)
local SUCCESS = Color3.fromRGB(40, 160, 80)

local function SendChatMessage(message)
    pcall(function()
        if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
            TextChatService.TextChannels.RBXGeneral:SendAsync(message)
        else
            game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(message, "All")
        end
    end)
end

SendChatMessage("XXXXXREDF7 Online")

local LoginGui = Instance.new("ScreenGui")
LoginGui.Name = "XXXXXREDF7_Login"
LoginGui.ResetOnSpawn = false
LoginGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
LoginGui.DisplayOrder = 99999
LoginGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local LoginFrame = Instance.new("Frame")
LoginFrame.Size = UDim2.new(0, 260, 0, 200)
LoginFrame.Position = UDim2.new(0.5, -130, 0.5, -100)
LoginFrame.BackgroundColor3 = NAVY
LoginFrame.BorderSizePixel = 0
LoginFrame.Parent = LoginGui
Instance.new("UICorner", LoginFrame).CornerRadius = UDim.new(0, 15)
local stroke = Instance.new("UIStroke", LoginFrame)
stroke.Color = ACCENT; stroke.Thickness = 2

local LoginTitleBar = Instance.new("Frame")
LoginTitleBar.Size = UDim2.new(1, 0, 0, 45)
LoginTitleBar.BackgroundColor3 = NAVY_DARK
LoginTitleBar.BorderSizePixel = 0
LoginTitleBar.Parent = LoginFrame
Instance.new("UICorner", LoginTitleBar).CornerRadius = UDim.new(0, 15)
local lTitleFix = Instance.new("Frame", LoginTitleBar)
lTitleFix.Size = UDim2.new(1, 0, 0, 15); lTitleFix.Position = UDim2.new(0, 0, 1, -15)
lTitleFix.BackgroundColor3 = NAVY_DARK; lTitleFix.BorderSizePixel = 0

local LoginTitle = Instance.new("TextLabel")
LoginTitle.Size = UDim2.new(1, 0, 1, 0); LoginTitle.BackgroundTransparency = 1
LoginTitle.Text = "ورود به پنل XXXXXREDF7"
LoginTitle.TextColor3 = TEXT_COLOR; LoginTitle.Font = Enum.Font.GothamBold
LoginTitle.TextSize = 15; LoginTitle.Parent = LoginTitleBar

local Pass1 = Instance.new("TextBox")
Pass1.Size = UDim2.new(0.8, 0, 0, 35); Pass1.Position = UDim2.new(0.1, 0, 0.3, 0)
Pass1.BackgroundColor3 = BTN_DARK; Pass1.PlaceholderText = "رمز مرحله اول..."
Pass1.TextColor3 = TEXT_COLOR; Pass1.Font = Enum.Font.Gotham; Pass1.TextSize = 14
Pass1.Parent = LoginFrame
Instance.new("UICorner", Pass1).CornerRadius = UDim.new(0, 8)

local Pass2 = Instance.new("TextBox")
Pass2.Size = UDim2.new(0.8, 0, 0, 35); Pass2.Position = UDim2.new(0.1, 0, 0.5, 0)
Pass2.BackgroundColor3 = BTN_DARK; Pass2.PlaceholderText = "رمز مرحله دوم..."
Pass2.TextColor3 = TEXT_COLOR; Pass2.Font = Enum.Font.Gotham; Pass2.TextSize = 14
Pass2.Parent = LoginFrame
Instance.new("UICorner", Pass2).CornerRadius = UDim.new(0, 8)

local LoginBtn = Instance.new("TextButton")
LoginBtn.Size = UDim2.new(0.8, 0, 0, 35); LoginBtn.Position = UDim2.new(0.1, 0, 0.72, 0)
LoginBtn.BackgroundColor3 = SUCCESS; LoginBtn.Text = "تایید و ورود"
LoginBtn.TextColor3 = TEXT_COLOR; LoginBtn.Font = Enum.Font.GothamBold
LoginBtn.TextSize = 14; LoginBtn.Parent = LoginFrame
Instance.new("UICorner", LoginBtn).CornerRadius = UDim.new(0, 8)

local ErrorLbl = Instance.new("TextLabel")
ErrorLbl.Size = UDim2.new(1, 0, 0, 20); ErrorLbl.Position = UDim2.new(0, 0, 0.9, 0)
ErrorLbl.BackgroundTransparency = 1; ErrorLbl.Text = ""; ErrorLbl.TextColor3 = DANGER
ErrorLbl.Font = Enum.Font.GothamBold; ErrorLbl.TextSize = 12; ErrorLbl.Parent = LoginFrame

SendChatMessage("رمز پنل رو وارد کنید")

LoginBtn.MouseButton1Click:Connect(function()
    if Pass1.Text == "1212" and Pass2.Text == "7890" then
        SendChatMessage("پنل باز شد✅")
        LoginGui:Destroy()
        
        -- کدهای رینگ اینجا شروع میشه
        local Folder = Instance.new("Folder", Workspace)
        local Part = Instance.new("Part", Folder)
        local Attachment1 = Instance.new("Attachment", Part)
        Part.Anchored = true; Part.CanCollide = false; Part.Transparency = 1

        if not getgenv().Network then
            getgenv().Network = { BaseParts = {}, Velocity = Vector3.new(14.46262424, 14.46262424, 14.46262424) }
            Network.RetainPart = function(Part)
                if typeof(Part) == "Instance" and Part:IsA("BasePart") and Part:IsDescendantOf(Workspace) then
                    table.insert(Network.BaseParts, Part)
                    Part.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
                    Part.CanCollide = false
                end
            end
            LocalPlayer.ReplicationFocus = Workspace
            RunService.Heartbeat:Connect(function()
                pcall(function() sethiddenproperty(LocalPlayer, "SimulationRadius", math.huge) end)
                for _, Part in pairs(Network.BaseParts) do
                    if Part:IsDescendantOf(Workspace) then Part.Velocity = Network.Velocity end
                end
            end)
        end

        local radius = 50
        local ringPartsEnabled = false
        local parts = {}
        
        local function addPart(part)
            if part:IsA("BasePart") and not part.Anchored and part:IsDescendantOf(Workspace) then
                if part.Parent ~= LocalPlayer.Character and not part:IsDescendantOf(LocalPlayer.Character) then
                    table.insert(parts, part)
                end
            end
        end
        for _, p in pairs(Workspace:GetDescendants()) do addPart(p) end
        Workspace.DescendantAdded:Connect(addPart)

        RunService.Heartbeat:Connect(function()
            if not ringPartsEnabled then return end
            local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                for _, part in pairs(parts) do
                    if part.Parent and not part.Anchored then
                        local pos = part.Position
                        local dist = (Vector3.new(pos.X, hrp.Position.Y, pos.Z) - hrp.Position).Magnitude
                        local ang = math.atan2(pos.Z - hrp.Position.Z, pos.X - hrp.Position.X) + math.rad(0.5)
                        local target = Vector3.new(
                            hrp.Position.X + math.cos(ang) * math.min(radius, dist),
                            hrp.Position.Y + (100 * (math.abs(math.sin((pos.Y - hrp.Position.Y) / 100)))),
                            hrp.Position.Z + math.sin(ang) * math.min(radius, dist)
                        )
                        part.Velocity = (target - part.Position).unit * 1000
                    end
                end
            end
        end)

        -- UI پنل اصلی
        local ScreenGui = Instance.new("ScreenGui")
        ScreenGui.Name = "XXXXXREDF7RingPanel"
        ScreenGui.ResetOnSpawn = false
        ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        ScreenGui.DisplayOrder = 99999
        ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

        local FloatingBtn = Instance.new("TextButton")
        FloatingBtn.Size = UDim2.new(0, 55, 0, 55)
        FloatingBtn.Position = UDim2.new(0, 20, 0.4, 0)
        FloatingBtn.BackgroundColor3 = NAVY; FloatingBtn.Text = "✈"
        FloatingBtn.TextColor3 = TEXT_COLOR; FloatingBtn.Font = Enum.Font.GothamBold
        FloatingBtn.TextSize = 28; FloatingBtn.BorderSizePixel = 0
        FloatingBtn.Parent = ScreenGui
        Instance.new("UICorner", FloatingBtn).CornerRadius = UDim.new(1, 0)
        local fStroke = Instance.new("UIStroke", FloatingBtn); fStroke.Color = ACCENT; fStroke.Thickness = 2

        local MainFrame = Instance.new("Frame")
        MainFrame.Size = UDim2.new(0, 260, 0, 240)
        MainFrame.Position = UDim2.new(0.5, -130, 0.5, -120)
        MainFrame.BackgroundColor3 = NAVY; MainFrame.BorderSizePixel = 0
        MainFrame.Visible = false; MainFrame.Parent = ScreenGui
        Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 15)
        local mStroke = Instance.new("UIStroke", MainFrame); mStroke.Color = ACCENT; mStroke.Thickness = 2

        local TitleBar = Instance.new("Frame")
        TitleBar.Size = UDim2.new(1, 0, 0, 45); TitleBar.BackgroundColor3 = NAVY_DARK
        TitleBar.BorderSizePixel = 0; TitleBar.Parent = MainFrame
        Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 15)
        local tFix = Instance.new("Frame", TitleBar)
        tFix.Size = UDim2.new(1, 0, 0, 15); tFix.Position = UDim2.new(0, 0, 1, -15)
        tFix.BackgroundColor3 = NAVY_DARK; tFix.BorderSizePixel = 0

        local Title = Instance.new("TextLabel")
        Title.Size = UDim2.new(1, -60, 1, 0); Title.Position = UDim2.new(0, 15, 0, 0)
        Title.Text = "پنل رینگ XXXXXREDF7"; Title.TextColor3 = TEXT_COLOR
        Title.BackgroundTransparency = 1; Title.Font = Enum.Font.GothamBold
        Title.TextSize = 15; Title.TextXAlignment = Enum.TextXAlignment.Left; Title.Parent = TitleBar

        local CloseBtn = Instance.new("TextButton")
        CloseBtn.Size = UDim2.new(0, 30, 0, 30); CloseBtn.Position = UDim2.new(1, -38, 0, 7)
        CloseBtn.BackgroundColor3 = DANGER; CloseBtn.Text = "X"
        CloseBtn.TextColor3 = TEXT_COLOR; CloseBtn.Font = Enum.Font.GothamBold
        CloseBtn.TextSize = 14; CloseBtn.Parent = TitleBar
        Instance.new("UICorner", CloseBtn).CornerRadius = UDim.new(0, 8)

        local ToggleButton = Instance.new("TextButton")
        ToggleButton.Size = UDim2.new(0.85, 0, 0, 40); ToggleButton.Position = UDim2.new(0.075, 0, 0.24, 0)
        ToggleButton.BackgroundColor3 = BTN_DARK; ToggleButton.Text = "رینگ خاموش است"
        ToggleButton.TextColor3 = TEXT_COLOR; ToggleButton.Font = Enum.Font.GothamBold
        ToggleButton.TextSize = 14; ToggleButton.Parent = MainFrame
        Instance.new("UICorner", ToggleButton).CornerRadius = UDim.new(0, 10)

        local DecreaseRadius = Instance.new("TextButton")
        DecreaseRadius.Size = UDim2.new(0.2, 0, 0, 40); DecreaseRadius.Position = UDim2.new(0.075, 0, 0.56, 0)
        DecreaseRadius.BackgroundColor3 = BTN_DARK; DecreaseRadius.Text = "-"
        DecreaseRadius.TextColor3 = TEXT_COLOR; DecreaseRadius.Font = Enum.Font.GothamBold
        DecreaseRadius.TextSize = 20; DecreaseRadius.Parent = MainFrame
        Instance.new("UICorner", DecreaseRadius).CornerRadius = UDim.new(0, 10)

        local IncreaseRadius = Instance.new("TextButton")
        IncreaseRadius.Size = UDim2.new(0.2, 0, 0, 40); IncreaseRadius.Position = UDim2.new(0.725, 0, 0.56, 0)
        IncreaseRadius.BackgroundColor3 = BTN_DARK; IncreaseRadius.Text = "+"
        IncreaseRadius.TextColor3 = TEXT_COLOR; IncreaseRadius.Font = Enum.Font.GothamBold
        IncreaseRadius.TextSize = 20; IncreaseRadius.Parent = MainFrame
        Instance.new("UICorner", IncreaseRadius).CornerRadius = UDim.new(0, 10)

        local RadiusDisplay = Instance.new("TextLabel")
        RadiusDisplay.Size = UDim2.new(0.4, 0, 0, 40); RadiusDisplay.Position = UDim2.new(0.3, 0, 0.56, 0)
        RadiusDisplay.BackgroundColor3 = NAVY_DARK; RadiusDisplay.Text = "شعاع: 50"
        RadiusDisplay.TextColor3 = TEXT_COLOR; RadiusDisplay.Font = Enum.Font.GothamBold
        RadiusDisplay.TextSize = 14; RadiusDisplay.Parent = MainFrame
        Instance.new("UICorner", RadiusDisplay).CornerRadius = UDim.new(0, 10)

        local isOpen = false
        local function toggleMenu()
            if isOpen then
                MainFrame.Visible = false
                isOpen = false
            else
                MainFrame.Visible = true
                isOpen = true
            end
        end

        FloatingBtn.MouseButton1Click:Connect(toggleMenu)
        CloseBtn.MouseButton1Click:Connect(toggleMenu)

        ToggleButton.MouseButton1Click:Connect(function()
            ringPartsEnabled = not ringPartsEnabled
            if ringPartsEnabled then
                ToggleButton.BackgroundColor3 = SUCCESS
                ToggleButton.Text = "رینگ روشن است"
            else
                ToggleButton.BackgroundColor3 = BTN_DARK
                ToggleButton.Text = "رینگ خاموش است"
            end
        end)

        DecreaseRadius.MouseButton1Click:Connect(function()
            radius = math.max(0, radius - 5)
            RadiusDisplay.Text = "شعاع: " .. radius
        end)

        IncreaseRadius.MouseButton1Click:Connect(function()
            radius = math.min(10000, radius + 5)
            RadiusDisplay.Text = "شعاع: " .. radius
        end)
        
        -- سیستم درگ
        local dragging, dragInput, dragStart, startPos
        local function makeDrag(frame, handle)
            handle.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = frame; dragStart = input.Position; startPos = frame.Position
                end
            end)
        end
        makeDrag(MainFrame, TitleBar)
        makeDrag(FloatingBtn, FloatingBtn)
        
        UserInputService.InputChanged:Connect(function(input)
            if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                local delta = input.Position - dragStart
                dragging.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
            end
        end)
        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = nil
            end
        end)
        
    else
        ErrorLbl.Text = "رمز اشتباه است! دوباره تلاش کنید."
        Pass1.Text = ""; Pass2.Text = ""
    end
end)
