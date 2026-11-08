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
-- 🎨 پالت رنگ‌ها (مشترک برای لاگین و پنل)
-- ==========================================
local NAVY = Color3.fromRGB(0, 0, 128)         -- #000080
local NAVY_DARK = Color3.fromRGB(0, 0, 80)     
local BTN_DARK = Color3.fromRGB(0, 0, 60)      
local ACCENT = Color3.fromRGB(50, 80, 200)     
local TEXT_COLOR = Color3.fromRGB(240, 245, 255)
local DANGER = Color3.fromRGB(180, 40, 40)
local SUCCESS = Color3.fromRGB(40, 160, 80)

-- ==========================================
-- 📢 تابع ارسال پیام در چت
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
SendChatMessage("پنل XXXXXREDF7 توسط من درحال اجرا هست!")

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

-- پیام چت برای درخواست رمز
SendChatMessage("رمز پنل XXXXXREDF7 رو وارد کنید")

-- منطق تایید رمز
LoginBtn.MouseButton1Click:Connect(function()
    if Pass1.Text == "1212" and Pass2.Text == "7890" then
        -- رمز صحیح
        SendChatMessage("پنل باز شد✅")
        LoginGui:Destroy()
        
        -- اجرای ادامه اسکریپت (پنل اصلی)
        loadstring(game:HttpGet("https://raw.githubusercontent.com/sanammoradii1399-bot/MyScripts/refs/heads/main/myscript.lua", true))() 
        -- ⚠️ نکته: اگر این کد در همان فایلی است که آپلود کردی، خط بالا را حذف کن و کدهای زیر (از بخش "تنظیمات و منطق شبکه") را مستقیماً در همین جا قرار بده.
        
    else
        -- رمز اشتباه
        ErrorLbl.Text = "رمز اشتباه است! دوباره تلاش کنید."
        Pass1.Text = ""
        Pass2.Text = ""
        TweenService:Create(LoginFrame, TweenInfo.new(0.1), {Position = UDim2.new(0.5, -125, 0.5, -100)}):Play()
        task.wait(0.1)
        TweenService:Create(LoginFrame, TweenInfo.new(0.1), {Position = UDim2.new(0.5, -135, 0.5, -100)}):Play()
        task.wait(0.1)
        TweenService:Create(LoginFrame, TweenInfo.new(0.1), {Position = UDim2.new(0.5, -130, 0.5, -100)}):Play()
    end
end)

-- افکت هاور برای دکمه ورود
LoginBtn.MouseEnter:Connect(function()
    TweenService:Create(LoginBtn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(60, 180, 100)}):Play()
end)
LoginBtn.MouseLeave:Connect(function()
    TweenService:Create(LoginBtn, TweenInfo.new(0.15), {BackgroundColor3 = SUCCESS}):Play()
end)

-- ==========================================
-- ⚙️ تنظیمات و منطق شبکه (Universal Part Claim)
-- این بخش دقیقاً همان کدهای قبلی شماست
-- ==========================================
--[[ 
    👇 توجه: 
    از آنجایی که کد اصلی شما برای عملکرد رینگ به فیزیک وابسته است، 
    بقیه کدهای مربوط به فیزیک و رینگ (از خط "local Folder = Instance.new..." تا انتهای کد) 
    را باید دقیقاً در همین جا (زیر این خط) قرار بدهید تا بعد از تایید رمز اجرا شوند.
]]
