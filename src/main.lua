local Players = game:GetService('Players')

local ESP = getgenv().require_file('Utils')

ESP:Destroy()

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