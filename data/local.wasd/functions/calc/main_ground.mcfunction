# Remove the current players W, A, S and D tags.
tag @s remove local.wasd_w
tag @s remove local.wasd_a
tag @s remove local.wasd_s
tag @s remove local.wasd_d

# Get the players X and Z positions of the player, here referred to as X and Y for simplification.
execute store result score player_x local.wasd_inp run data get entity @s Pos[0] 1000
execute store result score player_y local.wasd_inp run data get entity @s Pos[2] 1000

# Simple point difference calculation to get a basic W, A, S and D detector that works for the rotation of 0.0.
scoreboard players operation difference_x local.wasd_var = player_x local.wasd_inp
scoreboard players operation difference_x local.wasd_var -= p_player_x local.wasd_inp
scoreboard players operation difference_y local.wasd_var = player_y local.wasd_inp
scoreboard players operation difference_y local.wasd_var -= p_player_y local.wasd_inp

# Get the players rotation. Then scale it by -1 to find difference from the polar axis.
execute store result score p_rotation local.wasd_inp run data get entity @s Rotation[0] -1

# Set the "phi.mathfunc:temp" angle value to the rotation.
execute store result storage local.wasd:math angle float 1 run scoreboard players get p_rotation local.wasd_inp

# Calculate sine and cosine using the Phi library.
function local.wasd:math/trig

## Take the difference point and apply the inverse transformation to it. The terms are essentially different parts of inverse, the cosine and sine. While the X and Y are the new transformed coordinates.
# The X term of the inverse transformation.
scoreboard players operation x_term_1 local.wasd_var = difference_x local.wasd_var
scoreboard players operation x_term_1 local.wasd_var *= cosine local.wasd_var
scoreboard players operation x_term_2 local.wasd_var = difference_y local.wasd_var
scoreboard players operation x_term_2 local.wasd_var *= sine local.wasd_var
scoreboard players operation x local.wasd_out = x_term_2 local.wasd_var
scoreboard players operation x local.wasd_out -= x_term_1 local.wasd_var

# The Y term of the inverse transformation.
scoreboard players operation y_term_1 local.wasd_var = difference_x local.wasd_var
scoreboard players operation y_term_1 local.wasd_var *= sine local.wasd_var
scoreboard players operation y_term_2 local.wasd_var = difference_y local.wasd_var
scoreboard players operation y_term_2 local.wasd_var *= cosine local.wasd_var
scoreboard players operation y local.wasd_out = y_term_2 local.wasd_var
scoreboard players operation y local.wasd_out += y_term_1 local.wasd_var

# Finally, compare the inverse points to the thresholds.
execute if score y local.wasd_out >= threshold_bottom local.wasd_var run tag @s add local.wasd_w
execute if score x local.wasd_out <= threshold_top local.wasd_var run tag @s add local.wasd_a
execute if score y local.wasd_out <= threshold_top local.wasd_var run tag @s add local.wasd_s
execute if score x local.wasd_out >= threshold_bottom local.wasd_var run tag @s add local.wasd_d

execute if score y local.wasd_out >= threshold_bottom local.wasd_var run say w
execute if score x local.wasd_out <= threshold_top local.wasd_var run say a
execute if score y local.wasd_out <= threshold_top local.wasd_var run say s
execute if score x local.wasd_out >= threshold_bottom local.wasd_var run say d

# Set the previous player position to the current player position.
execute store result score p_player_x local.wasd_inp run data get entity @s Pos[0] 1000
execute store result score p_player_y local.wasd_inp run data get entity @s Pos[2] 1000