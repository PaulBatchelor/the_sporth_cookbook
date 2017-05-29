##: # branch
##:
##: Arguments: signal, sig1, sig0 branch
##: 
##: Branch switches between two signals given a gate signal. A value of
##: "1" will go to *sig1* (first signal), and a value of 0 will go to
##: **sig0** (second signal). 
##: 
##: The example below uses **branch** to switch between a random and steady
##: signal to be used as frequency for a sine wave. The switching mechanism
##: is generated via **metro** and **tog**
##---
# generate gate signal with metro and tog
1 metro tog 
# signal 1: random signal
200 800 10 randh 
# signal 2: steady signal
200 
branch 
0.3 sine
##---
