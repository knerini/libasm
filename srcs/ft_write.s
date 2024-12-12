; Data declaration

section .data

SYS_write 	equ  	1					; call code for write system call

extern __errno_location					; call the errno_location C function to set the error for the syscall

; Code section
; Function to write up to n bytes from a buffer to a specified file
; Call:
;	ssize_t ft_write(int fd, const void *buffer, size_t count);

; Arguments passed:
; 1) rdi -> fd
; 2) rsi -> buffer
; 3) rdx -> count

; Returns:
; 1) rax -> number of bytes written (ssize_t)

section .text
global ft_write
ft_write:
	mov		rax, 	SYS_write			; Prepare write syscall
	syscall

	test 	rax, 	rax					; if syscall not failed...
	jge		.end						; ...goto .end; else goto .error;

.error:
	neg		rax							; Error code -> negative value so get the absolute value
	mov		r8,		rax					; Save the result of the write syscall in another register
	call 	__errno_location WRT ..plt
	mov		[rax],	r8					; Put the value of r8 (value of the write syscall) into memory pointed by rax register
	mov		rax,	-1					; Error returns -1  

.end:
	ret 								; return ssize_t;
		
; Stack protection
section .note.GNU-stack
