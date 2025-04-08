local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local mouse = player:GetMouse()

-- Create the main screen GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Parent = playerGui

-- Create the main menu frame
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 300, 0, 400)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
mainFrame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
mainFrame.Parent = screenGui

-- Add title to the menu
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 50)
title.Position = UDim2.new(0, 0, 0, 0)
title.Text = "Made by Astro👑 v1"
title.TextSize = 30
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.BackgroundTransparency = 1
title.Parent = mainFrame

-- Function to add a button to the menu
local function createButton(name, func)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 0, 50)
    button.Text = name
    button.TextSize = 20
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    button.Parent = mainFrame
    
    button.MouseButton1Click:Connect(func)
end

-- ESP Feature: Draws a box around players
local function createESP(player)
    local highlight = Instance.new("Highlight")
    highlight.Parent = player.Character
    highlight.Adornee = player.Character
    highlight.FillColor = Color3.fromRGB(255, 0, 0)
    highlight.OutlineColor = Color3.fromRGB(0, 0, 0)
end

-- Toggle ESP
createButton("Toggle ESP", function()
    for _, plr in pairs(game.Players:GetChildren()) do
        if plr.Character and plr.Character:FindFirstChild("Head") then
            if not plr.Character:FindFirstChild("Highlight") then
                createESP(plr)
            end
        end
    end
end)

-- NoClip Feature: Allows the player to walk through walls
local noclipEnabled = false
local function toggleNoClip()
    noclipEnabled = not noclipEnabled
    local character = player.Character
    if character then
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.PlatformStand = noclipEnabled
        end

        -- Make sure the character doesn't collide with walls
        for _, part in pairs(character:GetChildren()) do
            if part:IsA("BasePart") then
                part.CanCollide = not noclipEnabled
            end
        end
    end
end

-- NoClip Button
createButton("Toggle NoClip", function()
    toggleNoClip()
end)

-- Fly Feature: Lets the player fly by adding a BodyVelocity
local flying = false
local bodyVelocity = nil

local function toggleFly()
    flying = not flying
    local character = player.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        if flying then
            -- Start flying
            bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.MaxForce = Vector3.new(400000, 400000, 400000)
            bodyVelocity.Velocity = Vector3.new(0, 50, 0)
            bodyVelocity.Parent = character:FindFirstChild("HumanoidRootPart")
        else
            -- Stop flying
            if bodyVelocity then
                bodyVelocity:Destroy()
            end
        end
    end
end

-- Fly Button
createButton("Toggle Fly", function()
    toggleFly()
end)

-- Function to teleport the player to a specific location
local function teleportPlayerToLocation()
    local character = player.Character
    if character and character:FindFirstChild("HumanoidRootPart") then
        local targetPosition = Vector3.new(100, 50, 100)  -- Replace with your desired coordinates
        character.HumanoidRootPart.CFrame = CFrame.new(targetPosition)
    end
end

-- Teleport Button
createButton("Teleport to Location", function()
    teleportPlayerToLocation()
end)

-- Extra functionality: Teleport to random location (as an example)
createButton("Teleport to Random Location", function()
    local randomPosition = Vector3.new(math.random(-50, 50), 50, math.random(-50, 50))
    local character = player.Character
    if character then
        character:SetPrimaryPartCFrame(CFrame.new(randomPosition))
    end
end)