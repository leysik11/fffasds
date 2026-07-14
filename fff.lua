
-- Создаем GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Создаем Frame (основное меню)
local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 250, 0, 450)
Frame.Position = UDim2.new(0, 20, 0.5, -225)
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
PlayerList.Size = UDim2.new(1, -10, 1, -130)
PlayerList.Position = UDim2.new(0, 5, 0, 35)
PlayerList.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
PlayerList.BackgroundTransparency = 0.5
PlayerList.ScrollBarThickness = 8
PlayerList.ScrollBarImageColor3 = Color3.new(0.5, 0.5, 0.5)
PlayerList.CanvasSize = UDim2.new(0, 0, 0, 0)
PlayerList.Parent = Frame

-- Создаем кнопки управления
local ButtonFrame = Instance.new("Frame")
ButtonFrame.Size = UDim2.new(1, 0, 0, 90)
ButtonFrame.Position = UDim2.new(0, 0, 1, -90)
ButtonFrame.BackgroundTransparency = 1
ButtonFrame.Parent = Frame

-- Кнопка "Бежать/Атаковать"
local RunButton = Instance.new("TextButton")
RunButton.Size = UDim2.new(1, -10, 0, 35)
RunButton.Position = UDim2.new(0, 5, 0, 0)
RunButton.Text = "🏃 Бежать к игроку"
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

-- Переменные
local runConnection = nil
local attackConnection = nil
local isRunning = false
local isAttacking = false
local selectedPlayer = nil
local playerButtons = {}

-- Функция для нанесения удара
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
    
    -- Проверяем расстояние до цели
    local rootPart = character:FindFirstChild("HumanoidRootPart")
    local targetRoot = targetCharacter:FindFirstChild("HumanoidRootPart")
    
    if not rootPart or not targetRoot then
        return false
    end
    
    local distance = (rootPart.Position - targetRoot.Position).Magnitude
    
    -- Если цель в радиусе 5 студий, бьем
    if distance <= 5 then
        -- Ищем способность удара (может быть Tool в руке или в инвентаре)
        local attackTool = nil
        
        -- Проверяем, есть ли оружие в руках
        for _, tool in pairs(character:GetChildren()) do
            if tool:IsA("Tool") and tool:FindFirstChild("Handle") then
                attackTool = tool
                break
            end
        end
        
        -- Если оружия нет, ищем в инвентаре
        if not attackTool then
            for _, tool in pairs(localPlayer.Backpack:GetChildren()) do
                if tool:IsA("Tool") then
                    attackTool = tool
                    break
                end
            end
        end
        
        if attackTool then
            -- Активируем оружие
            local humanoid = character:FindFirstChild("Humanoid")
            if humanoid then
                humanoid:EquipTool(attackTool)
            end
            
            -- Симулируем удар (активируем Tool)
            attackTool:Activate()
            
            -- Для некоторых игр может потребоваться удаленный вызов
            local remoteEvent = attackTool:FindFirstChild("RemoteEvent")
            if remoteEvent and remoteEvent:IsA("RemoteEvent") then
                remoteEvent:FireServer()
            end
            
            -- Проверяем, есть ли у инструмента событие для удара
            local attackFunction = attackTool:FindFirstChild("Attack")
            if attackFunction and attackFunction:IsA("RemoteEvent") then
                attackFunction:FireServer()
            end
            
            return true
        else
            -- Если оружия нет, пытаемся найти способность в Character
            local humanoid = character:FindFirstChild("Humanoid")
            if humanoid then
                -- Для некоторых игр удар может быть в Humanoid
                local attackRemote = character:FindFirstChild("AttackRemote")
                if attackRemote and attackRemote:IsA("RemoteEvent") then
                    attackRemote:FireServer()
                    return true
                end
            end
        end
    end
    
    return false
end

-- Функция для постоянного нанесения ударов
local function startAttacking(targetPlayer)
    if attackConnection then
        attackConnection:Disconnect()
        attackConnection = nil
    end
    
    isAttacking = true
    
    attackConnection = game:GetService("RunService").Heartbeat:Connect(function()
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
        
        local rootPart = character:FindFirstChild("HumanoidRootPart")
        local targetRoot = targetCharacter:FindFirstChild("HumanoidRootPart")
        
        if not rootPart or not targetRoot then
            stopEverything()
            return
        end
        
        local distance = (rootPart.Position - targetRoot.Position).Magnitude
        
        -- Если цель в радиусе атаки
        if distance <= 5 then
            -- Меняем цвет кнопки на оранжевый (режим атаки)
            RunButton.BackgroundColor3 = Color3.new(1, 0.5, 0)
            RunButton.Text = "⚔️ Атакую " .. targetPlayer.Name
            
            -- Наносим удар
            attackPlayer(targetPlayer)
        else
            -- Если цель далеко, показываем что бежим
            if isRunning then
                RunButton.BackgroundColor3 = Color3.new(0, 1, 0)
                RunButton.Text = "🏃 Бегу к " .. targetPlayer.Name .. "..."
            end
        end
    end)
end

-- Остановка всего (и бега, и атаки)
local function stopEverything()
    if runConnection then
        runConnection:Disconnect()
        runConnection = nil
    end
    
    if attackConnection then
        attackConnection:Disconnect()
        attackConnection = nil
    end
    
    local character = game.Players.LocalPlayer.Character
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
    
    isRunning = false
    isAttacking = false
    RunButton.BackgroundColor3 = Color3.new(0, 0.5, 1)
    if selectedPlayer then
        RunButton.Text = "🏃 Бежать к " .. selectedPlayer.Name
    else
        RunButton.Text = "🏃 Бежать к игроку"
    end
end

-- Функция остановки бега (вызывается из stopEverything)
local function stopRunning()
    stopEverything()
end

-- Функция начала бега и атаки
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
        
        -- Проверяем расстояние до цели
        local distance = (localRoot.Position - targetPos.Position).Magnitude
        
        if distance <= 5 then
            -- Достигли цели, начинаем атаковать
            if not isAttacking then
                startAttacking(targetPlayer)
            end
        else
            -- Продолжаем бежать к цели
            humanoid:MoveTo(targetPos.Position)
            RunButton.BackgroundColor3 = Color3.new(0, 1, 0)
            RunButton.Text = "🏃 Бегу к " .. targetPlayer.Name .. "..."
        end
    end)
    
    isRunning = true
end

-- Функция обновления списка игроков
local function updatePlayerList()
    -- Очищаем старые кнопки
    for _, button in ipairs(playerButtons) do
        button:Destroy()
    end
    playerButtons = {}
    
    local players = game.Players:GetPlayers()
    local canvasHeight = #players * 35 + 5
    
    PlayerList.CanvasSize = UDim2.new(0, 0, 0, canvasHeight)
    
    for i, player in ipairs(players) do
        -- Создаем кнопку для каждого игрока
        local playerButton = Instance.new("TextButton")
        playerButton.Size = UDim2.new(1, -10, 0, 30)
        playerButton.Position = UDim2.new(0, 5, 0, (i - 1) * 35 + 5)
        playerButton.Text = player.Name
        playerButton.BackgroundColor3 = Color3.new(0.25, 0.25, 0.25)
        playerButton.TextColor3 = Color3.new(1, 1, 1)
        playerButton.Font = Enum.Font.SourceSans
        playerButton.TextSize = 14
        playerButton.Parent = PlayerList
        
        -- Выделяем выбранного игрока
        if player == selectedPlayer then
            playerButton.BackgroundColor3 = Color3.new(0, 0.5, 0)
        end
        
        -- Обработчик выбора игрока
        playerButton.MouseButton1Click:Connect(function()
            selectedPlayer = player
            
            -- Обновляем выделение
            for _, btn in ipairs(playerButtons) do
                btn.BackgroundColor3 = Color3.new(0.25, 0.25, 0.25)
            end
            playerButton.BackgroundColor3 = Color3.new(0, 0.5, 0)
            
            -- Показываем сообщение
            RunButton.Text = "🏃 Бежать к " .. player.Name
        end)
        
        table.insert(playerButtons, playerButton)
    end
end

-- Обработчики кнопок
RunButton.MouseButton1Click:Connect(function()
    if isRunning or isAttacking then
        stopEverything()
        return
    end
    
    if not selectedPlayer then
        warn("Выберите игрока из списка")
        return
    end
    
    startRunningToPlayer(selectedPlayer)
end)

StopButton.MouseButton1Click:Connect(function()
    stopEverything()
end)

-- Обновляем список при подключении/отключении игроков
game.Players.PlayerAdded:Connect(updatePlayerList)
game.Players.PlayerRemoving:Connect(updatePlayerList)

-- Первоначальное обновление
updatePlayerList()

-- Обновляем список каждые 5 секунд
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
