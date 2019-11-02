characters = {}

local root = GM.FolderName .. "/gamemode/chars/"
local _, folders = file.Find(root .. "*", "LUA")

for _, folder in SortedPairs(folders, true) do
	character = util.JSONToTable(file.Read(root .. folder .. "/" .. "description.json", "LUA"))
	
	table.insert(characters, {["name"] = character.name, ["model"] = character.model, ["weapon"] = character.weapon, ["health"] = character.health})
end