# ESP

## Owner: *AltLexon*

<br>

### Made with Drawing Library.

```lua

getgenv().Settings = {
    TextColor = Color3.fromRGB(200, 200, 200),
    TextSize = 15,
    Part = 'Head' -- HumanoidRootPart, Head or Torso
}

local Creator, Repo, Name = 'AltLexon', 'ESP', 'Script.lua'

local url = string.format('https://raw.githubusercontent.com/%s/%s/master/%s', Creator, Repo, Name)

loadstring(game:HttpGet(url))()
```