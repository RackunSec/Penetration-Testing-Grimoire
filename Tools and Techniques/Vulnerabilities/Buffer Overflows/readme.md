# Buffer Overflows
A [buffer overflow](https://en.wikipedia.org/wiki/Buffer_overflow) is an anomaly where a program, while writing data to a buffer, overruns the buffer's boundary and overwrites adjacent memory locations. 
## Remote Buffer Overflows
In this document I analyze a binary that was pulled from a remote system. This binary is a service that runs on port 9999 of the Brainpan VulnHUB.com exercise.

## Local Buffer Overflow
Have you found a Linux ELF binary that shows signs of homebrew and is SUID to root? Let's analyze a binary as an exercise to apply to future findings. In this sheet I will be using the Barinpan VulnHUB.com lab exercise.
