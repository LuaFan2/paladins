util.AddNetworkString "paladins.charactersMenu"

function GM:ShowSpare2(ply)
    net.Start("paladins.charactersMenu")
    net.WriteTable(paladins.characters)
    net.Send(ply)
end