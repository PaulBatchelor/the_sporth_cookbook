# Play With Toys

\[[code](/res/cook/play_with_toys.sp)]

Play with toys is a fun little patch making use of sequencing and
weighted random distributions. 
## Tables and Variables
The only table used in this patch is called *seq*, used as the main 
sequencer. The table is generated using *gen_rand*, which generates
a weighted distribution for randomness. 

    _seq 32 "0 0.4 7 0.4 12 0.1 5 0.1" gen_rand

The patch uses a number of variables through out the patch:
- the clock signal is stored in *clk*
- the main trigger signal is stored in *trig*
- the frequency (MIDI note number) of the sequence is stored in *freq*
- the entire dry signal is stored in *dry*
- the bpm (set to 110) is stored in *bpm*

    _clk var 
    _trig var
    _freq var
    _dry var
    _bpm 110 varset

## Clocks, Triggers, and Sequencing
After the variables and tables have been declared, it is time to set
up the main sequencer. Like many patches, this starts with a clock signal.
This is done using **clock**.

    0 _bpm get 4 clock _clk set

From the clock signal, a trigger signal is derived by feeding it through
**maygate**.

    _clk get 0.6 maytrig _trig set

Next, the trigger signal drives **tseq**. **tseq** is set to shuffle mode,
randomly sequencing through the distribution in *seq*. It is then
biased by 60 (middle C) and assigned to *freq*.

    _trig get 1 _seq tseq 60 + _freq set

## FM Oscillator
The crux of this patch comes from the FM oscillator described below. 
Here, the frequency is obtained from *freq* and converted from MIDI
to frequency using **mtof**. The next argument, amplitude, is set to 0.1.

    _freq get mtof 0.1 

The trigger signal *trig* is used to randomly modulate the C:M ratio 
of the FM pair via *trand*. To keep the spectra harmonically related
to the fundamental and not clangorous, it is important to ensure that
the C:M ratio uses whole integers, so the output of **trand** is 
floored using **floor**. 

    _trig get 0 3 trand floor
    _trig get 0 7 trand  floor

A static modulation index of 1 is used, which completes the arguments for
**fm**.

    1 fm

The amplitude envelope of the FM oscillator is generated via **tenvx**.
The trigger signal *trig* used above also feeds into **tenvx**. The FM
and envelope signals are then multiplied together.

    _trig get 0.005 0.01 0.04 tenvx * 

## Moog Saw
Acting as a bassline, a subtractive saw oscillator uses a bandlimited 
sawtooth oscillator fed through a moog filter. The frequency used
is identical to the frequency used in the FM oscillator, but pitched
down an octave to exist in the bass register. 

    _freq get 12 - mtof 0.1 saw 1000 0.1 moogladder

The envelope generator in the bass patch also uses the same *trig* trigger 
signal, except that it is fed into a maytrig to make it more sparse and 
less overwhelming in the mix.

    _trig get 0.3 maytrig 0.01 0.01 0.1 tenvx * 

The bass patch is then mixed into everything else so far, and assigned to
the variable *dry*. 

    + _dry set

## Effects
For effects processing, the dry signal *dry* is fed into the zita reverb
module **zrev**.

    _dry get dup 10 10 10000 zrev drop -10 ampdb * 

To keep the mix from getting too muddy, the reverb is highpassed at 1000kHZ,
leaving plenty of space for the bass instrument.

    1000 buthp 

This signal is then added back into the dry mix. 

    _dry get +

