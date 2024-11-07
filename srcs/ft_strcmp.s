; Data declaration

section .data

; **********

; Code section
; Function to compare two strings lexicographically
; Call:
;	ft_strcmp(s1, s2);

; Arguments passed:
; 1) rdi - address of s1
; 2) rsi - address of s2

; Returns:
; 1) rax - 0 if s1 and s2 are equal, positive integer if s1 > s2, negative integer if s1 < s2

section .text
global ft_strcmp
ft_strcmp:
	xor		r8,			r8					; r8 = 0, count initialized to 0

_cmp_loop:
	mov		al,			byte [rdi + r8]		; Put the s1 actual byte in the al register to prepare ascii substraction
	mov		bl,			byte [rsi + r8]		; Put the s2 actual byte in the bl register to prepare ascii substraction
	sub 	al,			bl					; Proceed the the substraction
	jne		_end							; If the result is not equal to 0, s1 and s2 are not equal, jump to the end section
	cmp 	[rdi + r8],	byte 0				; Compare the null terminated '/0'
	jz		_end							; Jump to the end section if it's the '/0'
	inc		r8								; Increment to go to next char
	jmp 	_cmp_loop						; Process again

_end:
	movsx	rax,		al 					; Widening signed conversion to return the result in rax
	ret 

; Stack protection
section .note.GNU-stack