local args = {...}
local repeats = args[1]
local startTime = os.time()
local allTries = 0
local lowest = nil

math.randomseed(startTime)

for i=1, repeats do
	tries = 0
	sequence = ''

	repeat
		sequence = ''
		tries = tries + 1
	
		for i=1, 6 do
			sequence = sequence..math.random(1, 6)
		end
	until sequence == '123456'
	
	if lowest == nil or tries < lowest then 
		lowest = tries 
		print('Took '..lowest..' tries on repeat '..i)
	end
	
	if i%100 == 0 then print('try: '..i) end
	
	--print('It took '..tries..' tries to get the sequence '..sequence..' from random numbers')
	
	allTries = allTries + tries
end

endTime = os.time()

print('MEAN tries: '..allTries/repeats)
print('lowest tries: '..lowest)
print('The execution took '..endTime - startTime..' seconds')
