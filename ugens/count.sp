##: # count
##:
##: A trigger-based counter. 
##:
##: It takes in the following arguments:
##: - trig: a trigger signal
##: - max: maximum value to count up to. since it is zero-index, the value 
##: reached is max - 1. 
##: - mode: this sets the counting mode. A value of 0 will loop, a value of 1
##: will reach the top value, then spit out "-2". 
##:
##: Count will always start at 0, and count upwards towards. It is assumed that
##: a trigger signal will occur at the very beginning of the patch. If it does
##: not occur, *count* will produce a value of -1 until triggered. 
##:
##: The patch below uses count to modulate the frequency of a sine wave to
##: produce the overtone series.
##---
# Metro trigger signal
4 metro 
# count 0-7
8 1 count 
# add one to make range 1-8
1 + 
# multiply signal by 100 to produce harmonic series
100 *
# the rest of the sine
0.3 sine
##---
