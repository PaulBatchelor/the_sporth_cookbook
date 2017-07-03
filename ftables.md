{{TITLE}}

F-tables, or "function tables" are terms borrowed from the Csound 
language. Simply put, ftables are arrays of floating point values. They are
often used by audio-rate signal generators in Sporth like samplers and table-lookup
oscillators. 

F-tables in Sporth are coupled with gen routines (another term from the Csound/Music N 
world). Gen routines are in charge of filling stuff into the F-tables. In 
Soundpipe, ftable creation and gen routines are two separate operations. However,
in Sporth, ftable creation and gen routine calls are a single operation.

## A simple example

Our most basic gen routine is a sine wave generator, which computes a single
cyle of a sine wave. The code below shows how can build a 300 Hz sine wave 
using a table lookup oscillator:

    "sine" 4096 gen_sine
    330 0.5 0 "sine" osc

A few things to take note of:

- "sine" is the name of the ftable. All created ftables in sporth are named
- gen\_sine is the name of the gen routine in Sporth. It is a convention in
soundpipe and sporth for gen routines to start with "gen_"
- 4096 is the size of the ftable.
- osc takes "sine" as a parameter. 

## Gen routines with arguments

Most gen routines are adopted from Csound, where arguments exist inside a 
string, separated by spaces. In Sporth/Soundpipe this convention is carried
over. The following patch uses sawtooth wavetable oscillator, whose wavetable
was generated using the gen_line gen routine. For variety, a random number
sample and hold generator is feeding into the frequency of the saw, and is
also being fed into a butterworth lowpass filter. 

    "saw" 4096 "0 1 4096 -1" gen_line
    (300 800 10 randh) 0.3 0 "saw" osc 
    (1000 butlp)

Gen routines conventionally follow a similar argument structure:

NAME SIZE ARGSTRING gen_routine

Where:

- NAME is the name of the ftable
- SIZE is the size of the ftable (the number of floats in the ftable)
- ARGSTRING is the argument string parsed by the gen routine

Because of the argument strings, gen routines are tricky things to use
and learn about. The [Soundpipe reference guide](/res/soundpipe/docs),
is the most comprehensive starting point. For instance,
[here is the entry on gen_line](/res/soundpipe/docs/gen_line.html), the gen 
routine used in above example.

## The underscore (_) shortcut

To save keystrokes and make ftables look prettier, the underscore key can be
used in place of strings without spaces. For instance:

    "line" 4096 "0 1 4096 -1" gen_line

Is identical to:

    _line 4096 "0 1 4096 -1" gen_line

This is the preferred convention for ftables and variables, which will be
discussed in the next chapter.

## Unit generators that use f-tables

Here are some common unit generators that make use of f-tables:
- [osc](ugens/osc.html): table-lookup oscillator with linear interpolation
- [tblrec](ugens/tblrec.html): writes an input signal to a table
- [tabread](ugens/tabread.html): reads from a tables
- [tseq](ugens/tseq.html): trigger-based sequencer
- [tget](ugens/tget.html): get a value in a table
- [tset](ugens/tset.html): set a value in a table
- [posc3](ugens/posc3.html): table-lookup high-precision oscillator with
cubic interpolation

{{FOOTER}}
