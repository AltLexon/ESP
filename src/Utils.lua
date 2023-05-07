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

    local Settings = getgenv().Settings

    local _Text = Drawing.new('Text');

    _Text.Text = player.Name == player.DisplayName and player.Name or player.DisplayName..' (@'..player.Name..')'
    _Text.Size = Settings.TextSize
    _Text.Color = Settings.TextColor
    _Text.Center = true
    _Text.Transparency = 1
    _Text.Visible = true
    
    local Connection = RunService.RenderStepped:Connect(function()
        local Character = player.Character
        if Character then
            local Part: any = Character:FindFirstChild(Settings.Part)

            if not Part then
                return
            end

            local Vector2Position: Vector2 = Vector3ToVector2(Character:FindFirstChild(Settings.Part).Position)

            _Text.Position = Vector2Position
        end
    end)

    if not getgenv()._DRAWS or not getgenv()._DRAWS['Connections'] or not getgenv()._DRAWS['Texts'] then
        return
    end

    getgenv()._DRAWS['Connections'][player.Name] = Connection
    getgenv()._DRAWS['Texts'][player.Name] = _Text
end

function module:Remove(player: Player)
    if getgenv()._DRAWS and getgenv()._DRAWS['Connections'] and getgenv()._DRAWS['Connections'][player.Name] then
        getgenv()._DRAWS['Connections'][player.Name]:Disconnect()
        getgenv()._DRAWS['Texts'][player.Name]:Remove()
    end
end

return module