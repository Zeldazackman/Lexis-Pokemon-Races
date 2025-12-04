local animationRate = 1
function update(dt)
	local phase = world.warpPhase()
	local flying = world.flyingType()
	if flying == "none" then
		if animationRate > 1 then
			animationRate = math.max(1, animationRate - 1 *dt)
		end
	elseif phase == "speedingup" then
		animationRate = math.min(3, animationRate + 1 *dt)
	elseif phase == "slowingdown" then
		animationRate = math.max(1, animationRate - 1 *dt)
	end

	animator.setAnimationRate(animationRate)
end
