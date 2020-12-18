# Kill the previous helper entity (Not using UUID's since appparently they are causing problems in this scenario).
kill @e[tag=local.wasd_helper]

# Three basic scoreboards for input values, variables inbetween and output values.
scoreboard objectives add local.wasd_var dummy
scoreboard objectives add local.wasd_inp dummy
scoreboard objectives add local.wasd_out dummy

# The fake player for sine and cosine.
scoreboard players set sine local.wasd_var 0
scoreboard players set cosine local.wasd_var 0

## Fake players for positioning.
# Player position.
scoreboard players set player_x local.wasd_inp 0
scoreboard players set player_y local.wasd_inp 0

# Previous player position.
scoreboard players set p_player_x local.wasd_inp 0
scoreboard players set p_player_y local.wasd_inp 0

# Terms of the inverse function.
scoreboard players set x_term_1 local.wasd_var 0
scoreboard players set y_term_2 local.wasd_var 0
scoreboard players set x_term_1 local.wasd_var 0
scoreboard players set y_term_2 local.wasd_var 0

# The transformed difference point.
scoreboard players set x local.wasd_out 0
scoreboard players set y local.wasd_out 0

# Difference between the actual player point and the previous player point.
scoreboard players set difference_x local.wasd_var 0
scoreboard players set difference_y local.wasd_var 0

# Rotation of the player in pitch (horizontal).
scoreboard players set p_rotation local.wasd_inp 0

# Set the threshold to some value, the system will ignore anything which isn't above the threshold. We do this so we can use less precision in storing variables and still get an accurate result.
scoreboard players set threshold_bottom local.wasd_var 100000
scoreboard players set threshold_top local.wasd_var -100000

# Initialize a storage for the sine and cosine.
data merge storage local.wasd:math {Null:0b}

# Force load the 0 0 chunk.
forceload add 0 0 0 0

# Summon a custom helper entity (original from Phi.core) that is specific to our needs.
summon area_effect_cloud 0 0 0 {Duration:-1,Age:-2147483648,WaitTime:-2147483648,Tags:["local.wasd_helper"],UUID:[I;0,0,0,1]}