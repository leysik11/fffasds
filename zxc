-- Создаем GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Создаем Frame (основное меню)
local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 250, 0, 400)
Frame.Position = UDim2.new(0, 20, 0.5, -200)
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
PlayerList.Size = UDim2.new(1, -10, 1, -80)
PlayerList.Position = UDim2.new(0, 5, 0, 35)
PlayerList.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
PlayerList.BackgroundTransparency = 0.5
PlayerList.ScrollBarThickness = 8
PlayerList.ScrollBarImageColor3 = Color3.new(0.5, 0.5, 0.5)
PlayerList.CanvasSize = UDim2.new(0, 0, 0, 0)
PlayerList.Parent = Frame

-- Создаем кнопки управления
local ButtonFrame = Instance.new("Frame")
ButtonFrame.Size = UDim2.new(1, 0, 0, 40)
ButtonFrame.Position = UDim2.new(0, 0, 1, -40)
ButtonFrame.BackgroundTransparency = 1
ButtonFrame.Parent = Frame

-- Кнопка "Бежать"
local RunButton = Instance.new("TextButton")
RunButton.Size = UDim2.new(0.5, -5, 1, -5)
RunButton.Position = UDim2.new(0, 0, 0, 2.5)
RunButton.Text = "🏃 Бежать"
RunButton.BackgroundColor3 = Color3.new(0, 0.5, 1)
RunButton.TextColor3 = Color3.new(1, 1, 1)
RunButton.Font = Enum.Font.SourceSansBold
RunButton.TextSize = 14
RunButton.Parent = ButtonFrame

-- Кнопка "Стоп"
local StopButton = Instance.new("TextButton")
StopButton.Size = UDim2.new(0.5, -5, 1, -5)
StopButton.Position = UDim2.new(0.5, 5, 0, 2.5)
StopButton.Text = "🛑 Стоп"
StopButton.BackgroundColor3 = Color3.new(1, 0, 0)
StopButton.TextColor3 = Color3.new(1, 1, 1)
StopButton.Font = Enum.Font.SourceSansBold
StopButton.TextSize = 14
StopButton.Parent = ButtonFrame

-- Переменные
local runConnection = nil
local isRunning = false
local selectedPlayer = nil
local playerButtons = {}

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

-- Функция остановки бега
local function stopRunning()
    if runConnection then
        runConnection:Disconnect()
        runConnection = nil
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
    RunButton.BackgroundColor3 = Color3.new(0, 0.5, 1)
    if selectedPlayer then
        RunButton.Text = "🏃 Бежать к " .. selectedPlayer.Name
    else
        RunButton.Text = "🏃 Бежать"
    end
end

-- Функция начала бега
local function startRunningToPlayer(targetPlayer)
    stopRunning()
    
    if not targetPlayer then
        warn("Выберите игрока")
        return
    end
    
    local character = game.Players.LocalPlayer.Character
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
    
    runConnection = game:GetService("RunService").Heartbeat:Connect(function()
        if targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local targetPos = targetPlayer.Character.HumanoidRootPart.Position
            humanoid:MoveTo(targetPos)
        else
            stopRunning()
        end
    end)
    
    isRunning = true
    RunButton.BackgroundColor3 = Color3.new(0, 1, 0)
    RunButton.Text = "🏃 Бегу к " .. targetPlayer.Name .. "..."
end

-- Обработчики кнопок
RunButton.MouseButton1Click:Connect(function()
    if isRunning then
        stopRunning()
        return
    end
    
    if not selectedPlayer then
        warn("Выберите игрока из списка")
        return
    end
    
    startRunningToPlayer(selectedPlayer)
end)

StopButton.MouseButton1Click:Connect(function()
    stopRunning()
end)

-- Обновляем список при подключении/отключении игроков
game.Players.PlayerAdded:Connect(updatePlayerList)
game.Players.PlayerRemoving:Connect(updatePlayerList)

-- Первоначальное обновление
updatePlayerList()

-- Обновляем список каждые 5 секунд (на случай изменения ника)
spawn(function()
    while true do
        wait(5)
        updatePlayerList()
    end
end)
