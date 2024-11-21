; Data declaration

section .data

; **********

; Code section
; Function to return the length of a string
; Call:
;	size_t ft_strlen(const char *str);

; Arguments passed:
; 1) rdi -> str

; Returns:
; 1) rax -> i

section .text
global ft_strlen
ft_strlen:
	xor		rax,	rax				; i = 0;

.next_char:							; while (str[i])
	cmp 	[rdi + rax],	byte 0 	; if (str[i] == '/0')...
	jz 		.end_of_string			; ...goto .end_of_string;

	inc 	rax						; i++;
	jmp 	.next_char				; loop again

.end_of_string:
	ret 							; return i;

; Stack protection
section .note.GNU-stack