-- Giftgiver'sBrand.lua
-- Written by Habna


_G.GGB = {};

--**v Control of Gift giver's Brand v**
GGB["Ctr"] = Turbine.UI.Control();
GGB["Ctr"]:SetParent( TB["win"] );
GGB["Ctr"]:SetMouseVisible( false );
GGB["Ctr"]:SetZOrder( 2 );
GGB["Ctr"]:SetBlendMode( Turbine.UI.BlendMode.AlphaBlend );
GGB["Ctr"]:SetBackColor( Turbine.UI.Color( GGBbcAlpha, GGBbcRed, GGBbcGreen, GGBbcBlue ) );
--**^
--**v Gift giver's Brand & icon on TitanBar v**
GGB["Icon"] = Turbine.UI.Control();
GGB["Icon"]:SetParent( GGB["Ctr"] );
GGB["Icon"]:SetBlendMode( Turbine.UI.BlendMode.AlphaBlend );
GGB["Icon"]:SetSize( 32, 32 );
GGB["Icon"]:SetBackground( WalletItem.GiftgiversBrand.Icon );-- in-game icon 32x32
--**^

GGB["Icon"].MouseMove = function( sender, args )
	GGB["Lbl"].MouseLeave( sender, args );
	TB["win"].MouseMove();
	if dragging then MoveGGBCtr(sender, args); end
end

GGB["Icon"].MouseLeave = function( sender, args )
	GGB["Lbl"].MouseLeave( sender, args );
end

GGB["Icon"].MouseClick = function( sender, args )
	GGB["Lbl"].MouseClick( sender, args );
end

GGB["Icon"].MouseDown = function( sender, args )
	GGB["Lbl"].MouseDown( sender, args );
end

GGB["Icon"].MouseUp = function( sender, args )
	GGB["Lbl"].MouseUp( sender, args );
end


GGB["Lbl"] = Turbine.UI.Label();
GGB["Lbl"]:SetParent( GGB["Ctr"] );
GGB["Lbl"]:SetFont( _G.TBFont );
GGB["Lbl"]:SetPosition( 0, 0 );
GGB["Lbl"]:SetFontStyle( Turbine.UI.FontStyle.Outline );
GGB["Lbl"]:SetTextAlignment( Turbine.UI.ContentAlignment.MiddleRight );

GGB["Lbl"].MouseMove = function( sender, args )
	GGB["Lbl"].MouseLeave( sender, args );
	TB["win"].MouseMove();
	if dragging then
		MoveGGBCtr(sender, args);
	else
		ShowToolTipWin( "GGB" );
	end
end

GGB["Lbl"].MouseLeave = function( sender, args )
	ResetToolTipWin();
end

GGB["Lbl"].MouseClick = function( sender, args )
	TB["win"].MouseMove();
	if ( args.Button == Turbine.UI.MouseButton.Left ) then
		if not WasDrag then
			
		end
	elseif ( args.Button == Turbine.UI.MouseButton.Right ) then
		_G.sFroGGBtr = "GGB";
		ControlMenu:ShowMenu();
	end
	WasDrag = false;
end

GGB["Lbl"].MouseDown = function( sender, args )
	if ( args.Button == Turbine.UI.MouseButton.Left ) then
		GGB["Ctr"]:SetZOrder( 3 );
		dragStartX = args.X;
		dragStartY = args.Y;
		dragging = true;
	end
end

GGB["Lbl"].MouseUp = function( sender, args )
	GGB["Ctr"]:SetZOrder( 2 );
	dragging = false;
	_G.GGBLocX = GGB["Ctr"]:GetLeft();
	settings.GiftgiversBrand.X = string.format("%.0f", _G.GGBLocX);
	_G.GGBLocY = GGB["Ctr"]:GetTop();
	settings.GiftgiversBrand.Y = string.format("%.0f", _G.GGBLocY);
	SaveSettings( false );
end
--**^

function MoveGGBCtr(sender, args)
	local CtrLocX = GGB["Ctr"]:GetLeft();
	local CtrWidth = GGB["Ctr"]:GetWidth();
	CtrLocX = CtrLocX + ( args.X - dragStartX );
	if CtrLocX < 0 then CtrLocX = 0; elseif CtrLocX + CtrWidth > screenWidth then CtrLocX = screenWidth - CtrWidth; end
	
	local CtrLocY = GGB["Ctr"]:GetTop();
	local CtrHeight = GGB["Ctr"]:GetHeight();
	CtrLocY = CtrLocY + ( args.Y - dragStartY );
	if CtrLocY < 0 then CtrLocY = 0; elseif CtrLocY + CtrHeight > TB["win"]:GetHeight() then CtrLocY = TB["win"]:GetHeight() - CtrHeight; end

	GGB["Ctr"]:SetPosition( CtrLocX, CtrLocY );
	WasDrag = true;
end