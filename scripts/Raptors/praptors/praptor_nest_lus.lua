local body, t1, t2, t3, t4, t5, nest = piece("MainBody","NestStrut","NestStrut1","NestStrut2","NestStrut3","NestStrut4","Nest")

local nestID = UnitDefNames["praptor_hive"].id

local function isUpgradee()
	local x, _, z = Spring.GetUnitPosition(unitID)
	local units = Spring.GetUnitsInCylinder(x, z, 10)
	for _, uID in pairs(units) do
		if Spring.GetUnitDefID(uID) == nestID then
			return true
		end
	end
	return false
end

function script.Create()
	local isUpgradeee = isUpgradee()
	-- custom build animation if an upgrade
	if isUpgradeee then
		-- move the body for upgrade animation
		Move(t1, 2, -90, nil)
		Move(t2, 2, -90, nil)
		Move(t3, 2, -90, nil)
		Move(t4, 2, -90, nil)
		Move(t5, 2, -90, nil)
		Turn(nest, 1, -1.5708, nil)
		Turn(nest, 2, -0.113446, nil)
		-- temp hide @TODO - switch hide for slow animation where:
		--		target rotationOrPosition = build progress * finalRotationOrPosition
		--		and speed is *pending mathing; speed = (current build progress - previous build progress) * 1/5 (sleep is 5000, make it 5seconds)
		Hide(body)
		Hide(t1)
		Hide(t2)
		Hide(t3)
		Hide(t4)
		Hide(t5)
		Hide(nest)
		-- wait till build progress is clsoe to finished
		local b = 0
		while b < 0.9 do
			Sleep(5000)
			_, b = Spring.GetUnitIsBeingBuilt(unitID)
		end
		Show(t1)
		Show(t2)
		Show(t3)
		Show(t4)
		Show(t5)
		Show(nest)

		-- rotate pieces
		-- distance 90, angle 90 / 1.5708 rad, duration 8, precaculated, t1-t5 spin needs a fully 360
		Move(t1, 2, 0, 11.25)
		Move(t2, 2, 0, 11.25)
		Move(t3, 2, 0, 11.25)
		Move(t4, 2, 0, 11.25)
		Move(t5, 2, 0, 11.25)
		Turn(nest, 1, 0, 0.19635)
		Turn(nest, 2, 0, 0.01418075)

		Spin(t1, 2, 0.78539816339744830961566084581988)
		Spin(t2, 2, 0.78539816339744830961566084581988)
		Spin(t3, 2, 0.78539816339744830961566084581988)
		Spin(t4, 2, 0.78539816339744830961566084581988)
		Spin(t5, 2, 0.78539816339744830961566084581988)
		Sleep(6000) -- i really don't know, swap this out later so that it can be properly timed?
		Turn(t1, 2, 0, 0.78539816339744830961566084581988)
		Turn(t2, 2, 0, 0.78539816339744830961566084581988)
		Turn(t3, 2, 0, 0.78539816339744830961566084581988)
		Turn(t4, 2, 0, 0.78539816339744830961566084581988)
		Turn(t5, 2, 0, 0.78539816339744830961566084581988)
		Show(body)
	end
end