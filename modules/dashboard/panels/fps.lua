local E, L, V, P, G = unpack(ElvUI);
local BUID = E:GetModule('BuiDashboard')

local _G = _G
local join, floor = string.join, floor
local GetFramerate = GetFramerate

local LastUpdate = 1

local statusColors = {
	'|cff0CD809',	-- green
	'|cffE8DA0F',	-- yellow
	'|cffFF9000',	-- orange
	'|cffD80909'	-- red
}

function BUID:CreateFps()
	local boardName = _G['FPS']
	boardName.Status:SetScript('OnUpdate', function(self, elapsed)
		LastUpdate = LastUpdate - elapsed

		if(LastUpdate < 0) then
			self:SetMinMaxValues(0, 200)
			local value = floor(GetFramerate())
			local max = 120
			local fpscolor = 4
			self:SetValue(value)

			if(value * 100 / max >= 45) then
				fpscolor = 1
			elseif value * 100 / max < 45 and value * 100 / max > 30 then
				fpscolor = 2
			else
				fpscolor = 3
			end

			local displayFormat = join('', 'FPS: ', statusColors[fpscolor], '%d|r')
			boardName.Text:SetFormattedText(displayFormat, value)
			LastUpdate = 1
		end
	end)
end