# 1 "suma.S"
# 1 "<built-in>"
# 1 "<command-line>"
# 31 "<command-line>"
# 1 "/usr/include/stdc-predef.h" 1 3 4
# 32 "<command-line>" 2
# 1 "suma.S"
# 1 "include/asm.h" 1
# 2 "suma.S" 2

.globl addASM; .type addASM, @function; .align 0; addASM:
 push %ebp
 mov %esp, %ebp
 mov 0xc(%ebp), %eax
 add 0x8(%ebp), %eax
 pop %ebp
 ret
