# Execute at 0.0, 0.0, 0.0 so we won't need subtraction (From Phi.mathfunc).
execute as 0-0-0-0-1 positioned 0.0 0.0 0.0 run function local.wasd:math/calculate_trig

# Store back sine and cosine and scale them by 1000.
execute store result score sine local.wasd_var run data get storage local.wasd:math sine 1000
execute store result score cosine local.wasd_var run data get storage local.wasd:math cosine 1000