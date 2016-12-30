.section __TEXT,__text
.align 4

.extern _NSApplicationMain
.extern _exit
.globl _main

_main:
    pushq %rbp                  // Save stack base pointer
    callq _NSApplicationMain    // Call Application Main
    movq %rax, %rdi             // Save return value to first argument register
    popq %rbp                   // Pop Base Pointer
    callq _exit                 // Call exit() with return value of NSApplicationMain()
