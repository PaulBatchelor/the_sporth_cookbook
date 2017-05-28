##: # blsaw
##:
##: Arguments: freq, amp
##:
##: **blsaw** is a band-limited sawtooth wave generator. For paramters, 
##: it takes in a frequency, and an amplitude.
##:
##: The argument below creates a simple 440hz sawtooth sound, put through
##: a butterworth lowpass filter.
##---
440 0.3 blsaw 1000 butlp
##---
