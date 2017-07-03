##: # tseq
##:
##: The ugen **tseq** is a trigger-based sequencer. It takes in the following
##: arguments:
##: - trig: trigger signal that clocks the sequencer
##: - mode: sets the mode of the sequencer. 0 = step through sequence. 
##: 1 = randomly go through sequence
##: - ftname: the name of the table to go through
##:
##: The example patch below shows how **tseq** can be used as an arpeggiator.
##:
##---
# the sequence: a minor arpeggio, root position
_seq "0 3 7 12" gen_vals
# an 8hz metronome used as a trigger signal to clock the sequencer
8 metro 
# step through the values
0 _seq tseq 
# add 60 bias so root note is middle C
60 + 
# put through portamento filter to smooth out jumps
0.005 port mtof
# use a bandlimited triangle wave generator
0.5 tri
##---
