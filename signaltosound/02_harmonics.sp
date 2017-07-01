##: # The Harmonic Series
##: 
##: The patch from previous has a new modification. The LFO signal is snapped
##: to whole integer values before being multiplied by the scalar value of 220.
##: When played, this produces what is known as the *overtone series* 
##: or *harmonic series*. 
##:
##: The harmonic series is a fundamental part of acoustics and sound. They can
##: be heard all over nature. Sounds that are periodic (have a pitch) that
##: are not simple sine waves will have a combination of overtones with various
##: amplitude strengths (and phase as well). This provides a fingerprint for
##: *timbre*, an ambiguous term to describe any sonic characteristics not 
##: pertaining to frequency or amplitude. 
##:
##---
0.1 1 sine 
1 8 biscale round 220 * 
"harmonic frequency" print
0.3 sine
##---
