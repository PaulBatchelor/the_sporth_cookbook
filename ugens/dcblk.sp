##: # dcblk
##: 
##: A DC blocking filter. This is used to correct any DC offset introduced
##: into the signal path. Common culprits that introduce DC offset include 
##: reverberators, comb filters, and string resonators.
##:
##---
# use an impulse as an excitation signal
1 metro
# feed it into some string resonators
220 0.999 streson
300 0.8 streson
# remove any dc offset with dcblk
dcblk
##---
