-- Teleport to Leader Script

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local MoneyTreeEvent = ReplicatedStorage:WaitForChild("MoneyTreeEvent")
local Player = Players.LocalPlayer

local function OnInputBegan(input, gameProcessed)
    if input.KeyCode == Enum.KeyCode.T and not gameProcessed then
        MoneyTreeEvent:FireServer("TeleportToLeader")
    end
end

UserInputService.InputBegan:Connect(OnInputBegan)