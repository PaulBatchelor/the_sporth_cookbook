{{TITLE}}

## All about the trigger

Triggers are a very important part of the Sporth ecosystem. They are a convention
inspired by supercollider as well as the eurorack modular synth community. 

A single trigger is exactly one sample that is a non-zero value (typically,
this value is just a '1'). Since everything in Sporth is sample accurate, triggers
are sample accurate and can work at audio rate. 

Trigger-based signals feed into trigger-based ugens to generate signals. 
Some of these ugens include:

- tenv: a linear envelope generator
- tenvx: an exponential envelope generator
- tseq: a step sequencer
- tgate: a gate generator
- tog: a toggle signal
- switch: a 2-way switch
- tadsr: a ADSR generator
- tblrec: a table recorder for sampling
- timer: a stopwatch like clock
- line: a line segment generator
- expon: an exponential line segment generator
- trand: a random number generator
- maytrig: a probablistic trigger filter
- maygate: a probabalistic gate generator
- tdiv: a trigger divider

To generate trigger signals, a few ugens are available:

- metro: a metronome object whose rate is specified in Hz.
- dmetro: a varation on the metronome object, which whose rate
can be specified in seconds instead of Hz.
- clock: a resettable clock whose rate can be specified in BPM and subdivision
- [prop](/proj/prop.html): a rhythmic notation language in Sporth capable of building proportion
based subdivisions
- dtrig: a "delta trigger"
- dust: generates random impulses. 
- tick: generates a single tick at the start of a sporth patch. Be careful,
this can only be called once! It is common practice to copy the output signal
to a variable or to use stack operations.

## All about the gate

A gate is a unipolar, steady state-based signal that is either 0 or 1. These
aren't as commonly used as triggers, but they are still used in some ugens 
that utilize gates:

- adsr: an analogue modelled ADSR generator
- branch: a switch that uses a gate instead of a trigger
- thresh: a threshold detector, useful for converting gates to triggers

Gates are signals that are multipled directly with other signals. They are 
very useful for things like reverb throws. You can also make a decent makeshift
envelope putting a gate through a portamento filter to smooth out the edges:

    1 metro tog 0.01 port

A 1Hz metronome object is being fed into a toggle generator, whose value
is going between 1 and 0 every second. This creates a gate signal which is
then fed into the portamento filter, whose half time value is 10ms. 
The portamento filter (a simple one pole smoothing filter), 
creates the ideal exponential curves for envelope, with a convex exponential 
slope on the attack, and a concave exponential slope on the release. The
"adsr" and "tenvx" ugens have been meticulously built and rebuilt to show these
curves using this method.
(You would be surprised how many envelope implementations I've seen 
that mess this up. Csound gets it wrong, as does most of the Eurorack 
modules!)

There are few ways to generate gate signals in Sporth:

- tgate, when triggered, generates gates signals with a specified duration 
- tog toggles itself on and off when triggered, creating a gate
- maygate takes a trigger and probalistically will turn itself on or off

Gate signals come into play more with APIs and other software, as gates
are easier to make than one-sample trigger signals. Using gate with a thresh
hold generator is often a good approach.

{{FOOTER}}
