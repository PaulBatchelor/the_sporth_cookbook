{{TITLE}}

Polysporth is an engine for polyphony in Sporth. Bindings for polysporth are
written in the scheme dialect tinyscheme, included inside of Sporth. 

## Why Polysporth?

Sporth does a few things really well: it's simple, it's fast to write, and it's
capable of building very complex signal chains. Sporth also does a few things
quite poorly: concepts like events and notes are non-existent in Sporth, and 
polyphony is quite limited. Thus, an engine was built to enable these concepts.
Polyphonic + Sporth = Polysporth!

Some of the features include:

- Embedded scheme language (abstractions!)
- a voice allocation system for individual notes
- a note scheduler
- plugin design

## How it works

Polysporth is called inside of Sporth, where a scheme file is loaded.
Inside the scheme file, different chunks of sporth code are defined called 
sporthlets. Sporthlets can be individually scheduled to be be turned on and off. 

## More information

This chapter is really a gist of Polysporth. It's still in a very
early phase. To learn more, be sure to check out the dedicated 
[Polysporth project page](/proj/polysporth.html).

{{FOOTER}}
