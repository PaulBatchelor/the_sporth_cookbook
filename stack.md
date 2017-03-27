{{TITLE}}

Sporth is a stack-based language, largely inspired by languages like Forth and
Postscript. In fact, Sporth is a blending of the words "Soundpipe" and "Forth".
Understanding how the stack works is key to effectively using Sporth.

A stack in computer science is a simple data structure, typically implemented
inside an array. Items can be *pushed* to the stack and *popped* off the stack.
For this reason, a stack is also known as a Last In, First Out (LIFO) data type.

In stack-based languages like Sporth, the stack is the means for how data is 
exchanged. For this reason, arguments precede function calls. This can be seen
in the A440 sine seen in the previous chapter:

    440 0.5 sine

In this code, the numbers "440" and "0.5" are arguments to the sine generator,
for both frequency and amplitude, respectively. This patch code be broken down
into stack operations:

- push 440 onto the stack
- push 0.5 onto the stack
- call the sine function
- sine pops 0.5 off the stack, assigns it to amplitude
- sine pops 440 off the stack, assigns it to frequency
- sine computes a sample, and pushes this value onto the stack
- sine sample gets popped off the stack, and sent to the speaker

Monophonic Sporth patches will always have a value left on the stack meant for
the speaker. This value should be in the range (-1, 1). In this patch, 
the sine generator is responsible for producing this last value. This sine generator
is known as a "unit generator" or "ugen". Ugens are the core means of producing 
sound and signal alike. Sporth has over 
100 unit generators. These unit generators can be used together to build up
very complex patches. 

The patch below now has two sine waves being summed together. The frequencies
produce a North American dial tone on phones:

    440 0.3 sine
    350 0.3 sine
    +

In this patch, a 440hz sine is created, followed by a 330hz. These signals 
are then summed together with the '+' operator.

In stack operations, this works as follows:
- push 440 onto the stack
- push 0.3 onto the stack
- call the sine ugen 
- sine pops 0.3 off the stack, assigns it to amplitude
- sine pops 440 off the stack, assigns it to frequency
- sine computes a sample, and pushes this value onto the stack
- push 350 onto the stack
- push 0.3 onto the stack
- call the sine ugen
- sine pops 0.3 off the stack, assigns it to amplitude
- sine pops 350 off the stack, assigns it to frequency
- sine computes a sample, and pushes this value onto the stack
- call the addition (+) ugen
- addition pops the two computed sine values on the stack
- addition adds these values together, and pushes this new value onto the stack
- sine sample gets popped off the stack, and sent to the speaker

Despite the fact that all unit generators are audio-rate, they 
don't necessarily need to be used to generate audio. They
are perfectly content being used to generate signals. In fact, the differences
between a control signal and an audio signal is rather arbitrary. This is important.

This patch below uses
a sine wave to control the frequency of another sine wave: 

    6 40 sine 
    440 + 0.3 sine

The first sine wave is 6 Hz with an amplitude of 40, which means the signal 
has a range (-40, 40).  This signal is then being
added to the constant value of 440. This addition operation causes this value
to go up 40 to 480 and down 40 to 400. This value feeds into the frequency 
argument of *another* sine wave with an amplitude of 0.3. 

Sporth is largely whitespace insensitive. This patch could all be written
on one line as follows:

    6 40 sine 440 + 0.3 sine

Parentheses are ignored. They can be used as a means to group things:

    ((6 40 sine) 440 +) 0.3 sine

Hopefully that looks a little bit clearer. 

Study this patch. The stack operations create an implied signal flow. Being
able to see the signal path in this configuration is a good first step
in developing an intution for modular sound design.

{{FOOTER}}
