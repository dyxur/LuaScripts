local args = {...}

startTime = os.time()

local numberOfTries = args[1]

local occurences = {
	[1] = 0,
	[2] = 0,
	[3] = 0,
	[4] = 0,
	[5] = 0,
	[6] = 0
}

math.randomseed(os.time()) 

for i=1, numberOfTries do
	ranNum = math.random(1, 6)
	
	occurences[ranNum] = occurences[ranNum] + 1
end

onePercent = 100 / numberOfTries

print('1: '..occurences[1]..'	'..occurences[1]*onePercent..'%')
print('2: '..occurences[2]..'	'..occurences[2]*onePercent..'%')
print('3: '..occurences[3]..'	'..occurences[3]*onePercent..'%')
print('4: '..occurences[4]..'	'..occurences[4]*onePercent..'%')
print('5: '..occurences[5]..'	'..occurences[5]*onePercent..'%')
print('6: '..occurences[6]..'	'..occurences[6]*onePercent..'%')

endTime = os.time()

print('\nThe execution took '..endTime - startTime..' seconds')
