-- StarsofMerit.lua
-- Written by Habna


_G.SOM = {};

--**v Control of Stars of Merit v**
SOM["Ctr"] = Turbine.UI.Control();
SOM["Ctr"]:SetParent( TB["win"] );
SOM["Ctr"]:SetMouseVisible( false );
SOM["Ctr"]:SetZOrder( 2 );
SOM["Ctr"]:SetBlendMode( Turbine.UI.BlendMode.AlphaBlend );
SOM["Ctr"]:SetBackColor( Turbine.UI.Color( SOMbcAlpha, SOMbcRed, SOMbcGreen, SOMbcBlue ) );
--**^
--**v Stars of Merit & icon on TitanBar v**
SOM["Icon"] = Turbine.UI.Control();
SOM["Icon"]:SetParent( SOM["Ctr"] );
SOM["Icon"]:SetBlendMode( Turbine.UI.BlendMode.AlphaBlend );
SOM["Icon"]:SetSize( 32, 32 );
SOM["Icon"]:SetBackground( WalletItem.StarsofMerit.Icon );-- in-game icon 32x32
--**^

SOM["Icon"].MouseMove = function( sender, args )
	SOM["Lbl"].MouseLeave( sender, args );
	TB["win"].MouseMove();
	if dragging then MoveSOMCtr(sender, args); end
end

SOM["Icon"].MouseLeave = function( sender, args )
	SOM["Lbl"].MouseLeave( sender, args );
end

SOM["Icon"].MouseClick = function( sender, args )
	SOM["Lbl"].MouseClick( sender, args );
end

SOM["Icon"].MouseDown = function( sender, args )
	SOM["Lbl"].MouseDown( sender, args );
end

SOM["Icon"].MouseUp = function( sender, args )
	SOM["Lbl"].MouseUp( sender, args );
end


SOM["Lbl"] = Turbine.UI.Label();
SOM["Lbl"]:SetParent( SOM["Ctr"] );
SOM["Lbl"]:SetFont( _G.TBFont );
SOM["Lbl"]:SetPosition( 0, 0 );
SOM["Lbl"]:SetFontStyle( Turbine.UI.FontStyle.Outline );
SOM["Lbl"]:SetTextAlignment( Turbine.UI.ContentAlignment.MiddleRight );

SOM["Lbl"].MouseMove = function( sender, args )
	SOM["Lbl"].MouseLeave( sender, args );
	TB["win"].MouseMove();
	if dragging then
		MoveSOMCtr(sender, args);
	else
		ShowToolTipWin( "SOM" );
	end
end

SOM["Lbl"].MouseLeave = function( sender, args )
	ResetToolTipWin();
end

SOM["Lbl"].MouseClick = function( sender, args )
	TB["win"].MouseMove();
	if ( args.Button == Turbine.UI.MouseButton.Left ) then
		if not WasDrag then
			
		end
	elseif ( args.Button == Turbine.UI.MouseButton.Right ) then
		_G.sFroSOMtr = "SOM";
		ControlMenu:ShowMenu();
	end
	WasDrag = false;
end

SOM["Lbl"].MouseDown = function( sender, args )
	if ( args.Button == Turbine.UI.MouseButton.Left ) then
		SOM["Ctr"]:SetZOrder( 3 );
		dragStartX = args.X;
		dragStartY = args.Y;
		dragging = true;
	end
end

SOM["Lbl"].MouseUp = function( sender, args )
	SOM["Ctr"]:SetZOrder( 2 );
	dragging = false;
	_G.SOMLocX = SOM["Ctr"]:GetLeft();
	settings.StarsofMerit.X = string.format("%.0f", _G.SOMLocX);
	_G.SOMLocY = SOM["Ctr"]:GetTop();
	settings.StarsofMerit.Y = string.format("%.0f", _G.SOMLocY);
	SaveSettings( false );
end
--**^

function MoveSOMCtr(sender, args)
	local CtrLocX = SOM["Ctr"]:GetLeft();
	local CtrWidth = SOM["Ctr"]:GetWidth();
	CtrLocX = CtrLocX + ( args.X - dragStartX );
	if CtrLocX < 0 then CtrLocX = 0; elseif CtrLocX + CtrWidth > screenWidth then CtrLocX = screenWidth - CtrWidth; end
	
	local CtrLocY = SOM["Ctr"]:GetTop();
	local CtrHeight = SOM["Ctr"]:GetHeight();
	CtrLocY = CtrLocY + ( args.Y - dragStartY );
	if CtrLocY < 0 then CtrLocY = 0; elseif CtrLocY + CtrHeight > TB["win"]:GetHeight() then CtrLocY = TB["win"]:GetHeight() - CtrHeight; end

	SOM["Ctr"]:SetPosition( CtrLocX, CtrLocY );
	WasDrag = true;
end