# discord-challenge-6-asm-32bit
One Lone Coder Discord Programming Challenge #6 in x86 32bit assembly for Linux

The example follows in the steps of the C++ and 64bit assembly variations of the OLC challenge #6.

I ported the 64bit assembly to 32bit so I could compile it on Ideone, where they don't currently support AT&T syntax (GCC)
64bit assembly language.  The original 64bit version was written with memory stored loop counters, but then
was modified to use registers r8-r15 for storing loop counters.  In this version I had to convert it back to memory
stored loop counters because ia32 lacks the extended registers.
