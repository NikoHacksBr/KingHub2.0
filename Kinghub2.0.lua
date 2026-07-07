--[[
    KING HUB - Script Completo para Mobile
    - Interface preto, branco e cinza
    - Cantos arredondados, visual moderno
    Funcionalidades:
    - Speed/Jump ajustáveis
    - Fly (joystick nativo + direção da câmera)
    - Noclip
    - Multi Jump (pulo infinito no ar)
    - Teleport por Toque
]]

local Player = game.Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Mouse = Player:GetMouse()

-- ========== INTERFACE ==========
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KingHub"
ScreenGui.Parent = game.CoreGui

-- Frame principal (arrastável)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 280, 0, 400)
MainFrame.Position = UDim2.new(0.5, -140, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

-- Sombra externa
local Shadow = Instance.new("UIStroke")
Shadow.Color = Color3.fromRGB(0, 0, 0)
Shadow.Thickness = 3
Shadow.Transparency = 0.4
Shadow.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
Shadow.Parent = MainFrame

-- Cantos arredondados
local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

-- Borda branca interna
local Border = Instance.new("Frame")
Border.Size = UDim2.new(1, -4, 1, -4)
Border.Position = UDim2.new(0, 2, 0, 2)
Border.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Border.BorderSizePixel = 0
Border.ZIndex = 0
Border.Parent = MainFrame

local BorderCorner = Instance.new("UICorner")
BorderCorner.CornerRadius = UDim.new(0, 10)
BorderCorner.Parent = Border

-- Fundo interno
local InnerFrame = Instance.new("Frame")
InnerFrame.Size = UDim2.new(1, -6, 1, -6)
InnerFrame.Position = UDim2.new(0, 3, 0, 3)
InnerFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
InnerFrame.BorderSizePixel = 0
InnerFrame.Parent = MainFrame

local InnerCorner = Instance.new("UICorner")
InnerCorner.CornerRadius = UDim.new(0, 8)
InnerCorner.Parent = InnerFrame

-- Título
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 35)
TitleBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = InnerFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 8)
TitleCorner.Parent = TitleBar

local TitleText = Instance.new("TextLabel")
TitleText.Size = UDim2.new(0, 200, 1, 0)
TitleText.Position = UDim2.new(0, 10, 0, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = "KING HUB"
TitleText.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleText.Font = Enum.Font.GothamBold
TitleText.TextSize = 18
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.Parent = TitleBar

-- Botão fechar
local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 28, 0, 28)
CloseButton.Position = UDim2.new(1, -34, 0, 4)
CloseButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
CloseButton.BorderSizePixel = 0
CloseButton.Text = "✕"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.TextSize = 16
CloseButton.Parent = TitleBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseButton

-- Botão minimizar
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Size = UDim2.new(0, 28, 0, 28)
MinimizeButton.Position = UDim2.new(1, -68, 0, 4)
MinimizeButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
MinimizeButton.BorderSizePixel = 0
MinimizeButton.Text = "−"
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.Font = Enum.Font.GothamBold
MinimizeButton.TextSize = 20
MinimizeButton.Parent = TitleBar

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(0, 6)
MinCorner.Parent = MinimizeButton

-- Conteúdo
local ContentFrame = Instance.new("Frame")
ContentFrame.Size = UDim2.new(1, -20, 1, -50)
ContentFrame.Position = UDim2.new(0, 10, 0, 40)
ContentFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
ContentFrame.BorderSizePixel = 0
ContentFrame.Parent = InnerFrame

local ContentCorner = Instance.new("UICorner")
ContentCorner.CornerRadius = UDim.new(0, 6)
ContentCorner.Parent = ContentFrame

local ScrollingFrame = Instance.new("ScrollingFrame")
ScrollingFrame.Size = UDim2.new(1, 0, 1, 0)
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.BorderSizePixel = 0
ScrollingFrame.ScrollBarThickness = 4
ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(150, 150, 150)
ScrollingFrame.Parent = ContentFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0, 10)
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Parent = ScrollingFrame

-- ========== FUNÇÕES AUXILIARES ==========
local function CreateButton(text, parent)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -10, 0, 36)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.BorderSizePixel = 0
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 14
    btn.Parent = parent

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = btn

    btn.MouseEnter:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(180, 180, 180)
        btn.TextColor3 = Color3.fromRGB(0, 0, 0)
    end)
    btn.MouseLeave:Connect(function()
        btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    end)
    return btn
end

local function CreateLabel(text, parent)
    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, -10, 0, 20)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.TextColor3 = Color3.fromRGB(200, 200, 200)
    lbl.Font = Enum.Font.GothamBold
    lbl.TextSize = 14
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = parent
    return lbl
end

local function CreateTextBox(labelText, placeholder, parent)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, -10, 0, 50)
    frame.BackgroundTransparency = 1
    frame.Parent = parent

    local lbl = Instance.new("TextLabel")
    lbl.Size = UDim2.new(1, 0, 0, 18)
    lbl.BackgroundTransparency = 1
    lbl.Text = labelText
    lbl.TextColor3 = Color3.fromRGB(180, 180, 180)
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 11
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.Parent = frame

    local tb = Instance.new("TextBox")
    tb.Size = UDim2.new(1, 0, 0, 28)
    tb.Position = UDim2.new(0, 0, 0, 22)
    tb.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    tb.BorderSizePixel = 0
    tb.Text = ""
    tb.PlaceholderText = placeholder
    tb.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
    tb.TextColor3 = Color3.fromRGB(255, 255, 255)
    tb.Font = Enum.Font.Gotham
    tb.TextSize = 14
    tb.ClearTextOnFocus = false
    tb.Parent = frame

    local tbCorner = Instance.new("UICorner")
    tbCorner.CornerRadius = UDim.new(0, 6)
    tbCorner.Parent = tb

    return tb
end

local function AddSeparator(parent)
    local sep = Instance.new("Frame")
    sep.Size = UDim2.new(1, -10, 0, 1)
    sep.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    sep.BorderSizePixel = 0
    sep.Parent = parent
end

-- ========== SEÇÕES DO MENU ==========
CreateLabel("MOVIMENTO", ScrollingFrame)
local SpeedTextBox = CreateTextBox("WalkSpeed", "16", ScrollingFrame)
local JumpPowerTextBox = CreateTextBox("JumpPower", "50", ScrollingFrame)

local ApplySpeedButton = CreateButton("Aplicar Speed/Jump", ScrollingFrame)
ApplySpeedButton.MouseButton1Click:Connect(function()
    local humanoid = Player.Character and Player.Character:FindFirstChild("Humanoid")
    if humanoid then
        local spd = tonumber(SpeedTextBox.Text)
        local jmp = tonumber(JumpPowerTextBox.Text)
        if spd and spd > 0 then humanoid.WalkSpeed = spd end
        if jmp and jmp > 0 then humanoid.JumpPower = jmp end
    end
end)

AddSeparator(ScrollingFrame)

-- ========== FLY ==========
CreateLabel("FLY", ScrollingFrame)
local FlySpeedTextBox = CreateTextBox("Fly Speed", "50", ScrollingFrame)

local FlyButton = CreateButton("Ativar Fly", ScrollingFrame)
local flyEnabled = false
local flyConnection
local bodyVelocity, bodyGyro

-- Botões de altitude
local AltitudeControls = Instance.new("Frame")
AltitudeControls.Size = UDim2.new(0, 70, 0, 120)
AltitudeControls.Position = UDim2.new(1, -80, 0.5, -60)
AltitudeControls.BackgroundTransparency = 1
AltitudeControls.Visible = false
AltitudeControls.Parent = ScreenGui

local function CreateAltitudeButton(name, position, color, textColor, parent)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 56, 0, 56)
    btn.Position = position
    btn.BackgroundColor3 = color
    btn.BorderSizePixel = 0
    btn.Text = name
    btn.TextColor3 = textColor
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 28
    btn.AutoButtonColor = false
    btn.Parent = parent

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 12)
    btnCorner.Parent = btn

    return btn
end

local BtnUp = CreateAltitudeButton("▲", UDim2.new(0, 7, 0, 0), Color3.fromRGB(60, 60, 60), Color3.fromRGB(255, 255, 255), AltitudeControls)
local BtnDown = CreateAltitudeButton("▼", UDim2.new(0, 7, 0, 65), Color3.fromRGB(60, 60, 60), Color3.fromRGB(255, 255, 255), AltitudeControls)

local upPressed = false
local downPressed = false

BtnUp.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        upPressed = true
    end
end)
BtnUp.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        upPressed = false
    end
end)

BtnDown.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        downPressed = true
    end
end)
BtnDown.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        downPressed = false
    end
end)

FlyButton.MouseButton1Click:Connect(function()
    flyEnabled = not flyEnabled
    local char = Player.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChild("Humanoid")

    if not (char and root and hum) then
        flyEnabled = false
        return
    end

    if flyEnabled then
        FlyButton.Text = "Desativar Fly"
        FlyButton.BackgroundColor3 = Color3.fromRGB(180, 180, 180)
        FlyButton.TextColor3 = Color3.fromRGB(0, 0, 0)
        AltitudeControls.Visible = true

        hum.PlatformStand = true
        hum.AutoRotate = false

        bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.MaxForce = Vector3.new(400000, 400000, 400000)
        bodyVelocity.Velocity = Vector3.zero
        bodyVelocity.P = 10000
        bodyVelocity.Parent = root

        bodyGyro = Instance.new("BodyGyro")
        bodyGyro.MaxTorque = Vector3.new(400000, 400000, 400000)
        bodyGyro.P = 10000
        bodyGyro.CFrame = root.CFrame
        bodyGyro.Parent = root

        flyConnection = RunService.RenderStepped:Connect(function()
            if not (char and root and root.Parent and hum) then
                flyEnabled = false
                FlyButton.Text = "Ativar Fly"
                FlyButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                FlyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                AltitudeControls.Visible = false
                if flyConnection then flyConnection:Disconnect() end
                if bodyVelocity then bodyVelocity:Destroy() end
                if bodyGyro then bodyGyro:Destroy() end
                return
            end

            local speed = tonumber(FlySpeedTextBox.Text) or 50
            local moveDir = Vector3.zero
            local camera = workspace.CurrentCamera

            if camera then
                local camLook = camera.CFrame.LookVector
                local camRight = camera.CFrame.RightVector

                local humMove = hum.MoveDirection
                if humMove.Magnitude > 0.1 then
                    local forwardProjected = camLook * Vector3.new(1,0,1)
                    if forwardProjected.Magnitude > 0.01 then
                        forwardProjected = forwardProjected.Unit
                    else
                        forwardProjected = Vector3.new(0,0,-1)
                    end

                    local rightProjected = camRight * Vector3.new(1,0,1)
                    if rightProjected.Magnitude > 0.01 then
                        rightProjected = rightProjected.Unit
                    else
                        rightProjected = Vector3.new(1,0,0)
                    end

                    local forwardAmount = humMove:Dot(forwardProjected)
                    local rightAmount = humMove:Dot(rightProjected)

                    moveDir += camLook * forwardAmount + camRight * rightAmount
                end

                if upPressed then
                    moveDir += Vector3.new(0, 1, 0)
                end
                if downPressed then
                    moveDir -= Vector3.new(0, 1, 0)
                end
            end

            if moveDir.Magnitude > 0 then
                bodyVelocity.Velocity = moveDir.Unit * speed
            else
                bodyVelocity.Velocity = Vector3.zero
            end

            bodyGyro.CFrame = root.CFrame
        end)
    else
        FlyButton.Text = "Ativar Fly"
        FlyButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        FlyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        AltitudeControls.Visible = false

        if flyConnection then flyConnection:Disconnect() end
        if bodyVelocity then bodyVelocity:Destroy() end
        if bodyGyro then bodyGyro:Destroy() end
        if hum then
            hum.PlatformStand = false
            hum.AutoRotate = true
        end
        upPressed = false
        downPressed = false
    end
end)

AddSeparator(ScrollingFrame)

-- ========== MULTI JUMP ==========
CreateLabel("MULTI JUMP", ScrollingFrame)
local MultiJumpButton = CreateButton("Ativar Multi Jump", ScrollingFrame)
local multiJumpEnabled = false
local jumpRequestConnection

local function onJumpRequest()
    if not multiJumpEnabled then return end
    local char = Player.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChild("Humanoid")
    if not root or not hum then return end

    local state = hum:GetState()
    if state ~= Enum.HumanoidStateType.Landed and state ~= Enum.HumanoidStateType.Running and state ~= Enum.HumanoidStateType.Seated then
        root.Velocity = Vector3.new(root.Velocity.X, 50, root.Velocity.Z)
    end
end

MultiJumpButton.MouseButton1Click:Connect(function()
    multiJumpEnabled = not multiJumpEnabled
    if multiJumpEnabled then
        MultiJumpButton.Text = "Desativar Multi Jump"
        MultiJumpButton.BackgroundColor3 = Color3.fromRGB(180, 180, 180)
        MultiJumpButton.TextColor3 = Color3.fromRGB(0, 0, 0)
        jumpRequestConnection = UserInputService.JumpRequest:Connect(onJumpRequest)
    else
        MultiJumpButton.Text = "Ativar Multi Jump"
        MultiJumpButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        MultiJumpButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        if jumpRequestConnection then
            jumpRequestConnection:Disconnect()
            jumpRequestConnection = nil
        end
    end
end)

AddSeparator(ScrollingFrame)

-- ========== TELEPORT ==========
CreateLabel("TELEPORT", ScrollingFrame)
local TeleportButton = CreateButton("Ativar Teleport", ScrollingFrame)
local teleportEnabled = false
local teleportConnection

TeleportButton.MouseButton1Click:Connect(function()
    teleportEnabled = not teleportEnabled
    if teleportEnabled then
        TeleportButton.Text = "Desativar Teleport"
        TeleportButton.BackgroundColor3 = Color3.fromRGB(180, 180, 180)
        TeleportButton.TextColor3 = Color3.fromRGB(0, 0, 0)
        teleportConnection = Mouse.Button1Down:Connect(function()
            if not teleportEnabled then return end
            local char = Player.Character
            local root = char and char:FindFirstChild("HumanoidRootPart")
            if root then
                local targetPos = Mouse.Hit.Position
                root.CFrame = CFrame.new(targetPos + Vector3.new(0, 3, 0))
            end
        end)
    else
        TeleportButton.Text = "Ativar Teleport"
        TeleportButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        TeleportButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        if teleportConnection then
            teleportConnection:Disconnect()
            teleportConnection = nil
        end
    end
end)

AddSeparator(ScrollingFrame)

-- ========== NOCLIP ==========
CreateLabel("NOCLIP", ScrollingFrame)
local NoclipButton = CreateButton("Ativar Noclip", ScrollingFrame)
local noclipEnabled = false
local noclipConnection

NoclipButton.MouseButton1Click:Connect(function()
    noclipEnabled = not noclipEnabled
    if noclipEnabled then
        NoclipButton.Text = "Desativar Noclip"
        NoclipButton.BackgroundColor3 = Color3.fromRGB(180, 180, 180)
        NoclipButton.TextColor3 = Color3.fromRGB(0, 0, 0)
        noclipConnection = RunService.Stepped:Connect(function()
            if Player.Character then
                for _, v in ipairs(Player.Character:GetDescendants()) do
                    if v:IsA("BasePart") and v.CanCollide then
                        v.CanCollide = false
                    end
                end
            end
        end)
    else
        NoclipButton.Text = "Ativar Noclip"
        NoclipButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        NoclipButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        if noclipConnection then noclipConnection:Disconnect() end
        if Player.Character then
            for _, v in ipairs(Player.Character:GetDescendants()) do
                if v:IsA("BasePart") then
                    v.CanCollide = true
                end
            end
        end
    end
end)

AddSeparator(ScrollingFrame)

-- ========== RESET ==========
local ResetButton = CreateButton("Resetar Personagem", ScrollingFrame)
ResetButton.MouseButton1Click:Connect(function()
    if Player.Character then
        Player.Character:BreakJoints()
    end
end)

-- ========== MINIMIZAR / ABRIR ==========
local isMinimized = false
local originalSize = MainFrame.Size

local OpenButton = Instance.new("TextButton")
OpenButton.Size = UDim2.new(0, 48, 0, 48)
OpenButton.Position = UDim2.new(0, 20, 0.5, -24)
OpenButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
OpenButton.BorderSizePixel = 0
OpenButton.Text = "+"
OpenButton.TextColor3 = Color3.fromRGB(255, 255, 255)
OpenButton.Font = Enum.Font.GothamBold
OpenButton.TextSize = 30
OpenButton.Visible = false
OpenButton.Parent = ScreenGui

local OpenCorner = Instance.new("UICorner")
OpenCorner.CornerRadius = UDim.new(0, 12)
OpenCorner.Parent = OpenButton

local OpenShadow = Instance.new("UIStroke")
OpenShadow.Color = Color3.fromRGB(255, 255, 255)
OpenShadow.Thickness = 2
OpenShadow.Transparency = 0.6
OpenShadow.Parent = OpenButton

MinimizeButton.MouseButton1Click:Connect(function()
    isMinimized = true
    ContentFrame.Visible = false
    MainFrame.Size = UDim2.new(0, 280, 0, 35)
    OpenButton.Visible = true
end)

OpenButton.MouseButton1Click:Connect(function()
    isMinimized = false
    ContentFrame.Visible = tr
