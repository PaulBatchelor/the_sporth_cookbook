##: # Allpass
##:
##: This is an allpass filter implementation taken from the Csound opcode
##: [alpass](http://csound.github.io/docs/manual/alpass.html) (note: 
##: spelling intentionally incorrect here.). In general, allpass filters are
##: unique in that they have unit-magnitude frequency response for the whole
##: spectrum. This particular allpass filter design is used in reverberation
##: design to provide colorless density. For this reason, units for this ugen 
##: are in seconds rather than in hertz.
##:
##: The arguments for allpass are as follows:
##: - revtime: is the reverberation time for the signal to decay 60dB (more 
##: commonly referred to as T60).
##: - looptime: is the delay line length (this provides the length of the 
##: "echo").
##: 
##: ## Example
##: The example below shows a typical usecase for an allpass filter. Allpass 
##: filters are often used in series. In the example below, three sucessive
##: instances of allpass are created. For an input signal, an impulse is being
##: generated with a broadband noise signal with an exponential envelope.
##: The resulting sound you hear is the "impulse response", which gives you
##: the characteristics of the reverb.  
##---
1 metro 0.001 0.001 0.001 tenvx 0.5 noise * 
5 0.010 allpass 
5 0.013 allpass 
5 0.008 allpass
##---
