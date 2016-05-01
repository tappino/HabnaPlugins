-- functions.lua
-- Written By Habna

--XP needed to reach next level
--Ex.: at lvl 1 u need 100 XP to reach lvl 2, at lvl 2 u need 275 XP to reach lvl 3 and so on.
--Source: http://lotro-wiki.com/index.php/Character#Character_Levels_and_Experience_Points
-- XP from lvl 75 to 85 from player Geko, thanks!
-- Lvls 96 to 100 from Hyoss.
PlayerLevel = {
	[1]="100", [2]="275", [3]="550", [4]="950", [5]="1,543", [6]="2,395", [7]="3,575", [8]="5,150", [9]="7,188", 
	[10]="9,798", [11]="13,090", [12]="17,175", [13]="22,163", [14]="28,163", [15]="35,328", [16]="43,810", [17]="53,763", [18]="65,338", [19]="78,688",
	[20]="94,008", [21]="111,493", [22]="131,338", [23]="153,738", [24]="178,888", [25]="207,025", [26]="238,388", [27]="273,213", [28]="311,738", [29]="354,200", 
	[30]="400,880", [31]="452,058", [32]="508,013", [33]="569,025", [34]="635,375", [35]="707,385", [36]="785,378", [37]="869,675", [38]="960,600", [39]="1,058,475", 
	[40]="1,163,665", [41]="1,276,535", [42]="1,397,450", [43]="1,526,775", [44]="1,664,875", [45]="1,812,158", [46]="1,969,030", [47]="2,135,900", [48]="2,313,175", [49]="2,501,263", 
	[50]="2,700,613", [51]="2,911,675", [52]="3,134,900", [53]="3,370,738", [54]="3,619,638", [55]="3,882,093", [56]="4,158,595", [57]="4,449,638", [58]="4,755,713", [59]="5,077,313", 
	[60]="5,415,226", [61]="5,770,277", [62]="6,143,336", [63]="6,535,316", [64]="6,947,176", [65]="7,379,926", [66]="7,834,624", [67]="8,312,383", [68]="8,814,374", [69]="9,341,823",
	[70]="9,896,024", [71]="10,478,333", [72]="11,090,176", [73]="11,733,051", [74]="12,408,532", [75]="13,117,787", [76]="13,862,504", [77]="14,644,456", [78]="15,465,505", [79]="16,327,606", 
	[80]="17,232,812", [81]="18,183,278", [82]="19,181,267", [83]="20,229,155", [84]="21,329,437", [85]="22,484,733", [86]="23,697,793", [87]="24,971,506", [88]="26,308,904", [89]="27,713,171",
	[90]="29,187,651", [91]="30,735,855", [92]="32,361,469", [93]="34,068,363", [94]="35,860,601", [95]="37,742,450", [96]="39,718,391", [97]="41,793,129 ", [98]="43,971,603 ", [99]="46,259,000",
	[100]= "48,660,766", [101]= "51,182,620", [102] = "53,830,566", [103] = "56,610,909", [104] = "59527269", [105] = "0" };

Capped = 0;

function ShowPIWindow()
	if PlayerAlign == 1 then CtrW = 340; th = 200; tw = 3*CtrW; else th = 75; tw = 2*CtrW; end --th: temp height / tw: temp width

	-- ( offsetX, offsetY, width, height, bubble side )
	local x, y, w, h = -5, -15, tw, th;
	local mouseX, mouseY = Turbine.UI.Display.GetMousePosition();
	
	if w + mouseX > screenWidth then x = w - 10; end

	if not TBTop then y = h; end
	
	_G.ToolTipWin = Turbine.UI.Window();
	_G.ToolTipWin:SetZOrder( 1 );
	--_G.ToolTipWin.xOffset = x;
	--_G.ToolTipWin.yOffset = y;
	_G.ToolTipWin:SetPosition( mouseX - x, mouseY - y);
	_G.ToolTipWin:SetSize( w, h );
	_G.ToolTipWin:SetVisible( true );

	--**v Control of all player infos v**
	local APICtr = Turbine.UI.Control();
	APICtr:SetParent( _G.ToolTipWin );
	APICtr:SetZOrder( 1 );
	APICtr:SetSize( w, h );
	APICtr:SetBlendMode( Turbine.UI.BlendMode.AlphaBlend );
	--APICtr:SetBackColor( Color["red"] ); -- Debug purpose
	--**^

	local MoraleCtr = Turbine.UI.Control();
	MoraleCtr:SetParent( APICtr );
	MoraleCtr:SetSize( CtrW, 26 );
	MoraleCtr:SetPosition( 20, 17 );

	local MoraleIcon = Turbine.UI.Control();
	MoraleIcon:SetParent(MoraleCtr);
	MoraleIcon:SetBlendMode(5);
	MoraleIcon:SetSize(24,26);
	MoraleIcon:SetPosition(1,1);
	MoraleIcon:SetBackground(resources.PlayerInfo.Morale);

	local MoraleLabel = Turbine.UI.Label();
	MoraleLabel:SetParent(MoraleCtr);
	MoraleLabel:SetSize(80,26);
	MoraleLabel:SetPosition(30,-2);
	MoraleLabel:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
	MoraleLabel:SetFont(Turbine.UI.Lotro.Font.TrajanPro20);
	MoraleLabel:SetForeColor( Color["nicegreen"] );
	MoraleLabel:SetText( L["Morale"] );
	
	MoraleValue = Turbine.UI.Label();
	MoraleValue:SetParent(MoraleCtr);
	MoraleValue:SetSize(220,26);
	MoraleValue:SetPosition(115,0);
	MoraleValue:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
	MoraleValue:SetFont(Turbine.UI.Lotro.Font.Verdana15);
	MoraleValue:SetForeColor( Color["white"] );
	
	local PowerCtr = Turbine.UI.Control();
	PowerCtr:SetParent( APICtr );
	PowerCtr:SetSize(CtrW,26);
	PowerCtr:SetPosition(MoraleCtr:GetLeft() + MoraleCtr:GetWidth() + 5, MoraleCtr:GetTop());

	local PowerIcon = Turbine.UI.Control();
	PowerIcon:SetParent(PowerCtr);
	PowerIcon:SetBlendMode(5);
	PowerIcon:SetSize(24,26);
	PowerIcon:SetPosition(1,1);
	if PlayerClassIs == L["Beorning"] then PowerIcon:SetBackground( resources.PlayerInfo.Wrath );
	else PowerIcon:SetBackground( resources.PlayerInfo.Power ); end;
	
	local PowerLabel = Turbine.UI.Label();
	PowerLabel:SetParent(PowerCtr);
	PowerLabel:SetSize(80,26);
	PowerLabel:SetPosition(30,-2);
	PowerLabel:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
	PowerLabel:SetFont(Turbine.UI.Lotro.Font.TrajanPro20);
	if PlayerClassIs == L["Beorning"] then 
		PowerLabel:SetText( L["Wrath"] );
		PowerLabel:SetForeColor( Color["gold"] );
	else 
		PowerLabel:SetText( L["Power"] ); 
		PowerLabel:SetForeColor( Color["niceblue"] );
	end;
	
	
	PowerValue = Turbine.UI.Label();
	PowerValue:SetParent(PowerCtr);
	PowerValue:SetSize(220,26);
	PowerValue:SetPosition(115,0);
	PowerValue:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
	PowerValue:SetFont(Turbine.UI.Lotro.Font.Verdana15);
	PowerValue:SetForeColor( Color["white"] );
	
	local Separator = Turbine.UI.Control();
	Separator:SetParent(APICtr);
	Separator:SetSize(tw-10,1);
	Separator:SetPosition(5,43);
	Separator:SetBackColor( Color["trueblue"] );
		
	if PlayerAlign == 1 then
		-- ARMOUR --
		local ArmorCtr = Turbine.UI.Control();
		ArmorCtr:SetParent( APICtr );
		--ArmorCtr:SetBlendMode(5);
		ArmorCtr:SetSize(CtrW,26);
		ArmorCtr:SetPosition(PowerCtr:GetLeft() + PowerCtr:GetWidth() + 5, MoraleCtr:GetTop());

		local ArmorIcon = Turbine.UI.Control();
		ArmorIcon:SetParent(ArmorCtr);
		ArmorIcon:SetBlendMode(5);
		ArmorIcon:SetSize(24,26);
		ArmorIcon:SetPosition(1,1);
		ArmorIcon:SetBackground(resources.PlayerInfo.Armor);

		local ArmorLabel = Turbine.UI.Label();
		ArmorLabel:SetParent(ArmorCtr);
		ArmorLabel:SetSize(85,26);
		ArmorLabel:SetPosition(30,-2);
		ArmorLabel:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
		ArmorLabel:SetFont(Turbine.UI.Lotro.Font.TrajanPro20);
		ArmorLabel:SetForeColor( Color["brown"] );
		ArmorLabel:SetText( L["Armour"] );

		ArmorValue = Turbine.UI.Label();
		ArmorValue:SetParent(ArmorCtr);
		ArmorValue:SetSize(215,26);
		ArmorValue:SetPosition(120,0);
		ArmorValue:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
		ArmorValue:SetFont(Turbine.UI.Lotro.Font.Verdana15);
		ArmorValue:SetForeColor( Color["white"] );
		-- ARMOUR END --
		
		-- OTHER --
		local PlayLbl, PlayVal = 50, 140; --Player size, label size, value size
		local PlayerLevelLabel = Turbine.UI.Label();
		PlayerLevelLabel:SetParent(APICtr);
		PlayerLevelLabel:SetSize(PlayLbl,15);
		PlayerLevelLabel:SetPosition(MoraleCtr:GetLeft(), MoraleCtr:GetTop()+30);
		PlayerLevelLabel:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
		PlayerLevelLabel:SetFont(Turbine.UI.Lotro.Font.TrajanPro14);
		PlayerLevelLabel:SetForeColor(Color["nicegold"]);
		PlayerLevelLabel:SetText(L["Level"]);

		PlayerLevelValue = Turbine.UI.Label();
		PlayerLevelValue:SetParent(APICtr);
		PlayerLevelValue:SetSize(PlayVal-25,15);
		PlayerLevelValue:SetPosition(PlayerLevelLabel:GetLeft()+PlayLbl,PlayerLevelLabel:GetTop());
		PlayerLevelValue:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleRight);
		PlayerLevelValue:SetFont(Turbine.UI.Lotro.Font.Verdana12);
		PlayerLevelValue:SetForeColor(Color["white"]);
		
		local PlayerRaceLabel = Turbine.UI.Label();
		PlayerRaceLabel:SetParent(APICtr);
		PlayerRaceLabel:SetSize(PlayLbl,15);
		PlayerRaceLabel:SetPosition(PlayerLevelLabel:GetLeft(),PlayerLevelLabel:GetTop()+15);
		PlayerRaceLabel:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
		PlayerRaceLabel:SetFont(Turbine.UI.Lotro.Font.TrajanPro14);
		PlayerRaceLabel:SetForeColor(Color["nicegold"]);
		PlayerRaceLabel:SetText(L["Race"]);

		PlayerRacelValue = Turbine.UI.Label();
		PlayerRacelValue:SetParent(APICtr);
		PlayerRacelValue:SetSize(PlayVal-25,15);
		PlayerRacelValue:SetPosition(PlayerRaceLabel:GetLeft()+PlayLbl,PlayerRaceLabel:GetTop());
		PlayerRacelValue:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleRight);
		PlayerRacelValue:SetFont(Turbine.UI.Lotro.Font.Verdana12);
		PlayerRacelValue:SetForeColor(Color["white"]);
		
		local PlayerClassLabel = Turbine.UI.Label();
		PlayerClassLabel:SetParent(APICtr);
		PlayerClassLabel:SetSize(PlayLbl,15);
		PlayerClassLabel:SetPosition(PlayerRaceLabel:GetLeft(),PlayerRaceLabel:GetTop()+15);
		PlayerClassLabel:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
		PlayerClassLabel:SetFont(Turbine.UI.Lotro.Font.TrajanPro14);
		PlayerClassLabel:SetForeColor(Color["nicegold"]);
		PlayerClassLabel:SetText(L["Class"]);

		PlayerClassValue = Turbine.UI.Label();
		PlayerClassValue:SetParent(APICtr);
		PlayerClassValue:SetSize(PlayVal-25,15);
		PlayerClassValue:SetPosition(PlayerClassLabel:GetLeft()+PlayLbl,PlayerClassLabel:GetTop());
		PlayerClassValue:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleRight);
		PlayerClassValue:SetFont(Turbine.UI.Lotro.Font.Verdana12);
		PlayerClassValue:SetForeColor(Color["white"]);
		
		local PlayerCurrentXPLabel = Turbine.UI.Label();
		PlayerCurrentXPLabel:SetParent(APICtr);
		PlayerCurrentXPLabel:SetSize(PlayLbl,15);
		PlayerCurrentXPLabel:SetPosition(PlayerClassLabel:GetLeft(),PlayerClassLabel:GetTop()+15);
		PlayerCurrentXPLabel:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
		PlayerCurrentXPLabel:SetFont(Turbine.UI.Lotro.Font.TrajanPro14);
		PlayerCurrentXPLabel:SetForeColor(Color["nicegold"]);
		PlayerCurrentXPLabel:SetText(L["XP"]);

		PlayerCurrentXPValue = Turbine.UI.Label();
		PlayerCurrentXPValue:SetParent(APICtr);
		PlayerCurrentXPValue:SetSize(PlayVal,15);
		PlayerCurrentXPValue:SetPosition(PlayerCurrentXPLabel:GetLeft()+25,PlayerCurrentXPLabel:GetTop());
		PlayerCurrentXPValue:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleRight);
		PlayerCurrentXPValue:SetFont(Turbine.UI.Lotro.Font.Verdana12);
		PlayerCurrentXPValue:SetForeColor(Color["white"]);
		
		local PlayerNeededXPLabel = Turbine.UI.Label();
		PlayerNeededXPLabel:SetParent(APICtr);
		PlayerNeededXPLabel:SetSize(PlayLbl+30,15);
		PlayerNeededXPLabel:SetPosition(PlayerCurrentXPLabel:GetLeft(),PlayerCurrentXPLabel:GetTop()+15);
		PlayerNeededXPLabel:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
		PlayerNeededXPLabel:SetFont(Turbine.UI.Lotro.Font.TrajanPro14);
		PlayerNeededXPLabel:SetForeColor(Color["nicegold"]);
		PlayerNeededXPLabel:SetText(L["NXP"]);

		PlayerNeededXPValue = Turbine.UI.Label();
		PlayerNeededXPValue:SetParent(APICtr);
		PlayerNeededXPValue:SetSize(PlayVal,15);
		PlayerNeededXPValue:SetPosition(PlayerNeededXPLabel:GetLeft()+25,PlayerNeededXPLabel:GetTop());
		PlayerNeededXPValue:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleRight);
		PlayerNeededXPValue:SetFont(Turbine.UI.Lotro.Font.Verdana12);
		PlayerNeededXPValue:SetForeColor(Color["white"]);
		-- OTHER END --
		
		-- HEALING --
		local HealLen, HealLbl, HealVal = 170, 70, 100; --Healing size, label size, value size
		local HealingHeading = Turbine.UI.Label();
		HealingHeading:SetParent(APICtr);
		HealingHeading:SetSize(HealLen,18);
		HealingHeading:SetPosition(PlayerNeededXPLabel:GetLeft(),PlayerNeededXPLabel:GetTop()+20);
		HealingHeading:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
		HealingHeading:SetFont(Turbine.UI.Lotro.Font.TrajanPro16);
		HealingHeading:SetForeColor( Color["white"] );
		HealingHeading:SetText( L["Healing"] );

		local HealingSeparator = Turbine.UI.Control();
		HealingSeparator:SetParent(APICtr);
		HealingSeparator:SetSize(HealLen+1,1);
		HealingSeparator:SetPosition(HealingHeading:GetLeft(),HealingHeading:GetTop()+18);
		HealingSeparator:SetBackColor( Color["trueblue"] );

		local OutgoingLabel = Turbine.UI.Label();
		OutgoingLabel:SetParent(APICtr);
		OutgoingLabel:SetSize(HealLbl,15);
		OutgoingLabel:SetPosition(HealingHeading:GetLeft(),HealingHeading:GetTop()+20);
		OutgoingLabel:SetTextAlignment(_G.AlignLbl);
		OutgoingLabel:SetFont(Turbine.UI.Lotro.Font.TrajanPro14);
		OutgoingLabel:SetForeColor( Color["nicegold"] );
		OutgoingLabel:SetText( L["Outgoing"] );

		OutgoingValue=Turbine.UI.Label();
		OutgoingValue:SetParent(APICtr);
		OutgoingValue:SetSize(HealVal,15);
		OutgoingValue:SetPosition(OutgoingLabel:GetLeft()+HealLbl+_G.AlignOff,OutgoingLabel:GetTop());
		OutgoingValue:SetTextAlignment(_G.AlignVal);
		OutgoingValue:SetFont(Turbine.UI.Lotro.Font.Verdana12);
		OutgoingValue:SetForeColor( Color["white"] );
		
		local IncomingLabel=Turbine.UI.Label();
		IncomingLabel:SetParent(APICtr);
		IncomingLabel:SetSize(HealLbl,15);
		IncomingLabel:SetPosition(OutgoingLabel:GetLeft(),OutgoingLabel:GetTop()+15);
		IncomingLabel:SetTextAlignment(_G.AlignLbl);
		IncomingLabel:SetFont(Turbine.UI.Lotro.Font.TrajanPro14);
		IncomingLabel:SetForeColor( Color["nicegold"] );
		IncomingLabel:SetText( L["Incoming"] );

		IncomingValue=Turbine.UI.Label();
		IncomingValue:SetParent(APICtr);
		IncomingValue:SetSize(HealVal,15);
		IncomingValue:SetPosition(IncomingLabel:GetLeft()+HealLbl+_G.AlignOff,IncomingLabel:GetTop());
		IncomingValue:SetTextAlignment(_G.AlignVal);
		IncomingValue:SetFont(Turbine.UI.Lotro.Font.Verdana12);
		IncomingValue:SetForeColor( Color["white"] );
		-- HEALING END --
		
		-- STATISTICS --
		local StatsLen, StatsLbl, StatsVal = 130, 50, 80; --Statistics size, label size, value size
		local StatsHeading = Turbine.UI.Label();
		StatsHeading:SetParent( APICtr );
		StatsHeading:SetSize(StatsLen,18);
		StatsHeading:SetPosition(HealingHeading:GetLeft()+HealingHeading:GetWidth()+30, PowerCtr:GetTop()+30);
		StatsHeading:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
		StatsHeading:SetFont(Turbine.UI.Lotro.Font.TrajanPro16);
		StatsHeading:SetForeColor( Color["white"] );
		StatsHeading:SetText( L["Stats"] );

		local StatsSeparator = Turbine.UI.Control();
		StatsSeparator:SetParent( APICtr );
		StatsSeparator:SetSize(StatsLen+1,1);
		StatsSeparator:SetPosition(StatsHeading:GetLeft(),StatsHeading:GetTop()+18);
		StatsSeparator:SetBackColor( Color["trueblue"] );

		local MightLabel = Turbine.UI.Label();
		MightLabel:SetParent( APICtr );
		MightLabel:SetSize(StatsLbl,15);
		MightLabel:SetPosition(StatsHeading:GetLeft(),StatsHeading:GetTop()+20);
		MightLabel:SetTextAlignment(_G.AlignLbl);
		MightLabel:SetFont(Turbine.UI.Lotro.Font.TrajanPro14);
		MightLabel:SetForeColor( Color["nicegold"] );
		MightLabel:SetText( L["Might"] );

		MightValue = Turbine.UI.Label();
		MightValue:SetParent( APICtr );
		MightValue:SetSize(StatsVal,15);
		MightValue:SetPosition(MightLabel:GetLeft()+StatsLbl+_G.AlignOff,MightLabel:GetTop());
		MightValue:SetTextAlignment(_G.AlignVal);
		MightValue:SetFont(Turbine.UI.Lotro.Font.Verdana12);
		MightValue:SetForeColor( Color["white"] );
		
		local AgilityLabel = Turbine.UI.Label();
		AgilityLabel:SetParent( APICtr );
		AgilityLabel:SetSize(StatsLbl,15);
		AgilityLabel:SetPosition(MightLabel:GetLeft(),MightLabel:GetTop()+15);
		AgilityLabel:SetTextAlignment(_G.AlignLbl);
		AgilityLabel:SetFont(Turbine.UI.Lotro.Font.TrajanPro14);
		AgilityLabel:SetForeColor( Color["nicegold"] );
		AgilityLabel:SetText( L["Agility"] );

		AgilityValue = Turbine.UI.Label();
		AgilityValue:SetParent( APICtr );
		AgilityValue:SetSize(StatsVal,15);
		AgilityValue:SetPosition(AgilityLabel:GetLeft()+StatsLbl+_G.AlignOff,AgilityLabel:GetTop());
		AgilityValue:SetTextAlignment(_G.AlignVal);
		AgilityValue:SetFont(Turbine.UI.Lotro.Font.Verdana12);
		AgilityValue:SetForeColor( Color["white"] );
		
		local VitalityLabel = Turbine.UI.Label();
		VitalityLabel:SetParent( APICtr );
		VitalityLabel:SetSize(StatsLbl,15);
		VitalityLabel:SetPosition(AgilityLabel:GetLeft(),AgilityLabel:GetTop()+15);
		VitalityLabel:SetTextAlignment(_G.AlignLbl);
		VitalityLabel:SetFont(Turbine.UI.Lotro.Font.TrajanPro14);
		VitalityLabel:SetForeColor( Color["nicegold"] );
		VitalityLabel:SetText( L["Vitality"] );

		VitalityValue=Turbine.UI.Label();
		VitalityValue:SetParent( APICtr );
		VitalityValue:SetSize(StatsVal,15);
		VitalityValue:SetPosition(VitalityLabel:GetLeft()+StatsLbl+_G.AlignOff,VitalityLabel:GetTop());
		VitalityValue:SetTextAlignment(_G.AlignVal);
		VitalityValue:SetFont(Turbine.UI.Lotro.Font.Verdana12);
		VitalityValue:SetForeColor( Color["white"] );
		
		local WillLabel = Turbine.UI.Label();
		WillLabel:SetParent( APICtr );
		WillLabel:SetSize(StatsLbl,15);
		WillLabel:SetPosition(VitalityLabel:GetLeft(),VitalityLabel:GetTop()+15);
		WillLabel:SetTextAlignment(_G.AlignLbl);
		WillLabel:SetFont(Turbine.UI.Lotro.Font.TrajanPro14);
		WillLabel:SetForeColor( Color["nicegold"] );
		WillLabel:SetText( L["Will"] );

		WillValue = Turbine.UI.Label();
		WillValue:SetParent( APICtr );
		WillValue:SetSize(StatsVal,15);
		WillValue:SetPosition(WillLabel:GetLeft()+StatsLbl+_G.AlignOff,WillLabel:GetTop());
		WillValue:SetTextAlignment(_G.AlignVal);
		WillValue:SetFont(Turbine.UI.Lotro.Font.Verdana12);
		WillValue:SetForeColor( Color["white"] );
		
		local FateLabel =  Turbine.UI.Label();
		FateLabel:SetParent( APICtr );
		FateLabel:SetSize(StatsLbl,15);
		FateLabel:SetPosition(WillLabel:GetLeft(),WillLabel:GetTop()+15);
		FateLabel:SetTextAlignment(_G.AlignLbl);
		FateLabel:SetFont(Turbine.UI.Lotro.Font.TrajanPro14);
		FateLabel:SetForeColor( Color["nicegold"] );
		FateLabel:SetText( L["Fate"] );

		FateValue = Turbine.UI.Label();
		FateValue:SetParent( APICtr );
		FateValue:SetSize(StatsVal,15);
		FateValue:SetPosition(FateLabel:GetLeft()+StatsLbl+_G.AlignOff,FateLabel:GetTop());
		FateValue:SetTextAlignment(_G.AlignVal);
		FateValue:SetFont(Turbine.UI.Lotro.Font.Verdana12);
		FateValue:SetForeColor( Color["white"] );
		-- STATISTICS END --
		
		-- MITIGATIONS --
		local MitLen, MitLbl, MitVal = 190, 90, 100; --Mitigation size, label size, value size
		local MitigationsHeading = Turbine.UI.Label();
		MitigationsHeading:SetParent(APICtr);
		MitigationsHeading:SetSize(MitLen,18);
		MitigationsHeading:SetPosition(StatsHeading:GetLeft()+StatsHeading:GetWidth()+30, PowerCtr:GetTop()+30);
		MitigationsHeading:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
		MitigationsHeading:SetFont(Turbine.UI.Lotro.Font.TrajanPro16);
		MitigationsHeading:SetForeColor(Color["white"]);
		MitigationsHeading:SetText(L["Mitigations"]);

		local MitigationsSeparator = Turbine.UI.Control();
		MitigationsSeparator:SetParent(APICtr);
		MitigationsSeparator:SetSize(MitLen+1,1);
		MitigationsSeparator:SetPosition(MitigationsHeading:GetLeft(),MitigationsHeading:GetTop()+18);
		MitigationsSeparator:SetBackColor(Color["trueblue"]);

		local PhysicalLabel = Turbine.UI.Label();
		PhysicalLabel:SetParent(APICtr);
		PhysicalLabel:SetSize(MitLbl,15);
		PhysicalLabel:SetPosition(MitigationsHeading:GetLeft(),MitigationsHeading:GetTop()+20);
		PhysicalLabel:SetTextAlignment(_G.AlignLbl);
		PhysicalLabel:SetFont(Turbine.UI.Lotro.Font.TrajanPro14);
		PhysicalLabel:SetForeColor(Color["nicegold"]);
		PhysicalLabel:SetText(L["Physical"]);
		
		PhysicalValue = Turbine.UI.Label();
		PhysicalValue:SetParent(APICtr);
		PhysicalValue:SetSize(MitVal,15);
		PhysicalValue:SetPosition(PhysicalLabel:GetLeft()+MitLbl+_G.AlignOff,PhysicalLabel:GetTop());
		PhysicalValue:SetTextAlignment(_G.AlignVal);
		PhysicalValue:SetFont(Turbine.UI.Lotro.Font.Verdana12);
		PhysicalValue:SetForeColor(Color["white"]);
		
		local TacticalMitLabel = Turbine.UI.Label();
		TacticalMitLabel:SetParent(APICtr);
		TacticalMitLabel:SetSize(MitLbl,15);
		TacticalMitLabel:SetPosition(PhysicalLabel:GetLeft(),PhysicalLabel:GetTop()+15);
		TacticalMitLabel:SetTextAlignment(_G.AlignLbl);
		TacticalMitLabel:SetFont(Turbine.UI.Lotro.Font.TrajanPro14);
		TacticalMitLabel:SetForeColor(Color["nicegold"]);
		TacticalMitLabel:SetText(L["Tactical"]);

		TacticalMitValue = Turbine.UI.Label();
		TacticalMitValue:SetParent(APICtr);
		TacticalMitValue:SetSize(MitVal,15);
		TacticalMitValue:SetPosition(TacticalMitLabel:GetLeft()+MitLbl+_G.AlignOff,TacticalMitLabel:GetTop());
		TacticalMitValue:SetTextAlignment(_G.AlignVal);
		TacticalMitValue:SetFont(Turbine.UI.Lotro.Font.Verdana12);
		TacticalMitValue:SetForeColor(Color["white"]);
		
		local OrcLabel = Turbine.UI.Label();
		OrcLabel:SetParent(APICtr);
		OrcLabel:SetSize(MitLbl,15);
		OrcLabel:SetPosition(TacticalMitLabel:GetLeft(),TacticalMitLabel:GetTop()+15);
		OrcLabel:SetTextAlignment(_G.AlignLbl);
		OrcLabel:SetFont(Turbine.UI.Lotro.Font.TrajanPro14);
		OrcLabel:SetForeColor(Color["nicegold"]);
		OrcLabel:SetText(L["Orc"]);
		
		OrcValue = Turbine.UI.Label();
		OrcValue:SetParent(APICtr);
		OrcValue:SetSize(MitVal,15);
		OrcValue:SetPosition(OrcLabel:GetLeft()+MitLbl+_G.AlignOff,OrcLabel:GetTop());
		OrcValue:SetTextAlignment(_G.AlignVal);
		OrcValue:SetFont(Turbine.UI.Lotro.Font.Verdana12);
		OrcValue:SetForeColor(Color["white"]);
		
		local FellLabel = Turbine.UI.Label();
		FellLabel:SetParent(APICtr);
		FellLabel:SetSize(MitLbl,15);
		FellLabel:SetPosition(OrcLabel:GetLeft(),OrcLabel:GetTop()+15);
		FellLabel:SetTextAlignment(_G.AlignLbl);
		FellLabel:SetFont(Turbine.UI.Lotro.Font.TrajanPro14);
		FellLabel:SetForeColor(Color["nicegold"]);
		FellLabel:SetText(L["Fell"]);

		FellValue = Turbine.UI.Label();
		FellValue:SetParent(APICtr);
		FellValue:SetSize(MitVal,15);
		FellValue:SetPosition(FellLabel:GetLeft()+MitLbl+_G.AlignOff,FellLabel:GetTop());
		FellValue:SetTextAlignment(_G.AlignVal);
		FellValue:SetFont(Turbine.UI.Lotro.Font.Verdana12);
		FellValue:SetForeColor(Color["white"]);
		-- MITIGATIONS END --
		
		-- OFFENCE --
		local OffLen, OffLbl, OffVal = 170, 70, 100; --Mitigation size, label size, value size
		local OffenceHeading = Turbine.UI.Label();
		OffenceHeading:SetParent(APICtr);
		OffenceHeading:SetSize(OffLen,18);
		OffenceHeading:SetPosition(MitigationsHeading:GetLeft()+MitigationsHeading:GetWidth()+30, PowerCtr:GetTop()+30);
		OffenceHeading:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
		OffenceHeading:SetFont(Turbine.UI.Lotro.Font.TrajanPro16);
		OffenceHeading:SetForeColor(Color["white"]);
		OffenceHeading:SetText(L["Offence"]);
		
		local OffenceSeparator = Turbine.UI.Control();
		OffenceSeparator:SetParent(APICtr);
		OffenceSeparator:SetSize(OffLen,1);
		OffenceSeparator:SetPosition(OffenceHeading:GetLeft(),OffenceHeading:GetTop()+18);
		OffenceSeparator:SetBackColor(Color["trueblue"]);

		local MeleeLabel = Turbine.UI.Label();
		MeleeLabel:SetParent(APICtr);
		MeleeLabel:SetSize(OffLbl,15);
		MeleeLabel:SetPosition(OffenceHeading:GetLeft(),OffenceHeading:GetTop()+20);
		MeleeLabel:SetTextAlignment(_G.AlignLbl);
		MeleeLabel:SetFont(Turbine.UI.Lotro.Font.TrajanPro14);
		MeleeLabel:SetForeColor(Color["nicegold"]);
		MeleeLabel:SetText(L["Melee"]);

		MeleeValue = Turbine.UI.Label();
		MeleeValue:SetParent(APICtr);
		MeleeValue:SetSize(OffVal,15);
		MeleeValue:SetPosition(MeleeLabel:GetLeft()+OffLbl+_G.AlignOff,MeleeLabel:GetTop());
		MeleeValue:SetTextAlignment(_G.AlignVal);
		MeleeValue:SetFont(Turbine.UI.Lotro.Font.Verdana12);
		MeleeValue:SetForeColor(Color["white"]);
		
		local RangedLabel = Turbine.UI.Label();
		RangedLabel:SetParent(APICtr);
		RangedLabel:SetSize(OffLbl,15);
		RangedLabel:SetPosition(MeleeLabel:GetLeft(),MeleeLabel:GetTop()+15);
		RangedLabel:SetTextAlignment(_G.AlignLbl);
		RangedLabel:SetFont(Turbine.UI.Lotro.Font.TrajanPro14);
		RangedLabel:SetForeColor(Color["nicegold"]);
		RangedLabel:SetText(L["Ranged"]);

		RangedValue = Turbine.UI.Label();
		RangedValue:SetParent(APICtr);
		RangedValue:SetSize(OffVal,15);
		RangedValue:SetPosition(RangedLabel:GetLeft()+OffLbl+_G.AlignOff,RangedLabel:GetTop());
		RangedValue:SetTextAlignment(_G.AlignVal);
		RangedValue:SetFont(Turbine.UI.Lotro.Font.Verdana12);
		RangedValue:SetForeColor(Color["white"]);
		
		local TacticalDamLabel = Turbine.UI.Label();
		TacticalDamLabel:SetParent(APICtr);
		TacticalDamLabel:SetSize(OffLbl,15);
		TacticalDamLabel:SetPosition(RangedLabel:GetLeft(),RangedLabel:GetTop()+15);
		TacticalDamLabel:SetTextAlignment(_G.AlignLbl);
		TacticalDamLabel:SetFont(Turbine.UI.Lotro.Font.TrajanPro14);
		TacticalDamLabel:SetForeColor(Color["nicegold"]);
		TacticalDamLabel:SetText(L["Tactical"]);

		TacticalDamValue = Turbine.UI.Label();
		TacticalDamValue:SetParent(APICtr);
		TacticalDamValue:SetSize(OffVal,15);
		TacticalDamValue:SetPosition(TacticalDamLabel:GetLeft()+OffLbl+_G.AlignOff,TacticalDamLabel:GetTop());
		TacticalDamValue:SetTextAlignment(_G.AlignVal);
		TacticalDamValue:SetFont(Turbine.UI.Lotro.Font.Verdana12);
		TacticalDamValue:SetForeColor(Color["white"]);
		
		local CritHitLabel = Turbine.UI.Label();
		CritHitLabel:SetParent(APICtr);
		CritHitLabel:SetSize(OffLbl,15);
		CritHitLabel:SetPosition(TacticalDamLabel:GetLeft(),TacticalDamLabel:GetTop()+15);
		CritHitLabel:SetTextAlignment(_G.AlignLbl);
		CritHitLabel:SetFont(Turbine.UI.Lotro.Font.TrajanPro14);
		CritHitLabel:SetForeColor(Color["nicegold"]);
		CritHitLabel:SetText(L["CritHit"]);

		CritHitValue = Turbine.UI.Label();
		CritHitValue:SetParent(APICtr);
		CritHitValue:SetSize(OffVal,15);
		CritHitValue:SetPosition(CritHitLabel:GetLeft()+OffLbl+_G.AlignOff,CritHitLabel:GetTop());
		CritHitValue:SetTextAlignment(_G.AlignVal);
		CritHitValue:SetFont(Turbine.UI.Lotro.Font.Verdana12);
		CritHitValue:SetForeColor(Color["white"]);
		
		local DevHitLabel = Turbine.UI.Label();
		DevHitLabel:SetParent(APICtr);
		DevHitLabel:SetSize(OffLbl,15);
		DevHitLabel:SetPosition(CritHitLabel:GetLeft(),CritHitLabel:GetTop()+15);
		DevHitLabel:SetTextAlignment(_G.AlignLbl);
		DevHitLabel:SetFont(Turbine.UI.Lotro.Font.TrajanPro14);
		DevHitLabel:SetForeColor(Color["nicegold"]);
		DevHitLabel:SetText(L["DevHit"]);

		DevHitValue = Turbine.UI.Label();
		DevHitValue:SetParent(APICtr);
		DevHitValue:SetSize(OffVal,15);
		DevHitValue:SetPosition(DevHitLabel:GetLeft()+OffLbl+_G.AlignOff,DevHitLabel:GetTop());
		DevHitValue:SetTextAlignment(_G.AlignVal);
		DevHitValue:SetFont(Turbine.UI.Lotro.Font.Verdana12);
		DevHitValue:SetForeColor(Color["white"]);
		
		local FinesseLabel = Turbine.UI.Label();
		FinesseLabel:SetParent( APICtr );
		FinesseLabel:SetSize(OffLbl,15);
		FinesseLabel:SetPosition(DevHitLabel:GetLeft(),DevHitLabel:GetTop()+15);
		FinesseLabel:SetTextAlignment(_G.AlignLbl);
		FinesseLabel:SetFont(Turbine.UI.Lotro.Font.TrajanPro14);
		FinesseLabel:SetForeColor( Color["nicegold"] );
		FinesseLabel:SetText( L["Finesse"] );

		FinesseValue = Turbine.UI.Label();
		FinesseValue:SetParent( APICtr );
		FinesseValue:SetSize(OffVal,15);
		FinesseValue:SetPosition(FinesseLabel:GetLeft()+OffLbl+_G.AlignOff,FinesseLabel:GetTop());
		FinesseValue:SetTextAlignment(_G.AlignVal);
		FinesseValue:SetFont(Turbine.UI.Lotro.Font.Verdana12);
		FinesseValue:SetForeColor( Color["white"] );
		-- OFFENCE END --
		
		-- DEFENCE --
		local DefenceLen, DefenceLbl, DefenceVal = 190, 90, 100; --Avoidances size, label size, value size
		local DefenceHeading=Turbine.UI.Label();
		DefenceHeading:SetParent(APICtr);
		DefenceHeading:SetSize(DefenceLen,18);
		DefenceHeading:SetPosition(OffenceHeading:GetLeft()+OffenceHeading:GetWidth()+30,PowerCtr:GetTop()+30);
		DefenceHeading:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
		DefenceHeading:SetFont(Turbine.UI.Lotro.Font.TrajanPro16);
		DefenceHeading:SetForeColor(Color["white"]);
		DefenceHeading:SetText(L["Defence"]);

		local DefenceSeparator=Turbine.UI.Control();
		DefenceSeparator:SetParent(APICtr);
		DefenceSeparator:SetSize(DefenceLen,1);
		DefenceSeparator:SetPosition(DefenceHeading:GetLeft(),DefenceHeading:GetTop()+18);
		DefenceSeparator:SetBackColor(Color["trueblue"]);

		local CritDefLabel=Turbine.UI.Label();
		CritDefLabel:SetParent(APICtr);
		CritDefLabel:SetSize(DefenceLbl,15);
		CritDefLabel:SetPosition(DefenceHeading:GetLeft(),DefenceHeading:GetTop()+20);
		CritDefLabel:SetTextAlignment(_G.AlignLbl);
		CritDefLabel:SetFont(Turbine.UI.Lotro.Font.TrajanPro14);
		CritDefLabel:SetForeColor(Color["nicegold"]);
		CritDefLabel:SetText(L["CritDef"]);

		CritDefValue=Turbine.UI.Label();
		CritDefValue:SetParent(APICtr);
		CritDefValue:SetSize(DefenceVal,15);
		CritDefValue:SetPosition(CritDefLabel:GetLeft()+DefenceLbl+_G.AlignOff,CritDefLabel:GetTop());
		CritDefValue:SetTextAlignment(_G.AlignVal);
		CritDefValue:SetFont(Turbine.UI.Lotro.Font.Verdana12);
		CritDefValue:SetForeColor(Color["white"]);
		
		local ResistanceLabel = Turbine.UI.Label();
		ResistanceLabel:SetParent(APICtr);
		ResistanceLabel:SetSize(DefenceLbl,15);
		ResistanceLabel:SetPosition(CritDefLabel:GetLeft(), CritDefLabel:GetTop()+15);
		ResistanceLabel:SetTextAlignment(_G.AlignLbl);
		ResistanceLabel:SetFont(Turbine.UI.Lotro.Font.TrajanPro14);
		ResistanceLabel:SetForeColor(Color["nicegold"]);
		ResistanceLabel:SetText(L["Resistances"]);

		ResistanceValue = Turbine.UI.Label();
		ResistanceValue:SetParent(APICtr);
		ResistanceValue:SetSize(DefenceVal,15);
		ResistanceValue:SetPosition(ResistanceLabel:GetLeft()+DefenceLbl+_G.AlignOff,ResistanceLabel:GetTop());
		ResistanceValue:SetTextAlignment(_G.AlignVal);
		ResistanceValue:SetFont(Turbine.UI.Lotro.Font.Verdana12);
		ResistanceValue:SetForeColor(Color["white"]);
				
		local BlockLabel=Turbine.UI.Label();
		BlockLabel:SetParent(APICtr);
		BlockLabel:SetSize(DefenceLbl,15);
		BlockLabel:SetPosition(ResistanceLabel:GetLeft(),ResistanceLabel:GetTop()+15);
		BlockLabel:SetTextAlignment(_G.AlignLbl);
		BlockLabel:SetFont(Turbine.UI.Lotro.Font.TrajanPro14);
		BlockLabel:SetForeColor(Color["nicegold"]);
		BlockLabel:SetText(L["Block"]);

		BlockValue=Turbine.UI.Label();
		BlockValue:SetParent(APICtr);
		BlockValue:SetSize(DefenceVal,15);
		BlockValue:SetPosition(BlockLabel:GetLeft()+DefenceLbl+_G.AlignOff,BlockLabel:GetTop());
		BlockValue:SetTextAlignment(_G.AlignVal);
		BlockValue:SetFont(Turbine.UI.Lotro.Font.Verdana12);
		BlockValue:SetForeColor(Color["white"]);
		
		local PBlockLabel=Turbine.UI.Label();
		PBlockLabel:SetParent(APICtr);
		PBlockLabel:SetSize(DefenceLbl,15);
		PBlockLabel:SetPosition(BlockLabel:GetLeft()+_G.AlignOffP,BlockLabel:GetTop()+15);
		PBlockLabel:SetTextAlignment(_G.AlignLbl);
		PBlockLabel:SetFont(Turbine.UI.Lotro.Font.TrajanPro14);
		PBlockLabel:SetForeColor(Color["nicegold"]);
		PBlockLabel:SetText(L["Partial"]);

		PBlockValue=Turbine.UI.Label();
		PBlockValue:SetParent(APICtr);
		PBlockValue:SetSize(DefenceVal,15);
		PBlockValue:SetPosition(PBlockLabel:GetLeft()+DefenceLbl-_G.AlignOffP+_G.AlignOff,PBlockLabel:GetTop());
		PBlockValue:SetTextAlignment(_G.AlignVal);
		PBlockValue:SetFont(Turbine.UI.Lotro.Font.Verdana12);
		PBlockValue:SetForeColor(Color["white"]);
		
		local ParryLabel=Turbine.UI.Label();
		ParryLabel:SetParent(APICtr);
		ParryLabel:SetSize(DefenceLbl,15);
		ParryLabel:SetPosition(BlockLabel:GetLeft(),BlockLabel:GetTop()+30);
		ParryLabel:SetTextAlignment(_G.AlignLbl);
		ParryLabel:SetFont(Turbine.UI.Lotro.Font.TrajanPro14);
		ParryLabel:SetForeColor(Color["nicegold"]);
		ParryLabel:SetText(L["Parry"]);

		ParryValue=Turbine.UI.Label();
		ParryValue:SetParent(APICtr);
		ParryValue:SetSize(DefenceVal,15);
		ParryValue:SetPosition(ParryLabel:GetLeft()+DefenceLbl+_G.AlignOff,ParryLabel:GetTop());
		ParryValue:SetTextAlignment(_G.AlignVal);
		ParryValue:SetFont(Turbine.UI.Lotro.Font.Verdana12);
		ParryValue:SetForeColor(Color["white"]);
		
		local PParryLabel=Turbine.UI.Label();
		PParryLabel:SetParent(APICtr);
		PParryLabel:SetSize(DefenceLbl,15);
		PParryLabel:SetPosition(ParryLabel:GetLeft()+_G.AlignOffP,ParryLabel:GetTop()+15);
		PParryLabel:SetTextAlignment(_G.AlignLbl);
		PParryLabel:SetFont(Turbine.UI.Lotro.Font.TrajanPro14);
		PParryLabel:SetForeColor(Color["nicegold"]);
		PParryLabel:SetText(L["Partial"]);

		PParryValue=Turbine.UI.Label();
		PParryValue:SetParent(APICtr);
		PParryValue:SetSize(DefenceVal,15);
		PParryValue:SetPosition(PParryLabel:GetLeft()+DefenceLbl-_G.AlignOffP+_G.AlignOff,PParryLabel:GetTop());
		PParryValue:SetTextAlignment(_G.AlignVal);
		PParryValue:SetFont(Turbine.UI.Lotro.Font.Verdana12);
		PParryValue:SetForeColor(Color["white"]);
		
		local EvadeLabel=Turbine.UI.Label();
		EvadeLabel:SetParent(APICtr);
		EvadeLabel:SetSize(DefenceLbl,15);
		EvadeLabel:SetPosition(ParryLabel:GetLeft(),ParryLabel:GetTop()+30);
		EvadeLabel:SetTextAlignment(_G.AlignLbl);
		EvadeLabel:SetFont(Turbine.UI.Lotro.Font.TrajanPro14);
		EvadeLabel:SetForeColor(Color["nicegold"]);
		EvadeLabel:SetText(L["Evade"]);

		EvadeValue=Turbine.UI.Label();
		EvadeValue:SetParent(APICtr);
		EvadeValue:SetSize(DefenceVal,15);
		EvadeValue:SetPosition(EvadeLabel:GetLeft()+DefenceLbl+_G.AlignOff,EvadeLabel:GetTop());
		EvadeValue:SetTextAlignment(_G.AlignVal);
		EvadeValue:SetFont(Turbine.UI.Lotro.Font.Verdana12);
		EvadeValue:SetForeColor(Color["white"]);
		
		local PEvadeLabel=Turbine.UI.Label();
		PEvadeLabel:SetParent(APICtr);
		PEvadeLabel:SetSize(DefenceLbl,15);
		PEvadeLabel:SetPosition(EvadeLabel:GetLeft()+_G.AlignOffP,EvadeLabel:GetTop()+15);
		PEvadeLabel:SetTextAlignment(_G.AlignLbl);
		PEvadeLabel:SetFont(Turbine.UI.Lotro.Font.TrajanPro14);
		PEvadeLabel:SetForeColor(Color["nicegold"]);
		PEvadeLabel:SetText(L["Partial"]);

		PEvadeValue=Turbine.UI.Label();
		PEvadeValue:SetParent(APICtr);
		PEvadeValue:SetSize(DefenceVal,15);
		PEvadeValue:SetPosition(PEvadeLabel:GetLeft()+DefenceLbl-_G.AlignOffP+_G.AlignOff,PEvadeLabel:GetTop());
		PEvadeValue:SetTextAlignment(_G.AlignVal);
		PEvadeValue:SetFont(Turbine.UI.Lotro.Font.Verdana12);
		PEvadeValue:SetForeColor(Color["white"]);
		-- DEFENCE END --
		
		local CappedLabel=Turbine.UI.Label();
		CappedLabel:SetParent(APICtr);
		CappedLabel:SetSize(400,15);
		CappedLabel:SetPosition(MitigationsHeading:GetLeft(),IncomingLabel:GetTop());
		CappedLabel:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
		CappedLabel:SetFont(Turbine.UI.Lotro.Font.Verdana16);
		CappedLabel:SetForeColor(Color["yellow"]);
		CappedLabel:SetText(L["Capped"]);
	else
		local WarningLabel = Turbine.UI.Label();
		WarningLabel:SetParent(APICtr);
		WarningLabel:SetPosition(25,MoraleCtr:GetTop()+30);
		WarningLabel:SetTextAlignment(Turbine.UI.ContentAlignment.MiddleLeft);
		WarningLabel:SetFont(Turbine.UI.Lotro.Font.TrajanPro14);
		WarningLabel:SetForeColor( Color["nicegold"] );
		WarningLabel:SetText( L["NoData"] );
		WarningLabel:SetSize(WarningLabel:GetTextLength()*7.2, 15 ); --Auto size with text lenght
	end

	GetData();

	ApplySkin();
end

function GetData()
	MoraleValue:SetText(round(Player:GetMorale()).." / ".. round(Player:GetMaxMorale()));
	
	if PlayerClassIs == L["Beorning"] then 
		Power = round(Player:GetClassAttributes():GetWrath());
		MaxPower = 100;
	else 
		Power = round(Player:GetPower());
		MaxPower = round(Player:GetMaxPower());
	end;
	PowerValue:SetText(Power .." / ".. MaxPower);
	
	if PlayerAlign == 1 then
		ArmorValue:SetText(PlayerAtt:GetArmor());
		curLvl = Player:GetLevel(); --Current player level
		--curLvl = 76; --debug purpose
		--ExpPTS = "13,117,787"; --debug purpose
		--curLvl = 77; --debug purpose
		--ExpPTS = "13,863,500"; --debug purpose
		--PlayerLevelValue:SetText( curLvl ); --debug purpose

		-- OTHER --
		PlayerLevelValue:SetText(Player:GetLevel());
		PlayerRacelValue:SetText(PlayerRaceIs);
		PlayerClassValue:SetText(PlayerClassIs);

		if curLvl >= #PlayerLevel then
			PlayerCurrentXPValue:SetText( L["MLvl"] );
			PlayerNeededXPValue:SetText( "" );
		else
			-- Calculate max xp for current level
			maxXP = PlayerLevel[curLvl]; --Max XP at current level
			maxXP = string.gsub(maxXP, ",", ""); --Replace "," in 1,400 to get 1400

			--Max XP at previous level
			if curLvl-1 == 0 then preXP = 0;
			else preXP = PlayerLevel[curLvl-1]; end
			preXP = string.gsub(preXP, ",", ""); --Replace "," in 1,400 to get 1400
			maxXP = maxXP - preXP;

			--Calculate the min xp for current level
			minXP = ExpPTS;
			
			--minXP = string.gsub(minXP, ",", ""); --Replace "," in 1,400 to get 1400
			minXP = string.gsub(minXP, "%p", ""); --Replace decimal separator Ex.: in 1,400 to get 1400
			minXP = minXP - preXP;
			if minXP < 0 then minXP = "No Data"; else minXP = string.format("%2d", minXP); end
			
			--Calculate % for current level
			if minXP ~= "No Data" then 
				percentage_done = " (" .. string.format("%.2f", (minXP / maxXP)*100) .. "%)"; 
				minXP = comma_value(minXP); -- Convert back number with comma
			else 
				percentage_done = ""; 
			end
			
			-- Convert back number with comma
			maxXP = comma_value(maxXP);

			PlayerCurrentXPValue:SetText( minXP .. percentage_done );
			PlayerNeededXPValue:SetText( maxXP );
		end
		-- OTHER END --
		
		-- HEALING --
		Rtg = round(PlayerAtt:GetOutgoingHealing());
		str = get_percentage("OutHeal", Rtg, curLvl);
		OutgoingValue:SetText(Rtg .. " (" .. str .. "%)");
		if Capped == 1 then OutgoingValue:SetForeColor(Color["yellow"]); Capped = 0; end
		
		Rtg = round(PlayerAtt:GetIncomingHealing());
		str = get_percentage("InHeal", Rtg, curLvl);
		IncomingValue:SetText(Rtg .. " (" .. str .. "%)");
		if Capped == 1 then IncomingValue:SetForeColor(Color["yellow"]); Capped = 0; end
		-- HEALING END --
		
		-- STATISTICS --
		MightValue:SetText(PlayerAtt:GetMight());
		AgilityValue:SetText(PlayerAtt:GetAgility());
		VitalityValue:SetText(PlayerAtt:GetVitality());
		WillValue:SetText(PlayerAtt:GetWill());
		FateValue:SetText(PlayerAtt:GetFate());
		
		Rtg = round(PlayerAtt:GetFinesse());
		str = get_percentage("Finesse", Rtg, curLvl);
		FinesseValue:SetText(Rtg .. " (" .. str .. "%)");
		if Capped == 1 then FinesseValue:SetForeColor(Color["yellow"]); Capped = 0; end
		-- STATISTICS END --
		
		-- MITIGATIONS
		Rtg = round(PlayerAtt:GetCommonMitigation());
		str = get_percentage("Mitigation", Rtg, curLvl);
		PhysicalValue:SetText(Rtg .. " (" .. str .. "%)");
		if Capped == 1 then PhysicalValue:SetForeColor(Color["yellow"]); Capped = 0; end
		
		Rtg = round(PlayerAtt:GetTacticalMitigation());
		str = get_percentage("Mitigation", Rtg, curLvl);
		TacticalMitValue:SetText(Rtg .. " (" .. str .. "%)");
		if Capped == 1 then TacticalMitValue:SetForeColor(Color["yellow"]); Capped = 0; end
		
		Rtg = round(PlayerAtt:GetPhysicalMitigation());
		str = get_percentage("Mitigation", Rtg, curLvl);
		OrcValue:SetText(Rtg .. " (" .. str .. "%)");
		FellValue:SetText(Rtg .. " (" .. str .. "%)");
		if Capped == 1 then OrcValue:SetForeColor(Color["yellow"]); FellValue:SetForeColor(Color["yellow"]); Capped = 0; end
		-- MITIGATIONS END --
		
		-- OFFENCE --
		Rtg = round(PlayerAtt:GetMeleeDamage());
		str = get_percentage("OffDam", Rtg, curLvl);
		MeleeValue:SetText(Rtg .. " (" .. str .. "%)");
		if Capped == 1 then MeleeValue:SetForeColor(Color["yellow"]); Capped = 0; end
		
		Rtg = round(PlayerAtt:GetRangeDamage());
		str = get_percentage("OffDam", Rtg, curLvl);
		RangedValue:SetText(Rtg .. " (" .. str .. "%)");
		if Capped == 1 then RangedValue:SetForeColor(Color["yellow"]); Capped = 0; end
		
		Rtg = round(PlayerAtt:GetTacticalDamage());
		str = get_percentage("OffDam", Rtg, curLvl);
		TacticalDamValue:SetText(Rtg .. " (" .. str .. "%)");
		if Capped == 1 then TacticalDamValue:SetForeColor(Color["yellow"]); Capped = 0; end
		
		Rtg = round(PlayerAtt:GetBaseCriticalHitChance());
		str = get_percentage("CritHit", Rtg, curLvl);
		CritHitValue:SetText(Rtg .. " (" .. str .. "%)");
		if Capped == 1 then CritHitValue:SetForeColor(Color["yellow"]); Capped = 0; end
		
		Rtg = round(PlayerAtt:GetBaseCriticalHitChance());
		str = get_percentage("DevasHit", Rtg, curLvl);
		DevHitValue:SetText(Rtg .. " (" .. str .. "%)");
		if Capped == 1 then DevHitValue:SetForeColor(Color["yellow"]); Capped = 0; end
		-- OFFENCE END --
		
		-- DEFENCE --
		Rtg = round(PlayerAtt:GetBaseCriticalHitAvoidance());
		str = string.format("%.1f", 1/(1+100/(Rtg/curLvl)*100));
		CritDefValue:SetText(Rtg .. " (" .. str .. "%)");
		if Capped == 1 then CritDefValue:SetForeColor(Color["yellow"]); Capped = 0; end
		
		Rtg = round(PlayerAtt:GetBaseResistance());
		str = get_percentage("Resistance", Rtg, curLvl);
		ResistanceValue:SetText(Rtg .. " (" .. str .. "%)");
		if Capped == 1 then ResistanceValue:SetForeColor(Color["yellow"]); Capped = 0; end
		
		Rtg = round(PlayerAtt:GetBlock());
		str = get_percentage("BPE", Rtg, curLvl);
		if Capped == 1 then BlockValue:SetForeColor(Color["yellow"]); Capped = 0; end
		pstr = get_percentage("PartBPE", Rtg, curLvl);
		if Capped == 1 then PBlockValue:SetForeColor(Color["yellow"]); Capped = 0; end
		BlockValue:SetText(Rtg .. " (" .. str .. "%)");
		PBlockValue:SetText(pstr .. "%");
		
		
		Rtg = round(PlayerAtt:GetParry());
		str = get_percentage("BPE", Rtg, curLvl);
		if Capped == 1 then ParryValue:SetForeColor(Color["yellow"]); Capped = 0; end
		pstr = get_percentage("PartBPE", Rtg, curLvl);
		if Capped == 1 then PParryValue:SetForeColor(Color["yellow"]); Capped = 0; end
		ParryValue:SetText(Rtg .. " (" .. str .. "%)");
		PParryValue:SetText(pstr .. "%");
		
		Rtg = round(PlayerAtt:GetEvade());
		str = get_percentage("BPE", Rtg, curLvl);
		if Capped == 1 then EvadeValue:SetForeColor(Color["yellow"]); Capped = 0; end
		pstr = get_percentage("PartBPE", Rtg, curLvl);
		if Capped == 1 then PEvadeValue:SetForeColor(Color["yellow"]); Capped = 0; end
		EvadeValue:SetText(Rtg .. " (" .. str .. "%)");
		PEvadeValue:SetText(pstr .. "%");
		-- DEFENCE END --
	end
end

-- Formula and data used from: http://lotro-wiki.com/index.php/rating_to_percentage_formula
function get_percentage( Attribute, R, L )
	local X0, Y0, K, lowRL, highRL;
	local RL = R/L;
	local Armour, Ratings;
	
	RatingsData = { CritHit = { S = 3, 								-- Critical Hit
							  dp = { 0, 0.15, 0.5, 0.5 },
							  K = { 1190/3, 794.8, 1075.2 },
							  dRL = { 0, 70, 79438/19, 1075.2/19 } },
				DevasHit = { S = 1,								-- Devastating Hit
							   dp = {0, 0.1},
							   K = {1330},
							   dRL = {0, 1330/9} },
				Finesse = { S = 1,								-- Finesse
							  dp = { 0, 0.1 },
							  K = {1190/3},
							  dRL = { 0, 105 } },
				OffDam = { 										-- Offence Damage (Linear)
							 levSegStart = { 1, 21, 31, 41, 51, 61, 71, 81, 91, 101 }, 
							 Factor = { 14.6, 24.2, 17, 13.4, 11.4 ,10.2, 7.4, 6.6, 5.7, 2.7 },
							 FactorLevel = { 0, 0.48, 0.24, 0.15, 0.11, 0.09, 0.05, 0.04, 0.03, 0 },
							 CapPct = { 40, 40, 40, 40, 200, 200, 200, 200, 200, 400 } },			  
				OutHeal = { S = 3,								-- Tactical Outgoing Healing
							  dp = { 0, 0.3, 0.2, 0.2 },
							  K = { 1190/3, 2380/3, 1190 },
							  dRL = { 0, 170, 595/3, 297.5 } },			
				Resistance = { S = 2,								-- Resistance
							     dp = { 0, 0.2, 0.2 },
							     K = { 1190/3, 2380/3 },
								 dRL = { 0, 170, 595/3 } },
				InHeal = { S = 2,									-- Incoming Healing
							 dp = { 0, 0.15, 0.1 },
							 K = { 1190/3, 2380/3 },
							 dRL = { 0, 70, 2380/27 } },
				BPE = { S = 1,										--  Block, Parry, Evade
							     dp = {0, 0.13},
								 K = {499.95},
								 dRL = {0, 43329/580} },
				PartBPE = { S = 4,									--  Partially Block, Parry, Evade
							 dp = { 0, 0.15, 0.02, 0.03, 0.15 },
							 K = { 396.66, 991.66, 1050, 1200 },
							 dRL = { 0, 59499/850, 49583/2450, 3150/97, 3600/17 } },
				Mitigation = { Light = { dp = { 0.2, 0.2 },			-- Mitigation
											K = { 150, 350 },
											dRL = { 37.5, 87.5 }},
								 Medium = { dp = { 0.2, 0.3 },
											K = { 150, 350 },
											dRL = { 37.5, 150 }},
								 Heavy = { dp = { 0.1, 0.5 },
										   K = { 5697/38, 5697/38 },
										   dRL = { 633/38, 5697/38 }}}
			 };
	
	if Attribute == "Mitigation" then -- is dependant on armour type
		if PlayerClassIs == _G.L["Lore-Master"] or PlayerClassIs == _G.L["Minstrel"] or PlayerClassIs == _G.L["Rune-Keeper"] then
			Armour = RatingsData.Mitigation.Light;
		elseif PlayerClassIs == _G.L["Beorning"] or PlayerClassIs == _G.L["Burglar"] or PlayerClassIs == _G.L["Hunter"] or PlayerClassIs == _G.L["Warden"] then
			Armour = RatingsData.Mitigation.Medium;
		elseif PlayerClassIs == _G.L["Captain"] or PlayerClassIs == _G.L["Champion"] or PlayerClassIs == _G.L["Guardian"] then
			Armour = RatingsData.Mitigation.Heavy;
		end
		
		if RL <= Armour.dRL[1] then
			X0 = 0;
			Y0 = 0;
			K = Armour.K[1];
		elseif (RL > Armour.dRL[1]) and (RL <= Armour.dRL[2]) then
			X0 = Armour.dRL[1];
			Y0 = Armour.dp[1];
			K = Armour.K[2];
		elseif RL > Armour.dRL[2] then -- CAPPED
			Capped = 1;
			answer = sum_array(Armour.dp, 2)*100;
			return string.format("%.1f", answer);
		end
		answer = (Y0 + 1/(1+K/(RL-X0)))*100;
		return string.format("%.1f", answer);
	elseif Attribute == "CritHit" then Ratings = RatingsData.CritHit;
	elseif Attribute == "DevasHit" then Ratings = RatingsData.DevasHit;
	elseif Attribute == "Finesse" then Ratings = RatingsData.Finesse;
	elseif Attribute == "OffDam" then -- linear
		Ratings = RatingsData.OffDam;
		local i = #Ratings.levSegStart;
		local answer;
		while Ratings.levSegStart[i] > L do
			i = i-1;
		end
		local Factor = Ratings.Factor[i] - Ratings.FactorLevel[i] * L
		answer = Factor * R / 1000;
		if answer > Ratings.CapPct[i] then
			Capped = 1;
			answer = Ratings.CapPct[i];
		end
		return string.format("%.1f", answer);
	elseif Attribute == "OutHeal" then Ratings = RatingsData.OutHeal;
	elseif Attribute == "Resistance" then Ratings = RatingsData.Resistance;
	elseif Attribute == "InHeal" then Ratings = RatingsData.InHeal;
	elseif Attribute == "BPE" then Ratings = RatingsData.BPE;
	elseif Attribute == "PartBPE" then Ratings = RatingsData.PartBPE;
	end
	
	local i = 0;
	local OverSet = 0;
	local answer;
	while 1 do
		i = i+1;
		MaxD = #Ratings.dRL;
		if Ratings.S == 0 then
			if i >= MaxD - 1 then
				OverSet = i + 1 - MaxD;
			end
			if (RL >= sum_array(Ratings.dRL, i-OverSet) + OverSet * Ratings.dRL[MaxD]) and (RL < sum_array(Ratings.dRL, i+1-OverSet) + OverSet * Ratings.dRL[MaxD]) then
				X0 = sum_array(Ratings.dRL, i-OverSet) + OverSet * Ratings.dRL[MaxD];
				Y0 = sum_array(Ratings.dp, i-OverSet) + OverSet * Ratings.dRL[MaxD];
				if OverSet == 0 then
					K = Ratings.K[i];
				else
					K = Ratings.K[MaxD-1];
				end
				answer = (Y0 + 1/(1+K/(RL-X0)))*100;
				return string.format("%.1f", answer);
			end
		elseif (Ratings.S+1 == i) and (Ratings.S > 0) and (RL>sum_array(Ratings.dRL,i)) then -- CAPPED
			Capped = 1;
			answer = sum_array(Ratings.dp, i)*100;
			return string.format("%.1f", answer);
		elseif (RL >= sum_array(Ratings.dRL, i)) and (RL < sum_array(Ratings.dRL, i+1)) and (Ratings.S > 0) then
			X0 = sum_array(Ratings.dRL, i);
			Y0 = sum_array(Ratings.dp, i);
			K = Ratings.K[i];
			answer = (Y0 + 1/(1+K/(RL-X0)))*100;
			return string.format("%.1f", answer);
		end
	end
end

function sum_array( Array, MaxInt )
	local sum = 0;
	for i = 1,MaxInt do
		sum = sum+Array[i];
	end
	return sum;
end
 
function comma_value(n) -- credit http://richard.warburton.it
	local left,num,right = string.match(n,'^([^%d]*%d)(%d*)(.-)$')
	return left..(num:reverse():gsub('(%d%d%d)','%1,'):reverse())..right
end