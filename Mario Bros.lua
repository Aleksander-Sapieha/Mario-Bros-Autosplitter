local pipe = io.open("\\\\.\\pipe\\LiveSplit", "w")

local lastStage = memory.readbyte(0x0550)
local started = false

while true do
    local stage = memory.readbyte(0x0550)

    if stage ~= lastStage then
        print("Stage:", lastStage, "->", stage)

        if pipe then
            if not started and lastStage == 0 and stage == 1 or lastStage == 34 and stage == 1 then
                pipe:write("starttimer\n")
                pipe:flush()
                started = true
                print("START")

            elseif started then
                pipe:write("split\n")
                pipe:flush()
                print("SPLIT")
            end
        else
            print("PIPE NOT OPEN")
        end

        lastStage = stage
    end

    emu.frameadvance()
end