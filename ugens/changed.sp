##: # Changed
##:
##: This ugen takes in a signal, and outputs a trigger if the signal has 
##: changed. Sometimes useful for realtime-controlelr based setups.
##:
##: The example is an enveloped sine wave whose frequency is modulated with 
##: sample and holds via **randh**. Anytime the frequency changes, it triggers
##: the envelope via **changed**.
##---
_freq var
200 1000 1 4 1 randh randh _freq set

_freq get 0.6 sine _freq get changed 0.001 0.005 0.001 tenvx * 
##---
