-- Load Wind UI safely
local success, WindUI = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/refs/heads/main/main.lua"))()
end)

if not success or not WindUI then
    warn("❌ Failed to load Wind UI. Please check the URL or your internet connection.")
    return
end

-- Function to create a gradient text
function gradient(text, startColor, endColor)
    local result = ""
    local length = #text
    for i = 1, length do
        local t = (i - 1) / math.max(length - 1, 1)
        local r = math.floor((startColor.R + (endColor.R - startColor.R) * t) * 255)
        local g = math.floor((startColor.G + (endColor.G - startColor.G) * t) * 255)
        local b = math.floor((startColor.B + (endColor.B - startColor.B) * t) * 255)
        local char = text:sub(i, i)
        result = result .. string.format("<font color='rgb(%d,%d,%d)'>%s</font>", r, g, b, char)
    end
    return result
end

-- Welcome Popup
local Confirmed = false
WindUI:Popup({
    Title = "Welcome!",
    Icon = "info",
    Content = "Welcome to the Bubble Gum Simulator Infinity!",
    Buttons = {
        { Title = "Cancel", Callback = function() end, Variant = "Tertiary" },
        { Title = "Continue", Icon = "arrow-right", Callback = function() Confirmed = true end, Variant = "Primary" }
    }
})

repeat wait() until Confirmed

-- Create the main window
local Window = WindUI:CreateWindow({
    Title = "Bubble Gum Simulator Infinity",
    Icon = "door-open",
    Author = "Your Name",
    Folder = "CloudHub",
    Size = UDim2.fromOffset(580, 460),
    Transparent = true,
    Theme = "Dark",
    UserEnabled = false,
    SideBarWidth = 200,
    URL = "https://github.com/Footagesus/WindUI",
    SaveKey = false,
})

-- Create Main Tab
local MainTab = Window:CreateTab("Main")

-- Auto Blow Toggle
local AutoBlow = false
MainTab:CreateToggle("Auto Blow", function(state)
    AutoBlow = state
    task.spawn(function()
        while AutoBlow do
            task.wait(0.1)
            pcall(function()
                game:GetService("ReplicatedStorage").Events.BubbleEvent:FireServer("Blow")
            end)
        end
    end)
end)

-- Auto Sell Toggle
MainTab:CreateToggle("Auto Sell (Bypass)", function(state)
    task.spawn(function()
        while state do
            task.wait(0.5)
            pcall(function()
                local sellArea = workspace:FindFirstChild("SellArea") or workspace:FindFirstChildWhichIsA("Part", true)
                if sellArea then
                    game.Players.LocalPlayer.Character:PivotTo(sellArea.CFrame + Vector3.new(0, 3, 0))
                end
            end)
        end
    end)
end)

-- Show the UI
Window:Show()
