##: # diode
##: 
##: **diode** is a diode ladder lowpass filter, adapted from code by Will 
##: Pirkle. The filter design is very similar to the one used by the iconic 
##: TB303 bassline generator.
##:
##: It has the following argument structure:
##: - input: the signal to be filtered
##: - freq: the cutoff frequency (in Hz)
##: - resonance: the resonance amount of the filter (0-1)
##:
##: The following example shows **diode** being used to create a subtractive
##: bass sound. 
##---
# Note Sequence
_seq "0 2 3 7" gen_vals
# Create clock, duplicate, and feed into sequencer
8 metro dup 0 _seq tseq
# bias squence to be pitched at 2 octaves below middle C
36 + 
# portamento filter to add glissando, then convert to frequency
0.01 port mtof
# feed frequency into bandlimited sawtooth generator
0.8 saw 
# feed clock into envelope, and multiply with sawtooth signal
swap 0.001 0.01 0.2 tenvx * 
# use LFO to control cutoff frequency of diode
0.1 1 sine 1000 8000 biscale
# the rest of diode, with resonance cranked up
0.9 diode
##---
