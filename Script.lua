local _1_, _2_ = 'ESP', 'src'

local src = string.format('https://raw.githubusercontent.com/AltLexon/%s/main/%s/', _1_, _2_)

local function get_script(name: string)
    return game:HttpGet(src..name..'.lua')
end

getgenv().require_file = function(name)
    local content = get_script(name)
    local load_string = loadstring(content)
    return load_string()
end

getgenv().require_file('main')