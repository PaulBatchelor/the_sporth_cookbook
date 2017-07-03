##: # tabread
##:
##: Table lookup with linear interpolation
##: 
##: **tabread** has the following arguments:
##: - index: index position
##: - scaled: 0 or 1 indicating whether or not to scale the signal. A value
##: of 1 expects the index to be in the range 0-1. A value of 0 will make the
##: expected input signal to be the actual index number
##: - wrap: using wrapping. Can be used to make hard-sync oscillators
##: - offset: initial phase offset
##: - ftname: name of the table
##:
##: The following patch below shows how **tabread** can be used to make a
##: table lookup oscillator.
##:
##---
# Generate sine wave lookup-table
_sine 8192 gen_sine
# create 440hz phasor signal (sawtooth moving between 0 and 1)
440 0 phasor
# feed phasor into tabread 
1 0 0 _sine tabread 
# scale signal
0.3 *
##--
