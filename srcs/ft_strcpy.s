; Data declaration

section .data

; **********

; Code section
; Function to copy a string source into a string dest
; Call:
;	ft_strcpy(dest, src);

; Arguments passed:
; 1) rdi - address of destination string
; 2) rsi - address of source string

; Returns:
; 1) rax - address of destination string

section .text
global ft_strcpy
ft_strcpy:
	xor 	r8, 	r8					; r8 = 0, count initialized to 0

_cpy_loop:
	mov		al,				[rsi + r8]	; Copy src char in intermediary register
	mov		[rdi + r8],		al			; Copy the char in intermediary register in the dest
	inc		r8							; Increment to go to next char
	test	al,				al			; Check if it's \0
	jnz 	_cpy_loop					; Process again if it's not \0

_end_of_string:
	mov		rax, rdi					; Copy the dest in the rax register used for return
	ret 								; Return dest string in rax register

; Stack protection
section .note.GNU-stack
