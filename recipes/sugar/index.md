# Sugar

\[[code](/res/cook/sugar.sp)]

This patch is yet another patch written specifically for a Sporth Editor
for the iPad, powered by AudioKit. This was a test patch designed to test out
the keyboard interface.
Like previous sporth patches for 
the sporth editor, p-registers 0-3 map to user-controllable sliders. 
In addition to these, p-register 4 and 5 are also used for the keyboard 
control. p4 is a gate signal, and p5 is a pitch value (in the range 0-24).

## Tables

    _seq "0 5 7 12 2 12 7 5" gen_vals
    _filt "1000 2000 7000 3000 1000 1000 7000 1000" gen_vals

## Controls
This patch contains 4 parametric controls.
Control 1: Tempo
This is the speed of the sequencer(s)

    _bpm var
    0 p 80 150 scale _bpm set

Control 2: Length
The length controls the pattern length of the sequence.

    _seqlen var
    1 p 8 * floor  _seqlen set

Control 3: Resonance
This controls how much resonance is applied to the filter.

    _res var
    2 p 0 0.99 scale _res set

Control 4: Detune
This controls how much detune there is amongst the oscillators.

    _det var
    3 p 0.01 0.45 scale _det set

## Variables
A few named variables are created to carry signals used through the patch.

    _phsr var
    _key var
    _dry var
    _note var
    _gt 4 palias

- "phsr" will hold the phasor signal, which are used in the sequencers.
- "key" will hold the midi note number value
- "dry" will hold the dry signal so it can be processed by effects
- "gt", is the gate signal generated from p4. Since words are easier to
remember than numbers, "palias" is used to alias p4 to the variable "gt"

## Note Sequencer
This chunk of code is in charge of producing the arpeggiation sequence.

The first thing is to get the base note from the keyboard UI. 
**tport** is used instead of **port** so that the initial note-on event
does not gliss from the previous note.
The keyboard is biased around middle C (60), and then assigned to 
the variable *key*. 

    5 p (4 p 0.5 0 thresh) 0.05 tport 60 + _key set

The line below is a bit of logic required to work with the keyboard
UI. This is also tricky to read, so I added parentheses for clarity.
Because of the way the keyboard signal works, the signal needs to only change
notes when a keyboard note is greater than 0. To do this, a **samphold**
is used. tick is also used to ensure that a note is assigned at the
start of the patch. 

Bear in mind that the samphold value remains on the stack to be processed
later.

    _key get (tick _key get 0 gt +) samphold

The next step is to generate a phasor signal. A phasor will generated a 
saw wave from 0 to 1, which can then be scaled and fed into table lookup 
unit generators. 
The phasor generator that will be used for the arpeggiator will have 
ability to reset itself to 0 at the start of the note. This signal
expects a trigger, but the keyboard produces a gate. Thus, **thresh**
is used:

    _gt get 0.5 0 thresh

From there, the frequency of the phasor is calculated. The BPM
is converted to frequency using bpm2rate. The rate of the sequencer
is normalized by the sequencer length so that the notes are the same
duration. The phase parameter for tphasor is set to 0. This entire signal
is then fed into the variable *phsr*.

    _bpm get bpm2rate 4 _seqlen get / * 0 tphasor _phsr set

The phasor signal is immediately retrieved, scaled, and floored by the 
sequencer length. This value becomes the index parameter for the table *seq*.
Remember that the signal generated from samphold is still on the stack. 
The value produced from **tget** is added on to this signal, and then 
assigned to the variable *note*.

    _phsr get _seqlen get * floor _seq tget +
    _note set

## Oscillators
Once the arpeggiation has been computed, it can be fed into the
sound source: three detuned bandlimited sawtooth oscillators.
The first oscillator has no detune parameter.

    _note get 0.001 port mtof 0.3 saw

The second oscillator is detuned sharp. To add variety, the detuned
parameter is scaled by 12.3 percent.

    _note get _det get 1.123 * + 0.001 port mtof 0.3 saw +

The final oscillator is detuned flat. 

    _note get _det get - 0.001 port mtof 0.3 saw +

## Filter Sequencer
In addition to sequencing the notes, there is also a sequence of 
filter resonances that move in time. This one has some subtle sound
engineering (it tooke me a while to figure out what I was trying to do!)

Similar to the note sequencer, the phasor signal is scaled and floored,
this time being fed into the filter table sequencer.

    _phsr get _seqlen get * floor _filt tget

To add some nuance, an adsr envelope is applied to the filter frequency
control signal. The signal is duplicated and fed into the crossfade 
unit generator **cf**, with a mix of 0.7. 

    dup
    _gt get 1.3 0.2 0.9 0.4 adsr * 
    0.7 cf

To prevent clicks, some small portamento is added to the filter frequency
sequencer. 

    0.001 port

Finally, the resonance is retrieved from the variable *res*, and the 
sawtooth signal is fed into the moog filter ugen **moogladder**.

    _res get moogladder

## Sub oscillator
To add some meat, a sub oscillator is created.
The sub oscillator is just a sine wave generator, tuned an octave below
the other oscillators, then added to the rest of the signal.

    _note get 12 - 0.001 port mtof 0.1 sine +

This whole signal is multiplied by an ADSR envelope, fed by the gate 
signal.

    _gt get 0.001 0.1 0.9 0.3 adsr *

To add more brightness, the signal is duplicated. One of the signals is
sent through a highpass filter and boosted. Then, they are added together.

    dup 7000 buthp 3 ampdb * +

With the signal complete, it is assigned to the variable *dry*.

    _dry set

## Effects
The effects processing is pretty standard reverb and delay setup
setup.

The dry signal is first procesed by my favorite reverb unit ReverbSC.

    _dry get dup 0.85 8000 revsc drop -12 ampdb * _dry get +

The dry signal is also processed in parallel with a filtered delay line.
While most filtered delay lines use lowpass filters, this filter is a 
highpass filter with a very high cutoff frequency. The resulting sound is
a "shimmer" in a frequency space that does not compete with any other 
instruments. 

    _dry get 0.75 0.3 delay 6000 buthp -20 ampdb * +


\[[Back](/proj/cook)]

