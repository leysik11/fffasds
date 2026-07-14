-- Создаем GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Создаем Frame
local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 280, 0, 520)
Frame.Position = UDim2.new(0, 20, 0.5, -260)
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
ButtonFrame.Size = UDim2.new(1, 0, 0, 160)
ButtonFrame.Position = UDim2.new(0, 0, 1, -160)
ButtonFrame.BackgroundTransparency = 1
ButtonFrame.Parent = Frame

-- Кнопка "Бежать + Атака"
local MainButton = Instance.new("TextButton")
MainButton.Size = UDim2.new(1, -10, 0, 40)
MainButton.Position = UDim2.new(0, 5, 0, 0)
MainButton.Text = "🏃 Бежать к игроку"
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

-- Настройки (ползунок задержки клика)
local SettingsLabel = Instance.new("TextLabel")
SettingsLabel.Size = UDim2.new(1, -10, 0, 20)
SettingsLabel.Position = UDim2.new(0, 5, 0, 85)
SettingsLabel.Text = "Задержка клика: 0.15 сек"
SettingsLabel.BackgroundColor3 = Color3.new(0.2, 0.2, 0.2)
SettingsLabel.BackgroundTransparency = 0.3
SettingsLabel.TextColor3 = Color3.new(1, 1, 1)
SettingsLabel.Font = Enum.Font.SourceSans
SettingsLabel.TextSize = 12
SettingsLabel.Parent = ButtonFrame

local ClickSlider = Instance.new("TextBox")
ClickSlider.Size = UDim2.new(1, -10, 0, 25)
ClickSlider.Position = UDim2.new(0, 5, 0, 108)
ClickSlider.Text = "0.15"
ClickSlider.BackgroundColor3 = Color3.new(0.3, 0.3, 0.3)
ClickSlider.TextColor3 = Color3.new(1, 1, 1)
ClickSlider.Font = Enum.Font.SourceSans
ClickSlider.TextSize = 14
ClickSlider.Parent = ButtonFrame

-- Статус
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, -10, 0, 20)
StatusLabel.Position = UDim2.new(0, 5, 0, 138)
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

-- Переменные для подключений
local runConnection = nil
local clickConnection = nil
local cameraConnection = nil

-- Переменные для автокликера
local clickDelay = 0.15
local canClick = true

-- ФУНКЦИЯ КЛИКА (улучшенная)
local function performClick()
    if not canClick then
        return
    end
    
    canClick = false
    
    -- Способ 1: VirtualInputManager
    pcall(function()
        local virtualInput = game:GetService("VirtualInputManager")
        virtualInput:SendMouseButtonEvent(0, 0, 0, true, game, 0)
        task.wait(0.02)
        virtualInput:SendMouseButtonEvent(0, 0, 0, false, game, 0)
    end)
    
    -- Способ 2: Через Mouse (запасной)
    pcall(function()
        local mouse = game.Players.LocalPlayer:GetMouse()
        if mouse and mouse.Button1Down then
            mouse.Button1Down:Fire()
            task.wait(0.02)
            mouse.Button1Up:Fire()
        end
    end)
    
    -- Способ 3: Через UserInputService
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
    
    -- Разблокируем клик через заданную задержку
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
            stopEverything()
            StatusLabel.Text = "Статус: ⚠️ Цель потеряна!"
            return
        end
        
        local targetRoot = targetCharacter:FindFirstChild("HumanoidRootPart")
        if not targetRoot then
            return
        end
        
        local targetPosition = targetRoot.Position
        -- Настройка ракурса камеры (можно менять)
        local cameraOffset = Vector3.new(0, 12, 12)
        local cameraPosition = targetPosition + cameraOffset
        
        camera.CFrame = CFrame.lookAt(cameraPosition, targetPosition)
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
                performClick()
                StatusLabel.Text = "Статус: ⚔️ Атака " .. targetPlayer.Name .. " (дист. " .. math.floor(distance) .. ")"
            else
                StatusLabel.Text = "Статус: 🏃 Догоняю " .. targetPlayer.Name .. " (дист. " .. math.floor(distance) .. ")"
            end
        end
    end)
end

-- ФУНКЦИЯ БЕГА
local function startRunning(targetPlayer)
    if runConnection then
        runConnection:Disconnect()
        runConnection = nil
    end
    
    if not targetPlayer then
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
    
    humanoid.WalkSpeed = 50
    
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
            -- Достигли цели - включаем автокликер
            if not clickConnection then
                startClicking(targetPlayer)
            end
            MainButton.BackgroundColor3 = Color3.new(1, 0.3, 0)
            MainButton.Text = "⚔️ Атакую " .. targetPlayer.Name
        else
            -- Бежим к цели
            humanoid:MoveTo(targetPos.Position)
            MainButton.BackgroundColor3 = Color3.new(0, 1, 0)
            MainButton.Text = "🏃 Бегу к " .. targetPlayer.Name .. "..."
            StatusLabel.Text = "Статус: 🏃 Бегу к " .. targetPlayer.Name .. " (" .. math.floor(distance) .. " ст.)"
        end
    end)
end

-- ОСТАНОВКА ВСЕГО
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
    
    -- Возвращаем камеру в нормальный режим
    pcall(function()
        local camera = workspace.CurrentCamera
        camera.CameraType = Enum.CameraType.Custom
    end)
    
    -- Останавливаем персонажа
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
    
    isActive = false
    canClick = true
    
    MainButton.BackgroundColor3 = Color3.new(0, 0.5, 1)
    if selectedPlayer then
        MainButton.Text = "🏃 Бежать к " .. selectedPlayer.Name
        StatusLabel.Text = "Статус: Выбран " .. selectedPlayer.Name
    else
        MainButton.Text = "🏃 Бежать к игроку"
        StatusLabel.Text = "Статус: Готов"
    end
end

-- ЗАПУСК ВСЕГО
local function startAll(targetPlayer)
    stopEverything()
    
    if not targetPlayer then
        StatusLabel.Text = "Статус: ⚠️ Выберите игрока!"
        return
    end
    
    -- Запускаем слежку камерой
    startCameraFollow(targetPlayer)
    
    -- Запускаем бег
    startRunning(targetPlayer)
    
    isActive = true
    StatusLabel.Text = "Статус: 🚀 Запущено"
end

-- ОБНОВЛЕНИЕ СПИСКА ИГРОКОВ
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
            if isActive then
                stopEverything()
            end
            
            selectedPlayer = player
            
            for _, btn in ipairs(playerButtons) do
                btn.BackgroundColor3 = Color3.new(0.25, 0.25, 0.25)
            end
            playerButton.BackgroundColor3 = Color3.new(0, 0.5, 0)
            
            MainButton.Text = "🏃 Бежать к " .. player.Name
            StatusLabel.Text = "Статус: Выбран " .. player.Name
        end)
        
        table.insert(playerButtons, playerButton)
    end
end

-- ОБРАБОТЧИКИ КНОПОК
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

StopButton.MouseButton1Click:Connect(function()
    stopEverything()
    StatusLabel.Text = "Статус: ⏹️ Остановлено"
end)

-- Настройка задержки клика
ClickSlider.FocusLost:Connect(function()
    local value = tonumber(ClickSlider.Text)
    if value and value > 0 then
        clickDelay = value
        SettingsLabel.Text = "Задержка клика: " .. string.format("%.2f", value) .. " сек"
    else
        ClickSlider.Text = tostring(clickDelay)
    end
end)

-- ОБНОВЛЕНИЕ СПИСКА
game.Players.PlayerAdded:Connect(updatePlayerList)
game.Players.PlayerRemoving:Connect(updatePlayerList)
updatePlayerList()

-- Обновление каждые 5 секунд
spawn(function()
    while true do
        task.wait(5)
        updatePlayerList()
    end
end)

-- СБРОС ПРИ ЗАКРЫТИИ GUI
ScreenGui.AncestryChanged:Connect(function()
    if not ScreenGui.Parent then
        stopEverything()
    end
end)

StatusLabel.Text = "Статус: ✅ Готов! Выберите игрока"
