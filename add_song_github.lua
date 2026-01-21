-- Script para adicionar músicas customizadas ao GitHub
-- Por TALENTLESS

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local CoreGui = game:GetService("CoreGui")

-- Criar GUI de upload
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "AddSongGitHub"
ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
MainFrame.Size = UDim2.new(0, 400, 0, 300)
MainFrame.Active = true
MainFrame.Draggable = true

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundTransparency = 1
Title.Position = UDim2.new(0, 0, 0, 10)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Font = Enum.Font.SourceSansBold
Title.Text = "Adicionar Musica"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 24

local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Parent = MainFrame
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
CloseButton.Position = UDim2.new(1, -35, 0, 10)
CloseButton.Size = UDim2.new(0, 25, 0, 25)
CloseButton.Font = Enum.Font.SourceSansBold
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 18

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 5)
CloseCorner.Parent = CloseButton

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Campo Nome da Música
local NameLabel = Instance.new("TextLabel")
NameLabel.Parent = MainFrame
NameLabel.BackgroundTransparency = 1
NameLabel.Position = UDim2.new(0, 20, 0, 60)
NameLabel.Size = UDim2.new(1, -40, 0, 20)
NameLabel.Font = Enum.Font.SourceSans
NameLabel.Text = "Nome da Musica:"
NameLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
NameLabel.TextSize = 16
NameLabel.TextXAlignment = Enum.TextXAlignment.Left

local NameBox = Instance.new("TextBox")
NameBox.Name = "NameBox"
NameBox.Parent = MainFrame
NameBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
NameBox.BorderSizePixel = 0
NameBox.Position = UDim2.new(0, 20, 0, 85)
NameBox.Size = UDim2.new(1, -40, 0, 35)
NameBox.Font = Enum.Font.SourceSans
NameBox.PlaceholderText = "Ex: Minha Musica"
NameBox.Text = ""
NameBox.TextColor3 = Color3.fromRGB(255, 255, 255)
NameBox.TextSize = 16

local NameCorner = Instance.new("UICorner")
NameCorner.CornerRadius = UDim.new(0, 5)
NameCorner.Parent = NameBox

-- Campo Código da Música
local CodeLabel = Instance.new("TextLabel")
CodeLabel.Parent = MainFrame
CodeLabel.BackgroundTransparency = 1
CodeLabel.Position = UDim2.new(0, 20, 0, 130)
CodeLabel.Size = UDim2.new(1, -40, 0, 20)
CodeLabel.Font = Enum.Font.SourceSans
CodeLabel.Text = "Codigo da Musica (Cole aqui):"
CodeLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
CodeLabel.TextSize = 16
CodeLabel.TextXAlignment = Enum.TextXAlignment.Left

local CodeBox = Instance.new("TextBox")
CodeBox.Name = "CodeBox"
CodeBox.Parent = MainFrame
CodeBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
CodeBox.BorderSizePixel = 0
CodeBox.Position = UDim2.new(0, 20, 0, 155)
CodeBox.Size = UDim2.new(1, -40, 0, 90)
CodeBox.Font = Enum.Font.SourceSans
CodeBox.PlaceholderText = "Cole o codigo Lua da musica aqui..."
CodeBox.Text = ""
CodeBox.TextColor3 = Color3.fromRGB(255, 255, 255)
CodeBox.TextSize = 14
CodeBox.TextWrapped = true
CodeBox.MultiLine = true
CodeBox.ClearTextOnFocus = false

local CodeCorner = Instance.new("UICorner")
CodeCorner.CornerRadius = UDim.new(0, 5)
CodeCorner.Parent = CodeBox

-- Botão de Upload
local UploadButton = Instance.new("TextButton")
UploadButton.Name = "UploadButton"
UploadButton.Parent = MainFrame
UploadButton.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
UploadButton.BorderSizePixel = 0
UploadButton.Position = UDim2.new(0, 20, 0, 255)
UploadButton.Size = UDim2.new(1, -40, 0, 35)
UploadButton.Font = Enum.Font.SourceSansBold
UploadButton.Text = "Adicionar"
UploadButton.TextColor3 = Color3.fromRGB(255, 255, 255)
UploadButton.TextSize = 18

local UploadCorner = Instance.new("UICorner")
UploadCorner.CornerRadius = UDim.new(0, 5)
UploadCorner.Parent = UploadButton

-- Função de Upload
UploadButton.MouseButton1Click:Connect(function()
    local songName = NameBox.Text
    local code = CodeBox.Text
    
    if songName == "" or code == "" then
        warn("Preencha todos os campos!")
        UploadButton.Text = "Erro: Campos vazios"
        UploadButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        wait(2)
        UploadButton.Text = "Adicionar"
        UploadButton.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
        return
    end
    
    -- Extrair BPM do código automaticamente
    local bpm = code:match("bpm%s*=%s*(%d+)")
    if not bpm then
        warn("BPM nao encontrado no codigo! Adicione 'bpm = X' no codigo.")
        UploadButton.Text = "Erro: BPM nao encontrado"
        UploadButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        wait(3)
        UploadButton.Text = "Adicionar"
        UploadButton.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
        return
    end
    
    UploadButton.Text = "Enviando..."
    UploadButton.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    
    -- Chamar função de upload (precisa estar definida no script principal)
    if uploadSongToGitHub then
        local success, message = uploadSongToGitHub(songName, bpm, code, LocalPlayer.Name)
        
        if success then
            UploadButton.Text = "Sucesso!"
            UploadButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
            wait(2)
            ScreenGui:Destroy()
        else
            UploadButton.Text = "Erro: " .. tostring(message)
            UploadButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
            wait(3)
            UploadButton.Text = "Adicionar"
            UploadButton.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
        end
    else
        UploadButton.Text = "Funcao nao encontrada!"
        UploadButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
    end
end)

print("GUI de upload carregada!")
