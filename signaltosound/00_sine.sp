##: # The Sine
##: The first signal to be examined will be the sine wave. It many ways, it can
##: be regarded as the atomic element in sound design. The sine wave will 
##: provide the foundations needed for building up sonic intuition.
##: 
##: When plotted, the sine wave has a very distinct shape:
##: 
##: INSERT IMAGE OF SINE WAVE HERE
##: 
##: When played as audio, the sine wave has a "pure" sound. In some
##: areas of music cognition and psychoacoustics, sine waves are actually 
##: known as "pure tones". 
##:
##: The patch below has two sine waves working together. One of these sine 
##: waves creates the sound as an *audio signal*. The other is a sine wave is
##: a *control signal*,
##: whose frequency is sub audio (0.1 Hertz), and is scaled to modulate the 
##: frequency of the other sine wave. This type of control signal is referred
##: to as a low-frequency oscillator, or LFO.
##:
##: What separates a control signal from an audio signal? Well, not a whole lot
##: really. In Sporth, there is no formal distinction. Anything that reaches
##: a speaker can be considered an audio signal. In many cases, it is helpful
##: to think of everything as simply a signal. All signals have potential
##: to be a sound. All sounds have potential to be a signal. 
##:
##: Listen to the patch below. Take careful note of the sonic characteristics
##: of the sine wave and the way the frequency is being modulated by the LFO. 
##: In future sections, both signals will come back again in different ways. 
##: Be ready...

##---
0.1 1 sine 
220 1760 biscale
0.3 sine
##---
