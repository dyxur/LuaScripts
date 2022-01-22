-- Execute and return the output from a console command
function os.capture(cmd)
    local f = assert(io.popen(cmd, 'r'))
    local s = assert(f:read('*a'))
    f:close()

    return s
end

-- Transform ping output to a usable table
function getRelevantPingData(ping)
    local pingData = {}
    pingData.name = ping:match("%-%s(.+)%sping")
    pingData.transmitted = ping:match("(%d+)%spackets%stransmitted")
    pingData.received = ping:match("(%d+)%sreceived")
    pingData.loss = ping:match("(%d+%%)%spacket%sloss")
    pingData.times = {}

    -- Create table with the time names as to not mess up
    local timeNames = {}
    for match in ((ping:match("rtt%s(.+)%s%="))..'/'):gmatch("(.-)/") do
        table.insert(timeNames, match)
    end

    -- Same as above but with the time values
    local timeVals = {}
    for match in ((ping:match("%=%s(.+)%sms"))..'/'):gmatch("(.-)/") do
        table.insert(timeVals, match)
    end

    -- Add the values of the tables from above to the pingData
    for i=1, 4 do
        if timeNames[i] == 'min' then
            pingData.times.min = {name=timeNames[i], value=timeVals[i]}
        elseif timeNames[i] == 'avg' then
            pingData.times.avg = {name=timeNames[i], value=timeVals[i]}
        elseif timeNames[i] == 'max' then
            pingData.times.max = {name=timeNames[i], value=timeVals[i]}
        end
    end

    return pingData
end

-- Convert data to a single string that can be read as a table through `load()`
function getTableFromData(data)
    local out = "{"
    out = out.."name='"..data.name.."',"
    out = out.."transmitted="..data.transmitted..","
    out = out.."received="..data.received..","
    out = out.."loss='"..data.loss.."',"
    local min = data.times.min
    out = out.."min={name='"..min.name.."',value="..min.value.."},"
    local avg = data.times.avg
    out = out.."avg={name='"..avg.name.."',value="..avg.value.."},"
    local max = data.times.max
    out = out.."max={name='"..max.name.."',value="..max.value.."}"
    out = out.."}"

    return out
end

-- Append a string to the log
function writeToLog(string)
    local f = io.open('ping.log', 'a')
    f:write(string)
    f:close()
end

local dateTimeNow = os.date("%Y-%m-%d/%H-%M")
local pingRawWingo = os.capture('ping -c 5 www.wingo.ch')
local pingRaw1111 = os.capture('ping -c 5 1.1.1.1')

local wingo = getRelevantPingData(pingRawWingo)
local onex4 = getRelevantPingData(pingRaw1111)

writeToLog('{wingo='..getTableFromData(wingo)..', onex4='..getTableFromData(onex4)..'}')

--[[
    -- An easy way to read the generated data from another lua script:
    data = {}
    for line in io.lines('<path to file>') do
        table.insert(data, load("return "..line)())
    end
]]--
