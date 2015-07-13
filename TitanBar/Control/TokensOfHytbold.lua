-- HytboldTokens.lua
-- Written by Habna


_G.HT = {}; -- Shards table in _G

--**v Control of Destiny points v**
HT["Ctr"] = Turbine.UI.Control();
HT["Ctr"]:SetParent( TB["win"] );
HT["Ctr"]:SetMouseVisible( false );
HT["Ctr"]:SetZOrder( 2 );
HT["Ctr"]:SetBlendMode( Turbine.UI.BlendMode.AlphaBlend );
HT["Ctr"]:SetBackColor( Turbine.UI.Color( HTbcAlpha, HTbcRed, HTbcGreen, HTbcBlue ) );
--SM["Ctr"]:SetBackColor( Color["red"] ); -- Debug purpose
--**^
--**v Destiny points & icon on TitanBar v**
HT["Icon"] = Turbine.UI.Control();
HT["Icon"]:SetParent( HT["Ctr"] );
HT["Icon"]:SetBlendMode( Turbine.UI.BlendMode.AlphaBlend );
HT["Icon"]:SetSize( 32, 32 );
HT["Icon"]:SetBackground( WalletItem.TokensOfHytbold.Icon );-- in-game icon 32x32
--SM["Icon"]:SetBackColor( Color["blue"] ); -- Debug purpose

HT["Icon"].MouseMove = function( sender, args )
	HT["Lbl"].MouseLeave( sender, args );
	TB["win"].MouseMove();
	if dragging then MoveHTCtr(sender, args); end
end

HT["Icon"].MouseLeave = function( sender, args )
	HT["Lbl"].MouseLeave( sender, args );
end

HT["Icon"].MouseClick = function( sender, args )
	HT["Lbl"].MouseClick( sender, args );
end

HT["Icon"].MouseDown = function( sender, args )
	HT["Lbl"].MouseDown( sender, args );
end

HT["Icon"].MouseUp = function( sender, args )
	HT["Lbl"].MouseUp( sender, args );
end


HT["Lbl"] = Turbine.UI.Label();
HT["Lbl"]:SetParent( HT["Ctr"] );
HT["Lbl"]:SetFont( _G.TBFont );
HT["Lbl"]:SetPosition( 0, 0 );
--SM["Lbl"]:SetForeColor( Color["white"] );
HT["Lbl"]:SetFontStyle( Turbine.UI.FontStyle.Outline );
HT["Lbl"]:SetTextAlignment( Turbine.UI.ContentAlignment.MiddleRight );
--SM["Lbl"]:SetBackColor( Color["white"] ); -- Debug purpose

HT["Lbl"].MouseMove = function( sender, args )
	HT["Lbl"].MouseLeave( sender, args );
	TB["win"].MouseMove();
	if dragging then
		MoveHTCtr(sender, args);
	else
		ShowToolTipWin( "HT" );
	end
end

HT["Lbl"].MouseLeave = function( sender, args )
	ResetToolTipWin();
end

HT["Lbl"].MouseClick = function( sender, args )
	TB["win"].MouseMove();
	if ( args.Button == Turbine.UI.MouseButton.Left ) then
		if not WasDrag then
			
		end
	elseif ( args.Button == Turbine.UI.MouseButton.Right ) then
		_G.sFromCtr = "HT";
		ControlMenu:ShowMenu();
	end
	WasDrag = false;
end

HT["Lbl"].MouseDown = function( sender, args )
	if ( args.Button == Turbine.UI.MouseButton.Left ) then
		HT["Ctr"]:SetZOrder( 3 );
		dragStartX = args.X;
		dragStartY = args.Y;
		dragging = true;
	end
end

HT["Lbl"].MouseUp = function( sender, args )
	HT["Ctr"]:SetZOrder( 2 );
	dragging = false;
	_G.HTLocX = HT["Ctr"]:GetLeft();
	settings.HytboldTokens.X = string.format("%.0f", _G.HTLocX);
	_G.HTLocY = HT["Ctr"]:GetTop();
	settings.HytboldTokens.Y = string.format("%.0f", _G.HTLocY);
	SaveSettings( false );
end
--**^

function MoveHTCtr(sender, args)
	local CtrLocX = HT["Ctr"]:GetLeft();
	local CtrWidth = HT["Ctr"]:GetWidth();
	CtrLocX = CtrLocX + ( args.X - dragStartX );
	if CtrLocX < 0 then CtrLocX = 0; elseif CtrLocX + CtrWidth > screenWidth then CtrLocX = screenWidth - CtrWidth; end
	
	local CtrLocY = HT["Ctr"]:GetTop();
	local CtrHeight = HT["Ctr"]:GetHeight();
	CtrLocY = CtrLocY + ( args.Y - dragStartY );
	if CtrLocY < 0 then CtrLocY = 0; elseif CtrLocY + CtrHeight > TB["win"]:GetHeight() then CtrLocY = TB["win"]:GetHeight() - CtrHeight; end

	HT["Ctr"]:SetPosition( CtrLocX, CtrLocY );
	WasDrag = true;
end