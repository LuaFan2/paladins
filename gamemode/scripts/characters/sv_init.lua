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