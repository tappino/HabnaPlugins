-- Mithril Coins.lua
-- Written by Habna


_G.MC = {}; -- Shards table in _G

--**v Control of Destiny points v**
MC["Ctr"] = Turbine.UI.Control();
MC["Ctr"]:SetParent( TB["win"] );
MC["Ctr"]:SetMouseVisible( false );
MC["Ctr"]:SetZOrder( 2 );
MC["Ctr"]:SetBlendMode( Turbine.UI.BlendMode.AlphaBlend );
MC["Ctr"]:SetBackColor( Turbine.UI.Color( MCbcAlpha, MCbcRed, MCbcGreen, MCbcBlue ) );
--SM["Ctr"]:SetBackColor( Color["red"] ); -- Debug purpose
--**^
--**v Destiny points & icon on TitanBar v**
MC["Icon"] = Turbine.UI.Control();
MC["Icon"]:SetParent( MC["Ctr"] );
MC["Icon"]:SetBlendMode( Turbine.UI.BlendMode.AlphaBlend );
MC["Icon"]:SetSize( 32, 32 );
MC["Icon"]:SetBackground( 0x411348E1 );-- in-game icon 32x32
--SM["Icon"]:SetBackColor( Color["blue"] ); -- Debug purpose

MC["Icon"].MouseMove = function( sender, args )
	MC["Lbl"].MouseLeave( sender, args );
	TB["win"].MouseMove();
	if dragging then MoveMCCtr(sender, args); end
end

MC["Icon"].MouseLeave = function( sender, args )
	MC["Lbl"].MouseLeave( sender, args );
end

MC["Icon"].MouseClick = function( sender, args )
	MC["Lbl"].MouseClick( sender, args );
end

MC["Icon"].MouseDown = function( sender, args )
	MC["Lbl"].MouseDown( sender, args );
end

MC["Icon"].MouseUp = function( sender, args )
	MC["Lbl"].MouseUp( sender, args );
end


MC["Lbl"] = Turbine.UI.Label();
MC["Lbl"]:SetParent( MC["Ctr"] );
MC["Lbl"]:SetFont( _G.TBFont );
MC["Lbl"]:SetPosition( 0, 0 );
--SM["Lbl"]:SetForeColor( Color["white"] );
MC["Lbl"]:SetFontStyle( Turbine.UI.FontStyle.Outline );
MC["Lbl"]:SetTextAlignment( Turbine.UI.ContentAlignment.MiddleRight );
--SM["Lbl"]:SetBackColor( Color["white"] ); -- Debug purpose

MC["Lbl"].MouseMove = function( sender, args )
	MC["Lbl"].MouseLeave( sender, args );
	TB["win"].MouseMove();
	if dragging then
		MoveMCCtr(sender, args);
	else
		ShowToolTipWin( "MC" );
	end
end

MC["Lbl"].MouseLeave = function( sender, args )
	ResetToolTipWin();
end

MC["Lbl"].MouseClick = function( sender, args )
	TB["win"].MouseMove();
	if ( args.Button == Turbine.UI.MouseButton.Left ) then
		if not WasDrag then
			
		end
	elseif ( args.Button == Turbine.UI.MouseButton.Right ) then
		_G.sFromCtr = "MC";
		ControlMenu:ShowMenu();
	end
	WasDrag = false;
end

MC["Lbl"].MouseDown = function( sender, args )
	if ( args.Button == Turbine.UI.MouseButton.Left ) then
		MC["Ctr"]:SetZOrder( 3 );
		dragStartX = args.X;
		dragStartY = args.Y;
		dragging = true;
	end
end

MC["Lbl"].MouseUp = function( sender, args )
	MC["Ctr"]:SetZOrder( 2 );
	dragging = false;
	_G.MCLocX = MC["Ctr"]:GetLeft();
	settings.MithrilCoins.X = string.format("%.0f", _G.MCLocX);
	_G.MCLocY = MC["Ctr"]:GetTop();
	settings.MithrilCoins.Y = string.format("%.0f", _G.MCLocY);
	SaveSettings( false );
end
--**^

function MoveMCCtr(sender, args)
	local CtrLocX = MC["Ctr"]:GetLeft();
	local CtrWidth = MC["Ctr"]:GetWidth();
	CtrLocX = CtrLocX + ( args.X - dragStartX );
	if CtrLocX < 0 then CtrLocX = 0; elseif CtrLocX + CtrWidth > screenWidth then CtrLocX = screenWidth - CtrWidth; end
	
	local CtrLocY = MC["Ctr"]:GetTop();
	local CtrHeight = MC["Ctr"]:GetHeight();
	CtrLocY = CtrLocY + ( args.Y - dragStartY );
	if CtrLocY < 0 then CtrLocY = 0; elseif CtrLocY + CtrHeight > TB["win"]:GetHeight() then CtrLocY = TB["win"]:GetHeight() - CtrHeight; end

	MC["Ctr"]:SetPosition( CtrLocX, CtrLocY );
	WasDrag = true;
end