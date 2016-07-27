##: # Dialtone

##: We are going to make a North American dialtone. A dialtone is part of the 
##: DTMF system used by telephones. It uses only two sine waves. 
##:
##: We first begin with a sine wave:
##---
440 0.3 sine
##---
##: Sporth is a *stack-based* language, which means that arguments come before
##: the function. The function **sine** takes frequency and amplitude as 
##: arguments. Under the hood, this can be read in the following way:
##: - 440 is pushed onto the stack
##: - 0.3 is pushed onto the stack
##: - the function **sine** is called
##: - 0.3 is pushed off the stack and set to be amplitude
##: - 440 is pushed off the stack and set to be the frequency
##: - **sine** computes one sample of audio, and pushes it onto the stack
##: 

##: Next, we push our other sine wave at 350 Hz:

##---
350 0.3 sine 
##---

##: Like before, **sine** takes the two arguments and then pushes a 
##: single sine sample onto the stack. We now have two sines on the stack.
##: Now these sine waves must be added together:

##---
+
##---

##: **Add** pops two arguments from the stack, adds them together, and pushes
##: the result back on the stack. This item is then popped from the stack, 
##: and then sent to the speaker. 
