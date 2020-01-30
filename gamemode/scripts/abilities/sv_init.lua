util.AddNetworkString "paladins.useQ"
util.AddNetworkString "paladins.useE"

paladins.abilities = {}

Ability = {}

function Ability.Find(c)
    local abilities = {}
    
    for k, v in pairs(paladins.abilities) do
        if v.description.character == c then
            abilities[#abilities + 1] = v
        end
    end
    
    return abilities
end

function Ability:New()
    local obj = {}
    
    function Ability:Description(f)
        local raw = file.Read( f, "LUA" )
        
        obj.description = {}
		local data = util.JSONToTable(raw)
        
        obj.description = {
            ["name"] = data.name,
            ["character"] = data.character
        }
    end
    
    function Ability:F(f)
        obj.f = f
    end

    function Ability:Q(f)
        obj.q = f
    end

    function Ability:E(f)
        obj.e = f
    end
    
    function Ability:Register()
        paladins.abilities[#paladins.abilities + 1] = obj
    end

    setmetatable(obj, self)
    self.__index = self; return obj
end

local root = GM.FolderName .. "/gamemode/chars/"
local _, folders = file.Find(root .. "*", "LUA")

for _, folderc in SortedPairs(folders, true) do
	local root = GM.FolderName .. "/gamemode/chars/" .. folderc .. "/abilities/"
	local _, folders = file.Find(root .. "*", "LUA")
	for _, folder in SortedPairs(folders, true) do
		include(root .. folder .. "/" .. "main.lua")
	end
end

net.Receive("paladins.useQ", function(_, ply)
    if not paladins.players[ply] then return end
    local abilities = Ability.Find(paladins.players[ply])
    
    for k, ability in pairs(abilities) do
        if ability.q then
            ability.q(ply)
        end
    end
end)

function GM:PlayerSwitchFlashlight(ply)
    if not paladins.players[ply] then return end
    local abilities = Ability.Find(paladins.players[ply])
    
    for k, ability in pairs(abilities) do
        if ability.f then
            ability.f(ply)
        end
    end
end

net.Receive("paladins.useE", function(_, ply)
    if not paladins.players[ply] then return end
    local abilities = Ability.Find(paladins.players[ply])
            
    for k, ability in pairs(abilities) do
        if ability.e then
            ability.e(ply)
        end
    end
end)