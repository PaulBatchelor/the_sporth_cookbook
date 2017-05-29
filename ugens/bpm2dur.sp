##: # bpm2dur
##: 
##: A function that efficiently converts bpm to duration (in seconds) with
##: the equation  
##:     60/BPM
##:
##: The example uses bpm2dur to create a 130BPM clock signal with **dmetro**,
##: fed into **trand**, which is used to control the frequency of a sine wave.
##---
# Create 130bpm clock signal with dmetro
130 bpm2dur dmetro 
# feed clock into trand, generating frequency values between 200 and 400. 
200 400 trand 
# the rest of sine
0.3 sine
##---
