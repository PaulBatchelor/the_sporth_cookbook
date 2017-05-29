##: # blsquare
##:
##: Arguments: Frequency, Amplitude, Pulse Width
##:
##: The ugen **blsquare** is a band-limited square wave generator. In addition
##: to having frequency and amplitude control, there is also a modulatable
##: pulse width parameter. This parameter should be in range 0-1, not including
##: 0 or 1 exactly. 

##: The example below shows blsquare with a modulated pulse width.
##---
200 0.3 
# LFO modulating pulse width
0.1 1 sine 0.01 0.99 biscale
blsquare
##---
