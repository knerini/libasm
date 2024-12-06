; Data declaration

section .data

enomem 		equ 			12 		; Code for error ENOMEM

%define 	LEN 			rax
%define 	NEW_S 			rax
%define 	S 				rsi

extern __errno_location				; call the errno_location C function to set the error for the syscall
extern malloc						; call the malloc C function
extern ft_strlen					; call the ft_strlen functiom
extern ft_strcpy					; call the ft_strcpy function

; Code section
; Function to return a pointer to a duplicate string with memory allocation
; Call:
;	char *ft_strdup(const char *s);

; Arguments passed:
; 1) rdi -> s

; Returns:
; 1) rax -> NEW_S

section .text
global ft_strdup
ft_strdup:
	mov 	S, 				rdi		; To later call ft_strcpy -> src = s
	call 	ft_strlen				; Get length of s
	add 	LEN,			1		; Add 1 to the length for '\0'

	push	S 						; var1 = s (savec on stack)

	;sub 	rsp, 			8 		; Align the stack register before a call to an extern function
	mov 	rdi, 			LEN		; Prepare the amount of memory to allocate
	call 	malloc WRT ..plt
	;add 	rsp,			8 		; Restore the stack state

	pop 	S 						; s = var1 (retrieve from stack)
	test	NEW_S,			NEW_S	; if malloc call failed...
	je		.error					; ...goto .error;

	mov		rdi,			NEW_S	; To call ft_strcpy -> dest = NEW_S
	call 	ft_strcpy				; Copy s in NEW_S (src in dest) 
	jmp 	.end					; goto .end;

.error:
	call 	__errno_location WRT ..plt 	
	mov		dword [rax], 	enomem	; Copy the error code from memory into rax register
	xor 	rax, 			rax 	; ft_strdup returns NULL if malloc failed

.end:
	ret 							; return NEW_S;
	
		
; Stack protection
section .note.GNU-stack