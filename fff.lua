-- Создаем GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Создаем Frame (основное меню)
local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 250, 0, 480)
Frame.Position = UDim2.new(0, 20, 0.5, -240)
Frame.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
Frame.BackgroundTransparency = 0.2
Frame.Active = true
Frame.Draggable = true
Frame.Parent = ScreenGui

-- Создаем заголовок
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, 0, 0, 30)
TitleLabel.Position = UDim2.new(0, 0, 0, 0)
TitleLabel.Text = "Игроки на сервере"
TitleLabel.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
TitleLabel.TextColor3 = Color3.new(1, 1, 1)
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.TextSize = 16
TitleLabel.Parent = Frame

-- Создаем ScrollingFrame для списка игроков
local PlayerList = Instance.new("ScrollingFrame")
PlayerList.Size = UDim2.new(1, -10, 1, -160)
PlayerList.Position = UDim2.new(0, 5, 0, 35)
PlayerList.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
PlayerList.BackgroundTransparency = 0.5
PlayerList.ScrollBarThickness = 8
PlayerList.ScrollBarImageColor3 = Color3.new(0.5, 0.5, 0.5)
PlayerList.CanvasSize = UDim2.new(0, 0, 0, 0)
PlayerList.Parent = Frame

-- Создаем кнопки управления
local ButtonFrame = Instance.new("Frame")
ButtonFrame.Size = UDim2.new(1, 0, 0, 120)
ButtonFrame.Position = UDim2.new(0, 0, 1, -120)
ButtonFrame.BackgroundTransparency = 1
ButtonFrame.Parent = Frame

-- Кнопка "Бежать/Атаковать"
local RunButton = Instance.new("TextButton")
RunButton.Size = UDim2.new(1, -10, 0, 35)
RunButton.Position = UDim2.new(0, 5, 0, 0)
RunButton.Text = "🎯 Бежать к игроку"
RunButton.BackgroundColor3 = Color3.new(0, 0.5, 1)
RunButton.TextColor3 = Color3.new(1, 1, 1)
RunButton.Font = Enum.Font.SourceSansBold
RunButton.TextSize = 14
RunButton.Parent = ButtonFrame

-- Кнопка "Стоп"
local StopButton = Instance.new("TextButton")
StopButton.Size = UDim2.new(1, -10, 0, 35)
StopButton.Position = UDim2.new(0, 5, 0, 40)
StopButton.Text = "🛑 Стоп"
StopButton.BackgroundColor3 = Color3.new(1, 0, 0)
StopButton.TextColor3 = Color3.new(1, 1, 1)
StopButton.Font = Enum.Font.SourceSansBold
StopButton.TextSize = 14
StopButton.Parent = ButtonFrame

-- Информационная метка
local InfoLabel = Instance.new("TextLabel")
InfoLabel.Size = UDim2.new(1, -10, 0, 30)
InfoLabel.Position = UDim2.new(0, 5, 0, 80)
InfoLabel.Text = "Статус: Ожидание..."
InfoLabel.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
InfoLabel.BackgroundTransparency = 0.3
InfoLabel.TextColor3 = Color3.new(1, 1, 1)
InfoLabel.Font = Enum.Font.SourceSans
InfoLabel.TextSize = 12
InfoLabel.Parent = ButtonFrame

-- Переменные
local runConnection = nil
local aimConnection = nil
local isRunning = false
local isAiming = false
local selectedPlayer = nil
local playerButtons = {}
local currentTarget = nil

-- Функция для прицеливания (наведение курсора на игрока)
local function aimAtPlayer(targetPlayer)
    if not targetPlayer or not targetPlayer.Character then
        return false
    end
    
    local localPlayer = game.Players.LocalPlayer
    local character = localPlayer.Character
    if not character then
        return false
    end
    
    local targetCharacter = targetPlayer.Character
    if not targetCharacter then
        return false
    end
    
    local targetRoot = targetCharacter:FindFirstChild("HumanoidRootPart")
    if not targetRoot then
        return false
    end
    
    -- Находим камеру
    local camera = workspace.CurrentCamera
    if not camera then
        return false
    end
    
    -- Получаем позицию цели в мировых координатах
    local targetPosition = targetRoot.Position
    
    -- Вариант 1: Наведение камеры через CFrame (для игр от 3-го лица)
    local characterRoot = character:FindFirstChild("HumanoidRootPart")
    if characterRoot then
        -- Вычисляем направление к цели
        local direction = (targetPosition - characterRoot.Position).Unit
        -- Поворачиваем камеру в сторону цели
        camera.CFrame = CFrame.new(camera.CFrame.Position, targetPosition)
    end
    
    -- Вариант 2: Для игр от 1-го лица - перемещаем мышь
    -- Это работает через UserInputService (эмуляция движения мыши)
    local userInputService = game:GetService("UserInputService")
    
    -- Получаем позицию цели на экране
    local screenPoint, onScreen = camera:WorldToScreenPoint(targetPosition)
    
    if onScreen then
        -- Пытаемся переместить курсор в центр цели
        -- (для некоторых игр это может не работать из-за ограничений Roblox)
        userInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
        userInputService.MouseIconEnabled = false
        
        -- Плавно перемещаем камеру
        local tweenService = game:GetService("TweenService")
        local newCFrame = CFrame.new(camera.CFrame.Position, targetPosition)
        
        -- Создаем анимацию поворота камеры
        local tweenInfo = TweenInfo.new(
            0.1, -- Длительность
            Enum.EasingStyle.Linear,
            Enum.EasingDirection.Out
        )
        
        -- Пытаемся применить анимацию к камере
        local tween = tweenService:Create(camera, tweenInfo, {CFrame = newCFrame})
        tween:Play()
    end
    
    return true
end

-- Функция для постоянного прицеливания
local function startAiming(targetPlayer)
    if aimConnection then
        aimConnection:Disconnect()
        aimConnection = nil
    end
    
    isAiming = true
    currentTarget = targetPlayer
    InfoLabel.Text = "Статус: 🎯 Прицеливание на " .. targetPlayer.Name
    
    aimConnection = game:GetService("RunService").Heartbeat:Connect(function()
        if not targetPlayer or not targetPlayer.Character then
            stopEverything()
            return
        end
        
        local localPlayer = game.Players.LocalPlayer
        local character = localPlayer.Character
        if not character then
            stopEverything()
            return
        end
        
        local targetCharacter = targetPlayer.Character
        if not targetCharacter then
            stopEverything()
            return
        end
        
        local targetRoot = targetCharacter:FindFirstChild("HumanoidRootPart")
        if not targetRoot then
            stopEverything()
            return
        end
        
        -- Наводимся на цель
        aimAtPlayer(targetPlayer)
        
        -- Проверяем, жива ли цель
        local targetHumanoid = targetCharacter:FindFirstChild("Humanoid")
        if targetHumanoid and targetHumanoid.Health <= 0 then
            stopEverything()
            InfoLabel.Text = "Статус: ❌ Цель мертва"
        end
    end)
end

-- Функция для нанесения удара (простая версия)
local function attackPlayer(targetPlayer)
    if not targetPlayer or not targetPlayer.Character then
        return false
    end
    
    local localPlayer = game.Players.LocalPlayer
    local character = localPlayer.Character
    if not character then
        return false
    end
    
    local targetCharacter = targetPlayer.Character
    if not targetCharacter then
        return false
    end
    
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    local targetRoot = targetCharacter:FindFirstChild("HumanoidRootPart")
    
    if not rootPart or not targetRoot then
        return false
    end
    
    local distance = (rootPart.Position - targetRoot.Position).Magnitude
    
    if distance <= 6 then
        -- Пытаемся найти оружие
        local attackTool = nil
        
        for _, tool in pairs(character:GetChildren()) do
            if tool:IsA("Tool") then
                attackTool = tool
                break
            end
        end
        
        if not attackTool then
            for _, tool in pairs(localPlayer.Backpack:GetChildren()) do
                if tool:IsA("Tool") then
                    attackTool = tool
                    break
                end
            end
        end
        
        if attackTool then
            local humanoid = character:FindFirstChild("Humanoid")
            if humanoid then
                humanoid:EquipTool(attackTool)
            end
            attackTool:Activate()
            
            -- Пытаемся вызвать удаленные события
            for _, child in pairs(attackTool:GetDescendants()) do
                if child:IsA("RemoteEvent") or child:IsA("RemoteFunction") then
                    if child.Name:lower():find("attack") or child.Name:lower():find("hit") or child.Name:lower():find("damage") then
                        pcall(function()
                            if child:IsA("RemoteEvent") then
                                child:FireServer()
                            elseif child:IsA("RemoteFunction") then
                                child:InvokeServer()
                            end
                        end)
                    end
                end
            end
            
            return true
        end
    end
    
    return false
end

-- Остановка всего
local function stopEverything()
    if runConnection then
        runConnection:Disconnect()
        runConnection = nil
    end
    
    if aimConnection then
        aimConnection:Disconnect()
        aimConnection = nil
    end
    
    local localPlayer = game.Players.LocalPlayer
    local character = localPlayer.Character
    if character then
        local humanoid = character:FindFirstChild("Humanoid")
        if humanoid then
            local rootPart = character:FindFirstChild("HumanoidRootPart")
            if rootPart then
                humanoid:MoveTo(rootPart.Position)
            end
            humanoid.WalkSpeed = 16
        end
    end
    
    -- Возвращаем нормальное поведение мыши
    local userInputService = game:GetService("UserInputService")
    userInputService.MouseBehavior = Enum.MouseBehavior.Default
    userInputService.MouseIconEnabled = true
    
    isRunning = false
    isAiming = false
    currentTarget = nil
    
    RunButton.BackgroundColor3 = Color3.new(0, 0.5, 1)
    if selectedPlayer then
        RunButton.Text = "🎯 Бежать к " .. selectedPlayer.Name
        InfoLabel.Text = "Статус: Ожидание... (выбран " .. selectedPlayer.Name .. ")"
    else
        RunButton.Text = "🎯 Бежать к игроку"
        InfoLabel.Text = "Статус: Выберите игрока"
    end
end

-- Функция начала бега и прицеливания
local function startRunningToPlayer(targetPlayer)
    stopEverything()
    
    if not targetPlayer then
        warn("Выберите игрока")
        return
    end
    
    local localPlayer = game.Players.LocalPlayer
    local character = localPlayer.Character
    if not character then
        warn("Персонаж не найден")
        return
    end
    
    local humanoid = character:FindFirstChild("Humanoid")
    if not humanoid then
        warn("Humanoid не найден")
        return
    end
    
    local targetCharacter = targetPlayer.Character
    if not targetCharacter then
        warn("Персонаж цели не найден")
        return
    end
    
    local targetPosition = targetCharacter:FindFirstChild("HumanoidRootPart")
    if not targetPosition then
        warn("HumanoidRootPart не найден у цели")
        return
    end
    
    humanoid.WalkSpeed = 50
    InfoLabel.Text = "Статус: 🏃 Бегу к " .. targetPlayer.Name
    
    -- Запускаем движение
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
        
        local targetPos = targetChar:FindFirstChild("HumanoidRootPart")
        if not targetPos then
            stopEverything()
            return
        end
        
        local localChar = game.Players.LocalPlayer.Character
        if not localChar then
            stopEverything()
            return
        end
        
        local localRoot = localChar:FindFirstChild("HumanoidRootPart")
        if not localRoot then
            stopEverything()
            return
        end
        
        local distance = (localRoot.Position - targetPos.Position).Magnitude
        
        if distance <= 6 then
            -- Достигли цели - начинаем прицеливание и атаку
            if not isAiming then
                startAiming(targetPlayer)
                InfoLabel.Text = "Статус: 🎯 Прицеливаюсь на " .. targetPlayer.Name
                RunButton.BackgroundColor3 = Color3.new(1, 0.5, 0)
                RunButton.Text = "🎯 Прицеливание на " .. targetPlayer.Name
            end
            
            -- Атакуем
            attackPlayer(targetPlayer)
        else
            -- Продолжаем бежать
            humanoid:MoveTo(targetPos.Position)
            RunButton.BackgroundColor3 = Color3.new(0, 1, 0)
            RunButton.Text = "🏃 Бегу к " .. targetPlayer.Name .. "..."
            InfoLabel.Text = "Статус: 🏃 Бегу к " .. targetPlayer.Name .. " (" .. math.floor(distance) .. " ст.)"
        end
    end)
    
    isRunning = true
end

-- Функция обновления списка игроков
local function updatePlayerList()
    for _, button in ipairs(playerButtons) do
        button:Destroy()
    end
    playerButtons = {}
    
    local players = game.Players:GetPlayers()
    local canvasHeight = #players * 35 + 5
    
    PlayerList.CanvasSize = UDim2.new(0, 0, 0, canvasHeight)
    
    for i, player in ipairs(players) do
        local playerButton = Instance.new("TextButton")
        playerButton.Size = UDim2.new(1, -10, 0, 30)
        playerButton.Position = UDim2.new(0, 5, 0, (i - 1) * 35 + 5)
        playerButton.Text = player.Name
        playerButton.BackgroundColor3 = Color3.new(0.25, 0.25, 0.25)
        playerButton.TextColor3 = Color3.new(1, 1, 1)
        playerButton.Font = Enum.Font.SourceSans
        playerButton.TextSize = 14
        playerButton.Parent = PlayerList
        
        if player == selectedPlayer then
            playerButton.BackgroundColor3 = Color3.new(0, 0.5, 0)
        end
        
        playerButton.MouseButton1Click:Connect(function()
            selectedPlayer = player
            
            for _, btn in ipairs(playerButtons) do
                btn.BackgroundColor3 = Color3.new(0.25, 0.25, 0.25)
            end
            playerButton.BackgroundColor3 = Color3.new(0, 0.5, 0)
            
            RunButton.Text = "🎯 Бежать к " .. player.Name
            InfoLabel.Text = "Статус: Выбран " .. player.Name
        end)
        
        table.insert(playerButtons, playerButton)
    end
end

-- Обработчики кнопок
RunButton.MouseButton1Click:Connect(function()
    if isRunning or isAiming then
        stopEverything()
        return
    end
    
    if not selectedPlayer then
        warn("Выберите игрока из списка")
        InfoLabel.Text = "Статус: ⚠️ Выберите игрока!"
        return
    end
    
    startRunningToPlayer(selectedPlayer)
end)

StopButton.MouseButton1Click:Connect(function()
    stopEverything()
    InfoLabel.Text = "Статус: ⏹️ Остановлено"
end)

-- Обновление списка
game.Players.PlayerAdded:Connect(updatePlayerList)
game.Players.PlayerRemoving:Connect(updatePlayerList)
updatePlayerList()

-- Обновление каждые 5 секунд
spawn(function()
    while true do
        wait(5)
        updatePlayerList()
    end
end)

-- Сброс при уничтожении GUI
ScreenGui.AncestryChanged:Connect(function()
    if not ScreenGui.Parent then
        stopEverything()
    end
end)

-- Сообщение об активации
InfoLabel.Text = "Статус: ✅ Скрипт активирован. Выберите игрока!"
