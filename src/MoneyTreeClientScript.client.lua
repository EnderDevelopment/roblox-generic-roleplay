-- Money Tree Client Script

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local MoneyTreeEvent = ReplicatedStorage:WaitForChild("MoneyTreeEvent")
local Player = Players.LocalPlayer

local function CreateMoneyTreeESP(tree)
    local billboardGui = Instance.new("BillboardGui")
    billboardGui.Name = "MoneyTreeESP"
    billboardGui.Size = UDim2.new(0, 100, 0, 50)
    billboardGui.StudsOffset = Vector3.new(0, 3, 0)
    billboardGui.AlwaysOnTop = true
    billboardGui.Parent = tree

    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.TextColor3 = Color3.new(1, 1, 1)
    textLabel.Text = "Money Tree"
    textLabel.Parent = billboardGui
end

local function OnInputBegan(input, gameProcessed)
    if input.KeyCode == Enum.KeyCode.E and not gameProcessed then
        local character = Player.Character
        if character then
            local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
            if humanoidRootPart then
                local position = humanoidRootPart.Position
                local treeId = "Tree_" .. tostring(math.random(1, 1000))
                MoneyTreeEvent:FireServer("RegisterTree", treeId, position)
            end
        end
    end
end

UserInputService.InputBegan:Connect(OnInputBegan)

local function OnCharacterAdded(character)
    local humanoid = character:WaitForChild("Humanoid")
    humanoid.Died:Connect(function()
        MoneyTreeEvent:FireServer("UpdateLeader")
    end)
end

Player.CharacterAdded:Connect(OnCharacterAdded)

local function OnPlayerAdded(player)
    if player == Player then
        MoneyTreeEvent:FireServer("UpdateLeader")
    end
end

Players.PlayerAdded:Connect(OnPlayerAdded)

local function OnPlayerRemoving(player)
    if player == Player then
        MoneyTreeEvent:FireServer("UpdateLeader")
    end
end

Players.PlayerRemoving:Connect(OnPlayerRemoving)

-- Create ESP for existing money trees
for _, tree in ipairs(workspace:GetChildren()) do
    if tree.Name == "MoneyTree" then
        CreateMoneyTreeESP(tree)
    end
end

-- Listen for new money trees
workspace.ChildAdded:Connect(function(child)
    if child.Name == "MoneyTree" then
        CreateMoneyTreeESP(child)
    end
end)