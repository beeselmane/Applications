.section __TEXT,__text
.align 4

.extern _NSApplicationMain
.globl _main

_main:
    pushq %rbp
    movq %rsp, %rbp
    callq _NSApplicationMain
    popq %rbp
    ret
