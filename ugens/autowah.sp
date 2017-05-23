##: # Autowah
##:
##: Original a guitarix effect written in Faust, **autowah** is an automatic 
##: wah pedal. These typically involve some sort of envelope follower on an 
##: hooked up to the cutoff frequency of the wah filter
##
##: ## Parameters
##: - level: level (range 0-1)
##: - wah: amount of "wah" (range 0 -1)
##: - mix: wet/dry mix (range 0-100)

##: ## Example

##---
96 "2(++)4(?+?+)" prop 0.5 maytrig dup
440 0.3 220 pluck dcblk swap 0.001 0.01 0.2 tenvx * 
1 1 100 autowah
##---
