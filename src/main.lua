local Players = game:GetService('Players')

local ESP = getgenv().require_file('Utils')

ESP:Destroy()

getgenv()._DRAWS = {
    ['Connections'] = {},
    ['Texts'] = {}
}

for _, player in next, Players:GetPlayers() do
    if player ~= Players.LocalPlayer then
        ESP:Add(player)
    end
end

Players.PlayerAdded:Connect(function(player: Player)
    if player ~= Players.LocalPlayer then
        ESP:Add(player)
    end
end)

Players.PlayerRemoving:Connect(function(player: Player)
    ESP:Remove()
end)