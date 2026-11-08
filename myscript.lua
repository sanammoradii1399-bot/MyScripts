--[[ 
    XXXXREDF7 Ring Panel
    Original: Super Ring Parts V5 by lukas
    Redesigned by XXXXXREDF7
    Theme: #000080 Navy | Floating | Animated | Persian UI
    2-Step Password Protected
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")
local StarterGui = game:GetService("StarterGui")
local TextChatService = game:GetService("TextChatService")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer

-- ==========================================
-- 🎨 پالت رنگ‌ها
-- ==========================================
local NAVY = Color3.fromRGB(0, 0, 128)         -- #000080
local NAVY_DARK = Color3.fromRGB(0, 0, 80)     
local BTN_DARK = Color3.fromRGB(0, 0, 60)      
local ACCENT = Color3.fromRGB(50, 80, 200)     
local TEXT_COLOR = Color3.fromRGB(240, 245, 255)
local DANGER = Color3.fromRGB(180, 40, 40)
local SUCCESS = Color3.fromRGB(40, 160, 80)

-- ==========================================
-- 📢 تابع ارسال پیام چت (کوتاه شده برای جلوگیری از فیلتر)
-- ==========================================
local function SendChatMessage(message)
    pcall(function()
        if TextChatService.ChatVersion == Enum.ChatVersion.TextChatService then
            local textChannel = TextChatService.TextChannels.RBXGeneral
            textChannel:SendAsync(message)
        else
            game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(message, "All")
        end
    end)
end

-- ==========================================
-- 🔐 مرحله ۱: صفحه لاگین دو مرحله‌ای
-- ==========================================
SendChatMessage("XXXXXREDF7 Online")

local LoginGui = Instance.new("ScreenGui")
LoginGui.Name = "XXXXXREDF7_Login"
LoginGui.ResetOnSpawn = false
LoginGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local LoginFrame = Instance.new("Frame")
LoginFrame.Size = UDim2.new(0, 260, 0, 200)
LoginFrame.Position = UDim2.new(0.5, -130, 0.5, -100)
LoginFrame.BackgroundColor3 = NAVY
LoginFrame.BorderSizePixel = 0
LoginFrame.Parent = LoginGui

local loginCorner = Instance.new("UICorner", LoginFrame)
loginCorner.CornerRadius = UDim.new(0, 15)

local loginStroke = Instance.new("UIStroke", LoginFrame)
loginStroke.Color = ACCENT
loginStroke.Thickness = 2

-- هدر لاگین
local LoginTitleBar = Instance.new("Frame")
LoginTitleBar.Size = UDim2.new(1, 0, 0, 45)
LoginTitleBar.BackgroundColor3 = NAVY_DARK
LoginTitleBar.BorderSizePixel = 0
LoginTitleBar.Parent = LoginFrame

local lTitleCorner = Instance.new("UICorner", LoginTitleBar)
lTitleCorner.CornerRadius = UDim.new(0, 15)

local lTitleFix = Instance.new("Frame", LoginTitleBar)
lTitleFix.Size = UDim2.new(1, 0, 0, 15)
lTitleFix.Position = UDim2.new(0, 0, 1, -15)
lTitleFix.BackgroundColor3 = NAVY_DARK
lTitleFix.BorderSizePixel = 0

local LoginTitle = Instance.new("TextLabel")
LoginTitle.Size = UDim2.new(1, 0, 1, 0)
LoginTitle.BackgroundTransparency = 1
LoginTitle.Text = "ورود به پنل XXXXXREDF7"
LoginTitle.TextColor3 = TEXT_COLOR
LoginTitle.Font = Enum.Font.GothamBold
LoginTitle.TextSize = 15
LoginTitle.Parent = LoginTitleBar

-- کادر رمز اول
local Pass1 = Instance.new("TextBox")
Pass1.Size = UDim2.new(0.8, 0, 0, 35)
Pass1.Position = UDim2.new(0.1, 0, 0.3, 0)
Pass1.BackgroundColor3 = BTN_DARK
Pass1.PlaceholderText = "رمز مرحله اول..."
Pass1.Text = ""
Pass1.TextColor3 = TEXT_COLOR
Pass1.PlaceholderColor3 = Color3.fromRGB(150, 150, 160)
Pass1.Font = Enum.Font.Gotham
Pass1.TextSize = 14
Pass1.ClearTextOnFocus = false
Pass1.Parent = LoginFrame

local p1Corner = Instance.new("UICorner", Pass1)
p1Corner.CornerRadius = UDim.new(0, 8)

-- کادر رمز دوم
local Pass2 = Instance.new("TextBox")
Pass2.Size = UDim2.new(0.8, 0, 0, 35)
Pass2.Position = UDim2.new(0.1, 0, 0.5, 0)
Pass2.BackgroundColor3 = BTN_DARK
Pass2.PlaceholderText = "رمز مرحله دوم..."
Pass2.Text = ""
Pass2.TextColor3 = TEXT_COLOR
Pass2.PlaceholderColor3 = Color3.fromRGB(150, 150, 160)
Pass2.Font = Enum.Font.Gotham
Pass2.TextSize = 14
Pass2.ClearTextOnFocus = false
Pass2.Parent = LoginFrame

local p2Corner = Instance.new("UICorner", Pass2)
p2Corner.CornerRadius = UDim.new(0, 8)

-- دکمه ورود
local LoginBtn = Instance.new("TextButton")
LoginBtn.Size = UDim2.new(0.8, 0, 0, 35)
LoginBtn.Position = UDim2.new(0.1, 0, 0.72, 0)
LoginBtn.BackgroundColor3 = SUCCESS
LoginBtn.Text = "تایید و ورود"
LoginBtn.TextColor3 = TEXT_COLOR
LoginBtn.Font = Enum.Font.GothamBold
LoginBtn.TextSize = 14
LoginBtn.AutoButtonColor = false
LoginBtn.Parent = LoginFrame

local lBtnCorner = Instance.new("UICorner", LoginBtn)
lBtnCorner.CornerRadius = UDim.new(0, 8)

-- خطای لاگین
local ErrorLbl = Instance.new("TextLabel")
ErrorLbl.Size = UDim2.new(1, 0, 0, 20)
ErrorLbl.Position = UDim2.new(0, 0, 0.9, 0)
ErrorLbl.BackgroundTransparency = 1
ErrorLbl.Text = ""
ErrorLbl.TextColor3 = DANGER
ErrorLbl.Font = Enum.Font.GothamBold
ErrorLbl.TextSize = 12
ErrorLbl.Parent = LoginFrame

-- درگ کردن صفحه لاگین
local loginDrag = nil
LoginTitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        loginDrag = {startPos = LoginFrame.Position, startInput = input.Position}
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if loginDrag and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - loginDrag.startInput
        LoginFrame.Position = UDim2.new(
            loginDrag.startPos.X.Scale, loginDrag.startPos.X.Offset + delta.X,
            loginDrag.startPos.Y.Scale, loginDrag.startPos.Y.Offset + delta.Y
        )
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        loginDrag = nil
    end
end)

SendChatMessage("رمز پنل رو وارد کنید")

-- منطق تایید رمز
LoginBtn.MouseButton1Click:Connect(function()
    if Pass1.Text == "1212" and Pass2.Text == "7890" then
        -- رمز صحیح
        SendChatMessage("پنل باز شد✅")
        LoginGui:Destroy()
        
        -- ==========================================
        -- ⚙️ شروع کدهای اصلی رینگ (بعد از لاگین)
        -- ==========================================
        
        local Folder = Instance.new("Folder", Workspace)
        local Part = Instance.new("Part", Folder)
        local Attachment1 = Instance.new("Attachment", Part)
        Part.Anchored = true
        Part.CanCollide = false
        Part.Transparency = 1

        if not getgenv().Network then
            getgenv().Network = {
                BaseParts = {},
                Velocity = Vector3.new(14.46262424, 14.46262424, 14.46262424)
            }

            Network.RetainPart = function(Part)
                if typeof(Part) == "Instance" and Part:IsA("BasePart") and Part:IsDescendantOf(Workspace) then
                    table.insert(Network.BaseParts, Part)
                    Part.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
                    Part.CanCollide = false
                end
            end

            local function EnablePartControl()
                LocalPlayer.ReplicationFocus = Workspace
                RunService.Heartbeat:Connect(function()
                    pcall(function() sethiddenproperty(LocalPlayer, "SimulationRadius", math.huge) end)
                    for _, Part in pairs(Network.BaseParts) do
                        if Part:IsDescendantOf(Workspace) then
                            Part.Velocity = Network.Velocity
                        end
                    end
                end)
            end
            EnablePartControl()
        end

        local radius = 50
        local height = 100
        local rotationSpeed = 0.5
        local attractionStrength = 1000
        local ringPartsEnabled = false

        local function RetainPart(Part)
            if Part:IsA("BasePart") and not Part.Anchored and Part:IsDescendantOf(Workspace) then
                if Part.Parent == LocalPlayer.Character or Part:IsDescendantOf(LocalPlayer.Character) then
                    return false
                end
                Part.CustomPhysicalProperties = PhysicalProperties.new(0, 0, 0, 0, 0)
                Part.CanCollide = false
                return true
            end
            return false
        end

        local parts = {}
        local function addPart(part)
            if RetainPart(part) and not table.find(parts, part) then
                table.insert(parts, part)
            end
        end

        local function removePart(part)
            local index = table.find(parts, part)
            if index then table.remove(parts, index) end
        end

        for _, part in pairs(Workspace:GetDescendants()) do addPart(part) end
        Workspace.DescendantAdded:Connect(addPart)
        Workspace.DescendantRemoving:Connect(removePart)

        RunService.Heartbeat:Connect(function()
            if not ringPartsEnabled then return end
            local humanoidRootPart = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if humanoidRootPart then
                local tornadoCenter = humanoidRootPart.Position
                for _, part in pairs(parts) do
                    if part.Parent and not part.Anchored then
                        local pos = part.Position
                        local distance = (Vector3.new(pos.X, tornadoCenter.Y, pos.Z) - tornadoCenter).Magnitude
                        local angle = math.atan2(pos.Z - tornadoCenter.Z, pos.X - tornadoCenter.X)
                        local newAngle = angle + math.rad(rotationSpeed)
                        local targetPos = Vector3.new(
                            tornadoCenter.X + math.cos(newAngle) * math.min(radius, distance),
                            tornadoCenter.Y + (height * (math.abs(math.sin((pos.Y - tornadoCenter.Y) / height)))),
                            tornadoCenter.Z + math.sin(newAngle) * math.min(radius, distance)
                        )
                        local directionToTarget = (targetPos - part.Position).unit
                        part.Velocity = directionToTarget * attractionStrength
                    end
                end
            end
        end)

        -- ==========================================
        -- 🎨 رابط کاربری پنل رینگ
        -- ==========================================
        local ScreenGui = Instance.new("ScreenGui")
        ScreenGui.Name = "XXXXXREDF7RingPanel"
        ScreenGui.ResetOnSpawn = false
        ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

        local FloatingBtn = Instance.new("TextButton")
        FloatingBtn.Size = UDim2.new(0, 55, 0, 55)
        FloatingBtn.Position = UDim2.new(0, 20, 0.4, 0)
        FloatingBtn.BackgroundColor3 = NAVY
        FloatingBtn.Text = "✈"
        FloatingBtn.TextColor3 = TEXT_COLOR
        FloatingBtn.Font = Enum.Font.GothamBold
        FloatingBtn.TextSize = 28
        FloatingBtn.AutoButtonColor = false
        FloatingBtn.BorderSizePixel = 0
        FloatingBtn.Parent = ScreenGui

        local floatCorner = Instance.new("UICorner", FloatingBtn)
        floatCorner.CornerRadius = UDim.new(1, 0)

        local floatStroke = Instance.new("UIStroke", FloatingBtn)
        floatStroke.Color = ACCENT
        floatStroke.Thickness = 2

        FloatingBtn.MouseEnter:Connect(function()
            TweenService:Create(FloatingBtn, TweenInfo.new(0.2, Enum.EasingStyle.Back), {Size = UDim2.new(0, 60, 0, 60), BackgroundColor3 = ACCENT}):Play()
        end)
        FloatingBtn.MouseLeave:Connect(function()
            TweenService:Create(FloatingBtn, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {Size = UDim2.new(0, 55, 0, 55), BackgroundColor3 = NAVY}):Play()
        end)

        local MainFrame = Instance.new("Frame")
        MainFrame.Size = UDim2.new(0, 260, 0, 240)
        MainFrame.Position = UDim2.new(0.5, -130, 0.5, -120)
        MainFrame.BackgroundColor3 = NAVY
        MainFrame.BorderSizePixel = 0
        MainFrame.Visible = false
        MainFrame.ClipsDescendants = true
        MainFrame.Parent = ScreenGui

        local mainCorner = Instance.new("UICorner", MainFrame)
        mainCorner.CornerRadius = UDim.new(0, 15)

        local mainStroke = Instance.new("UIStroke", MainFrame)
        mainStroke.Color = ACCENT
        mainStroke.Thickness = 2

        local TitleBar = Instance.new("Frame")
        TitleBar.Size = UDim2.new(1, 0, 0, 45)
        TitleBar.BackgroundColor3 = NAVY_DARK
        TitleBar.BorderSizePixel = 0
        TitleBar.Parent = MainFrame

        local titleCorner = Instance.new("UICorner", TitleBar)
        titleCorner.CornerRadius = UDim.new(0, 15)

        local titleFix = Instance.new("Frame", TitleBar)
        titleFix.Size = UDim2.new(1, 0, 0, 15)
        titleFix.Position = UDim2.new(0, 0, 1, -15)
        titleFix.BackgroundColor3 = NAVY_DARK
        titleFix.BorderSizePixel = 0

        local Title = Instance.new("TextLabel")
        Title.Size = UDim2.new(1, -60, 1, 0)
        Title.Position = UDim2.new(0, 15, 0, 0)
        Title.Text = "پنل رینگ XXXXXREDF7"
        Title.TextColor3 = TEXT_COLOR
        Title.BackgroundTransparency = 1
        Title.Font = Enum.Font.GothamBold
        Title.TextSize = 15
        Title.TextXAlignment = Enum.TextXAlignment.Left
        Title.Parent = TitleBar

        local CloseBtn = Instance.new("TextButton")
        CloseBtn.Size = UDim2.new(0, 30, 0, 30)
        CloseBtn.Position = UDim2.new(1, -38, 0, 7)
        CloseBtn.BackgroundColor3 = DANGER
        CloseBtn.Text = "X"
        CloseBtn.TextColor3 = TEXT_COLOR
        CloseBtn.Font = Enum.Font.GothamBold
        CloseBtn.TextSize = 14
        CloseBtn.AutoButtonColor = false
        CloseBtn.Parent = TitleBar

        local closeCorner = Instance.new("UICorner", CloseBtn)
        closeCorner.CornerRadius = UDim.new(0, 8)

        local ToggleButton = Instance.new("TextButton")
        ToggleButton.Size = UDim2.new(0.85, 0, 0, 40)
        ToggleButton.Position = UDim2.new(0.075, 0, 0.24, 0)
        ToggleButton.BackgroundColor3 = BTN_DARK
        ToggleButton.Text = "رینگ خاموش است"
        ToggleButton.TextColor3 = TEXT_COLOR
        ToggleButton.Font = Enum.Font.GothamBold
        ToggleButton.TextSize = 14
        ToggleButton.AutoButtonColor = false
        ToggleButton.Parent = MainFrame

        local toggleCorner = Instance.new("UICorner", ToggleButton)
        toggleCorner.CornerRadius = UDim.new(0, 10)

        local toggleStroke = Instance.new("UIStroke", ToggleButton)
        toggleStroke.Color = ACCENT
        toggleStroke.Thickness = 1
        toggleStroke.Transparency = 0.5

        local DecreaseRadius = Instance.new("TextButton")
        DecreaseRadius.Size = UDim2.new(0.2, 0, 0, 40)
        DecreaseRadius.Position = UDim2.new(0.075, 0, 0.56, 0)
        DecreaseRadius.BackgroundColor3 = BTN_DARK
        DecreaseRadius.Text = "-"
        DecreaseRadius.TextColor3 = TEXT_COLOR
        DecreaseRadius.Font = Enum.Font.GothamBold
        DecreaseRadius.TextSize = 20
        DecreaseRadius.AutoButtonColor = false
        DecreaseRadius.Parent = MainFrame

        local decCorner = Instance.new("UICorner", DecreaseRadius)
        decCorner.CornerRadius = UDim.new(0, 10)

        local IncreaseRadius = Instance.new("TextButton")
        IncreaseRadius.Size = UDim2.new(0.2, 0, 0, 40)
        IncreaseRadius.Position = UDim2.new(0.725, 0, 0.56, 0)
        IncreaseRadius.BackgroundColor3 = BTN_DARK
        IncreaseRadius.Text = "+"
        IncreaseRadius.TextColor3 = TEXT_COLOR
        IncreaseRadius.Font = Enum.Font.GothamBold
        IncreaseRadius.TextSize = 20
        IncreaseRadius.AutoButtonColor = false
        IncreaseRadius.Parent = MainFrame

        local incCorner = Instance.new("UICorner", IncreaseRadius)
        incCorner.CornerRadius = UDim.new(0, 10)

        local RadiusDisplay = Instance.new("TextLabel")
        RadiusDisplay.Size = UDim2.new(0.4, 0, 0, 40)
        RadiusDisplay.Position = UDim2.new(0.3, 0, 0.56, 0)
        RadiusDisplay.BackgroundColor3 = NAVY_DARK
        RadiusDisplay.Text = "شعاع: 50"
        RadiusDisplay.TextColor3 = TEXT_COLOR
        RadiusDisplay.Font = Enum.Font.GothamBold
        RadiusDisplay.TextSize = 14
        RadiusDisplay.Parent = MainFrame

        local radCorner = Instance.new("UICorner", RadiusDisplay)
        radCorner.CornerRadius = UDim.new(0, 10)

        local Watermark = Instance.new("TextLabel")
        Watermark.Size = UDim2.new(1, 0, 0, 20)
        Watermark.Position = UDim2.new(0, 0, 1, -25)
        Watermark.Text = "Super Ring V5 | Redesigned by XXXXXREDF7"
        Watermark.TextColor3 = Color3.fromRGB(150, 170, 220)
        Watermark.BackgroundTransparency = 1
        Watermark.Font = Enum.Font.Gotham
        Watermark.TextSize = 11
        Watermark.Parent = MainFrame

        -- انیمیشن‌ها
        local function addHover(btn, normalColor, hoverColor)
            btn.MouseEnter:Connect(function()
                TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = hoverColor}):Play()
            end)
            btn.MouseLeave:Connect(function()
                TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = normalColor}):Play()
            end)
        end

        addHover(CloseBtn, DANGER, Color3.fromRGB(220, 60, 60))
        addHover(DecreaseRadius, BTN_DARK, ACCENT)
        addHover(IncreaseRadius, BTN_DARK, ACCENT)

        local function toggleMenu()
            if MainFrame.Visible then
                local tween = TweenService:Create(MainFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {
                    Size = UDim2.new(0, 0, 0, 0),
                    Position = UDim2.new(0.5, 0, 0.5, 0)
                })
                tween:Play()
                tween.Completed:Wait()
                MainFrame.Visible = false
            else
                MainFrame.Visible = true
                MainFrame.Size = UDim2.new(0, 0, 0, 0)
                MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
                TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
                    Size = UDim2.new(0, 260, 0, 240),
                    Position = UDim2.new(0.5, -130, 0.5, -120)
                }):Play()
            end
        end

        FloatingBtn.MouseButton1Click:Connect(toggleMenu)
        CloseBtn.MouseButton1Click:Connect(toggleMenu)

        ToggleButton.MouseButton1Click:Connect(function()
            ringPartsEnabled = not ringPartsEnabled
            if ringPartsEnabled then
                TweenService:Create(ToggleButton, TweenInfo.new(0.2), {BackgroundColor3 = SUCCESS}):Play()
                ToggleButton.Text = "رینگ روشن است"
            else
                TweenService:Create(ToggleButton, TweenInfo.new(0.2), {BackgroundColor3 = BTN_DARK}):Play()
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

        local activeDrag = nil
        local function setupDrag(frame, handle)
            handle.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    activeDrag = {frame = frame, s
