.section __TEXT,__text
.align 4

.extern _NSApplicationMain
.extern _gb
.globl _main

_main:
    pushq %rbp
    callq _gb
    //callq _NSApplicationMain
    popq %rbp
    ret