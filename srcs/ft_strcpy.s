; Data declaration

section .data

%define 	C 			al 			; char c;
%define 	I 			r8  		; int i;
%define 	DEST 		rdi 		; char *dest
%define		SRC 		rsi 		; const char* src

; Code section
; Function to copy a string source into a string dest
; Call:
;	char *ft_strcpy(char *dest, const char *src);

; Arguments passed:
; 1) rdi -> dest
; 2) rsi -> src

; Returns:
; 1) rax -> dest

section .text
global ft_strcpy
ft_strcpy:
	xor 	I, 			I			; i = 0;

.cpy_loop:							; while (src[i])
	mov		C,			[SRC + I]	; c = src[i];
	mov		[DEST + I],	C			; dest[i] = c;
	
	inc		I						; i++;
	
	test	C,			C			; if (src[i] == '\0')...
	jnz 	.cpy_loop				; ...goto .end_of_string; else loop again

.end_of_string:
	mov		rax, 		DEST		; Copy the dest in the rax register used for return
	ret 							; return dest;

; Stack protection
section .note.GNU-stack
