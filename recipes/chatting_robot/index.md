# Chatting Robot

\[[code](/res/cook/chatting_robot.sp)]

"Chatting Robot", also known as "computer talking on the phone with his 
Mother", is a patch centered around a rudimentary vowel synthesis 
technique. This technique involves an approximate glottal excitation 
signal sent through three bandpass filters tuned at specific formant
frequencies.
## Table generation
The tables are used to store parameters for the three bandpass filters. 
Tables are used to interpolate between three different states, each corresponding
to a different vowel sound:

- position 0 is an 'o' sound
- position 1 is an 'a' sound
- position 2 is an 'e' sound

The interpolation between the states allows the voice to smoothly morph 
between vowels.

Tables *f1*, *f2*, and *f3* correspond to the first, second, and third
bandfilters, respectively.

    # o a e
    'f1' '350 600 400' gen_vals
    'f2' '600 1040 1620' gen_vals
    'f3' '2400 2250 2400' gen_vals

Tables *g1*, *g2*, and *g3* correspond to the gains of the bandpass filters.

    'g1' '1 1 1' gen_vals
    'g2' '0.28184 0.4468 0.251' gen_vals
    'g3' '0.0891 0.354 0.354' gen_vals

Tables *bw1*, *bw2*, and *bw3* correspond to the bandwidths of the bandpass
filters.

    'bw1' '40 60 40' gen_vals
    'bw2' '80 70 80' gen_vals
    'bw3' '100 110 100' gen_vals

## Jitter
The jitter signal is in charge of morphing between the vowel sounds. The 
core of the jitter signal is **randi**, who range and between 0 and 2, 
and whose speed is modulated by a sine wave between 2 and 10. 

The output signal is then copied to p-register 0. 

    0 2
    0.1 1 sine 2 10 biscale
    randi 0 pset

## Glottis 
To simulate the glottis, a bandlimited pulse oscillator is used with a 
now pulse width, or duty cycle. 

The frequency of the glottis is randomly modulated with another **randi**
jitter signal in the range of 110 and 200 Hz. The rate of change is modulated 
with a sine wave in the range of 2 and 8 Hz. 

    110 200 0.8 1 sine 2 8 biscale randi 

Additional deviation is added using jitter.

    3 20 30 jitter + 

Finally, the rest of *square*, with an amplitude of 0.2 and a pulse width of
0.1.

    0.2 0.1 square
    dup

## Resonant Cavities
The glottal signal is fed through three bandpass filters in series to generate
vowel sounds. 

As mentioned in the previous section, parameters are linearly interpolated 
between three states in order to morph between vowel sounds. The 
interpolation is done using *tabread*. 

    0 p 0 0 0 'g1' tabread *
    0 p 0 0 0 'f1' tabread
    0 p 0 0 0 'bw1' tabread
    butbp

and here are the other two filters...

    swap dup
    0 p 0 0 0 'g2' tabread *
    0 p 0 0 0 'f2' tabread
    0 p 0 0 0 'bw2' tabread
    butbp
    swap
    0 p 0 0 0 'g3' tabread *
    0 p 0 0 0 'f3' tabread
    0 p 0 0 0 'bw3' tabread
    butbp
    + +

## Words
The signal generated up to this point is pretty good, but it is a 
endless babble with no breaks.
It would be good to add some pockets of silence to add space and create
words and phrases.
This effecting is created using a makeshifte envelope generator, built
from a maygate and a portamento filter. The maygate is being fed by 
a dmetro, sending off a tick every 400 milliseconds.

    0.4 dmetro 0.5 maygate 0.01 port * 2.0 *

## Effects
Finally, the resulting signal is sent into **zitareverb**. 

    dup
    60 500 3.0 1.0 6000
    315 6
    2000 0
    0.2 2 zitarev drop

