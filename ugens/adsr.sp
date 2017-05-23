##: # ADSR
##: 
##: A gate-based ADSR envelope generator. 
##:
##: ADSR takes the following arguments:
##: - gate signal: a steady on or off
##: - attack: attack time (in seconds)
##: - decay: decay time (in seconds)
##: - sustain: level to sustain at (should be between 0 and 1)
##: - release: release time (in seconds)
##;
##: This particular ADSR algorithm is special in that it uses filters to 
##: generate the curved envelope signal, which is contrary to most popular ADSRs, 
##: which are linear. 
##: 
##: ## Example
##: In the example below a toggle signal generated with the ugens **dmetro**
##: and **tog** are fed into **adsr**. This signal is then multiplied with 
##: a 440hz sine wave.
##---
2 dmetro tog 0.1 0.1 0.9 0.8 adsr 440 0.5 sine * 
##---
