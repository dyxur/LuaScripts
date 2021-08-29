local args = {...}

local timePerFight = args[1]
local costPerFight = args[2]
local maxSpiritPoints = args[3]
local eventPointsEarned = args[4]

if timePerFight and costPerFight and maxSpiritPoints and eventPointsEarned then
	local time = 0
	local totalPoints = 0

	for i = 0, maxSpiritPoints, costPerFight do
		time = time + timePerFight
		totalPoints = totalPoints + eventPointsEarned
		
		if i%(maxSpiritPoints*0.05) == 1 then
			print(math.floor((i/maxSpiritPoints)*100).."%")
			--os.execute("clear")
		end 
	end

	print("Time: "..math.floor(time/60)..' Minutes')
	print("Points: "..totalPoints)
	
	os.execute("neofetch")
else
	print("One of the following arguments is not correct or missing:")
	print("timePerFight: "..(timePerFight or "null"))
	print("costPerFight: "..(costPerFight or "null"))
	print("maxSpiritPoints: "..(maxSpiritPoints or "null"))
	print("eventPointsEarned: "..(eventPointsEarned or "null"))
end
