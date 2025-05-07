-- Load Wind UI safely
local success, WindLib = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/ItzJustDev/Wind/main/Source.lua"))()
end)

if not success or not WindLib then
    warn("❌ Failed to load Wind UI. Please check the URL or your internet connection.")
    return
end

print("Wind UI loaded successfully.")

-- Create the main window
local Window = WindLib:CreateWindow("Bubble Gum Simulator Infinity", {
    main_color = Color3.fromRGB(80, 120, 255),
    min_size = Vector2.new(450, 350),
    toggle_key = Enum.KeyCode.RightShift,
    can_resize = true
})

print("Main window created.")

-- Main Tab
local MainTab = Window:CreateTab("Main")
print("Main tab created.")

-- Auto Blow Toggle
local AutoBlow = false
MainTab:CreateToggle("Auto Blow", function(state)
    AutoBlow = state
    print("Auto Blow state changed to: " .. tostring(state))
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
    print("Auto Sell state changed to: " .. tostring(state))
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

-- Ensure the UI is visible
Window:Show()
print("UI should now be visible.")
