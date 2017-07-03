##: # osc
##:
##: **osc** is a table-lookup oscillator with linear interpolation.
##:
##: It takes in the following arguments:
##: - frequency
##: - amplitude
##: - initial phase (0-1)
##: - table name 
##:
##: The following patch creates a 440Hz sine wave using **osc**. It is
##: analogous to the unit generator **sine**.
##---
_sine 8192 gen_sine
440 0.5 0 _sine osc
##---
