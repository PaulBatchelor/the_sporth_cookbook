##: # Bones
##:
##---
# Bones
# By Paul Batchelor
# September 2016
##---
##: Bones is a quick sporthlet I made to get back into the habbit of
##: making sporthlets. It primarily utilizes modal synthesize and variable
##: feedback delay lines to achieve something vaguely bone like (well, 
##: at one point it was).
##:
##: ## Tables and variables
##:
##: The first table created is a set of modal ratios approximating a 
##: uniform wooden bar ratios. They have been obtained from
##: http://www.csounds.com/manual/html/MiscModalFreq.html.
##---
_rat "1 2.5752 4.4644 6.984" gen_vals
##---

##: Variables are a relatively new concept in Sporth, and have their own
##: commands for setting and getting. *tk* is a variable that will hold
##: the trigger tick, and *frq* will eventually hold the fundamental
##: frequency of the instrument.

##---
_tk var
_frq var
##---

##:
##: ## Trigger generation
##:
##: The base trigger is a metronome, whose rate is randomized via
##: a **randh** module.

##---
1 10 1 randh metro
##---

##: A consistent metronome can annoying quickly, so it is sent through
##: a maytrig to hush it up every now and then. The probability randomly
##: swings between 0.1 and 0.8 via **randi**. To make the line a little less
##: regular, the rate gets changed with **randh**.

##---
(0.1 0.8 (1 10 3 randh) randi) maytrig 
##---

##: The maytrig reduces the density, but phrasing is also important. 
##: for this reason, the output of the maytrig is multiplied by a **maygate**.
##: (Could this have been done with just one maytrig? Probably. But that
##: I did not think of this in the moment of creating this)

##---
dup 0.65 maygate * 
##---

##: **tick** is added onto the trigger signal, to ensure that there is a 
##: trigger at the start of the sporth drawing. 

##---
tick + 
##---

##: The entire signal is assigned to the variable *tk* via the **set** ugen.

##---
_tk set
##---


##:
##: ## Modal Resonators
##:
##: An entire explanation of modal resonators and modal synthesis are 
##: beyond the scope of this sporthlet, but a small one will be given.

##: One can think of a modal filter as a filter that resonants at a particular 
##: Q and frequency. In modal synthesis, an excitation signal (in this case, 
##: a trigger signal), is fed through a bank of modal filters, configured
##: in both series and in parallel. What comes out is the sound. This technique
##: is largely used in physical modelling. 
##:
##: The base frequency of the instrument is set via **trand**, who trigger
##: is obtained from the previously set variable *tk*.

##---
_tk get 500 1500 trand _frq set
##---

##: The trigger signal *tk* is sent through two modal filters in series, whose
##: frequences are obtained from the first two elements table *rat*, multiplied
##: by the frequency *frq*. In the first modal filter, the Q is being randomized
##: via **randi**.

##---
_tk get (_frq get 0 _rat tget *) 10 40 3 randi mode
(_frq get 1 _rat tget *) 20 mode
##---

##: The process is repeated again, this time with the last two modal 
##: frequency ratios in *rat*, and different Q values (by the way, these
##: Q values were chosen fairly randomly with a little experimentation)

##---
_tk get (_frq get 2 _rat tget *) 22 mode
(_frq get 3 _rat tget *) 15 mode +
##---

##:
##: ## Delay lines
##:
##: The variable delay line is the crucial element that adds a strange crittery
##: characteristic to the sound. This is done by randomizing the feedback
##: and delay times with **randi**. 

##---
dup 0.1 0.8 3 randi
0.001 0.2 (0.1 4 1 randi) randi
1.0 vdelay
##---

##: To add more texture to the delay line, a **smoothdelay** is applied
##: to the variable delay signal. A smooth delay line is like a variable
##: delay line, except there is no residual pitch modulation. **Randi** is used
##: to control feedback, and **sine** is used to control delay time. 
##: To add space and variation, the level is modulated by yet another 
##: **randi**. 

##---
dup 0.4 0.9 0.5 randi
0.2 1 sine 0.01 0.3 biscale
1.0 64 smoothdelay 0 1 0.2 randi *
##---

##: Finally, the delay lines and dry signal are summed together.
##---
+ +
##---

##:
##: ## Post-effects
##: 
##: The final effects used are a gentle chowning reverb fed through
##: a hard limiter **limit**. 
##---
dup jcrev -6 ampdb * + -1 1 limit
##---
