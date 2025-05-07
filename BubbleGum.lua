-- Load Wind UI safely
local success, WindUI = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/refs/heads/main/main.lua"))()
end)

if not success or not WindUI then
    warn("❌ Failed to load Wind UI. Please check the URL or your internet connection.")
    return
end

-- Create the main window with mobile size
local Window = WindUI:CreateWindow({
    Title = "WindUI | PieXHub",
    Icon = "door-open",
    Author = "PieX",
    Folder = "PieXHub",
    Size = UDim2.fromOffset(360, 640), -- Mobile size
    Transparent = true,
    Theme = "Dark",
    User = {
        Enabled = true,
        Callback = function() print("User clicked") end,
        Anonymous = true
    },
    SideBarWidth = 200,
    HasOutline = true,
})

-- ✅ Create Main Tab
local MainTab = Window:Tab({ Title = "Main", Icon = "type" })

-- ✅ Auto Blow Toggle
getgenv().AutoBlow = false
MainTab:Toggle({
    Title = "Auto Blow",
    Description = "Automatically blows bubble",
    Default = false,
    Callback = function(Value)
        getgenv().AutoBlow = Value
        task.spawn(function()
            while getgenv().AutoBlow do
                task.wait(0.1)
                pcall(function()
                    game:GetService("ReplicatedStorage").Events.BubbleEvent:FireServer("Blow")
                end)
            end
        end)
    end
})

-- ✅ Auto Sell Toggle
getgenv().AutoSell = false
MainTab:Toggle({
    Title = "Auto Sell (Bypass)",
    Description = "Teleport to sell area to bypass auto sell",
    Default = false,
    Callback = function(Value)
        getgenv().AutoSell = Value
        task.spawn(function()
            while getgenv().AutoSell do
                task.wait(0.5)
                pcall(function()
                    local sellArea = workspace:FindFirstChild("SellArea") or workspace:FindFirstChildWhichIsA("Part", true)
                    if sellArea then
                        game.Players.LocalPlayer.Character:PivotTo(sellArea.CFrame + Vector3.new(0, 3, 0))
                    end
                end)
            end
        end)
    end
})

-- ✅ Show the UI
Window:Show()
