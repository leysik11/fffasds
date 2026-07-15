-- ============================================
-- FLY HUNTER - MAIN SCRIPT
-- ============================================

local player = game.Players.LocalPlayer
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "FlyGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = player:WaitForChild("PlayerGui")

-- ============================================
-- CREATE MAIN FRAME
-- ============================================

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 320, 0, 600)
Frame.Position = UDim2.new(0, 20, 0.5, -300)
Frame.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
Frame.BackgroundTransparency = 0.2
Frame.Active = true
Frame.Draggable = true
Frame.Parent = ScreenGui

-- ============================================
-- CLOSE BUTTON
-- ============================================

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -35, 0, 2)
CloseButton.Text = "✕"
CloseButton.BackgroundColor3 = Color3.new(1, 0, 0)
CloseButton.BackgroundTransparency = 0.3
CloseButton.TextColor3 = Color3.new(1, 1, 1)
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.TextSize = 18
CloseButton.Parent = Frame

-- ============================================
-- TITLE
-- ============================================

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -40, 0, 30)
TitleLabel.Position = UDim2.new(0, 5, 0, 0)
TitleLabel.Text = "Игроки на сервере"
TitleLabel.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
TitleLabel.TextColor3 = Color3.new(1, 1, 1)
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.TextSize = 16
TitleLabel.Parent = Frame

-- ============================================
-- PLAYER LIST
-- ============================================

local PlayerList = Instance.new("ScrollingFrame")
PlayerList.Size = UDim2.new(1, -10, 1, -240)
PlayerList.Position = UDim2.new(0, 5, 0, 35)
PlayerList.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
PlayerList.BackgroundTransparency = 0.5
PlayerList.ScrollBarThickness = 8
PlayerList.ScrollBarImageColor3 = Color3.new(0.5, 0.5, 0.5)
PlayerList.CanvasSize = UDim2.new(0, 0, 0, 0)
PlayerList.Parent = Frame

-- ============================================
-- BUTTON PANEL
-- ============================================

local ButtonFrame = Instance.new("Frame")
ButtonFrame.Size = UDim2.new(1, 0, 0, 240)
ButtonFrame.Position = UDim2.new(0, 0, 1, -240)
ButtonFrame.BackgroundTransparency = 1
ButtonFrame.Parent = Frame

-- FLY BUTTON
local FlyButton = Instance.new("TextButton")
FlyButton.Size = UDim2.new(1, -10, 0, 40)
FlyButton.Position = UDim2.new(0, 5, 0, 0)
FlyButton.Text = "✈️ Fly to player"
FlyButton.BackgroundColor3 = Color3.new(0, 0.5, 1)
FlyButton.TextColor3 = Color3.new(1, 1, 1)
FlyButton.Font = Enum.Font.SourceSansBold
FlyButton.TextSize = 14
FlyButton.Parent = ButtonFrame

-- STOP BUTTON
local StopButton = Instance.new("TextButton")
StopButton.Size = UDim2.new(1, -10, 0, 35)
StopButton.Position = UDim2.new(0, 5, 0, 45)
StopButton.Text = "🛑 STOP"
StopButton.BackgroundColor3 = Color3.new(1, 0, 0)
StopButton.TextColor3 = Color3.new(1, 1, 1)
StopButton.Font = Enum.Font.SourceSansBold
StopButton.TextSize = 14
StopButton.Parent = ButtonFrame

-- NEAREST BUTTON
local NearestButton = Instance.new("TextButton")
NearestButton.Size = UDim2.new(0.48, -5, 0, 30)
NearestButton.Position = UDim2.new(0, 5, 0, 85)
NearestButton.Text = "🎯 Nearest"
NearestButton.BackgroundColor3 = Color3.new(0.8, 0.4, 0)
NearestButton.TextColor3 = Color3.new(1, 1, 1)
NearestButton.Font = Enum.Font.SourceSansBold
NearestButton.TextSize = 12
NearestButton.Parent = ButtonFrame

-- AUTO TARGET BUTTON
local AutoTargetButton = Instance.new("TextButton")
AutoTargetButton.Size = UDim2.new(0.48, -5, 0, 30)
AutoTargetButton.Position = UDim2.new(0.52, 5, 0, 85)
AutoTargetButton.Text = "🔄 Auto-target"
AutoTargetButton.BackgroundColor3 = Color3.new(0.5, 0, 0.5)
AutoTargetButton.TextColor3 = Color3.new(1, 1, 1)
AutoTargetButton.Font = Enum.Font.SourceSansBold
AutoTargetButton.TextSize = 12
AutoTargetButton.Parent = ButtonFrame

-- ESP BUTTON
local ESPButton = Instance.new("TextButton")
ESPButton.Size = UDim2.new(0.48, -5, 0, 25)
ESPButton.Position = UDim2.new(0, 5, 0, 120)
ESPButton.Text = "👁️ ESP OFF"
ESPButton.BackgroundColor3 = Color3.new(0.6, 0, 0.8)
ESPButton.TextColor3 = Color3.new(1, 1, 1)
ESPButton.Font = Enum.Font.SourceSansBold
ESPButton.TextSize = 11
ESPButton.Parent = ButtonFrame

-- SPEED SETTINGS
local SpeedLabel = Instance.new("TextLabel")
SpeedLabel.Size = UDim2.new(0.48, -5, 0, 20)
SpeedLabel.Position = UDim2.new(0, 5, 0, 150)
SpeedLabel.Text = "Speed: 150"
SpeedLabel.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
SpeedLabel.BackgroundTransparency = 0.3
SpeedLabel.TextColor3 = Color3.new(1, 1, 1)
SpeedLabel.Font = Enum.Font.SourceSans
SpeedLabel.TextSize = 11
SpeedLabel.Parent = ButtonFrame

local SpeedInput = Instance.new("TextBox")
SpeedInput.Size = UDim2.new(0.48, -5, 0, 20)
SpeedInput.Position = UDim2.new(0.52, 5, 0, 150)
SpeedInput.Text = "150"
SpeedInput.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
SpeedInput.TextColor3 = Color3.new(1, 1, 1)
SpeedInput.Font = Enum.Font.SourceSans
SpeedInput.TextSize = 12
SpeedInput.Parent = ButtonFrame

-- ATTACK DISTANCE SETTINGS
local DistLabel = Instance.new("TextLabel")
DistLabel.Size = UDim2.new(0.48, -5, 0, 20)
DistLabel.Position = UDim2.new(0, 5, 0, 174)
DistLabel.Text = "Attack dist: 10"
DistLabel.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
DistLabel.BackgroundTransparency = 0.3
DistLabel.TextColor3 = Color3.new(1, 1, 1)
DistLabel.Font = Enum.Font.SourceSans
DistLabel.TextSize = 11
DistLabel.Parent = ButtonFrame

local DistInput = Instance.new("TextBox")
DistInput.Size = UDim2.new(0.48, -5, 0, 20)
DistInput.Position = UDim2.new(0.52, 5, 0, 174)
DistInput.Text = "10"
DistInput.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
DistInput.TextColor3 = Color3.new(1, 1, 1)
DistInput.Font = Enum.Font.SourceSans
DistInput.TextSize = 12
DistInput.Parent = ButtonFrame

-- STATUS
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, -10, 0, 20)
StatusLabel.Position = UDim2.new(0, 5, 0, 200)
StatusLabel.Text = "Status: Ready"
StatusLabel.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
StatusLabel.BackgroundTransparency = 0.3
StatusLabel.TextColor3 = Color3.new(1, 1, 1)
StatusLabel.Font = Enum.Font.SourceSans
StatusLabel.TextSize = 12
StatusLabel.Parent = ButtonFrame

-- ============================================
-- ESP SYSTEM
-- ============================================

local espEnabled = false
local espLabels = {}
local espConnection = nil
local healthConnections = {}

local function createESP(plr)
    if plr == player then return nil end
    
    if plr:FindFirstChild("ESP_" .. plr.Name) then
        return plr:FindFirstChild("ESP_" .. plr.Name)
    end
    
    if not plr.Character then return nil end
    
    local label = Instance.new("BillboardGui")
    label.Name = "ESP_" .. plr.Name
    label.Size = UDim2.new(0, 200, 0, 40)
    label.StudsOffset = Vector3.new(0, 3.5, 0)
    label.AlwaysOnTop = true
    label.MaxDistance = 200
    label.Parent = plr.Character
    
    local text = Instance.new("TextLabel")
    text.Size = UDim2.new(1, 0, 0.6, 0)
    text.Position = UDim2.new(0, 0, 0, 0)
    text.BackgroundTransparency = 1
    text.Text = plr.Name
    text.TextColor3 = Color3.fromRGB(180, 50, 255)
    text.TextScaled = true
    text.Font = Enum.Font.GothamBold
    text.TextStrokeTransparency = 0.2
    text.TextStrokeColor3 = Color3.new(0, 0, 0)
    text.Parent = label
    
    local healthBar = Instance.new("Frame")
    healthBar.Size = UDim2.new(1, 0, 0, 4)
    healthBar.Position = UDim2.new(0, 0, 0.7, 2)
    healthBar.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    healthBar.BorderSizePixel = 0
    healthBar.Parent = label
    
    local healthBG = Instance.new("Frame")
    healthBG.Size = UDim2.new(1, 0, 1, 0)
    healthBG.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    healthBG.BorderSizePixel = 0
    healthBG.Parent = healthBar
    
    local distLabel = Instance.new("TextLabel")
    distLabel.Size = UDim2.new(1, 0, 0.3, 0)
    distLabel.Position = UDim2.new(0, 0, 0.6, 0)
    distLabel.BackgroundTransparency = 1
    distLabel.Text = "0m"
    distLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
    distLabel.TextSize = 12
    distLabel.Font = Enum.Font.Gotham
    distLabel.TextStrokeTransparency = 0.3
    distLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
    distLabel.Parent = label
    
    local connection = game:GetService("RunService").Heartbeat:Connect(function()
        if not plr or not plr.Character then return end
        
        local humanoid = plr.Character:FindFirstChild("Humanoid")
        if humanoid then
            local health = humanoid.Health / humanoid.MaxHealth
            healthBar.Size = UDim2.new(math.clamp(health, 0, 1), 0, 0, 4)
            if health > 0.5 then
                healthBar.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
            elseif health > 0.25 then
                healthBar.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
            else
                healthBar.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
            end
        end
        
        local localChar = player.Character
        if localChar then
            local localRoot = localChar:FindFirstChild("HumanoidRootPart")
            local targetRoot = plr.Character:FindFirstChild("HumanoidRootPart")
            if localRoot and targetRoot then
                local dist = (localRoot.Position - targetRoot.Position).Magnitude
                distLabel.Text = math.floor(dist) .. "m"
                if dist <= 10 then
                    distLabel.TextColor3 = Color3.fromRGB(255, 50, 50)
                elseif dist <= 30 then
                    distLabel.TextColor3 = Color3.fromRGB(255, 200, 50)
                else
                    distLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
                end
            end
        end
    end)
    
    table.insert(healthConnections, connection)
    return label
end

local function updateESP()
    for _, label in ipairs(espLabels) do
        pcall(function() label:Destroy() end)
    end
    espLabels = {}
    
    for _, conn in ipairs(healthConnections) do
        pcall(function() conn:Disconnect() end)
    end
    healthConnections = {}
    
    if not espEnabled then return end
    
    for _, plr in ipairs(game.Players:GetPlayers()) do
        if plr ~= player and plr.Character then
            local label = createESP(plr)
            if label then
                table.insert(espLabels, label)
            end
        end
    end
end

local function enableESP()
    if espEnabled then return end
    espEnabled = true
    updateESP()
    
    if espConnection then
        espConnection:Disconnect()
        espConnection = nil
    end
    
    espConnection = game.Players.PlayerAdded:Connect(function(plr)
        task.wait(0.5)
        if espEnabled and plr.Character then
            local label = createESP(plr)
            if label then
                table.insert(espLabels, label)
            end
        end
    end)
    
    for _, plr in ipairs(game.Players:GetPlayers()) do
        if plr ~= player then
            plr.CharacterAdded:Connect(function(character)
                task.wait(0.5)
                if espEnabled then
                    if plr:FindFirstChild("ESP_" .. plr.Name) then
                        plr:FindFirstChild("ESP_" .. plr.Name):Destroy()
                    end
                    local label = createESP(plr)
                    if label then
                        table.insert(espLabels, label)
                    end
                end
            end)
        end
    end
    
    StatusLabel.Text = "Status: ESP ON"
    ESPButton.Text = "👁️ ESP ON"
    ESPButton.BackgroundColor3 = Color3.fromRGB(0.8, 0, 1)
end

local function disableESP()
    if not espEnabled then return end
    espEnabled = false
    
    for _, label in ipairs(espLabels) do
        pcall(function() label:Destroy() end)
    end
    espLabels = {}
    
    for _, conn in ipairs(healthConnections) do
        pcall(function() conn:Disconnect() end)
    end
    healthConnections = {}
    
    if espConnection then
        espConnection:Disconnect()
        espConnection = nil
    end
    
    StatusLabel.Text = "Status: ESP OFF"
    ESPButton.Text = "👁️ ESP OFF"
    ESPButton.BackgroundColor3 = Color3.fromRGB(0.6, 0, 0.8)
end

local function toggleESP()
    if espEnabled then
        disableESP()
    else
        enableESP()
    end
    return espEnabled
end

-- ============================================
-- ESP BUTTON HANDLER
-- ============================================

ESPButton.MouseButton1Click:Connect(function()
    toggleESP()
end)

-- ============================================
-- VARIABLES
-- ============================================

local selectedPlayer = nil
local playerButtons = {}
local isActive = false
local flySpeed = 150
local attackDistance = 10
local autoTargetEnabled = false
local autoTargetConnection = nil

local runConnection = nil
local clickConnection = nil
local cameraConnection = nil
local characterCheckConnection = nil
local flyBodyPosition = nil
local flyBodyGyro = nil

local clickDelay = 1.2
local canClick = true

-- ============================================
-- FUNCTIONS
-- ============================================

local function getAllPlayersWithDistance()
    local localPlayer = game.Players.LocalPlayer
    local character = localPlayer.Character
    if not character then return {} end
    
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not rootPart then return {} end
    
    local playersData = {}
    
    for _, plr in ipairs(game.Players:GetPlayers()) do
        if plr ~= localPlayer then
            local targetChar = plr.Character
            if targetChar then
                local targetRoot = targetChar:FindFirstChild("HumanoidRootPart")
                if targetRoot then
                    local distance = (rootPart.Position - targetRoot.Position).Magnitude
                    local humanoid = targetChar:FindFirstChild("Humanoid")
                    local isAlive = humanoid and humanoid.Health > 0
                    
                    table.insert(playersData, {
                        player = plr,
                        distance = distance,
                        isAlive = isAlive,
                        character = targetChar,
                        rootPart = targetRoot,
                        humanoid = humanoid
                    })
                end
            end
        end
    end
    
    table.sort(playersData, function(a, b)
        return a.distance < b.distance
    end)
    
    return playersData
end

local function findNearestEnemy()
    local playersData = getAllPlayersWithDistance()
    for _, data in ipairs(playersData) do
        if data.isAlive then
            return data.player, data.distance
        end
    end
    return nil, nil
end

local function stopEverything()
    if runConnection then
        runConnection:Disconnect()
        runConnection = nil
    end
    
    if clickConnection then
        clickConnection:Disconnect()
        clickConnection = nil
    end
    
    if cameraConnection then
        cameraConnection:Disconnect()
        cameraConnection = nil
    end
    
    if flyBodyPosition then
        flyBodyPosition:Destroy()
        flyBodyPosition = nil
    end
    
    if flyBodyGyro then
        flyBodyGyro:Destroy()
        flyBodyGyro = nil
    end
    
    pcall(function()
        local camera = workspace.CurrentCamera
        camera.CameraType = Enum.CameraType.Custom
    end)
    
    local localPlayer = game.Players.LocalPlayer
    local character = localPlayer.Character
    if character then
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.PlatformStand = false
            humanoid.WalkSpeed = 16
            local rootPart = character:FindFirstChild("HumanoidRootPart")
            if rootPart then
                rootPart.Velocity = Vector3.new(0, 0, 0)
            end
        end
    end
    
    isActive = false
    canClick = true
    
    FlyButton.BackgroundColor3 = Color3.new(0, 0.5, 1)
    if selectedPlayer then
        FlyButton.Text = "✈️ Fly to " .. selectedPlayer.Name
        StatusLabel.Text = "Status: Selected " .. selectedPlayer.Name
    else
        FlyButton.Text = "✈️ Fly to player"
        StatusLabel.Text = "Status: Ready"
    end
end

local function closeScript()
    stopEverything()
    
    if espEnabled then
        disableESP()
    end
    
    if autoTargetConnection then
        autoTargetConnection:Disconnect()
        autoTargetConnection = nil
    end
    
    if characterCheckConnection then
        characterCheckConnection:Disconnect()
        characterCheckConnection = nil
    end
    
    for _, button in ipairs(playerButtons) do
        button:Destroy()
    end
    playerButtons = {}
    
    if ScreenGui then
        ScreenGui:Destroy()
    end
    
    print("✅ Script stopped and closed")
end

local function autoRestartOnRespawn()
    if characterCheckConnection then
        characterCheckConnection:Disconnect()
        characterCheckConnection = nil
    end
    
    local localPlayer = game.Players.LocalPlayer
    
    characterCheckConnection = localPlayer.CharacterAdded:Connect(function(newCharacter)
        task.wait(0.5)
        
        if not ScreenGui.Parent then
            ScreenGui.Parent = player:WaitForChild("PlayerGui")
        end
        
        updatePlayerList()
        
        if isActive and selectedPlayer then
            if selectedPlayer and selectedPlayer.Character then
                local humanoid = selectedPlayer.Character:FindFirstChild("Humanoid")
                if humanoid and humanoid.Health > 0 then
                    StatusLabel.Text = "Status: 🔄 Restart after death..."
                    startCameraFollow(selectedPlayer)
                    startFlying(selectedPlayer)
                    StatusLabel.Text = "Status: ✅ Restarted!"
                else
                    StatusLabel.Text = "Status: ⚠️ Target dead, waiting..."
                end
            end
        end
        
        if espEnabled then
            updateESP()
        end
    end)
end

local function performClick()
    if not canClick then return end
    canClick = false
    
    pcall(function()
        local virtualInput = game:GetService("VirtualInputManager")
        virtualInput:SendMouseButtonEvent(0, 0, 0, true, game, 0)
        task.wait(0.02)
        virtualInput:SendMouseButtonEvent(0, 0, 0, false, game, 0)
    end)
    
    pcall(function()
        local mouse = game.Players.LocalPlayer:GetMouse()
        if mouse and mouse.Button1Down then
            mouse.Button1Down:Fire()
            task.wait(0.02)
            mouse.Button1Up:Fire()
        end
    end)
    
    pcall(function()
        local userInputService = game:GetService("UserInputService")
        local inputObject = {
            UserInputType = Enum.UserInputType.MouseButton1,
            Position = Vector2.new(0, 0)
        }
        userInputService:InputBegan(inputObject, false)
        task.wait(0.02)
        userInputService:InputEnded(inputObject, false)
    end)
    
    task.wait(clickDelay)
    canClick = true
end

local function startCameraFollow(targetPlayer)
    if cameraConnection then
        cameraConnection:Disconnect()
        cameraConnection = nil
    end
    
    if not targetPlayer then return end
    
    local camera = workspace.CurrentCamera
    camera.CameraType = Enum.CameraType.Scriptable
    
    cameraConnection = game:GetService("RunService").RenderStepped:Connect(function()
        local targetCharacter = targetPlayer.Character
        if not targetCharacter then return end
        local targetRoot = targetCharacter:FindFirstChild("HumanoidRootPart")
        if not targetRoot then return end
        
        local localPlayer = game.Players.LocalPlayer
        local character = localPlayer.Character
        if not character then return end
        local localRoot = character:FindFirstChild("HumanoidRootPart")
        if not localRoot then return end
        
        local distance = (localRoot.Position - targetRoot.Position).Magnitude
        if distance <= 15 then
            local targetPosition = targetRoot.Position
            local cameraOffset = Vector3.new(0, 12, 12)
            local cameraPosition = targetPosition + cameraOffset
            camera.CFrame = CFrame.lookAt(cameraPosition, targetPosition)
        else
            camera.CameraType = Enum.CameraType.Custom
        end
    end)
end

local function startClicking(targetPlayer)
    if clickConnection then
        clickConnection:Disconnect()
        clickConnection = nil
    end
    
    StatusLabel.Text = "Status: 🔥 Auto-clicker ON"
    
    clickConnection = game:GetService("RunService").Heartbeat:Connect(function()
        if not targetPlayer or not targetPlayer.Character then
            stopEverything()
            return
        end
        
        local localPlayer = game.Players.LocalPlayer
        local character = localPlayer.Character
        if not character then return end
        
        local targetCharacter = targetPlayer.Character
        if not targetCharacter then
            stopEverything()
            return
        end
        
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        local targetRoot = targetCharacter:FindFirstChild("HumanoidRootPart")
        
        if rootPart and targetRoot then
            local distance = (rootPart.Position - targetRoot.Position).Magnitude
            if distance <= attackDistance then
                performClick()
                StatusLabel.Text = "Status: ⚔️ Attacking " .. targetPlayer.Name .. " (dist " .. math.floor(distance) .. ")"
            else
                StatusLabel.Text = "Status: ✈️ Flying to " .. targetPlayer.Name .. " (dist " .. math.floor(distance) .. ")"
            end
        end
    end)
end

local function startFlying(targetPlayer)
    if runConnection then
        runConnection:Disconnect()
        runConnection = nil
    end
    
    if flyBodyPosition then
        flyBodyPosition:Destroy()
        flyBodyPosition = nil
    end
    
    if flyBodyGyro then
        flyBodyGyro:Destroy()
        flyBodyGyro = nil
    end
    
    if not targetPlayer then return end
    
    local localPlayer = game.Players.LocalPlayer
    local character = localPlayer.Character
    if not character then
        StatusLabel.Text = "Status: ⏳ Waiting for character..."
        return
    end
    
    local humanoid = character:FindFirstChild("Humanoid")
    if not humanoid then
        StatusLabel.Text = "Status: ⏳ Waiting for character..."
        return
    end
    
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not rootPart then
        StatusLabel.Text = "Status: ⚠️ RootPart not found"
        return
    end
    
    humanoid.PlatformStand = true
    humanoid.WalkSpeed = 0
    
    flyBodyPosition = Instance.new("BodyPosition")
    flyBodyPosition.MaxForce = Vector3.new(500000, 500000, 500000)
    flyBodyPosition.P = 10000
    flyBodyPosition.D = 1000
    flyBodyPosition.Parent = rootPart
    
    flyBodyGyro = Instance.new("BodyGyro")
    flyBodyGyro.MaxTorque = Vector3.new(500000, 500000, 500000)
    flyBodyGyro.P = 5000
    flyBodyGyro.Parent = rootPart
    
    runConnection = game:GetService("RunService").Heartbeat:Connect(function()
        if not targetPlayer or not targetPlayer.Character then
            stopEverything()
            return
        end
        
        local targetChar = targetPlayer.Character
        if not targetChar then
            stopEverything()
            return
        end
        
        local targetRoot = targetChar:FindFirstChild("HumanoidRootPart")
        if not targetRoot then
            stopEverything()
            return
        end
        
        local localChar = game.Players.LocalPlayer.Character
        if not localChar then return end
        local localRoot = localChar:FindFirstChild("HumanoidRootPart")
        if not localRoot then return end
        
        if not flyBodyPosition or not flyBodyGyro then
            stopEverything()
            return
        end
        
        local distance = (localRoot.Position - targetRoot.Position).Magnitude
        local targetPos = targetRoot.Position + Vector3.new(0, 5, 0)
        
        flyBodyPosition.Position = targetPos
        
        local lookAtCFrame = CFrame.lookAt(localRoot.Position, targetRoot.Position)
        flyBodyGyro.CFrame = lookAtCFrame
        
        local speedMultiplier = flySpeed / 100
        flyBodyPosition.P = 10000 * speedMultiplier
        flyBodyPosition.MaxForce = Vector3.new(500000 * speedMultiplier, 500000 * speedMultiplier, 500000 * speedMultiplier)
        
        if distance <= attackDistance then
            if not clickConnection then
                startClicking(targetPlayer)
            end
            FlyButton.BackgroundColor3 = Color3.new(1, 0.3, 0)
            FlyButton.Text = "⚔️ Attacking " .. targetPlayer.Name
            StatusLabel.Text = "Status: 💥 NEAR " .. targetPlayer.Name
        else
            FlyButton.BackgroundColor3 = Color3.new(0, 1, 0)
            FlyButton.Text = "✈️ Flying to " .. targetPlayer.Name .. " (speed " .. flySpeed .. ")"
            StatusLabel.Text = "Status: ✈️ Flying to " .. targetPlayer.Name .. " (" .. math.floor(distance) .. "m)"
        end
    end)
end

local function startAll(targetPlayer)
    stopEverything()
    
    if not targetPlayer then
        StatusLabel.Text = "Status: ⚠️ Select a player!"
        return
    end
    
    startCameraFollow(targetPlayer)
    startFlying(targetPlayer)
    
    isActive = true
    StatusLabel.Text = "Status: 🚀 Started"
end

-- ============================================
-- UPDATE PLAYER LIST
-- ============================================

local function updatePlayerList()
    for _, button in ipairs(playerButtons) do
        button:Destroy()
    end
    playerButtons = {}
    
    if not ScreenGui or not ScreenGui.Parent then
        return
    end
    
    local playersData = getAllPlayersWithDistance()
    local canvasHeight = #playersData * 35 + 5
    
    PlayerList.CanvasSize = UDim2.new(0, 0, 0, canvasHeight)
    
    for i, data in ipairs(playersData) do
        local plr = data.player
        local distance = data.distance
        local isAlive = data.isAlive
        
        local playerButton = Instance.new("TextButton")
        playerButton.Size = UDim2.new(1, -10, 0, 30)
        playerButton.Position = UDim2.new(0, 5, 0, (i - 1) * 35 + 5)
        
        local statusText = isAlive and "🟢" or "🔴"
        playerButton.Text = statusText .. " " .. plr.Name .. " (" .. math.floor(distance) .. "m)"
        
        playerButton.BackgroundColor3 = Color3.new(0.25, 0.25, 0.25)
        playerButton.TextColor3 = isAlive and Color3.new(1, 1, 1) or Color3.new(0.5, 0.5, 0.5)
        playerButton.Font = Enum.Font.SourceSans
        playerButton.TextSize = 13
        playerButton.Parent = PlayerList
        
        if plr == selectedPlayer then
            playerButton.BackgroundColor3 = Color3.new(0, 0.5, 0)
        end
        
        playerButton.MouseButton1Click:Connect(function()
            if not isAlive then
                StatusLabel.Text = "Status: ⚠️ Player is dead!"
                return
            end
            
            if isActive then
                stopEverything()
            end
            
            selectedPlayer = plr
            
            for _, btn in ipairs(playerButtons) do
                btn.BackgroundColor3 = Color3.new(0.25, 0.25, 0.25)
            end
            playerButton.BackgroundColor3 = Color3.new(0, 0.5, 0)
            
            FlyButton.Text = "✈️ Fly to " .. plr.Name
            StatusLabel.Text = "Status: Selected " .. plr.Name .. " (" .. math.floor(distance) .. "m)"
        end)
        
        table.insert(playerButtons, playerButton)
    end
end

-- ============================================
-- BUTTON HANDLERS
-- ============================================

CloseButton.MouseButton1Click:Connect(function()
    closeScript()
end)

FlyButton.MouseButton1Click:Connect(function()
    if isActive then
        stopEverything()
        return
    end
    
    if not selectedPlayer then
        StatusLabel.Text = "Status: ⚠️ Select a player!"
        return
    end
    
    startAll(selectedPlayer)
end)

StopButton.MouseButton1Click:Connect(function()
    stopEverything()
    StatusLabel.Text = "Status: ⏹️ Stopped"
end)

NearestButton.MouseButton1Click:Connect(function()
    local nearest, distance = findNearestEnemy()
    
    if nearest then
        if isActive then stopEverything() end
        selectedPlayer = nearest
        updatePlayerList()
        StatusLabel.Text = "Status: 🎯 Nearest - " .. nearest.Name .. " (" .. math.floor(distance) .. "m)"
        FlyButton.Text = "✈️ Fly to " .. nearest.Name
        startAll(selectedPlayer)
    else
        StatusLabel.Text = "Status: ⚠️ No alive enemies!"
    end
end)

AutoTargetButton.MouseButton1Click:Connect(function()
    autoTargetEnabled = not autoTargetEnabled
    
    if autoTargetEnabled then
        AutoTargetButton.BackgroundColor3 = Color3.new(0, 1, 0)
        AutoTargetButton.Text = "🔄 Auto-target ON"
        StatusLabel.Text = "Status: 🔄 Auto-target ON"
        
        if autoTargetConnection then
            autoTargetConnection:Disconnect()
            autoTargetConnection = nil
        end
        
        autoTargetConnection = game:GetService("RunService").Heartbeat:Connect(function()
            if not isActive then return end
            
            local targetAlive = false
            if selectedPlayer and selectedPlayer.Character then
                local humanoid = selectedPlayer.Character:FindFirstChild("Humanoid")
                if humanoid and humanoid.Health > 0 then
                    targetAlive = true
                end
            end
            
            if not targetAlive then
                local nearest, distance = findNearestEnemy()
                if nearest and nearest ~= selectedPlayer then
                    selectedPlayer = nearest
                    updatePlayerList()
                    StatusLabel.Text = "🔄 New target: " .. nearest.Name .. " (" .. math.floor(distance) .. "m)"
                    startAll(selectedPlayer)
                elseif not nearest then
                    StatusLabel.Text = "⚠️ No alive enemies, waiting..."
                end
            end
        end)
    else
        AutoTargetButton.BackgroundColor3 = Color3.new(0.5, 0, 0.5)
        AutoTargetButton.Text = "🔄 Auto-target"
        StatusLabel.Text = "Status: Auto-target OFF"
        
        if autoTargetConnection then
            autoTargetConnection:Disconnect()
            autoTargetConnection = nil
        end
    end
end)

SpeedInput.FocusLost:Connect(function()
    local value = tonumber(SpeedInput.Text)
    if value and value > 0 then
        flySpeed = value
        SpeedLabel.Text = "Speed: " .. tostring(value)
        StatusLabel.Text = "Status: Speed changed to " .. value
    else
        SpeedInput.Text = tostring(flySpeed)
    end
end)

DistInput.FocusLost:Connect(function()
    local value = tonumber(DistInput.Text)
    if value and value > 0 then
        attackDistance = value
        DistLabel.Text = "Attack dist: " .. tostring(value)
        StatusLabel.Text = "Status: Attack distance changed to " .. value
    else
        DistInput.Text = tostring(attackDistance)
    end
end)

-- ============================================
-- HOTKEYS
-- ============================================

game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.F then
        FlyButton.MouseButton1Click:Fire()
    end
    
    if input.KeyCode == Enum.KeyCode.X then
        StopButton.MouseButton1Click:Fire()
    end
    
    if input.KeyCode == Enum.KeyCode.R then
        NearestButton.MouseButton1Click:Fire()
    end
    
    if input.KeyCode == Enum.KeyCode.T then
        AutoTargetButton.MouseButton1Click:Fire()
    end
    
    if input.KeyCode == Enum.KeyCode.E then
        ESPButton.MouseButton1Click:Fire()
    end
end)

-- ============================================
-- STARTUP
-- ============================================

autoRestartOnRespawn()

game.Players.PlayerAdded:Connect(updatePlayerList)
game.Players.PlayerRemoving:Connect(updatePlayerList)
updatePlayerList()

spawn(function()
    while true do
        task.wait(3)
        if ScreenGui and ScreenGui.Parent then
            updatePlayerList()
        else
            ScreenGui.Parent = player:WaitForChild("PlayerGui")
        end
    end
end)

StatusLabel.Text = "Status: ✅ Ready! Press R for nearest"

print("✅ Script loaded!")
print("📌 Hotkeys:")
print("   F - Fly/Stop")
print("   X - Stop all")
print("   R - Nearest enemy")
print("   T - Auto-target")
print("   E - Toggle ESP")
print("✅ GUI does NOT disappear after death!")
