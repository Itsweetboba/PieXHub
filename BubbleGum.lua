-- Load Wind UI from the official GitHub repository
local success, Wind = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/refs/heads/main/Example.lua"))()
end)

if not success then
    warn("❌ Failed to load Wind UI!")
    return
end

print("✅ Wind UI loaded successfully!")

-- Create the main window
local Window = Wind:CreateWindow("Bubble Gum Simulator Infinity", {
    main_color = Color3.fromRGB(80, 120, 255),
    min_size = Vector2.new(450, 350),
    toggle_key = Enum.KeyCode.RightShift,
    can_resize = true
})

if not Window then
    warn("❌ Failed to create Window.")
    return
end

print("✅ Window created.")

-- Create the Main tab
local MainTab = Window:CreateTab("Main")

if not MainTab then
    warn("❌ Failed to create MainTab.")
    return
end

print("✅ MainTab created.")

-- Test label
MainTab:CreateLabel("Main tab loaded")

-- Auto Blow Toggle
local AutoBlow = false
MainTab:CreateToggle("Auto Blow", function(state)
    print("Auto Blow toggle clicked:", state)
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

-- Auto Sell Toggle (Bypass)
MainTab:CreateToggle("Auto Sell (Bypass)", function(state)
    print("Auto Sell toggle clicked:", state)
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
