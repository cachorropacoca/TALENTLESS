-- Sistema GitHub para TALENTLESS
-- UI identica ao sistema local antigo

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Instances:
local addgui = Instance.new("ScreenGui")
local newsongframe = Instance.new("Frame")
local insertscript = Instance.new("TextBox")
local newsonglabel = Instance.new("TextLabel")
local cancelButton = Instance.new("TextButton")
local insertsongName = Instance.new("TextBox")
local submitSong = Instance.new("TextButton")
local UIListLayout = Instance.new("UIListLayout")

--Properties:
addgui.Name = "addgui"
addgui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
addgui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

newsongframe.Name = "newsongframe"
newsongframe.Parent = addgui
newsongframe.AnchorPoint = Vector2.new(0.5, 0.5)
newsongframe.BackgroundColor3 = Color3.fromRGB(33, 33, 41)
newsongframe.BorderColor3 = Color3.fromRGB(0, 0, 0)
newsongframe.BorderSizePixel = 0
newsongframe.Position = UDim2.new(0.5, 0, 0.5, 0)
newsongframe.Size = UDim2.new(0, 254, 0, 326)

insertscript.Name = "insertscript"
insertscript.Parent = newsongframe
insertscript.BackgroundColor3 = Color3.fromRGB(96, 102, 121)
insertscript.BorderColor3 = Color3.fromRGB(76, 82, 101)
insertscript.BorderSizePixel = 4
insertscript.LayoutOrder = 2
insertscript.Position = UDim2.new(0.0708699971, 0, 0.257669985, 0)
insertscript.Size = UDim2.new(0, 218, 0, 123)
insertscript.Font = Enum.Font.SourceSans
insertscript.PlaceholderText = "Cole o codigo da musica aqui (bpm sera extraido automaticamente)"
insertscript.Text = ""
insertscript.TextColor3 = Color3.fromRGB(255, 255, 255)
insertscript.TextSize = 14.000
insertscript.TextWrapped = true
insertscript.MultiLine = true
insertscript.ClearTextOnFocus = false

newsonglabel.Name = "newsonglabel"
newsonglabel.Parent = newsongframe
newsonglabel.BackgroundColor3 = Color3.fromRGB(76, 82, 101)
newsonglabel.BorderColor3 = Color3.fromRGB(64, 68, 90)
newsonglabel.BorderSizePixel = 4
newsonglabel.LayoutOrder = 1
newsonglabel.Position = UDim2.new(0.0708699971, 0, 0.0552100018, 0)
newsonglabel.Size = UDim2.new(0, 218, 0, 50)
newsonglabel.Font = Enum.Font.SourceSansBold
newsonglabel.Text = "Adicionar Musica (GitHub)"
newsonglabel.TextColor3 = Color3.fromRGB(255, 255, 255)
newsonglabel.TextScaled = true
newsonglabel.TextWrapped = true

cancelButton.Name = "cancelButton"
cancelButton.Parent = newsonglabel
cancelButton.AnchorPoint = Vector2.new(1, 0)
cancelButton.BackgroundColor3 = Color3.fromRGB(170, 85, 85)
cancelButton.BorderColor3 = Color3.fromRGB(255, 255, 255)
cancelButton.Position = UDim2.new(1.10091746, 10, -0.400000006, -10)
cancelButton.Size = UDim2.new(0, 40, 0, 40)
cancelButton.Font = Enum.Font.SourceSansBold
cancelButton.Text = "X"
cancelButton.TextColor3 = Color3.fromRGB(255, 255, 255)
cancelButton.TextSize = 45.000

insertsongName.Name = "insertsongName"
insertsongName.Parent = newsongframe
insertsongName.BackgroundColor3 = Color3.fromRGB(96, 102, 121)
insertsongName.BorderColor3 = Color3.fromRGB(64, 68, 90)
insertsongName.BorderSizePixel = 4
insertsongName.LayoutOrder = 3
insertsongName.Position = UDim2.new(0.0708699971, 0, 0.69325, 0)
insertsongName.Size = UDim2.new(0, 218, 0, 32)
insertsongName.Font = Enum.Font.SourceSans
insertsongName.PlaceholderText = "Nome da musica"
insertsongName.Text = ""
insertsongName.TextColor3 = Color3.fromRGB(255, 255, 255)
insertsongName.TextSize = 20
insertsongName.TextWrapped = true

submitSong.Name = "submitSong"
submitSong.Parent = newsongframe
submitSong.BackgroundColor3 = Color3.fromRGB(85, 170, 85)
submitSong.BorderColor3 = Color3.fromRGB(0, 0, 0)
submitSong.BorderSizePixel = 0
submitSong.LayoutOrder = 4
submitSong.Position = UDim2.new(0.0708699971, 0, 0.834360003, 0)
submitSong.Size = UDim2.new(0, 218, 0, 41)
submitSong.Font = Enum.Font.SourceSansBold
submitSong.Text = "Enviar"
submitSong.TextColor3 = Color3.fromRGB(255, 255, 255)
submitSong.TextSize = 43.000

UIListLayout.Parent = newsongframe
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
UIListLayout.Padding = UDim.new(0, 15)

-- Drag script
local UserInputService = game:GetService("UserInputService")
local gui = newsongframe
local dragging
local dragInput
local dragStart
local startPos

local function update(input)
    local delta = input.Position - dragStart
    gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

gui.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = gui.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

gui.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

-- Cancel button
cancelButton.MouseButton1Click:Connect(function()
    addgui:Destroy()
end)

-- Submit button
submitSong.MouseButton1Click:Connect(function()
    local scriptInput = insertscript.Text
    local songName = insertsongName.Text
    
    if songName == "" or scriptInput == "" then
        warn("Preencha todos os campos!")
        submitSong.Text = "Erro: Preencha todos os campos"
        submitSong.BackgroundColor3 = Color3.fromRGB(170, 85, 85)
        wait(2)
        submitSong.Text = "Enviar"
        submitSong.BackgroundColor3 = Color3.fromRGB(85, 170, 85)
        return
    end
    
    -- Extrair BPM do codigo
    local bpm = scriptInput:match("bpm%s*=%s*(%d+)")
    if not bpm then
        warn("BPM nao encontrado no codigo!")
        submitSong.Text = "Erro: BPM nao encontrado"
        submitSong.BackgroundColor3 = Color3.fromRGB(170, 85, 85)
        wait(2)
        submitSong.Text = "Enviar"
        submitSong.BackgroundColor3 = Color3.fromRGB(85, 170, 85)
        return
    end
    
    submitSong.Text = "Enviando para GitHub..."
    submitSong.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
    
    -- Chamar funcao de upload do Talentless.lua
    if _G.uploadSongToGitHub then
        local success, message = _G.uploadSongToGitHub(songName, bpm, scriptInput, LocalPlayer.Name)
        
        if success then
            submitSong.Text = "Sucesso!"
            submitSong.BackgroundColor3 = Color3.fromRGB(85, 170, 85)
            insertscript.Text = ""
            insertsongName.Text = ""
            wait(1)
            
            -- Atualizar lista de musicas
            if _G.updateSongs then
                _G.updateSongs()
            end
            
            addgui:Destroy()
        else
            submitSong.Text = "Erro: " .. tostring(message)
            submitSong.BackgroundColor3 = Color3.fromRGB(170, 85, 85)
            wait(3)
            submitSong.Text = "Enviar"
            submitSong.BackgroundColor3 = Color3.fromRGB(85, 170, 85)
        end
    else
        submitSong.Text = "Erro: Funcao nao encontrada"
        submitSong.BackgroundColor3 = Color3.fromRGB(170, 85, 85)
        warn("_G.uploadSongToGitHub nao esta disponivel!")
    end
end)

print("Interface de adicionar musica carregada!")
