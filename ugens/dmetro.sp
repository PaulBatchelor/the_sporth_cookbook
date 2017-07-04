##: # dmetro
##:
##: **dmetro** creates a trigger signal in terms of duration. 
##:
##: The following patch uses dmetro to trigger an envelope generator
##---
# create trigger every 100 ms
0.1 dmetro
# feed it into envelope generator
0.001 0.01 0.01 tenvx
# multiply with sine wave
1000 0.5 sine *
##---
