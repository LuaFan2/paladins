local panel

local blur = Material("pp/blurscreen")

function draw.Blur(panel, amount)
    local x, y = panel:LocalToScreen(0, 0)
    local scrW, scrH = ScrW(), ScrH()
    surface.SetDrawColor(255, 255, 255)
    surface.SetMaterial(blur)
    for i = 1, 3 do
        blur:SetFloat("$blur", (i / 3) * (amount or 6))
        blur:Recompute()
        render.UpdateScreenEffectTexture()
        surface.DrawTexturedRect(x * -1, y * -1, scrW, scrH)
    end
end

local function F4()
    local characters = net.ReadTable()
    local materials = {}
    
    for k, v in pairs(characters) do
        materials[v.description.name] = Material(v.description.card)
    end
    
    local rows = {
        [1] = {"", "", "", "", "", "", ""},
        [2] = {"", "", "", "", "", "", ""},
        [3] = {"", "", "", "", "", "", ""}
    }
    
    local i = #characters
    for row, v in ipairs(rows) do
        for elem, v in pairs(rows[row]) do
            if i ~= 0 then
                rows[row][elem] = characters[i]
                i = i -1
            end
        end
    end
    
    
    if IsValid(panel) then panel:SetVisible(false) end
    local keydown = false
    
    panel = vgui.Create("Panel")
    
    panel:SetSize(ScrW(), ScrH())
    panel:Center()
    panel:MakePopup()
    
    local w, h = panel:GetSize()

    for row = 1, #rows do
        for element = 1, #rows[row] do
            local elem = vgui.Create("DLabel", panel)
            elem:SetMouseInputEnabled( true )
            elem:SetText("")
            elem.border = false
            
            local el = rows[row][element]
            local char = el ~= "" and el.description or nil
                                                
            local offset = element == 1 and ScrW() * 0.08 + 1 or (ScrW() * 0.08 + 1) * element
            
            elem:SetPos(ScrW() * 0.135 + offset, row * ScrH() * 0.2)
            elem:SetSize(ScrW() * 0.08, ScrH() * 0.19)
            
            function elem:Think()
                if self:IsHovered() then
                    self.border = true
                else
                   self.border = false
                end
            end
            
            function elem:Paint(w, h)
                if char then
                    surface.SetDrawColor( 255, 255, 255, 255 )
                    surface.SetMaterial(materials[char.name])
                    surface.DrawTexturedRect(0,0,w,h)
                    if self.border then
                        surface.SetDrawColor(Color(255,0,0,255))
                        surface.DrawOutlinedRect(0,0,w,h)
                    end
                else
                    surface.SetDrawColor( 128, 128, 128, 100 )
                    surface.DrawRect(0, 0, w, h)
                end
            end
            
            function elem:DoClick()
                net.Start("paladins.chooseCharacter")
                net.WriteString(char.name)
                net.SendToServer()
                
                self:GetParent():Remove()
            end
        end
    end

    function panel:Paint()
        draw.Blur(self)
        
        surface.SetDrawColor( 255, 255, 255, 255 )
        surface.DrawRect(ScrW() * 0.05, ScrH() * 0.05, ScrW() * 0.9, ScrH() * 0.9)
    end
    
    function panel:Think()
        if input.IsKeyDown(KEY_F4) and keydown then
            self:Remove()
        elseif (not input.IsKeyDown(KEY_F4)) then
            keydown = true
        end
    end
end

net.Receive("paladins.charactersMenu", F4)