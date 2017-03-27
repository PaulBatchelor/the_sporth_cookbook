##: # Midnight Crawl
##: Midnight crawl is a prickly warm little patch featuring string resonators,
##: and warm FM and subtractive saw sounds. 

##: ## Tables and variables
##: - Table *seq* is the sequence for the warm saw sound. 
##: - Table *prog* is used together with *seq* to build a "progression"
##: - Table *seq2* is used to sequence the warm fm sound. 
##: - Variable *clk* is used to store the clock signal
##: - Variable *send* is used as a send signal for the delay. 
##: - Variable *env* is used to store an envelope signal
##---
_seq "0 2 7" gen_vals 
_prog "0 2 5 7 9" gen_vals
_seq2 "0 2 7 11 14 19" gen_vals
_clk var
_send var 
_env var
##---

##: ## The Clock
##: First, the clock signal is created. The clock is generated using 
##: **dmetro**. It is set to 125 BPM, then multiplied by 4 to get 
##: sixteenth note subdivisions. The clock is sent into a maytrig
##: with an 80% probability rate. All of this is assigned to 
##: the variable *clk*.
##---
125 4 * bpm2dur dmetro 0.8 maytrig _clk set 
##---

##: ## Warm Saw Sound
##: The warm sound saw is a sequenced subtractive sawtooth patch. 
##: The sequence is created via **tseq**, using the values inside of *seq*,
##: and the clock *clk*. 
##---
_clk get 0 _seq tseq 58 + 
##---

##: To add a sense of a chord progression, another "progression" sequence
##: is added to the note as a bias. The same *clk* signal is used, but it
##: is fed into clock divider **tdiv** so that the "chord" changes every 
##: 4 notes. To keep it from changing that frequently, the clock signal is
##: fed into a **maytrig**. 
##---
_clk get 4 0 tdiv 0.1 maytrig 1 _prog tseq + 
##---

##: To add occasional octave leaps, **maygate** scaled by 12 is added into
##: the sequence signal. 
##---
12 _clk get 0.2 maygate * + 
##---


##: To simulate analogue "drift", **jitter** is added to the sequenced signal.
##: This entire signal is converted to frequency via **mtof**. 
##---
0.1 0.1 5 jitter + mtof 
##---

##: Portamento between frequencies is controlled via **port**. The portamento
##: time is randomized via **randi** to pick a value between 1 and 20 milliseconds
##: every 5 seconds (**inv** efficiently inverts a number). 
##---
0.001 0.02 (5 inv) randi port 
##---

##: With the frequency set, the amplitude of the saw is set to 0.4. 
##---
0.4 saw 
##---

##: The sawtooth signal is fed into butterworth lowpass filter **butlp**.
##: The cutoff frequency of the filter is determined via a sinusoidal LFO
##: **sine**, modulating between 200 and 800 Hz. 
##---
15 inv 1 sine 200 800 biscale butlp
##---

##: The amplitude of the filtered saw signal is modulated by envelope 
##: generator **tenv**. The envelope used is very long, and is meant to
##: be the contour for many notes at a given time. Since the clock signal
##: is way too fast for this, it is sent through **maytrig**. 
##---
_clk get 0.05 maytrig  1.4 1.1 2.3 tenv *
##---

##: ## Streson Prickles
##: Now for the instrument I like to call "streson prickles". These are the
##: most novel sounds of the patch, created using a series of string resonators.
##: The start of this sound are short little noise bursts, created from 
##: *clk*, **maytrig**, **tenvx**, and **noise**.
##---
_clk get 0.7 maytrig 0.001 0.001 0.001 tenvx 1.9 noise * 
##---

##: **Streson**, is a string resonator. When fed an impulse (like from the noise 
##: bursts ) it will produce a karplus strong pluck sound. In addition to the
##: input signal, there are two arguments to **streson**: the filter frequency 
##: determines the frequency of the string, and the feedback amount determines
##: how long the note stays on for. The first string resonator has both 
##: the frequency and feedback parameters being randomized by *clk*-synchronized
##: random number generators **trand**. 

##---
_clk get 100 1000 trand _clk get 0.8 0.9 trand streson 
##---

##: This signal is fed through two other string resonators in series. 
##: The decay times are set to be constants at 0.9, and 0.8, respectively.
##---
_clk get 400 4000 trand 0.9 streson 
_clk get 100 1000 trand 0.8 streson  
##---

##: To keep samples numerically reasonable, this signal is fed through a 
##: DC blocker **dcblk** and attenuated by 10 dB. Some of the high end is 
##: shaved off using a lowpass filter **butlp**.
##---
dcblk -10 ampdb * 2500 butlp 
##---

##: This sound is complete, but copy of it is sent to the variable *send*
##: to be used as a throw signal. The throw mechanism below is built out
##: of a **maygate**, **tdiv**, and **port** filter. 
##---
dup _clk get 4 0 tdiv 0.1 maygate 0.01 port * _send set +
##---

##: ## Pinging FM Sound
##: The final instrument in the mix is a pinging FM sound. It is a sound
##: buried in the mix. As the trigger signal will show, it is very sparse,
##: having **clk** being set through a very large clock divider and 
##: **maytrig**.
##---
_clk get 16 0 tdiv 0.5 maytrig 
##---

##: A copy of the signal maytrig is made with **dup**, and it is fed into
##: the envelope generator **tenvx**. This generator sets the envelope *env*.
##---
dup 0.005 0.01 0.3 tenvx _env set
##---

##: The clock signal that was **dup**d before feeds into a **tseq**, where it
##: is then biased by 58. When I wrote this patch, I wanted to bump this synth
##: up an octave, so I added 12 to it too. 
##---
1 _seq2 tseq 58 12 + + mtof 
##---

##: The amplitude of the FM synth is is modulated by a slow moving LFO.
##---
13 inv 1 sine 0.01 0.2 biscale 
##---

##: The C:M ratio is set to a typically very bright 2:5. 
##---
2 5 
##---

##: The modulation index is modulated by envelope stored in *env*. This 
##: basically controls "brightness" in the FM world. This is the final argument
##: in **fm**, the sound generator.
##---
_env get 5 * fm 
##---

##: In addition to manipulating the timbre, *env* also controls the amplitude.
##: this signal is then fed into **butlp**. 
##---
_env get * 1500 butlp 
##---

##: The instrument signal generated is copied and added onto the *send* signal,
##: which will be sent into some effects. 
##---
dup 0.3 * _send get + _send set +
##---

##: ## Effects
##: The first effect used in this patch is a feedback delay, with a very
##: large feedback parameter. The delay time is based on the BPM, and is set
##: to approximately dotted quarters. I say "approximately" because I made it
##: slightly longer to make it go out of phase with the dry signal. 
##---
dup 0.9 125 bpm2dur 1.51 * delay 2000 butlp -8 ampdb * + 
##---

##: Next, the *send* signals are processed. First, *send* is fed into 
##: **revsc**. It is fed into a dc blocker **dcblk**, and a high pass filter
##: **buthp**. 
##---
_send get dup 0.98 5550 revsc drop 0.9 * dcblk 200 buthp + 
##---

##: The *send* signal is fed into a tempo-synced feedback delay line 
##: **delay**. It is attenuated and then added into the rest of the patch.
##---
_send get 0.3 125 bpm2dur delay -3 ampdb * +
##---

