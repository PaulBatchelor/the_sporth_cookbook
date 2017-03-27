{{TITLE}}
 
LSYS is a tiny little language designed to produce l-systems.

## Some LSYS code

A grammar for a classic L-System could look like this:

 a|a:ab|b:a

The code is split up into three slices, delimited by the '|'.
The first slice dictates the initial axiom, 'a'.
The second slice dictates the definition for 'a' to be 'ab'.
The third slice dictates the definition for 'b' to be 'a'.

Once the code has been parsed, it can be used to generate a
list, whose length is determined by the order N:

    N | output
    ----------
    1 | a
    2 | ab 
    3 | aba
    4 | abaab
    5 | abaababa
    6 | abaababaabaab
    7 | abaababaabaababaababa

And so on and so forth...

## LSYS in Sporth

LSYS is implemented as a Sporth UGen, which takes in 
3 arguments. From left to right, they are:

1. trigger signal, which iterates through the L-System
2. The order N of the L-System (init-time only)
3. The code itself.

The signal output by the LSYS ugen a number in 
the range of 0-35, which correspond to the base-36
numbering system:

    0123456789abcdefghijklmnopqrstuvwxyz

In the example above, the signal would be alternating between
10 and 11.

To see the lys ugen in action, see examples/lsys.sp

## LSYS as a standalone

Using the [C code found in Sporth](
https://raw.github.com/PaulBatchelor/Sporth/master/ugens/lsys.c
)
, 
LSYS can also be compiled as a standalone application:

    gcc lsys.c -DLSYS_STANDALONE -o lsys

It can be fed in code and the order as command line arguments:

    ./lsys 5 "01|0:121|1:01|2:1

Which will produce the following string:

    01101121011210101101121011210101121010110112101


{{FOOTER}}
