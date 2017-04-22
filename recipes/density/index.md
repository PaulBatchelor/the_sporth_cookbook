# Density

\[[code](/res/cook/density.sp)]

[Density](/sporthlings/006/) is something of a test patch, originally 
built as a playground for [lsys](/proj/cook/lsys.html), a new and still
very underused microlanguage in Sporth for describing L-systems. Full 
explanations of what lsys is doing is beyond the scope of this document. 
Besides lys, is a very short and simple patch, make good use of exponential
envelopes, sinusoids, and delay lines to create organic bubbly textures.
## Clock 
The clock signal utilized in this patch is generated using **clock** and
stored in the variable *clk*. 

    _clk var
    0 150 4 clock _clk set

## LSYS 1
In Density, there are two very lsys-driven instruments, the first of which
is described now. An instance of **lsys** is spawned. It is controlled with
the clock signal *clk*, and has an order of 16. The output of **lsys**
is fed into **thresh** in order to generate a trigger signal for **tenvx**.

    _clk get 16 "bab|a:bba|b:a" lsys 10.5 2 thresh

The exponetial trigger envelope generator **tenvx** is then instantiated.
It is a very quick envelope with 1ms durations for attack, hold and decay
parameters. 

    0.001 0.001 0.001 tenvx 

This envelope drives a sinusoidal oscilator **sine**, whose frequency 
is controlled by another **sine** lfo running between 2000Hz and 3000Hz.
The speed of this (1/30) Hz, efficiently calculated via **inv**.

    30 inv 1 sine 2000 3000 biscale 0.5 sine *

## LSYS 2
The second **lsys** instrument in the patch is nearly identical to
the first lsys patch, with a few notable differences. Firstly, the
order of this instance of **lsys** is 17 instead of 16. This creates
an interesting phasing effect with the other **lsys** generator. Secondly,
the sinusoidal oscillator **sine** is set to a fixed frequency of 800Hz.

    _clk get 17 "bab|a:ba|b:a" lsys 10.5 2 thresh
    0.001 0.001 0.001 tenvx 
    800 0.5 sine * +

## Effects
The first part of the effect chain is delay line, with a very high feedback
amount. This delay line is set through a highpass fitler with a rather 
aggressive cutoff point (4000hz) so that the delay line only effects the 
high end. This signal is then attenuated by 20db. 

    dup 0.8 0.2 delay 4000 buthp -20 ampdb * + 

## Dark noise
This is an underlying sound which I call "dark noise" because of the dark
timbre. The initial noise source is generated via **randh** changed
at audio-rate. The rate of **randh** is controlled by a sinusoidal LFO, 
going between 100Hz and 110 Hz. 

    -0.1 0.1 (40 inv 1 sine 100 110 biscale) randh 

This signal is "softened" using the butterworth lowpass filter **butlp**.
It is put through a bitcrusher *bitcrush*, set to be 8 bits with a sampling
rate of 8000Hz. This bitcrusher adds lots of nonlinear aliasing and brings 
back some of the high end lost with **butlp**. This is then added to
the rest of the mix.

    400 butlp 8 8000 bitcrush + 


\[[Back](/proj/cook)]

