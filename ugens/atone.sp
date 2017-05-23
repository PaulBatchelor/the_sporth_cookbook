##: # Atone
##: Arguments: input, cutoff
##: 
##: Where
##: - input: input signal
##: - cutoff: cutoff frequency
##: 
##: Atone is a simple one pole high-pass filter, directly related to tone.
##---
0.1 noise dup 2000 atone bal
##---
