local Workspace = game:GetService('Workspace')
local RunService = game:GetService('RunService')

local CurrentCamera = Workspace.CurrentCamera

local function Vector3ToVector2(position: Vector3) : Vector2
    local newPosition: Vector3 = CurrentCamera:WorldToViewportPoint(position)

    return Vector2.new(newPosition.X, newPosition.Y)
end

local module = {}

function module:Destroy()
    if getgenv()._DRAWS then
        local Connections = getgenv()._DRAWS['Connections'] or {}
        local Texts = getgenv()._DRAWS['Texts'] or {}

        for _, v in next, Connections do
            v:Disconnect()
        end
        for _, v in next, Texts do
            v:Remove()
        end

        getgenv()._DRAWS = {
            ['Connections'] = {},
            ['Texts'] = {}
        }
    end
end

function module:Add(player: Player)
    local _Text = Drawing.new('Text');

    _Text.Text = player.Name == player.DisplayName and player.Name or player.DisplayName..' (@'..player.Name..')'
    _Text.Size = 15
    _Text.Color = Color3.fromRGB(200, 200, 200)
    _Text.Center = true
    _Text.Transparency = 1
    _Text.Visible = true
    
    local Connection = RunService.RenderStepped:Connect(function()
        local Character = player.Character
        if Character then
            local Vector2Position: any = Vector3ToVector2(Character:FindFirstChild("HumanoidRootPart").Position)

            _Text.Position = Vector2Position
        end
    end)

    table.insert(getgenv()._DRAWS['Connections'], Connection)
    table.insert(getgenv()._DRAWS['Texts'], _Text)
end

return module