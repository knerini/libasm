; Data declaration

section .data

; ----Define standard constants---

LF				equ		10			; line feed
NULL			equ		0			; end of string

EXIT_SUCCESS	equ		0			; success code

STDOUT 			equ 	1	 		; standard output
O_RDONLY 		equ 	0			; read only
SYS_open		equ		2			; call code for open
SYS_close 		equ 	3 			; call code for close
SYS_exit		equ		60			; call code for exit, terminate programe

; ----Define variables----

nested			db		"----Nested test----", LF, NULL
read 			db		"----Read test----", LF, NULL
comp			db		"----Comp test----", LF, NULL
comp_res		db		"Comp result : %d", LF, NULL
vs1				db 		"++str1 vs str2++", LF, NULL
vs2 			db    	"++str2 vs str1++", LF, NULL
vs3 			db 		"++str1 vs str3++", LF, NULL
nl 				db 		LF, NULL
s 				db 		"This sentence is a duplicate string displayed on STDOUT using ft_strdup and ft_write in assembly. Also ft_strdup is using ft_strlen and ft_strcpy to work.", LF, NULL
filename		db		"main.c", NULL

str1			db		"Hello world", LF, NULL
str2 			db		"Hello World", LF, NULL
str3 			db		"Hello world", LF, NULL

; ----Call of extern functions----

extern ft_strlen
extern ft_strcpy
extern ft_strcmp
extern ft_strdup
extern ft_read
extern ft_write
extern free 						; C function
;extern malloc						; C function
extern printf						; C function



; Memory section

section .bss

buffer 			resb 	100			; 100 bytes buffer reserved on heap



; Code section

section .text

global main
main:

	; ---------------------
	; ---- nested test ----
	; ---------------------

	mov 	rdi, 	STDOUT			; Prepare the call to ft_write, rdi register is for file descriptor
	lea 	rsi, 	[rel nested]	; Load the address of string nested in rsi register to prepare the call to ft_write
	mov 	rdx, 	20				; Length of nested string
	call 	ft_write

	; ++++ ft_strdup part ++++

	lea 	rdi, 	[rel s]			; Load the address of string s in rdi register to prepare the call to ft_strdup
	sub 	rsp,	8 				; Align the stack register before a call to an extern function
	call 	ft_strdup
	add 	rsp, 	8 				; Restore the stack state
	push	rax						; Put rax register on the stack to save the pointer to the duplicated string
	
	; ++++ print on stdout part ++++

	mov 	rdi, 	rax				; Prepare the call to ft_strlen
	call 	ft_strlen
	mov 	rdi, 	STDOUT			; Prepare the call to ft_write, rdi register is for file descriptor
	mov 	rsi, 	[rsp]			; Prepare the string saved on the stack, rsi register is for the buffer
	mov 	rdx, 	rax 			; Prepare the length to write, result of ft_strlen
	call 	ft_write

	; ++++ free the allocated memory with ft_strdup ++++

	pop 	rax						; Get back the pointer saved on the stack
	mov 	rdi, 	rax				; Prepare the call to free C function
	call 	free WRT ..plt



	; -----------------
	; ---- ft_read ----
	; -----------------

	mov 	rdi, 	STDOUT			; Prepare the call to ft_write, rdi register is for file descriptor
	lea 	rsi, 	[rel read]		; Load the address of string read in rsi register to prepare the call to ft_write
	mov 	rdx, 	18				; Length of read string
	call 	ft_write

	; ++++ open a file ++++

	mov		rax,	SYS_open 		; Prepare the call system for open
	lea		rdi, 	[rel filename]	; Prepare the file to open
	mov 	rsi, 	O_RDONLY 		; Prepare the flag
	syscall
	mov 	r8, 	rax				; Put the file descriptor in another register

	; ++++ ft_read ++++

	lea 	rsi, 	[rel buffer] 	; Prepare the memory allocated buffer for ft_read
	mov 	rdi, 	r8  			; Prepare the file descriptor
	mov 	rdx, 	100				; Prepare the number of bytes to count
	call 	ft_read

	; ++++ write the buffer ++++

	mov 	rdx, 	rax				; Put the number of bytes read to use it for ft_write
	mov		rdi,	STDOUT			; Prepare the file descriptor to write in it
	lea 	rsi, 	[rel buffer] 	; Prepare the buffer to write from the stack
	call 	ft_write

	; ++++ closing the file ++++

	mov 	rdi,	r8				; Prepapre the file descriptor to close
	mov 	rax, 	SYS_close 		; Prepare the call system for close
	syscall



	; -------------------
	; ---- ft_strcmp ----
	; -------------------

	; ++++ printing ++++

	mov 	rdi, 	STDOUT			; Prepare the call to ft_write, rdi register is for file descriptor
	lea 	rsi, 	[rel nl]		; Load the address of string nl in rsi register to prepare the call to ft_write
	mov 	rdx, 	1				; Length of nl string
	call 	ft_write
	mov 	rdi, 	STDOUT			; Prepare the call to ft_write, rdi register is for file descriptor
	lea 	rsi, 	[rel comp]		; Load the address of string comp in rsi register to prepare the call to ft_write
	mov 	rdx, 	18				; Length of comp string
	call 	ft_write
	mov 	rdi, 	STDOUT			; Prepare the call to ft_write, rdi register is for file descriptor
	lea 	rsi, 	[rel vs1]		; Load the address of string vs1 in rsi register to prepare the call to ft_write
	mov 	rdx, 	17				; Length of vs1 string
	call 	ft_write
	lea 	rdi, 	[rel str1] 		; Load the address of str1 to prepare the call to ft_strlen
	call 	ft_strlen
	mov 	rdx, 	rax				; Put the result of ft_strlen in rdx register to prepare the  of ft_write
	lea 	rsi, 	[rel str1]		; Load the address of str1 to prepare the call to ft_write
	mov 	rdi,  	STDOUT			; Prepare the call to ft_write, rdi register is for file descriptor
	call 	ft_write
	lea 	rdi, 	[rel str2] 		; Load the address of str2 to prepare the call to ft_strlen
	call 	ft_strlen
	mov 	rdx, 	rax				; Put the result of ft_strlen in rdx register to prepare the of ft_write
	lea 	rsi, 	[rel str2]		; Load the address of str2 to prepare the call to ft_write
	mov 	rdi,  	STDOUT			; Prepare the call to ft_write, rdi register is for file descriptor
	call 	ft_write

	; ++++ ft_strcmp ++++

	lea		rdi,	[rel str1]		; Load the address of the first string to compare
	lea 	rsi, 	[rel str2] 		; Load the address of the second string to compare
	call 	ft_strcmp

	; ++++ printf call ++++

	lea 	rdi, 	[rel comp_res]	; Load the address of format string to prepare the call to printf
	mov		rsi,	rax				; Put the result of ft_strcmp in rsi register to call printf
	sub 	rsp, 	8 				; Align the stack state on 16 bytes
	call 	printf WRT ..plt
	add 	rsp, 	8 				; Restore the stack state
	xor		rax,	rax				; Reinitialisation of rax register

	; ++++ printing ++++

	mov 	rdi, 	STDOUT			; Prepare the call to ft_write, rdi register is for file descriptor
	lea 	rsi, 	[rel vs2]		; Load the address of string vs2 in rsi register to prepare the call to ft_write
	mov 	rdx, 	17				; Length of vs1 string
	call 	ft_write
	lea 	rdi, 	[rel str2] 		; Load the address of str2 to prepare the call to ft_strlen
	call 	ft_strlen
	mov 	rdx, 	rax				; Put the result of ft_strlen in rdx register to prepare the  of ft_write
	lea 	rsi, 	[rel str2]		; Load the address of str2 to prepare the call to ft_write
	mov 	rdi,  	STDOUT			; Prepare the call to ft_write, rdi register is for file descriptor
	call 	ft_write
	lea 	rdi, 	[rel str1] 		; Load the address of str1 to prepare the call to ft_strlen
	call 	ft_strlen
	mov 	rdx, 	rax				; Put the result of ft_strlen in rdx register to prepare the of ft_write
	lea 	rsi, 	[rel str1]		; Load the address of str1 to prepare the call to ft_write
	mov 	rdi,  	STDOUT			; Prepare the call to ft_write, rdi register is for file descriptor
	call 	ft_write

	; ++++ ft_strcmp ++++

	lea		rdi,	[rel str2]		; Load the address of the first string to compare
	lea 	rsi, 	[rel str1] 		; Load the address of the second string to compare
	call 	ft_strcmp

	; ++++ printf call ++++

	lea 	rdi, 	[rel comp_res]	; Load the address of format string to prepare the call to printf
	mov		rsi,	rax				; Put the result of ft_strcmp in rsi register to call printf
	sub 	rsp, 	8 				; Align the stack state on 16 bytes
	call 	printf WRT ..plt
	add 	rsp, 	8 				; Restore the stack state
	xor		rax,	rax				; Reinitialisation of rax register

	; ++++ printing ++++

	mov 	rdi, 	STDOUT			; Prepare the call to ft_write, rdi register is for file descriptor
	lea 	rsi, 	[rel vs3]		; Load the address of string vs3 in rsi register to prepare the call to ft_write
	mov 	rdx, 	17				; Length of vs1 string
	call 	ft_write
	lea 	rdi, 	[rel str1] 		; Load the address of str1 to prepare the call to ft_strlen
	call 	ft_strlen
	mov 	rdx, 	rax				; Put the result of ft_strlen in rdx register to prepare the  of ft_write
	lea 	rsi, 	[rel str1]		; Load the address of str1 to prepare the call to ft_write
	mov 	rdi,  	STDOUT			; Prepare the call to ft_write, rdi register is for file descriptor
	call 	ft_write
	lea 	rdi, 	[rel str3] 		; Load the address of str3 to prepare the call to ft_strlen
	call 	ft_strlen
	mov 	rdx, 	rax				; Put the result of ft_strlen in rdx register to prepare the of ft_write
	lea 	rsi, 	[rel str3]		; Load the address of str3 to prepare the call to ft_write
	mov 	rdi,  	STDOUT			; Prepare the call to ft_write, rdi register is for file descriptor
	call 	ft_write

	; ++++ ft_strcmp ++++

	lea		rdi,	[rel str1]		; Load the address of the first string to compare
	lea 	rsi, 	[rel str3] 		; Load the address of the second string to compare
	call 	ft_strcmp

	; ++++ printf call ++++

	lea 	rdi, 	[rel comp_res]	; Load the address of format string to prepare the call to printf
	mov		rsi,	rax				; Put the result of ft_strcmp in rsi register to call printf
	sub 	rsp, 	8 				; Align the stack state on 16 bytes
	call 	printf WRT ..plt
	add 	rsp, 	8 				; Restore the stack state
	xor		rax,	rax				; Reinitialisation of rax register



	; --------------------
	; ----program done----
	; --------------------
	mov 	rax,	SYS_exit
	mov 	rdi,	EXIT_SUCCESS
	syscall



; Stack protection
section .note.GNU-stack