##: # bpm2rate
##: 
##: A function that efficiently converts bpm to rate (in Hz) with
##: the equation  
##:     BPM/60
##:
##: The example uses bpm2dur to create a 130BPM clock signal with **metro**,
##: fed into **trand**, which is used to control the frequency of a sine wave.
##---
# Create 130bpm clock signal with metro
130 bpm2rate metro 
# feed clock into trand, generating frequency values between 200 and 400. 
200 400 trand 
# the rest of sine
0.3 sine
##---
