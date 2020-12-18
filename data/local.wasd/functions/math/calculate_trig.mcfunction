## Calculate sine and cosine - Phi.mathfunc
# Set the entities angle to the angle we from storage.
data modify entity @s Rotation[0] set from storage local.wasd:math angle

# Move the entity up to create a point that utilize both sine and cosine.
execute rotated as @s rotated ~ 0 run tp @s ^ ^ ^1 ~ ~

# Get the Z coordinate.
data modify storage local.wasd:math cosine set from entity @s Pos[2]

# Sine is negated. So move back.
execute rotated as @s run tp @s ^ ^ ^-1

# Get the X coordinate.
data modify storage local.wasd:math sine set from entity @s Pos[0]