##: # tblrec
##:
##: Tblrec has the following arguments:
##: - input: input signal
##: - trigger: trigger signal to start/stop recording
##: - table name: name of f-table to record to
##:
##: **tblrec** will record an input signal to an f-table. In addition, there is 
##: also the ability to turn the recording off and on. When turned back on, the
##: pointer will rewind to the beginning, overwriting any previous data. When
##: the record pointer reaches the end of the table, it loops to the beginning
##: and continues onwards.
##:

##: The patch below demonstrates one particular way **tblrec** can be used.
##: A simple karplus-strong instrument is recorded into a 2-second long buffer.
##: The buffer is then randomly shuffled through using the phase-vocoder 
##: mincer.
##:
##: **tblrec** pushes a copy of the dry signal back onto the stack.
##:

##---
# create a 2-second long buffer called "in"
_in sr 2 * zeros

# a small plucked instrument patch
1 metro dup 300 800 trand 0.5 100 pluck 

# record the patch using tblrec. "tick" makes it start recording indefinitely
tick _in tblrec 

# drop the dry signal
drop

# create a jitter signal between 0 and the position of the input buffer
0 _in tbldur (2 10 1 randh) randi 

# mince it up using mincer
1 1 2048 _in mincer

##---
