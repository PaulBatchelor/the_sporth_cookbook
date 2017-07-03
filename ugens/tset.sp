##: # tset
##:
##: **tset** will retrieve values from a table. It takes in a value, 
##: an index position, and a table name, then pushes that value onto the 
##: stack.
##: 
##: The following patch uses **tget** to retrieve parameter values for 
##: **sine**, and **tset** to set the parameters 
##:
##---
_vals 2 zeros
350 0 _vals tset
0.5 1 _vals tset
0 _vals tget
1 _vals tget
sine
##---
