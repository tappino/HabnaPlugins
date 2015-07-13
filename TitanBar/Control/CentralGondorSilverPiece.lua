-- CentralGondorSilverPiece.lua
-- Written by Habna


_G.CGSP = {};

--**v Control of Central Gondor Silver Piece v**
CGSP["Ctr"] = Turbine.UI.Control();
CGSP["Ctr"]:SetParent( TB["win"] );
CGSP["Ctr"]:SetMouseVisible( false );
CGSP["Ctr"]:SetZOrder( 2 );
CGSP["Ctr"]:SetBlendMode( Turbine.UI.BlendMode.AlphaBlend );
CGSP["Ctr"]:SetBackColor( Turbine.UI.Color( CGSPbcAlpha, CGSPbcRed, CGSPbcGreen, CGSPbcBlue ) );
--**^
--**v Central Gondor Silver Piece & icon on TitanBar v**
CGSP["Icon"] = Turbine.UI.Control();
CGSP["Icon"]:SetParent( CGSP["Ctr"] );
CGSP["Icon"]:SetBlendMode( Turbine.UI.BlendMode.AlphaBlend );
CGSP["Icon"]:SetSize( 32, 32 );
CGSP["Icon"]:SetBackground( WalletItem.CentralGondorSilverPiece.Icon );-- in-game icon 32x32
--**^

CGSP["Icon"].MouseMove = function( sender, args )
	CGSP["Lbl"].MouseLeave( sender, args );
	TB["win"].MouseMove();
	if dragging then MoveCGSPCtr(sender, args); end
end

CGSP["Icon"].MouseLeave = function( sender, args )
	CGSP["Lbl"].MouseLeave( sender, args );
end

CGSP["Icon"].MouseClick = function( sender, args )
	CGSP["Lbl"].MouseClick( sender, args );
end

CGSP["Icon"].MouseDown = function( sender, args )
	CGSP["Lbl"].MouseDown( sender, args );
end

CGSP["Icon"].MouseUp = function( sender, args )
	CGSP["Lbl"].MouseUp( sender, args );
end


CGSP["Lbl"] = Turbine.UI.Label();
CGSP["Lbl"]:SetParent( CGSP["Ctr"] );
CGSP["Lbl"]:SetFont( _G.TBFont );
CGSP["Lbl"]:SetPosition( 0, 0 );
CGSP["Lbl"]:SetFontStyle( Turbine.UI.FontStyle.Outline );
CGSP["Lbl"]:SetTextAlignment( Turbine.UI.ContentAlignment.MiddleRight );

CGSP["Lbl"].MouseMove = function( sender, args )
	CGSP["Lbl"].MouseLeave( sender, args );
	TB["win"].MouseMove();
	if dragging then
		MoveCGSPCtr(sender, args);
	else
		ShowToolTipWin( "CGSP" );
	end
end

CGSP["Lbl"].MouseLeave = function( sender, args )
	ResetToolTipWin();
end

CGSP["Lbl"].MouseClick = function( sender, args )
	TB["win"].MouseMove();
	if ( args.Button == Turbine.UI.MouseButton.Left ) then
		if not WasDrag then
			
		end
	elseif ( args.Button == Turbine.UI.MouseButton.Right ) then
		_G.sFroCGSPtr = "CGSP";
		ControlMenu:ShowMenu();
	end
	WasDrag = false;
end

CGSP["Lbl"].MouseDown = function( sender, args )
	if ( args.Button == Turbine.UI.MouseButton.Left ) then
		CGSP["Ctr"]:SetZOrder( 3 );
		dragStartX = args.X;
		dragStartY = args.Y;
		dragging = true;
	end
end

CGSP["Lbl"].MouseUp = function( sender, args )
	CGSP["Ctr"]:SetZOrder( 2 );
	dragging = false;
	_G.CGSPLocX = CGSP["Ctr"]:GetLeft();
	settings.CentralGondorSilverPiece.X = string.format("%.0f", _G.CGSPLocX);
	_G.CGSPLocY = CGSP["Ctr"]:GetTop();
	settings.CentralGondorSilverPiece.Y = string.format("%.0f", _G.CGSPLocY);
	SaveSettings( false );
end
--**^

function MoveCGSPCtr(sender, args)
	local CtrLocX = CGSP["Ctr"]:GetLeft();
	local CtrWidth = CGSP["Ctr"]:GetWidth();
	CtrLocX = CtrLocX + ( args.X - dragStartX );
	if CtrLocX < 0 then CtrLocX = 0; elseif CtrLocX + CtrWidth > screenWidth then CtrLocX = screenWidth - CtrWidth; end
	
	local CtrLocY = CGSP["Ctr"]:GetTop();
	local CtrHeight = CGSP["Ctr"]:GetHeight();
	CtrLocY = CtrLocY + ( args.Y - dragStartY );
	if CtrLocY < 0 then CtrLocY = 0; elseif CtrLocY + CtrHeight > TB["win"]:GetHeight() then CtrLocY = TB["win"]:GetHeight() - CtrHeight; end

	CGSP["Ctr"]:SetPosition( CtrLocX, CtrLocY );
	WasDrag = true;
end