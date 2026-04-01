# Mario-Bros-Autosplitter

This is a lua script that communicates with LiveSplit, and automatically starts/splits on phase change

## This file was only tested in BizHawk. It may or may not work with other emulators.

# How to use?

1. Open Emulator, and load the ROM
2. Open LiveSplit
3. Prepare the splits
4. Customize the script (more on that later)
5. Open the lua editor in your emulator and load the script
6. Speedrun!

# How to customize?

1. Open the script in your favourite text editor
2. Modify values in settings:
   
   a) split_on_stage_increase is true or false
   
   b) split_on_score_increase is true or false
    
   c) target_score is only used if split_on_score_increase is true
   
   d) target_score_multiplier multiplies target_score every split. Only used if split_on_score_increase is true
   
   e) auto_start is either true or false
