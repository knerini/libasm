; Data declaration

section .data

SYS_read 	equ 	0  					; call code for read system call

extern __errno_location					; call the errno_location C function to set the error for the syscall

; Code section
; Function to read up to count bytes from the fd into the buffer
; Call:
;	ft_read(fd, buf, count);

; Arguments passed:
; 1) rdi - the file descriptor
; 2) rsi - the buffer
; 3) rdx - the size to count

; Returns:
; 1) rax - number of bytes read or 0 if end of file

section .text
global ft_read
ft_read:
	mov		rax, 	SYS_read			; Prepare read syscall
	syscall

	test 	rax, 	rax					; if syscall not failed...
	jge		.end						; ...goto .end; else goto .error;

.error:
	neg		rax							; Error code -> negative value so get the absolute value
	mov		r8,		rax					; Save the result of the read syscall in another register
	call 	__errno_location WRT ..plt
	mov		[rax],	r8					; Put the value of r8 (value of the write syscall) into memory pointed by rax register
	mov		rax,	-1					; Error returns -1 

.end:
	ret 								; return ssize_t
		
; Stack protection
section .note.GNU-stack