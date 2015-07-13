-- AmrothSilverPiece.lua
-- Written by Habna


_G.ASP = {};

--**v Control of Amroth Silver Piece v**
ASP["Ctr"] = Turbine.UI.Control();
ASP["Ctr"]:SetParent( TB["win"] );
ASP["Ctr"]:SetMouseVisible( false );
ASP["Ctr"]:SetZOrder( 2 );
ASP["Ctr"]:SetBlendMode( Turbine.UI.BlendMode.AlphaBlend );
ASP["Ctr"]:SetBackColor( Turbine.UI.Color( ASPbcAlpha, ASPbcRed, ASPbcGreen, ASPbcBlue ) );
--**^
--**v Amroth Silver Piece & icon on TitanBar v**
ASP["Icon"] = Turbine.UI.Control();
ASP["Icon"]:SetParent( ASP["Ctr"] );
ASP["Icon"]:SetBlendMode( Turbine.UI.BlendMode.AlphaBlend );
ASP["Icon"]:SetSize( 32, 32 );
ASP["Icon"]:SetBackground( 0x41152875 );-- in-game icon 32x32
--**^

ASP["Icon"].MouseMove = function( sender, args )
	ASP["Lbl"].MouseLeave( sender, args );
	TB["win"].MouseMove();
	if dragging then MoveASPCtr(sender, args); end
end

ASP["Icon"].MouseLeave = function( sender, args )
	ASP["Lbl"].MouseLeave( sender, args );
end

ASP["Icon"].MouseClick = function( sender, args )
	ASP["Lbl"].MouseClick( sender, args );
end

ASP["Icon"].MouseDown = function( sender, args )
	ASP["Lbl"].MouseDown( sender, args );
end

ASP["Icon"].MouseUp = function( sender, args )
	ASP["Lbl"].MouseUp( sender, args );
end


ASP["Lbl"] = Turbine.UI.Label();
ASP["Lbl"]:SetParent( ASP["Ctr"] );
ASP["Lbl"]:SetFont( _G.TBFont );
ASP["Lbl"]:SetPosition( 0, 0 );
ASP["Lbl"]:SetFontStyle( Turbine.UI.FontStyle.Outline );
ASP["Lbl"]:SetTextAlignment( Turbine.UI.ContentAlignment.MiddleRight );

ASP["Lbl"].MouseMove = function( sender, args )
	ASP["Lbl"].MouseLeave( sender, args );
	TB["win"].MouseMove();
	if dragging then
		MoveASPCtr(sender, args);
	else
		ShowToolTipWin( "ASP" );
	end
end

ASP["Lbl"].MouseLeave = function( sender, args )
	ResetToolTipWin();
end

ASP["Lbl"].MouseClick = function( sender, args )
	TB["win"].MouseMove();
	if ( args.Button == Turbine.UI.MouseButton.Left ) then
		if not WasDrag then
			
		end
	elseif ( args.Button == Turbine.UI.MouseButton.Right ) then
		_G.sFroASPtr = "ASP";
		ControlMenu:ShowMenu();
	end
	WasDrag = false;
end

ASP["Lbl"].MouseDown = function( sender, args )
	if ( args.Button == Turbine.UI.MouseButton.Left ) then
		ASP["Ctr"]:SetZOrder( 3 );
		dragStartX = args.X;
		dragStartY = args.Y;
		dragging = true;
	end
end

ASP["Lbl"].MouseUp = function( sender, args )
	ASP["Ctr"]:SetZOrder( 2 );
	dragging = false;
	_G.ASPLocX = ASP["Ctr"]:GetLeft();
	settings.AmrothSilverPiece.X = string.format("%.0f", _G.ASPLocX);
	_G.ASPLocY = ASP["Ctr"]:GetTop();
	settings.AmrothSilverPiece.Y = string.format("%.0f", _G.ASPLocY);
	SaveSettings( false );
end
--**^

function MoveASPCtr(sender, args)
	local CtrLocX = ASP["Ctr"]:GetLeft();
	local CtrWidth = ASP["Ctr"]:GetWidth();
	CtrLocX = CtrLocX + ( args.X - dragStartX );
	if CtrLocX < 0 then CtrLocX = 0; elseif CtrLocX + CtrWidth > screenWidth then CtrLocX = screenWidth - CtrWidth; end
	
	local CtrLocY = ASP["Ctr"]:GetTop();
	local CtrHeight = ASP["Ctr"]:GetHeight();
	CtrLocY = CtrLocY + ( args.Y - dragStartY );
	if CtrLocY < 0 then CtrLocY = 0; elseif CtrLocY + CtrHeight > TB["win"]:GetHeight() then CtrLocY = TB["win"]:GetHeight() - CtrHeight; end

	ASP["Ctr"]:SetPosition( CtrLocX, CtrLocY );
	WasDrag = true;
end