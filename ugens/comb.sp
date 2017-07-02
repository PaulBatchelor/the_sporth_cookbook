##: # comb
##:
##: This effect is a delay line comb-filter, which is often used in the 
##: creation of artificial reverberators. It has the following arguments:
##: - reverberation time: the T-60 decay time.
##: - loop time: the size of the comb filter delay line, in seconds

##---
# use metro to produce an impulse signal
1 metro
# the output of comb is the impulse response
1.5 0.01 comb
##---
