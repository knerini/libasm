; Data declaration

section .data

%define 	S1			rdi				; char *s1;
%define 	S2 			rsi 			; char *s2;
%define 	C1 			al 				; char c1;
%define		C2			bl 				; char c2;
%define		I 			r8 				; int i;

; Code section
; Function to compare two strings lexicographically
; Call:
;	int ft_strcmp(const char *s1, const char *s2);

; Arguments passed:
; 1) rdi -> s1
; 2) rsi -> s2

; Returns:
; 1) rax -> 0 if s1 and s2 are equal, positive integer if s1 > s2, negative integer if s1 < s2

section .text
global ft_strcmp
ft_strcmp:
	xor		I,			I				; i = 0;

.cmp_loop:								; while (s1[i])
	mov		C1,			byte [S1 + I]	; c1 = s1[i];
	mov		C2,			byte [S2 + I]	; c2 = s2[i];
	
	sub 	C1,			C2				; if (c1 - c2 != 0)...
	jne		.end						; ...goto .end; 
	
	cmp 	[S1 + I],	byte 0			; if (s1[i] == '\0')...
	jz		.end						; ...goto .end;
	
	inc		I							; i++;
	jmp 	.cmp_loop					; Loop again

.end:
	movsx	rax,		C1 				; Widening signed conversion to return the result in rax
	ret 								; return c1;

; Stack protection
section .note.GNU-stack