util.AddNetworkString "paladins.chooseCharacter"

paladins.characters = {}

Character = {}

function Character:New()
    local obj = {}
    
    function Character:Description(f)
        local raw = file.Read( f, "LUA" )
        
        obj.description = {}
		local data = util.JSONToTable(raw)
        
        obj.description = {
            ["name"] = data.name,
            ["card"] = data.card,
            
            ["model"] = data.model,
            ["weapon"] = data.weapon,
            
            ["health"] = data.health,
            ["shield"] = data.shield or 0
        }
    end
    
    function Character:Register()
        paladins.characters[#paladins.characters + 1] = obj
    end

    setmetatable(obj, self)
    self.__index = self; return obj
end

local root = GM.FolderName .. "/gamemode/chars/"
local _, folders = file.Find(root .. "*", "LUA")

for _, folder in SortedPairs(folders, true) do
	include(root .. folder .. "/" .. "main.lua")
end

net.Receive("paladins.chooseCharacter", function(_, ply)
    local name = net.ReadString()
    
    for k, v in pairs(paladins.characters) do
        if v.description.name == name then
            if paladins.players[ply] and paladins.players[ply] == name then return end
            paladins.players[ply] = name
            
            local desc = v.description
            
            ply:StripWeapons()
            ply:SetHealth(desc.health)
            ply:SetMaxHealth(desc.health)
            
            ply:SetArmor(desc.shield)
            ply:Give(desc.weapon)
        end
    end

end)