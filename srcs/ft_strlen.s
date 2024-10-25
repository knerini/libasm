; Data declaration

section .data

; **********

; Code section
; Function to return the length of a string
; Call:
;	ft_strlen(str);

; Arguments passed:
; 1) rdi - address of string

; Returns:
; 1) rax - length of the string

section .text
global ft_strlen
ft_strlen:
	xor		rax,	rax				; rax = 0, count initialized to 0

_next_char:
	cmp 	[rdi + rax],	byte 0 	; Compare the null terminated '/0'
	jz 		_end_of_string			; Jump to the end section if it's the '/0'
	inc 	rax						; It's a char to count, and increment to go to next char
	jmp 	_next_char				; Process again

_end_of_string:
	ret 							; Return the lenght in rax

; Stack protection
section .note.GNU-stack