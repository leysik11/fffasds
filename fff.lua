-- Создаем GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Создаем Frame
local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 250, 0, 450)
Frame.Position = UDim2.new(0, 20, 0.5, -225)
Frame.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15)
Frame.BackgroundTransparency = 0.2
Frame.Active = true
Frame.Draggable = true
Frame.Parent = ScreenGui

-- Заголовок
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, 0, 0, 30)
TitleLabel.Position = UDim2.new(0, 0, 0, 0)
TitleLabel.Text = "Игроки на сервере"
TitleLabel.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
TitleLabel.TextColor3 = Color3.new(1, 1, 1)
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.TextSize = 16
TitleLabel.Parent = Frame

-- Список игроков
local PlayerList = Instance.new("ScrollingFrame")
PlayerList.Size = UDim2.new(1, -10, 1, -130)
PlayerList.Position = UDim2.new(0, 5, 0, 35)
PlayerList.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
PlayerList.BackgroundTransparency = 0.5
PlayerList.ScrollBarThickness = 8
PlayerList.ScrollBarImageColor3 = Color3.new(0.5, 0.5, 0.5)
PlayerList.CanvasSize = UDim2.new(0, 0, 0, 0)
PlayerList.Parent = Frame

-- Панель кнопок
local ButtonFrame = Instance.new("Frame")
ButtonFrame.Size = UDim2.new(1, 0, 0, 90)
ButtonFrame.Position = UDim2.new(0, 0, 1, -90)
ButtonFrame.BackgroundTransparency = 1
ButtonFrame.Parent = Frame

-- Кнопка "Бежать"
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

-- Статус
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, -10, 0, 20)
StatusLabel.Position = UDim2.new(0, 5, 0, 78)
StatusLabel.Text = "Статус: Готов"
StatusLabel.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
StatusLabel.BackgroundTransparency = 0.3
StatusLabel.TextColor3 = Color3.new(1, 1, 1)
StatusLabel.Font = Enum.Font.SourceSans
StatusLabel.TextSize = 12
StatusLabel.Parent = ButtonFrame

-- Переменные
local runConnection = nil
local clickConnection = nil
local isRunning = false
local isClicking = false
local selectedPlayer = nil
local playerButtons = {}

-- ФУНКЦИЯ КЛИКА (исправленная)
local function clickMouse()
    -- Способ 1: VirtualInputManager (самый надежный)
    pcall(function()
        local virtualInput = game:GetService("VirtualInputManager")
        -- Нажимаем ЛКМ
        virtualInput:SendMouseButtonEvent(0, 0, 0, true, game, 0)
        wait(0.05)
        -- Отпускаем ЛКМ
        virtualInput:SendMouseButtonEvent(0, 0, 0, false, game, 0)
    end)
    
    -- Способ 2: Через Mouse (запасной)
    pcall(function()
        local mouse = game.Players.LocalPlayer:GetMouse()
        if mouse then
            -- Эмулируем нажатие через события
            local args = {
                [1] = Enum.UserInputState.Begin,
                [2] = Enum.UserInputType.MouseButton1,
                [3] = Vector2.new(mouse.X or 0, mouse.Y or 0)
            }
            game:GetService("UserInputService").InputBegan:Fire(args)
            wait(0.05)
            args[1] = Enum.UserInputState.End
            game:GetService("UserInputService").InputEnded:Fire(args)
        end
    end)
end

-- Функция для постоянных кликов
local function startClicking(targetPlayer)
    if clickConnection then
        clickConnection:Disconnect()
        clickConnection = nil
    end
    
    isClicking = true
    StatusLabel.Text = "Статус: 🔥 Атака по " .. targetPlayer.Name
    RunButton.BackgroundColor3 = Color3.new(1, 0.3, 0)
    RunButton.Text = "⚔️ Атакую " .. targetPlayer.Name
    
    -- Кликаем КАЖДЫЙ КАДР (очень быстро)
    clickConnection = game:GetService("RunService").Heartbeat:Connect(function()
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
        
        if rootPart and targetRoot then
            local distance = (rootPart.Position - targetRoot.Position).Magnitude
            
            if distance <= 8 then
                -- Делаем клик
                clickMouse()
                StatusLabel.Text = "Статус: ⚔️ Атакую " .. targetPlayer.Name .. " (дист. " .. math.floor(distance) .. ")"
            else
                StatusLabel.Text = "Статус: 🏃 Догоняю " .. targetPlayer.Name .. " (дист. " .. math.floor(distance) .. ")"
            end
        end
    end)
end

-- Остановка всего
local function stopEverything()
    if runConnection then
        runConnection:Disconnect()
        runConnection = nil
    end
    
    if clickConnection then
        clickConnection:Disconnect()
        clickConnection = nil
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
    
    isRunning = false
    isClicking = false
    
    RunButton.BackgroundColor3 = Color3.new(0, 0.5, 1)
    if selectedPlayer then
        RunButton.Text = "🏃 Бежать к " .. selectedPlayer.Name
        StatusLabel.Text = "Статус: Выбран " .. selectedPlayer.Name
    else
        RunButton.Text = "🏃 Бежать к игроку"
        StatusLabel.Text = "Статус: Выберите игрока"
    end
end

-- Функция начала бега
local function startRunningToPlayer(targetPlayer)
    stopEverything()
    
    if not targetPlayer then
        StatusLabel.Text = "Статус: ⚠️ Выберите игрока!"
        return
    end
    
    local localPlayer = game.Players.LocalPlayer
    local character = localPlayer.Character
    if not character then
        StatusLabel.Text = "Статус: ❌ Персонаж не найден"
        return
    end
    
    local humanoid = character:FindFirstChild("Humanoid")
    if not humanoid then
        StatusLabel.Text = "Статус: ❌ Humanoid не найден"
        return
    end
    
    local targetCharacter = targetPlayer.Character
    if not targetCharacter then
        StatusLabel.Text = "Статус: ❌ Цель не найдена"
        return
    end
    
    local targetPosition = targetCharacter:FindFirstChild("HumanoidRootPart")
    if not targetPosition then
        StatusLabel.Text = "Статус: ❌ Позиция цели не найдена"
        return
    end
    
    humanoid.WalkSpeed = 50
    StatusLabel.Text = "Статус: 🏃 Бегу к " .. targetPlayer.Name
    
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
        
        if distance <= 8 then
            if not isClicking then
                startClicking(targetPlayer)
            end
        else
            humanoid:MoveTo(targetPos.Position)
            RunButton.BackgroundColor3 = Color3.new(0, 1, 0)
            RunButton.Text = "🏃 Бегу к " .. targetPlayer.Name .. "..."
            StatusLabel.Text = "Статус: 🏃 Бегу к " .. targetPlayer.Name .. " (" .. math.floor(distance) .. " ст.)"
        end
    end)
    
    isRunning = true
end

-- Обновление списка игроков
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
            
            RunButton.Text = "🏃 Бежать к " .. player.Name
            StatusLabel.Text = "Статус: Выбран " .. player.Name
        end)
        
        table.insert(playerButtons, playerButton)
    end
end

-- Обработчики кнопок
RunButton.MouseButton1Click:Connect(function()
    if isRunning or isClicking then
        stopEverything()
        return
    end
    
    if not selectedPlayer then
        StatusLabel.Text = "Статус: ⚠️ Выберите игрока!"
        return
    end
    
    startRunningToPlayer(selectedPlayer)
end)

StopButton.MouseButton1Click:Connect(function()
    stopEverything()
    StatusLabel.Text = "Статус: ⏹️ Остановлено"
end)

-- Обновление списка
game.Players.PlayerAdded:Connect(updatePlayerList)
game.Players.PlayerRemoving:Connect(updatePlayerList)
updatePlayerList()

spawn(function()
    while true do
        wait(5)
        updatePlayerList()
    end
end)

ScreenGui.AncestryChanged:Connect(function()
    if not ScreenGui.Parent then
        stopEverything()
    end
end)

StatusLabel.Text = "Статус: ✅ Готов! Выберите игрока"
