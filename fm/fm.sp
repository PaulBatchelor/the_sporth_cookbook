##: # FM Synthesis
##: We are going to make an FM pair from scratch. 
##: First we start with a modulator signal, which controls (modulates) the
##: frequency of the carrier oscillator.

##---
440 440 sine
##---

##: This creates a sine wave that goes between -440 and 440. Next we bias it
##: by 440 Hz so it centers 440 Hz, going down to 0 Hz and going up to 880 Hz:

##---
440 +
##---

##: Finally, we send this signal to modulate the frequency carrier signal: 

##---
0.5 sine
##---

##: What we end up with is a basic FM pair at 440 Hz, 1 1:1 Carrier-Modulator
##: ratio, with a modulation index of 1, and an ampitude of 0.5.
