local args = {...}

fileA = args[1]
fileB = args[2]

function file_exists(file)
    local f = io.open(file, "rb")

    if f then f:close() end

    return f ~= nil
end

function lines_from(file)
    if not file_exists(file) then return {} end

    lines = {}

    for line in io.lines(file) do
        lines[#lines + 1] = line
    end

    return lines
end

local linesA = lines_from(fileA)
local linesB = lines_from(fileB)

local onlyA = "ONLY FOUND IN A:"
local onlyB = "ONLY FOUND IN B:"
local both = "FOUND IN BOTH A AND B:"

for kA,vA in pairs(linesA) do
    local foundInBoth = false

    for kB,vB in pairs(linesB) do
        if (vA == vB) then
            both = both.."\n"..vB

            table.remove(linesB, kB)

            foundInBoth = true
        end
    end

    if not foundInBoth then
        onlyA = onlyA.."\n"..vA
    end
end

for k,v in pairs(linesB) do
    onlyB = onlyB.."\n"..v
end

resultFile = io.open('compared.txt', "w")
resultFile:write(onlyA.."\n"..onlyB.."\n"..both)
resultFile:close()
