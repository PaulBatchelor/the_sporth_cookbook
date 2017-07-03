##: # tget
##:
##: **tget** will retrieve values from a table. It takes in an index position 
##: and a table name, and pushes that value onto the stack.
##: 
##: The following patch uses **tget** to retrieve parameter values for 
##: **sine**.
##:
##---
_vals "440 0.5" gen_vals
0 _vals tget
1 _vals tget
sine
##---
