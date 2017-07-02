##: # clip
##:
##: Arguments: input, threshold
##:
##: Performs clipping on an *input* signal that goes past a *threshold*
##: (both postive and negative). 
##:
##: The patch below clips a sine wave and makes it sound more like a square
##: wave. 
##---
440 1 sine 
# threshold to 0.3
0.3 clip -5 ampdb * 
##---
