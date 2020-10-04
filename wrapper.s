# 1 "wrapper.S"
# 1 "<built-in>"
# 1 "<command-line>"
# 31 "<command-line>"
# 1 "/usr/include/stdc-predef.h" 1 3 4
# 32 "<command-line>" 2
# 1 "wrapper.S"
# 1 "include/asm.h" 1
# 2 "wrapper.S" 2

.globl write; .type write, @function; .align 0; write:
 pushl %ebp
 movl %esp, %ebp


 movl 8(%ebp), %ebx
 movl 12(%ebp), %ecx
 movl 16(%ebp), %edx
 movl $0x04, %eax

 pushl %ecx
 pushl %edx
 pushl $return_address


 pushl %ebp
 movl %esp, %ebp
 sysenter

return_address:

 popl %ebp
 addl $4, %esp
 popl %edx
 popl %ecx
 cmp $0, %eax
 jl process_result

 popl %ebp
 ret

process_result:
 neg %eax
 mov %eax, errno
 mov $-1, %eax

 popl %ebp
 ret
