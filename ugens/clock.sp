##: # clock
##:
##: Arguments:
##: - trigger: resets the clock
##: - tempo: clock tempo in beats per minute (BPM)
##: - subdivision: Clock subdivision amount (1 = quarter notes, 2=eighth notes
##: 4=sixteenth notes, etc...)
##:
##: The unit generator *clock* produces a trigger signal that can be used by
##: other trigger-based unit generators. The example below shows **clock**
##: being fed into the envelope generator **tenvx**. 
##---
# Generate 120 BPM clock signal
0 120 1 clock 
# Feed clock into exponential envelope generator
0.001 0.001 0.05 tenvx 
# Multiply envelope with sine wave
1000 0.5 sine *
##---
