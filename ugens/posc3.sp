##: # posc3
##:
##: **posc3** is a table-lookup high precision oscillator with 
##: cubic interpolation. 
##:
##: It takes in the following arguments:
##: - frequency
##: - amplitude
##: - table name 
##:
##: The following patch creates a 440Hz sine wave using **posc3**. It is
##: analogous to the unit generator **sine**.
##---
_sine 8192 gen_sine
440 0.5 _sine posc3
##---
