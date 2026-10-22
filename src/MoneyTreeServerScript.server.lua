-- Money Tree Server Script

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")

local MoneyTreeEvent = Instance.new("RemoteEvent")
MoneyTreeEvent.Name = "MoneyTreeEvent"
MoneyTreeEvent.Parent = ReplicatedStorage

local MoneyTrees = {}
local Leader = nil

local function UpdateLeader()
    local highestMoney = 0
    for _, player in ipairs(Players:GetPlayers()) do
        local money = player.leaderstats.Money.Value
        if money > highestMoney then
            highestMoney = money
            Leader = player
        end
    end
end

local function TeleportToLeader(player)
    if Leader and Leader ~= player then
        player.Character:MoveTo(Leader.Character.HumanoidRootPart.Position)
    end
end

local function TeleportToMoneyTree(player, treeId)
    local tree = MoneyTrees[treeId]
    if tree then
        player.Character:MoveTo(tree.Position)
    end
end

MoneyTreeEvent.OnServerEvent:Connect(function(player, action, ...)
    if action == "RegisterTree" then
        local treeId, position = ...
        MoneyTrees[treeId] = position
    elseif action == "UpdateLeader" then
        UpdateLeader()
    elseif action == "TeleportToLeader" then
        TeleportToLeader(player)
    elseif action == "TeleportToMoneyTree" then
        local treeId = ...
        TeleportToMoneyTree(player, treeId)
    end
end)

Players.PlayerAdded:Connect(function(player)
    local leaderstats = Instance.new("Folder")
    leaderstats.Name = "leaderstats"
    leaderstats.Parent = player

    local money = Instance.new("IntValue")
    money.Name = "Money"
    money.Value = 0
    money.Parent = leaderstats

    UpdateLeader()
end)

Players.PlayerRemoving:Connect(function(player)
    UpdateLeader()
end)