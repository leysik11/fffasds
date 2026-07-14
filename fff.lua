-- Создаем GUI (привязываем к PlayerGui, а не к персонажу)
local player = game.Players.LocalPlayer
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = player:WaitForChild("PlayerGui")

-- Создаем Frame
local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 280, 0, 520)
Frame.Position = UDim2.new(0, 20, 0.5, -260)
Frame.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
Frame.BackgroundTransparency = 0.2
Frame.Active = true
Frame.Draggable = true
Frame.Parent = ScreenGui

-- КНОПКА ЗАКРЫТИЯ
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

-- Заголовок
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -40, 0, 30)
TitleLabel.Position = UDim2.new(0, 5, 0, 0)
TitleLabel.Text = "Игроки на сервере"
TitleLabel.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
TitleLabel.TextColor3 = Color3.new(1, 1, 1)
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.TextSize = 16
TitleLabel.Parent = Frame

-- Список игроков
local PlayerList = Instance.new("ScrollingFrame")
PlayerList.Size = UDim2.new(1, -10, 1, -200)
PlayerList.Position = UDim2.new(0, 5, 0, 35)
PlayerList.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
PlayerList.BackgroundTransparency = 0.5
PlayerList.ScrollBarThickness = 8
PlayerList.ScrollBarImageColor3 = Color3.new(0.5, 0.5, 0.5)
PlayerList.CanvasSize = UDim2.new(0, 0, 0, 0)
PlayerList.Parent = Frame

-- Панель кнопок
local ButtonFrame = Instance.new("Frame")
ButtonFrame.Size = UDim2.new(1, 0, 0, 200)
ButtonFrame.Position = UDim2.new(0, 0, 1, -200)
ButtonFrame.BackgroundTransparency = 1
ButtonFrame.Parent = Frame

-- Кнопка "Лететь + Атака"
local MainButton = Instance.new("TextButton")
MainButton.Size = UDim2.new(1, -10, 0, 40)
MainButton.Position = UDim2.new(0, 5, 0, 0)
MainButton.Text = "✈️ Лететь к игроку"
MainButton.BackgroundColor3 = Color3.new(0, 0.5, 1)
MainButton.TextColor3 = Color3.new(1, 1, 1)
MainButton.Font = Enum.Font.SourceSansBold
MainButton.TextSize = 14
MainButton.Parent = ButtonFrame

-- Кнопка "Стоп"
local StopButton = Instance.new("TextButton")
StopButton.Size = UDim2.new(1, -10, 0, 35)
StopButton.Position = UDim2.new(0, 5, 0, 45)
StopButton.Text = "🛑 СТОП (всё остановить)"
StopButton.BackgroundColor3 = Color3.new(1, 0, 0)
StopButton.TextColor3 = Color3.new(1, 1, 1)
StopButton.Font = Enum.Font.SourceSansBold
StopButton.TextSize = 14
StopButton.Parent = ButtonFrame

-- Кнопка "Ближайший враг"
local NearestButton = Instance.new("TextButton")
NearestButton.Size = UDim2.new(0.48, -5, 0, 30)
NearestButton.Position = UDim2.new(0, 5, 0, 85)
NearestButton.Text = "🎯 Ближайший"
NearestButton.BackgroundColor3 = Color3.new(0.8, 0.4, 0)
NearestButton.TextColor3 = Color3.new(1, 1, 1)
NearestButton.Font = Enum.Font.SourceSansBold
NearestButton.TextSize = 12
NearestButton.Parent = ButtonFrame

-- Кнопка "Авто-поиск"
local AutoTargetButton = Instance.new("TextButton")
AutoTargetButton.Size = UDim2.new(0.48, -5, 0, 30)
AutoTargetButton.Position = UDim2.new(0.52, 5, 0, 85)
AutoTargetButton.Text = "🔄 Авто-поиск"
AutoTargetButton.BackgroundColor3 = Color3.new(0.5, 0, 0.5)
AutoTargetButton.TextColor3 = Color3.new(1, 1, 1)
AutoTargetButton.Font = Enum.Font.SourceSansBold
AutoTargetButton.TextSize = 12
AutoTargetButton.Parent = ButtonFrame

-- Настройки скорости полета
local SettingsLabel = Instance.new("TextLabel")
SettingsLabel.Size = UDim2.new(0.48, -5, 0, 20)
SettingsLabel.Position = UDim2.new(0, 5, 0, 118)
SettingsLabel.Text = "Скорость: 150"
SettingsLabel.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
SettingsLabel.BackgroundTransparency = 0.3
SettingsLabel.TextColor3 = Color3.new(1, 1, 1)
SettingsLabel.Font = Enum.Font.SourceSans
SettingsLabel.TextSize = 11
SettingsLabel.Parent = ButtonFrame

local SpeedSlider = Instance.new("TextBox")
SpeedSlider.Size = UDim2.new(0.48, -5, 0, 20)
SpeedSlider.Position = UDim2.new(0.52, 5, 0, 118)
SpeedSlider.Text = "150"
SpeedSlider.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
SpeedSlider.TextColor3 = Color3.new(1, 1, 1)
SpeedSlider.Font = Enum.Font.SourceSans
SpeedSlider.TextSize = 12
SpeedSlider.Parent = ButtonFrame

-- Настройка дистанции атаки
local DistLabel = Instance.new("TextLabel")
DistLabel.Size = UDim2.new(0.48, -5, 0, 20)
DistLabel.Position = UDim2.new(0, 5, 0, 142)
DistLabel.Text = "Дист. атаки: 10"
DistLabel.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
DistLabel.BackgroundTransparency = 0.3
DistLabel.TextColor3 = Color3.new(1, 1, 1)
DistLabel.Font = Enum.Font.SourceSans
DistLabel.TextSize = 11
DistLabel.Parent = ButtonFrame

local DistSlider = Instance.new("TextBox")
DistSlider.Size = UDim2.new(0.48, -5, 0, 20)
DistSlider.Position = UDim2.new(0.52, 5, 0, 142)
DistSlider.Text = "10"
DistSlider.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
DistSlider.TextColor3 = Color3.new(1, 1, 1)
DistSlider.Font = Enum.Font.SourceSans
DistSlider.TextSize = 12
DistSlider.Parent = ButtonFrame

-- Статус
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, -10, 0, 20)
StatusLabel.Position = UDim2.new(0, 5, 0, 170)
StatusLabel.Text = "Статус: Готов"
StatusLabel.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
StatusLabel.BackgroundTransparency = 0.3
StatusLabel.TextColor3 = Color3.new(1, 1, 1)
StatusLabel.Font = Enum.Font.SourceSans
StatusLabel.TextSize = 12
StatusLabel.Parent = ButtonFrame

-- ПЕРЕМЕННЫЕ
local selectedPlayer = nil
local playerButtons = {}
local isActive = false
local flySpeed = 150
local attackDistance = 10
local autoTargetEnabled = false
local autoTargetConnection = nil

-- Переменные для подключений
local runConnection = nil
local clickConnection = nil
local cameraConnection = nil
local characterCheckConnection = nil
local flyBodyPosition = nil
local flyBodyGyro = nil

-- Переменные для автокликера
local clickDelay = 0.15
local canClick = true

-- ============================================
-- ФУНКЦИЯ ПОИСКА БЛИЖАЙШИХ ВРАГОВ
-- ============================================

-- Функция поиска всех игроков с расстоянием
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
    
    -- Сортируем по расстоянию
    table.sort(playersData, function(a, b)
        return a.distance < b.distance
    end)
    
    return playersData
end

-- Функция поиска ближайшего живого врага
local function findNearestEnemy()
    local playersData = getAllPlayersWithDistance()
    
    for _, data in ipairs(playersData) do
        if data.isAlive then
            return data.player, data.distance
        end
    end
    
    return nil, nil
end

-- Функция поиска всех врагов в радиусе
local function findEnemiesInRadius(radius)
    local playersData = getAllPlayersWithDistance()
    local enemies = {}
    
    for _, data in ipairs(playersData) do
        if data.isAlive and data.distance <= radius then
            table.insert(enemies, {
                player = data.player,
                distance = data.distance,
                rootPart = data.rootPart
            })
        end
    end
    
    return enemies
end

-- Функция поиска врага с наименьшим здоровьем
local function findLowestHealthEnemy()
    local playersData = getAllPlayersWithDistance()
    local lowestHealth = math.huge
    local targetPlayer = nil
    
    for _, data in ipairs(playersData) do
        if data.isAlive and data.humanoid then
            local health = data.humanoid.Health
            if health < lowestHealth then
                lowestHealth = health
                targetPlayer = data.player
            end
        end
    end
    
    return targetPlayer, lowestHealth
end

-- Функция поиска врага с наибольшим здоровьем
local function findHighestHealthEnemy()
    local playersData = getAllPlayersWithDistance()
    local highestHealth = 0
    local targetPlayer = nil
    
    for _, data in ipairs(playersData) do
        if data.isAlive and data.humanoid then
            local health = data.humanoid.Health
            if health > highestHealth then
                highestHealth = health
                targetPlayer = data.player
            end
        end
    end
    
    return targetPlayer, highestHealth
end

-- Функция поиска ближайшего врага с учетом приоритетов
local function findPriorityEnemy(priority)
    -- priority: "nearest" - ближайший, "lowest" - с малым хп, "highest" - с большим хп
    if priority == "nearest" then
        return findNearestEnemy()
    elseif priority == "lowest" then
        return findLowestHealthEnemy()
    elseif priority == "highest" then
        return findHighestHealthEnemy()
    else
        return findNearestEnemy()
    end
end

-- ============================================
-- ОСТАЛЬНЫЕ ФУНКЦИИ
-- ============================================

-- ФУНКЦИЯ ОСТАНОВКИ ВСЕГО
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
    
    MainButton.BackgroundColor3 = Color3.new(0, 0.5, 1)
    if selectedPlayer then
        MainButton.Text = "✈️ Лететь к " .. selectedPlayer.Name
        StatusLabel.Text = "Статус: Выбран " .. selectedPlayer.Name
    else
        MainButton.Text = "✈️ Лететь к игроку"
        StatusLabel.Text = "Статус: Готов"
    end
end

-- ФУНКЦИЯ ПОЛНОГО ЗАКРЫТИЯ
local function closeScript()
    stopEverything()
    
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
    
    print("✅ Скрипт полностью остановлен и закрыт")
end

-- ФУНКЦИЯ АВТОМАТИЧЕСКОГО ПЕРЕЗАПУСКА ПОСЛЕ СМЕРТИ
local function autoRestartOnRespawn()
    if characterCheckConnection then
        characterCheckConnection:Disconnect()
        characterCheckConnection = nil
    end
    
    local localPlayer = game.Players.LocalPlayer
    
    characterCheckConnection = localPlayer.CharacterAdded:Connect(function(newCharacter)
        if isActive and selectedPlayer then
            task.wait(0.5)
            
            if selectedPlayer and selectedPlayer.Character then
                local humanoid = selectedPlayer.Character:FindFirstChild("Humanoid")
                if humanoid and humanoid.Health > 0 then
                    StatusLabel.Text = "Статус: 🔄 Перезапуск после смерти..."
                    startCameraFollow(selectedPlayer)
                    startFlying(selectedPlayer)
                    StatusLabel.Text = "Статус: ✅ Перезапущено!"
                else
                    StatusLabel.Text = "Статус: ⚠️ Цель мертва, ожидание..."
                end
            end
        end
    end)
end

-- ФУНКЦИЯ КЛИКА
local function performClick()
    if not canClick then
        return
    end
    
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

-- ФУНКЦИЯ ПРИКЛЕИВАНИЯ КАМЕРЫ
local function startCameraFollow(targetPlayer)
    if cameraConnection then
        cameraConnection:Disconnect()
        cameraConnection = nil
    end
    
    if not targetPlayer then
        return
    end
    
    local camera = workspace.CurrentCamera
    camera.CameraType = Enum.CameraType.Scriptable
    
    cameraConnection = game:GetService("RunService").RenderStepped:Connect(function()
        local targetCharacter = targetPlayer.Character
        if not targetCharacter then
            return
        end
        
        local targetRoot = targetCharacter:FindFirstChild("HumanoidRootPart")
        if not targetRoot then
            return
        end
        
        local localPlayer = game.Players.LocalPlayer
        local character = localPlayer.Character
        if not character then
            return
        end
        
        local localRoot = character:FindFirstChild("HumanoidRootPart")
        if not localRoot then
            return
        end
        
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

-- ФУНКЦИЯ АВТОКЛИКЕРА
local function startClicking(targetPlayer)
    if clickConnection then
        clickConnection:Disconnect()
        clickConnection = nil
    end
    
    StatusLabel.Text = "Статус: 🔥 Автокликер включен"
    
    clickConnection = game:GetService("RunService").Heartbeat:Connect(function()
        if not targetPlayer or not targetPlayer.Character then
            stopEverything()
            return
        end
        
        local localPlayer = game.Players.LocalPlayer
        local character = localPlayer.Character
        if not character then
            return
        end
        
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
                StatusLabel.Text = "Статус: ⚔️ Атака " .. targetPlayer.Name .. " (дист. " .. math.floor(distance) .. ")"
            else
                StatusLabel.Text = "Статус: ✈️ Лечу к " .. targetPlayer.Name .. " (дист. " .. math.floor(distance) .. ")"
            end
        end
    end)
end

-- ФУНКЦИЯ ПОЛЕТА
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
    
    if not targetPlayer then
        return
    end
    
    local localPlayer = game.Players.LocalPlayer
    local character = localPlayer.Character
    if not character then
        StatusLabel.Text = "Статус: ⏳ Ожидание персонажа..."
        return
    end
    
    local humanoid = character:FindFirstChild("Humanoid")
    if not humanoid then
        StatusLabel.Text = "Статус: ⏳ Ожидание персонажа..."
        return
    end
    
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    if not rootPart then
        StatusLabel.Text = "Статус: ⚠️ RootPart не найден"
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
        if not localChar then
            return
        end
        
        local localRoot = localChar:FindFirstChild("HumanoidRootPart")
        if not localRoot then
            return
        end
        
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
            MainButton.BackgroundColor3 = Color3.new(1, 0.3, 0)
            MainButton.Text = "⚔️ Атакую " .. targetPlayer.Name
            StatusLabel.Text = "Статус: 💥 РЯДОМ с " .. targetPlayer.Name
        else
            MainButton.BackgroundColor3 = Color3.new(0, 1, 0)
            MainButton.Text = "✈️ Лечу к " .. targetPlayer.Name .. " (скор. " .. flySpeed .. ")"
            StatusLabel.Text = "Статус: ✈️ Лечу к " .. targetPlayer.Name .. " (" .. math.floor(distance) .. " ст.)"
        end
    end)
end

-- ЗАПУСК ВСЕГО
local function startAll(targetPlayer)
    stopEverything()
    
    if not targetPlayer then
        StatusLabel.Text = "Статус: ⚠️ Выберите игрока!"
        return
    end
    
    startCameraFollow(targetPlayer)
    startFlying(targetPlayer)
    
    isActive = true
    StatusLabel.Text = "Статус: 🚀 Запущено"
end

-- ОБНОВЛЕНИЕ СПИСКА ИГРОКОВ С ОТОБРАЖЕНИЕМ ДИСТАНЦИИ
local function updatePlayerList()
    for _, button in ipairs(playerButtons) do
        button:Destroy()
    end
    playerButtons = {}
    
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
        
        -- Отображаем имя + расстояние + статус
        local statusText = isAlive and "🟢" or "🔴"
        playerButton.Text = statusText .. " " .. plr.Name .. " (" .. math.floor(distance) .. " ст.)"
        
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
                StatusLabel.Text = "Статус: ⚠️ Игрок мертв!"
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
            
            MainButton.Text = "✈️ Лететь к " .. plr.Name
            StatusLabel.Text = "Статус: Выбран " .. plr.Name .. " (" .. math.floor(distance) .. " ст.)"
        end)
        
        table.insert(playerButtons, playerButton)
    end
end

-- ============================================
-- ОБРАБОТЧИКИ КНОПОК
-- ============================================

-- Кнопка ЗАКРЫТИЯ
CloseButton.MouseButton1Click:Connect(function()
    closeScript()
end)

-- Основная кнопка
MainButton.MouseButton1Click:Connect(function()
    if isActive then
        stopEverything()
        return
    end
    
    if not selectedPlayer then
        StatusLabel.Text = "Статус: ⚠️ Выберите игрока!"
        return
    end
    
    startAll(selectedPlayer)
end)

-- Кнопка Стоп
StopButton.MouseButton1Click:Connect(function()
    stopEverything()
    StatusLabel.Text = "Статус: ⏹️ Остановлено"
end)

-- КНОПКА "БЛИЖАЙШИЙ ВРАГ"
NearestButton.MouseButton1Click:Connect(function()
    local nearest, distance = findNearestEnemy()
    
    if nearest then
        if isActive then stopEverything() end
        
        selectedPlayer = nearest
        updatePlayerList()
        
        StatusLabel.Text = "Статус: 🎯 Ближайший - " .. nearest.Name .. " (" .. math.floor(distance) .. " ст.)"
        MainButton.Text = "✈️ Лететь к " .. nearest.Name
        
        -- Автоматически запускаем
        startAll(selectedPlayer)
    else
        StatusLabel.Text = "Статус: ⚠️ Нет живых врагов!"
    end
end)

-- КНОПКА "АВТО-ПОИСК"
AutoTargetButton.MouseButton1Click:Connect(function()
    autoTargetEnabled = not autoTargetEnabled
    
    if autoTargetEnabled then
        AutoTargetButton.BackgroundColor3 = Color3.new(0, 1, 0)
        AutoTargetButton.Text = "🔄 Авто-поиск ВКЛ"
        StatusLabel.Text = "Статус: 🔄 Авто-поиск включен"
        
        if autoTargetConnection then
            autoTargetConnection:Disconnect()
            autoTargetConnection = nil
        end
        
        autoTargetConnection = game:GetService("RunService").Heartbeat:Connect(function()
            if not isActive then return end
            
            -- Проверяем, жива ли текущая цель
            local targetAlive = false
            if selectedPlayer and selectedPlayer.Character then
                local humanoid = selectedPlayer.Character:FindFirstChild("Humanoid")
                if humanoid and humanoid.Health > 0 then
                    targetAlive = true
                end
            end
            
            -- Если цель мертва или ее нет - ищем новую
            if not targetAlive then
                local nearest, distance = findNearestEnemy()
                if nearest and nearest ~= selectedPlayer then
                    selectedPlayer = nearest
                    updatePlayerList()
                    StatusLabel.Text = "🔄 Новая цель: " .. nearest.Name .. " (" .. math.floor(distance) .. " ст.)"
                    -- Перезапускаем полет к новой цели
                    startAll(selectedPlayer)
                elseif not nearest then
                    StatusLabel.Text = "⚠️ Нет живых врагов, ожидание..."
                end
            end
        end)
    else
        AutoTargetButton.BackgroundColor3 = Color3.new(0.5, 0, 0.5)
        AutoTargetButton.Text = "🔄 Авто-поиск"
        StatusLabel.Text = "Статус: Авто-поиск выключен"
        
        if autoTargetConnection then
            autoTargetConnection:Disconnect()
            autoTargetConnection = nil
        end
    end
end)

-- НАСТРОЙКА СКОРОСТИ
SpeedSlider.FocusLost:Connect(function()
    local value = tonumber(SpeedSlider.Text)
    if value and value > 0 then
        flySpeed = value
        SettingsLabel.Text = "Скорость: " .. tostring(value)
        StatusLabel.Text = "Статус: Скорость изменена на " .. value
    else
        SpeedSlider.Text = tostring(flySpeed)
    end
end)

-- НАСТРОЙКА ДИСТАНЦИИ АТАКИ
DistSlider.FocusLost:Connect(function()
    local value = tonumber(DistSlider.Text)
    if value and value > 0 then
        attackDistance = value
        DistLabel.Text = "Дист. атаки: " .. tostring(value)
        StatusLabel.Text = "Статус: Дистанция изменена на " .. value
    else
        DistSlider.Text = tostring(attackDistance)
    end
end)

-- ============================================
-- ГОРЯЧИЕ КЛАВИШИ
-- ============================================

game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == Enum.KeyCode.F then
        MainButton.MouseButton1Click:Fire()
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
end)

-- ============================================
-- ЗАПУСК
-- ============================================

autoRestartOnRespawn()

game.Players.PlayerAdded:Connect(updatePlayerList)
game.Players.PlayerRemoving:Connect(updatePlayerList)
updatePlayerList()

-- Обновление списка каждые 3 секунды (чаще для точности)
spawn(function()
    while true do
        task.wait(3)
        updatePlayerList()
    end
end)

StatusLabel.Text = "Статус: ✅ Готов! Нажми R для поиска ближайшего"

print("✅ Скрипт загружен!")
print("📌 Горячие клавиши:")
print("   F - Старт/Стоп")
print("   X - Остановка")
print("   R - Ближайший враг")
print("   T - Авто-поиск цели")
