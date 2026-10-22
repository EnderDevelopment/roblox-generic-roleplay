-- Teleport to Money Tree Script

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local MoneyTreeEvent = ReplicatedStorage:WaitForChild("MoneyTreeEvent")
local Player = Players.LocalPlayer

local function OnInputBegan(input, gameProcessed)
    if input.KeyCode == Enum.KeyCode.M and not gameProcessed then
        local character = Player.Character
        if character then
            local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
            if humanoidRootPart then
                local position = humanoidRootPart.Position
                local treeId = "Tree_" .. tostring(math.random(1, 1000))
                MoneyTreeEvent:FireServer("TeleportToMoneyTree", treeId)
            end
        end
    end
end

UserInputService.InputBegan:Connect(OnInputBegan)