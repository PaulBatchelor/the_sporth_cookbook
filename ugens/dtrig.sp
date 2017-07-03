##: # dtrig
##:
##: **dtrig** is a delta-time trigger, used for creating trigger signals 
##: in terms of delta times, or the amount of time between two trigger signals. 
##: Delta times are read from an [f-table](/proj/cook/ftables.html). 
##:
##: **dtrig** takes in the following arguments:
##: - trigger: this is a trigger signal that will trigger the sequence of de
##: delta values. Can be used for restarting the sequence
##: - loop: turns looping the trigger values on or off 1=on, 0=off
##: - delay: amount of time (in seconds) to delay the triggers
##: - scale: value to scale the d-trig signals by. For instance, to double
##: the time, use "2", to half it, use "0.5". "1" is normal.
##: - table: name of the table containing the delta values.
##:
##: The following example using **dtrig** to control an envelope generator.
##---
# delta times: 100ms and 500 ms
_delta "0.1 0.5" gen_vals

# dtrig. "tick" is used to start it looping
tick 1 0 1 _delta dtrig
# dtrig feeds into an envelope generator...
0.001 0.001 0.1 tenvx 
# and then that is multiplied by a sine wave
1000 0.5 sine *
##---
