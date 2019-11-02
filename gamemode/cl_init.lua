GM.Version = "0.0.1"
GM.Name = "Paladins"
GM.Author = "Deleted"

DeriveGamemode("sandbox")
DEFINE_BASECLASS("gamemode_sandbox")
GM.Sandbox = BaseClass

local root = GM.FolderName .. "/gamemode/scripts/"
local _, folders = file.Find(root .. "*", "LUA")
	
for _, folder in SortedPairs(folders, true) do
	for _, File in SortedPairs(file.Find(root .. folder .. '/*.lua', "LUA"), true) do
		if string.match(File, "sh_.*.lua") then include(root .. folder .. "/" .. File) end
		if string.match(File, "cl_.*.lua") then include(root .. folder .. "/" .. File) end
	end
end