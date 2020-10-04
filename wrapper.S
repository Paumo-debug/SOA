#include <asm.h>

ENTRY(write)
	pushl	%ebp
	movl	%esp,	%ebp

	//move the parameters to ebx, ecx, edx
	movl	8(%ebp),	%ebx
	movl	12(%ebp),	%ecx
	movl	16(%ebp),	%edx
	movl	$0x04,	%eax	//identifier of the system call (number 4 for write) in the eax register	

	pushl	%ecx
	pushl	%edx
	pushl	$return_address
	
	//creates a fake dynamic link
	pushl	%ebp		//points to the top of the user stack and it can be used from the handler in system mode to access any user value easily
	movl	%esp,	%ebp
	sysenter

return_address:
	//remove the temporal data / delete stack parameters
	popl	%ebp
	addl	$4,	%esp	//skips the pushl made for the $return_address
	popl	%edx
	popl	%ecx
	cmp	$0, %eax
	jl	process_result	//if %eax is negative we process the result
	//movl	%ebp,	&esp
	popl	%ebp
	ret

process_result:
	neg	%eax		//absolute value of the return
	mov	%eax,	errno	//save the absolute value of the return in a error variable defined in the library as errno
	mov	$-1,	%eax	//return -1 to the user to notify that the system call has an error
	//movl	%ebp,	&esp
	popl	%ebp
	ret
