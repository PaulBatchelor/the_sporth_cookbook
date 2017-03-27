{{TITLE}}

P-registers were an early way to shared information without using the stack. 
It is simply an array accessible to Sporth where values can be easily 
read/written to. At the moment, there are 16 p-registers. 

Here is a simple patch demonstrating this:

    440 0 pset
    0 p 0.3 sine

In the example above, the value of p-register 0 is being set to 440 via 
**pset**. In the line below, the value of p-register 0 is being read with
**p**.

The very nifty thing about p-registers is that they are trivial to read/write 
from when using the API. P-registers are a fast solution for people who want to quickly
bind values into Sporth (or alternatively, send audio-signals out of sporth). 

A little silly side note on P-registers: the "P" stands for parameter. The term
itself is borrowed from Csound, where p-fields, or parameter fields, are
optional values read from a Csound score. 

{{FOOTER}}
