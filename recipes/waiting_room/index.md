# The Waiting Room

\[[code](/res/cook/the_waiting_room.sp)]

## Tables 
A sine wave table is used for the many sinusoid LFOs used in the patch.
A table of notes is created using **gen_vals**, which will be used for
the main melody. 

    _sine 8192 gen_sine
    _seq "62 69 72 71 74" gen_vals

## Gbuzz Pads
The pads provide the canvas for the patch. For a sound generator, a
buzz generator is used, called *gbuzz*. gbuzz produces a set of 
harmonically related sinusoids, which approximately sounds like a 
sawtooth. The strength of each successive overtone is modulated with
a sine LFO via **osc*. This modulates the overall timbre of the sound.

    62 mtof 0.3 8 3 
    15 inv 1 0.2 _sine osc
    0.1 0.6 biscale gbuzz

This sound gets repeated 2 more times to form a triad with notes
C, D, and A, which outlines some sort of D7 chord. The phase and
frequency of each LFO is tweaked to make the voices more individual.


    60 mtof 0.3 8 3 
    10 inv 1 0 _sine osc
    0.1 0.6 biscale gbuzz 
    
    +
    
    12 inv 1 0.75 _sine osc
    0.1 0.6 biscale gbuzz
    
    +

The summed signal is attenuated by 6dB and put through a butterworth
highpass filter.

    -8 ampdb * 400 buthp

## Chorused Pluck 
The chorused pluck sound is the lead instrument sound that plays the 
melody. It begins with a clock signal generated via **clock**, and 
then put through a **maytrig**. This signal is duplicated. One will
feed the sequencer, the other will be the trigger signal for **pluck**.

    0 77 1 clock 0.4 maytrig dup

The melody generated comes from the *seq* table generated above. **tseq**
is set to shuffle mode, picking notes randomly. A small bit of portamento 
is added as a stylistic choice, but it is not necessary. 

    1 _seq tseq mtof 0.003 port 

The rest of the arguments for **pluck**, then a lowpass filter **butlp**.
The last argument to pluck is the lowest intended frequency to be used with
pluck. This is a static value that sets the buffer size. This parameter
is worth experimenting with a bit, as it drastically changes the sound
and decay of the sound.

    0.5 50 pluck 3000 butlp 

The puck signal is fed through a string resonator, which is the filtered
version of pluck. This string resonator is tuned to F#, a major third
above "D". The idea is to roughly simulate nodes and antinodes of a string
body. When the plucked string plays an F# it will ring louder. 
**streson** and **pluck** are known to build up a lot of DC, so a dc blocker
is placed at the end.

    66 mtof 0.91 streson dcblk

This string sound is duplicated, and fed into a chorus effect. 
Sporth does not have a chorus effect, but a makeshift one can be made
easily using a vdelay and slow, small modulations of the delay time.
For good measure, a dc blocker is used here as well (I must have been
getting a lot of DC when making this patch!)

    dup 0.4 0.1 1 0 _sine osc 0.002 0.008 biscale 0.2 vdelay + dcblk

The chorused instrument is then fed into a delay line whose delay time
is set to a dotted-eigth note duration. This delay is fed into a butterworth
lowpass filter to keep it out of the way, then scaled to make it quieter. 

    dup 0.7 77 bpm2dur 0.75 * delay 2000 butlp 0.5 * + 

This signal attenuated by 3dB, then added to the rest of the mix.

    -3 ampdb * +

## Subtractive Bass
This instrument provides the bass sound, a constant pulsating drone. It
is comprised of two detuned bandlimited sawtooth oscillators tuned to a 
D.

    26 mtof 0.2 saw 38.1 mtof 0.3 saw +

As stated in the title, this is a subtractive patch, and the lowpass
filter used here is **diode**, a filter design based of the one used by
the TB303.  The filter cutoff is modulated by a slow-moving LFO whose period 
is 8 seconds.

    8 inv 1 0 _sine osc 500 2000 biscale 0.1 diode 

This sound is added the rest of the patch. The entire patch is attenuated
by 3 dB.

    + -3 ampdb *


\[[Back](/proj/cook)]

