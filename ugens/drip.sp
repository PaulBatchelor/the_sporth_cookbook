##: # drip
##:
##: Physical model of a dripping water sound.
##: This has the following arguments:
##: - trigger signal to trigger droplet
##: - number of units tubes
##: - amplitude
##: - damp
##: - shake_max: amount of energy to add back into the system
##: - main resonant frequency
##: - first resonant frequency
##: - second resonant frequency
##: - period of time over which all sound is stopped
##:
##: For sensible values, it is best to refer to the example below.
##:
##---
0.5 dmetro  0.5 maytrig
# number of units/tubes
10 
# amplitude
0.3 
# damp 
0.2 
# shake_max: amount of energy to add back into the system
0 
# main resonant frequency
458 
# first resonant frequency 
600 
# second resonant frequency
750 
# period of time over which all sound is stopped
0.09 
drip

# feed into some reverb
dup dup 3 8 10000 zrev drop 0.1 * + 
##---
