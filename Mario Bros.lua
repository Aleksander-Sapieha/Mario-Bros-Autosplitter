local settings = {
    split_on_stage_increase = false, -- Set to true to split on stage increase,
    -- split_on_score_increase = true, -- Set to true to split on score increase,
    -- target_score = 1000, -- Set the target score for splitting, only used if split_on_score_increase is true
    -- target_score_multiplier = 2, -- Multiplier for the target score after each split, only used if split_on_score_increase is true
    auto_start = true -- Set to true to automatically start the timer when the game starts
}

local pipe = io.open("\\\\.\\pipe\\LiveSplit", "w")

local lastStage = memory.readbyte(0x0550)
local started = false

while true do
    local stage = memory.readbyte(0x0550)

    if stage ~= lastStage then
        print("Stage:", lastStage, "->", stage)

        if pipe then
            if not started and lastStage == 0 and stage == 1 or lastStage == 34 and stage == 1 and settings.auto_start then
                pipe:write("starttimer\n")
                pipe:flush()
                started = true
                print("START")

            elseif started and settings.split_on_stage_increase then
                pipe:write("split\n")
                pipe:flush()
                print("SPLIT")
            end
        else
            print("PIPE NOT OPEN")
        end
        lastStage = stage
    end
    
    -- if settings.split_on_score_increase then
    --     if pipe then
    --         if started then
    --             local score = ((memory.readbyte(0x0095) - 0x030) * 100 + (memory.readbyte(0x0096) - 0x030) * 10 + (memory.readbyte(0x0097) - 0x030)) / 1.6
    --             print("Score:", score, "Target Score:", settings.target_score)
    --             -- print("Address 0x0095:", memory.readbyte(0x0095), "Address 0x0096:", memory.readbyte(0x0096), "Address 0x0097:", memory.readbyte(0x0097))
    --             if score > settings.target_score then
    --                 pipe:write("split\n")
    --                 pipe:flush()
    --                 print("SPLIT")
    --                 score_multiplied = settings.target_score * settings.target_score_multiplier
    --                 print("New target score:", score_multiplied)
    --                 -- Reset the target score for the next split
    --                 settings.target_score = score_multiplied
    --             end
    --         end
    --     else
    --         print("PIPE NOT OPEN")
    --     end
    -- end

    emu.frameadvance()
end