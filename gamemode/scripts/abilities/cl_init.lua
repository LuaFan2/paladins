function GM:OnSpawnMenuOpen()
    local q = net.Start("paladins.useQ")
    net.SendToServer()
        
    return
end

function GM:KeyPress(_, key)
    if key == IN_USE then
        net.Start("paladins.useE")
        net.SendToServer()
    end
end