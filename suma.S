#include <asm.h>

ENTRY(addASM)
	push	%ebp
	mov	%esp, %ebp
	mov	0xc(%ebp), %eax	
	add 	0x8(%ebp), %eax
	pop	%ebp
	ret
