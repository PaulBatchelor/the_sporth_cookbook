##: # crossfade
##: 
##: Crossfade applies a linear crossfrade between two signals with a certain
##: percentage *alpha*. When *alpha* is 0, it 100% the top signal. When *alpha*
##: is 1, the signal is 100% the second signal.
##: 
##: Crossfade also has the alias "cf"
##:

##---
# Signal 1
440 0.3 sine
# Signal 2
880 0.3 sine
# LFO modulating crossfade. 0 = signal 1, 1 = signal 2
0.2 1 sine 0 1 biscale
crossfade
##---
