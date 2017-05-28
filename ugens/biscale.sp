##: # Biscale
##: 
##: Arguments: input, min, max
##:
##: Biscale will take an input signal in the range -1, 1, and map it to 
##: an arbitrary minimum and maximum. If the input signal exceeds these ranges,
##: the scaled output will be linearly mapped beyond the min/max bounds.
##:
##: The example below takes a unit amplitude low-frequency sinusoid and maps
##: it to the range (200, 500). This signal acts as a control signal for 
##: the frequency of another audio-rate sine object.
##---
0.1 1 sine 200 500 biscale 0.3 sine
##---
