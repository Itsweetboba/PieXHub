-- Load Rayfield UI safely
local success, Rayfield = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/yourusername/Rayfield/main/source.lua"))()
end)

if not success or not Rayfield then
    warn("❌ Failed to load Rayfield UI. Please check the URL or your internet connection.")
    return
end

-- Create the main window
local Window = Rayfield:CreateWindow("Bubble Gum Simulator Infinity")

-- Main Tab
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
Rayfield:Show()
