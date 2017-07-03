##: # oscmorph
##:
##: The oscmorph unit generators provide a table-lookup oscillator with 
##: the ability to crossfade between wavetables. **oscmorph2** morphs between
##: two waveshapes. **oscmorph4** morphs between 4 waveshapes.
##:
##: Both **oscmorph4** and **oscmorph2** have the following argument structure:
##: - frequency
##: - amplitude
##: - wavetable crossfade position (scaled 0-1). wavetable selection happens
##: left-to-right, with 0 being the leftmost waveshape, and 1 being the 
##: rightmost.
##: - initial phase (0)
##: - wavetables to crossfade between. in **oscmorph2**, the number is 2. in
##: **oscmorph4**, the number is 4.
##: 
##---
# some wave shapes
_sine 4096 gen_sine
_sinesum1 4096 "0 0 1 11" gen_sinesum
_saw 4096 "0 1 4096 -1" gen_line
_sinesum2 4096 "1 1 0 1" gen_sinesum

# 440 hz 0.3 amp
440 0.3 
# LFO oscillator modulating wave position
1 1 sine 0 1 biscale
# initial phase
0 
# 4 wave shapes
_sine _saw _sinesum1 _sinesum2 
oscmorph4
##---
