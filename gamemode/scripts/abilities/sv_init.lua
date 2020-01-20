paladins.abilities = {}

Ability = {}

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
        obj.q = q
    end

    function Ability:E(f)
        obj.f = f
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