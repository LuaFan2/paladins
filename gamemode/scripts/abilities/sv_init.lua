abilities = {}

local root = GM.FolderName .. "/gamemode/chars/"
local _, folders = file.Find(root .. "*", "LUA")

for _, folderc in SortedPairs(folders, true) do
	local root = GM.FolderName .. "/gamemode/chars/" .. folderc .. "/abilities/"
	local _, folders = file.Find(root .. "*", "LUA")
	for _, folder in SortedPairs(folders, true) do
		ability = util.JSONToTable(file.Read(root .. folder .. "/" .. "description.json", "LUA"))
		table.insert(abilities, {["name"] = ability.name, ["character"] = folderc})
	end
end