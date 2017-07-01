##: # The Sine (again)
##: One thing not explained was where the range of frequencies were derived
##: in the previous patch. Why 220 and 1760? 
##: This patch below has been rewritten to explain these numbers. The LFO 
##: is now scaled to go between 1 and 8, and is multiplied by a scalar value 
##: of 220. 
##---
0.1 1 sine 
1 8 biscale 220 * 
0.3 sine
##---
