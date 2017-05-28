##: # Bal
##: 
##: Arguments: reference, input
##: 
##: Bal comes from the csound opcode "balance". Bal will take an input signal,
##: and match the amplitude of the signal with a reference signal. 
##:
##: Typically bal is used as a tool with filters like **moogladder** whose topology
##: often reduces the gain of the input signal. The example below shows
##: this typical usecase, splitting the input value into a filtered input signal
##: and a dry reference signal. These values go into **bal** to add makeup gain.
##---
150 0.3 saw dup
0.1 1 sine 200 1000 biscale 0.3 moogladder bal
##---
