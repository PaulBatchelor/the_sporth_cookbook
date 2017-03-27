##: # Oatmeal
##: This was a quick patch I whipped up some morning while eating some oatmeal.
##: It is part of my ongoing collection of [sporthlings](/sporthlings/002).
##: By and large, this patch was derived by layering simple sounds together.

##: ## Tables and Variables
##: Tables generation is minimal. A sine lookup table is generated for some oscillators,
##: A single variable *d* is used for the dust signal.
##---
_wav 8192 gen_sine
_d var
##---

##: ## Dust
##: The **dust** ugen is a ugen that fires random impulses at a certain
##: density. It is unique in that it works well as both a control signal as 
##: well as an audio signal. This patch uses this signal for both purposes.
##: 
##: The first argument to **dust** is amplitude, which is set to a constant 2.
##:
##---
2 
##---

##: The second argument is density, which is controlled by a low-frequency 
##: oscillator, set at 0.2 Hz. It is scaled via **biscale** to go between
##: 5 and 20 impulses per second. 
##:
##---
0.2 1 0 _wav osc 5 20 biscale
##---

##: The rest of **dust** is written out. The final argument to **dust** is
##: the mode, which has been set to 1, bipolar mode.
##: The signal is duplicated, and one of the values is set to teh variable *d*.
##---
1 dust dup _d set
##---

##: The dust signal continues onward, being filtered by **wpkorg35**. It is set
##: to a cutoff frequency of 1100 with a very high resonance (this particular
##: filter has a range of 0-2, and the resonance is 1.9. The sonic output
##: of putting impulses into a highly resonant filter little sinusoidal blip 
##: sounds. One of my favorite go-to effects. 
##:
##---
1100 1.9 0 wpkorg35
##---
##: To add some body, the blips are fed into the chowning reverb, which I have
##: found to be very favorable to sinusoidal signals for some reason.
##---
jcrev 
##---

##: ## Blerps
##: The next layer in our cake of sound are what I will call "blerps". These
##: are rhythmic blips tuned at whole integer ratios from one another. 
##: 
##: The make up of a single "blerp" consists of a sinusoid and an envelope.
##: The envelope is created gate signal (generated via **tgate**)
##: being sent through a portamento filter. The gate is controlled via the
##: dust signal stored in variable *d*. To make things less busy, the trigger
##: is fed into a maytrig.
##: 
##---
_d get 0.5 maytrig 0.01 tgate 0.001 port 
##---
##: The envelope generatored is then multipled with a sinusoidal oscillator 
##: tuned at 1000Hz. This signal is then added onto the current signal.
##:
##---
1000 0.3 0 _wav osc *  + 
##---
##: The same thing more or less is repeated 2 more times, with a few variations
##: in parameters. The oscillators are tuned to 2000Hz and 500Hz.
##---
_d get 0.5 maytrig 0.004 tgate 0.001 port 
2000 0.3 0 _wav osc *  + 
_d get 0.2 maytrig 0.004 tgate 0.001 port 
500 0.3 0 _wav osc *  + 
##---

##: ## Noise
##: **Randh**, like dust, can function equally well as a control signal and an
##: audio signal. When the rate is set to audio-rate frequencies, you can get
##: different "colors" of noise, an sound reminiscent to 8-bit game sounds.
##: 
##: For starters, an envelope signal is generated in similar manner to the 
##: envelopes created in the previous section.
##: 
##---
_d get 0.3 maytrig 0.04 tgate 0.005 port 
##---
##: The arguments for ugen **randh** can now begin. These two arguments tell
##: randh to produce random values between (+/-)0.05. 
##---
-0.05 0.05 
##---
##: The third argument to **randh** is rate (or frequency), which we have
##: delegated to a triggerable random number generator **trand**. The 
##: trigger signal is being fed by our dust signal, and is producing random
##: values between 1102Hz and 11025Hz. 
##---
_d get 1102 11025 trand  
##---
##: Finally, **randh** is called and multiplied with the corresponding 
##: envelope. It is then added to the current signal. 
##---
randh * + 
##---

##: ## Processing
##: The effects processing is used in a very unusual way. One could argue that
##: the processing is an instrument as well.
##:
##: To begin, the signal is duplicated so that a dry version of the signal
##: is stored.
##---
dup 
##---
##: The first thing created is a "throw" signal. The dust signal used from 
##: before feeds into a very sparse **maytrig**. This trigger signal feeds
##: into a tenv, where a very gentle envelope signal is multipled with
##: the signal to be processed. The results is we are occasionally "throwing"
##: the signal into processor. This term is borrowed from what is known by
##: mix engineers as a "reverb throw". 
##:
##---
_d get 0.1 maytrig 0.4 0.1 0.1 tenv * 
##---
##: The thrown signal is fed into a feedback delay of 300ms with a feedback 
##: amount of 60 percent.
##:
##---
0.6 0.3 delay 
##---
##: The feedback delay is fed into the pitch shifter **pshift**, where it is
##: tuned up an octave.
##: 
##---
12 1024 512 pshift 
##---
##: The pitch shifted signal is put through a butterworth lowpass, and then 
##: attenuated by 6dB. The dry and wet signal are then added together.
##: 
##---
1000 butlp -6 ampdb * + 
##---
