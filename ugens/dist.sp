##: # dist
##: 
##: Performs distortion using a hyperbolic tangent function. 
##: **dist** has the following arguments:
##: - input: input signal to be distorted
##: - pregrain: gain applied before waveshaping
##: - postgain: gain applied after waveshaping
##: - shape1: shape of the positive part of the signal a value of 0 is a flat
##: clip
##: - shape2: shape of the negative part of the signal. a value of 0 is a flat
##: clip
##:
##: The following patch demonstrates how **dist** can be used with **diode**
##: to create a squelchy bass sound.
##---
# generate a saw wave
100 1 saw
# LFO scaled for cutoff frequency sweep
0.1 1 sine 300 3000 biscale
# diode with high resonance
0.9 diode
# distortion with dist
5 0.5 0.01 0.9 dist
##---
