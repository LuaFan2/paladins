local fview = 0

function GM:OnContextMenuOpen( )
	fview = not fview
end

local function PlayerView( ply, pos, angles, fov )
	local view = {}
	
	local eyes = ply:GetAttachment( ply:LookupAttachment( "eyes" ) );
	
	view.origin = fview and eyes.Pos or pos - (angles:Forward()*150) 
	view.angles = angles
	view.fov = fov
	view.drawviewer = true
	
	return view
end

hook.Add( "CalcView", "PlayerView", PlayerView )