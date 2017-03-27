##: # Machines at Work

##: Machines at work is yet another example which showcases how Sporth can be
##: used to produce sequenced music. It is comprised of main sounds with 
##: aux efects.

##: ## Tables and Variables
##: Being a largely sequenced patch, this patch is highly reliant on tables:
##: - the table *sine* uses **gen_sinesum** to produce a summation of 
##: harmonically related sine waves
##: - the table *seq* uses gen_rand to generated a random distribution for
##: use with tseq, with an emphasis on note "38", then "41", then "43". 
##: - the table **sqrseq** is the sequence used by the square instrument
##---
_sine 8192 "1 0 0.1 0.8 0.8" gen_sinesum
_seq 32 "38 0.7 41 0.2 43 0.1" gen_rand
_sqrseq "74 77 79 81" gen_vals
##---
##: The patch also uses three variables. 
##: - the variable *rms* stores the RMS of the bass
##: - the variable *bass* stores the signal of the bass
##: - the variable *clk* holds the clock signal
##: - the variable *note* stores the note of the bass

##---
_rms var
_bass var
_clk var
_note var
##---

##: ## Bass
##: To begin, a clock signal is generated via **dmetro** and **bpm2dur**. 
##: To get sixteenths notes, the tempo (92), is multiplied by 4. We set this
##: to the variable *clk* so it can easily be used throughout the patch.
##---
92 4 * bpm2dur dmetro _clk set
##---

##: The bass sequence is created using **tseq** in shuffle mode, using the 
##: table and weighted random distribution *seq*. Before being sent to 
##: **tseq**, the clock signal *clk* is fed through a clock divider to 
##: effectively get eigth notes.

##---
_clk get 2 0 tdiv 1 _seq tseq 0.001 port _note set
##---

##: The bass instrument is composed of three oscillators, the first two
##: being FM oscillators via **fosc**. These are slightly detuned and an octave
##: apart from one another. Each oscillator has their own sinusoidal LFO 
##: controlling modulation index, which effectively controls the brightness.
##: To add more grit, the usually sine lookup table supplied to **fosc** 
##: has extra harmonics for some extra grit. 
##---
_note get mtof 0.1 2 1 (0.1 1 sine 1 3 biscale) _sine fosc
_note get 12.1 - mtof 0.1 1 1 (0.1 1 sine 4 7 biscale) _sine fosc +
##---

##: The third oscillator is a triangle wave, tuned a fifth up. 
##---
_note get 7 + mtof 0.2 tri +
##---

##: Next, the the signal is modulated by the exponential envelope signal 
##: generator **tenvx**. A copy of the **tenvx** signal is saved to the 
##: variable *rms*. 
##---
_clk get 2 0 tdiv 0.001 0.01 0.3 tenvx dup _rms set * 
##---

##: the bass filter is passed through a lowpass filter **butlp** with a 3000
##: hz cutoff, and then saved to the variable *bass* for later. 
##---
3000 butlp _bass set
##---

##: ## Square
##: The second instrument created is a square oscillator instrument. 
##: To begin, the envelope signal is generated from *clk*. A copy of clk is
##: created to be used next.
##---
_clk get dup 0.001 0.02 0.1 tenvx 
##---
##: The envelope and the clock signal **swap** places, so that *clk* can feed
##: **tseq**. This generates the sequencer signal for the square wave.
##---
swap 0 _sqrseq tseq 
##---
##: The clock is retrieved once more, and fed into a maygate signal, which
##: is then scaled by 12, and then added to the sequence signal. 
##: This has the effect of making the sequence occasionally jump an octave.
##---
_clk get 0.2 maygate 12 * +
##---

##: To smooth jumps between the notes, the portamento filter **port** is used,
##: then the MIDI value is converted to frequency with **mtof**. 
##---
0.005 port mtof
##---

##: Next, the amplitude of the square oscillator is set to 0.3
##---
0.3 
##---
##: The pulse width is determined by a sinusoidal LFO, scaled between 0.2 and
##: 0.8. 
##---
10 inv 1 sine 0.2 0.8 biscale 
##---
##: Afterwards, **square** is finally called, and then multiplied with the 
##: envelope signal generated previously. This signal is then put through a
##: butterworth lowpass filter with a 2kHz cutoff.
##---
square *  2000 butlp
##---

##: Next, the square signal is put through a tempo-synced delay, timed to work
##: at a 3 sixteenth note time delay.
##---
dup 0.7 92 bpm2dur 0.75 * delay 1000 butlp -4 ampdb * + 
##---

##: ## Pads
##: The bulk of the pad sound is mostly built from three bandlimited 
##: sawtooth oscillators. Examining a single oscillator, it can be seen that
##: a fixed pitch is assigned, and the amplitude is being modulated via
##: a randome line segment generator **randi**. 
##---
76 mtof 0 0.2 0.2 randi saw 
##---

##: This gets duplicated two more times, with different pitches and 
##: instances of **randi**. They are all combined together into one signal.
##---
65 mtof 0 0.2 0.5 randi saw +
67 mtof 0 0.2 1 randi saw +
##---

##: The pad signal is fed through a **moogladder** ugen. The cutoff frequency
##: is modulated by an LFO signal, scaled between values 1000 and 3000. The
##: **moogladder** ugen loses gain with the resonance set to a high 0.5, so 
##: the signal is doubled. 
##---
12 inv 1 sine 1000 3000 biscale 0.5 moogladder 2 *  
##---

##: This signal is fed through a delay, timed to work with a quarter note 
##: delay time.
##---
dup 0.7 92 bpm2dur delay 1000 buthp -3 ampdb * + +
##---

##: ## Noise
##: The final sound added to the mix is a percussive white noise instrument.
##: Unlike the previous sounds, this uses its own clock signal, but it is
##: synced to the same tempo as the clock. For the clock signal, **prop** is
##: used. Prop is a microlanguage within Sporth for generating complex rhythms.
##---
92 "-+|-2(-+)|-4(++--)|-?-4(-+-+)" prop 
##---

##: The prop signal is fed through maytrig to make it less dense...
##---
0.7 maytrig
##---
##: ...which in turn is used to produce an exponential envelope signal via
##: **tenvx**.
##---
0.001 0.1 0.1 tenvx 
##---

##: Next is the noise source is generated by **randh** being modulated at
##: audio rate  with **randh**. Then it is fed through **butlp**. 
##---
(-0.3 0.3 sr (1 5 13 randh) / randh) * 4000 butlp
##---

##: The ampltiude of the noise source is modulated by a morphing signal 
##: via **cf**. The first signal is a series of tiny gate signals generated
##: with **tgate**, whose parameters are being randomly modulated.
##---
(10 40 1 randh) metro (0.001 0.015 2 randi) tgate 
##---

##: The next signal is just a constant "on" signal 1.
##---
1 
##---

##: These two signals are crossfaded from one to the other via a smoothed
##: toggle signal **tog**, synced up with the clock signal *clk*. 
##---
_clk get 0.5 maytrig tog 0.01 port 
cf *
##---

##: This generated signal is fed througha tempo sycned feedback delay, set 
##: to a delay line of 3 sixteenths notes. 
##---
dup 0.7 92 bpm2dur 0.75 * delay -10 ampdb * + 
##---

##: This instrument is then piled onto everything else on the stack.
##---
+
##---

##: ## Effects

##: Before the effects are prossed, every instrument (minus the bass), is 
##: scaled by "rms" signal of the bass (which is actually just the amplitude
##: of the bass). The signal can be scaled between -3 and 2 db. 
##: This acts as a bootleg signal ducker. When the bass turns on, the rest 
##: of the instruments back off.
##---
1 _rms get - -3 2 scale ampdb * 
##---

##: To give the bass even more space, we put the isntruments through a highpass
##: filter. 
##---
500 buthp
##---

##: These instruments are fed through the chowning reverb **jcrev**. 
##---
dup jcrev 3 ampdb * +
##---
##: The bass signal from what back is retrieved from *bass*, and given a bass
##: boost via eqfil. Then, everything is summed together and attenuated a 
##: bit so things do not clip.
##---
_bass get  100 20 3 eqfil + -2 ampdb * 
##---
