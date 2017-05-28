##: # Bitcrush
##: 
##: Arguments: Bitdepth, samplerate
##:
##: Bitcrush is a a bitcrusher that adds artificial samplerate and bitdepth 
##: reduction. The *bitdepth* parameter is in bits, and the samplerate 
##: parameter is in Hertz. 
##:
##: The example below feeds an enveloped FM oscillator into bitcrush. To 
##: hear the effects, both paramters are modulated using low-frequency 
##: oscillators
##---

3 metro 0.001 0.01 0.2 tenv 300 0.4 1 1 1 fm *

5 inv 1 sine 1 16 biscale
8 inv 1 sine 100 10000 biscale
bitcrush

##---
