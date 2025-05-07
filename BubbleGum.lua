-- Load Wind UI from the official GitHub repository
local WindUI = loadstring(game:HttpGet("https://tree-hub.vercel.app/api/UI/WindUI"))()

-- Create the main window
local Window = Wind:CreateWindow("Bubble Gum Simulator Infinity", {
    main_color = Color3.fromRGB(80, 120, 255),
    min_size = Vector2.new(450, 350),
    toggle_key = Enum.KeyCode.RightShift,
    can_resize = true
})

-- Create the Main tab
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
