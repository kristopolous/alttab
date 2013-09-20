# alt-tab project

See [here](https://www.youtube.com/watch?v=Qo5HvhJ3Qic) for a demo video.

## Syntax

Placing the following with your query:
 * ` before will iconify the windows that don't match.
 * -9 after will kill the matching windows.
 * PCRE regex is not supported - partial regex makes it crash (woops)
 * [tab] will cycle through matching windows, shift + [tab] will go backwards.
 * & after will execute the program

# Install

$ sudo apt-get install libio-pty-easy-perl xdotool xosd-bin
