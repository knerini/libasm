; Data declaration

section .data

extern __errno_location		; call the errno_location function to set the error for the syscall

; Code section
; Function to write up to n bytes from a buffer to a specified file
; Call:
;	ft_write(fd, buffer, count);

; Arguments passed:
; 1) rdi - the file descriptor
; 2) rsi - the buffer
; 3) rdx - the size to count

; Returns:
; 1) rax - number of bytes written

section .text
global ft_write
ft_write:
	mov		rax, 	1					; Call code for write system call
	syscall
	cmp 	rax, 	0					; Compare the rax register value to 0, after syscall rax contains the number of bytes written or an error code
	jg		_end						; Jump to the end section if rax value is greater than 0

_error:
	neg		rax							; As it's an error code (negative), get the absolute value to get the error code
	mov		r8,		rax					; Save the result of the write syscall in another register
	call 	__errno_location WRT ..plt	; Call the extern C function __errno_location to get the pointer to the errno variable (WRT = With Respect To // plt = function call via Procedure Linkage Table)
	mov		[rax],	r8					; As the address of errno variable is in rax register, put the previously saved error code in it by dereferencing the address
	mov		rax,	-1					; As it's an error, the return has to be '-1'

_end:
	ret
		
; Stack protection
section .note.GNU-stack