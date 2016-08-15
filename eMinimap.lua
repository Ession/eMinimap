-- =============================================================================
-- 
--       Filename:  eMinimap.lua
-- 
--    Description:  Hides the minimap buttons and changes
--                  the position and shape of the map.
-- 
--        Version:  7.0.1
--        Created:  Sun Nov 01 13:21:24 CET 2009
--       Revision:  none
-- 
--         Author:  Mathias Jost (mail@mathiasjost.com)
-- 
-- =============================================================================


-- -----------------------------------------------------------------------------
-- Options
-- -----------------------------------------------------------------------------
local MinimapScale  = 1.04
local MinimapStrata = "MEDIUM"
local MinimapAlpha  = 1
local MinimapPosX   = 18
local MinimapPosY   = -9


-- -----------------------------------------------------------------------------
-- Hides the default buttons/frames
-- -----------------------------------------------------------------------------
MinimapZoomIn:Hide()
MinimapZoomOut:Hide()
MiniMapWorldMapButton:Hide()
MinimapNorthTag:SetAlpha(0)
MinimapBorderTop:Hide()
MiniMapVoiceChatFrame:Hide()
MinimapZoneTextButton:Hide()
MiniMapTracking:Hide()
GameTimeFrame:Hide()
TimeManagerClockButton:Hide()


-- -----------------------------------------------------------------------------
-- Moves the LFG/LFR/BG Queue icon
-- -----------------------------------------------------------------------------
QueueStatusMinimapButton:ClearAllPoints()
QueueStatusMinimapButton:SetParent(Minimap)
QueueStatusMinimapButton:SetPoint('BOTTOMRIGHT', -2, 2)


-- -----------------------------------------------------------------------------
-- move the dungen difficulty indicator
-- -----------------------------------------------------------------------------
MiniMapInstanceDifficulty:ClearAllPoints()
MiniMapInstanceDifficulty:SetParent(Minimap)
MiniMapInstanceDifficulty:SetPoint('CENTER', -50, 45)

GuildInstanceDifficulty:ClearAllPoints()
GuildInstanceDifficulty:SetParent(Minimap)
GuildInstanceDifficulty:SetPoint('CENTER', -50, 45)
	
	
-- -----------------------------------------------------------------------------
-- Hides the Mail Button and puts it in a textframe at the top
-- -----------------------------------------------------------------------------
MiniMapMailFrame:ClearAllPoints()
MiniMapMailFrame:SetParent(Minimap)
MiniMapMailFrame:SetPoint('TOP', 0, 0)
MiniMapMailFrame:SetHeight(8)
MiniMapMailBorder:SetTexture(nil)

MiniMapMailText = MiniMapMailFrame:CreateFontString(nil, 'OVERLAY')
MiniMapMailText:SetPoint('BOTTOM', 0, -10)
MiniMapMailText:SetFont("Interface\\AddOns\\eMinimap\\font.ttf", 16, "OUTLINE")
MiniMapMailText:SetTextColor(1, 1, 1)
MiniMapMailText:SetText('New Mail!')

MiniMapMailIcon:Hide()


-- -----------------------------------------------------------------------------
-- Makes the minimap square
-- -----------------------------------------------------------------------------
MinimapBorder:Hide()
Minimap:SetMaskTexture([=[Interface\ChatFrame\ChatFrameBackground]=])


-- -----------------------------------------------------------------------------
-- Determins the position and size of the minimap
-- -----------------------------------------------------------------------------
Minimap:ClearAllPoints()
Minimap:SetScale(MinimapScale)
Minimap:SetAlpha(MinimapAlpha)
Minimap:SetFrameStrata(MinimapStrata)
if ebfMinimap then
	Minimap:SetPoint("CENTER", ebfMinimap, "CENTER")
else
	Minimap:SetPoint("TOPLEFT", UIParent, "TOPLEFT", MinimapPosX , MinimapPosY)
end

-- -----------------------------------------------------------------------------
-- Enables mousewheel zoom for the minimap
-- -----------------------------------------------------------------------------
Minimap:EnableMouseWheel(true)
Minimap:SetScript("OnMouseWheel", function(_, zoom)
	if zoom > 0 then
		Minimap_ZoomIn()
	else
		Minimap_ZoomOut()
	end
end)


-- -----------------------------------------------------------------------------
-- Pings on left button, shows the calendar on right button, 
-- and toggles between tracking skills on middle button.
-- -----------------------------------------------------------------------------
Minimap:SetScript("OnMouseUp", function(self, btn)
	if btn == ("RightButton") then
		ToggleDropDownMenu(1, nil, MiniMapTrackingDropDown, self)
	elseif btn == ("MiddleButton") then
		GameTimeFrame:Click()
	elseif btn == "LeftButton" then
		Minimap_OnClick(self)
	end
end)

-- -----------------------------------------------------------------------------
-- Tells other addons that the minimap is square
-- -----------------------------------------------------------------------------
function GetMinimapShape() return "SQUARE" end
