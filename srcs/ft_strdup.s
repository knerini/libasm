; Data declaration

section .data

extern __errno_location		; call the errno_location function to set the error for the syscall
extern malloc				; call the malloc function
extern ft_strlen			; call the ft_strlen functiom
extern ft_strcpy			; call the ft_strcpy function

; Code section
; Function to return a pointer to a duplicate string with memory allocation
; Call:
;	ft_strdup(s);

; Arguments passed:
; 1) rdi - the string to duplicate

; Returns:
; 1) rax - the pointer to the duplicated string

section .text
global ft_strdup
ft_strdup:
	mov 	rsi, 		rdi				; Save the string to duplicate in rsi register to call ft_strcpy later 
	call 	ft_strlen					; Pass the string in rdi register to get its length
	add 	rax,		1				; Add 1 to the ft_strlen result for '\0'
	push	rsi 						; Save rsi register on the stack before the call to malloc
	mov 	rdi, 		rax				; Pass the result of ft_strlen to the rdi register
	call 	malloc WRT ..plt
	pop 	rsi 						; Get back the rsi register from the stack
	test	rax,		rax				; Check if malloc returns null in case of error
	je		_error						; If it's null jump to error section
	mov		rdi,	rax					; Put the result of malloc in rdi register to prepare call to ft_strcpy
	call 	ft_strcpy					; Use ft_strcpy to copy the string in the new allocated memory space
	jmp 	_end

_error:
	call 	__errno_location WRT ..plt 	; Call the extern C function __errno_location to get the pointer to the errno variable (WRT = With Respect To // plt = function call via Procedure Linkage Table)
	mov		dword [rax], 		12		; As the address of errno variable is in rax register, put ENOMEM code in it by dereferencing the address
	xor 	rax, 		rax 			; Has to return null for ft_strdup

_end:
	ret
	
		
; Stack protection
section .note.GNU-stack