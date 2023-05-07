local Players = game:GetService('Players')

local ESP = getgenv().require_file('Utils')

ESP:Destroy()

getgenv()._DRAWS = {
    ['Connections'] = {},
    ['Texts'] = {},
    ['EXTRA'] = {}
}

for _, player in next, Players:GetPlayers() do
    if player ~= Players.LocalPlayer then
        ESP:Add(player)
    end
end

local _1_ = Players.PlayerAdded:Connect(function(player: Player)
    if player ~= Players.LocalPlayer then
        ESP:Add(player)
    end
end)

local _2_ = Players.PlayerRemoving:Connect(function(player: Player)
    ESP:Remove(player)
end)

table.insert(getgenv()._DRAWS['EXTRA'], _1_)
table.insert(getgenv()._DRAWS['EXTRA'], _2_)