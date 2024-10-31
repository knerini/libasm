; Data declaration

section .data

; ----Define standard constants---

LF				equ		10		; line feed
NULL			equ		0		; end of string

EXIT_SUCCESS	equ		0		; success code

STDOUT 			equ 	1	 	; standard output
SYS_write 		equ 	1		; call code for write
SYS_exit		equ		60		; call code for exit, terminate programe

; ----Define variables---

str1			db		"Hello word", LF, NULL
str2			db		"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin ut ex nec neque placerat sagittis at at nulla. Etiam in nulla justo. Interdum et malesuada fames ac ante ipsum primis in faucibus. Pellentesque a mi magna. Vestibulum pellentesque nisi id felis faucibus, a consectetur orci molestie. Etiam tempor sed justo nec hendrerit. Integer quis est leo. Integer rutrum, mauris sit amet tempus dignissim, ligula leo dapibus tortor, a bibendum velit nisl a erat. Integer nibh velit, gravida vitae ut.", LF, NULL
str3			db 		"", LF, NULL

; ----Call of extern functions----

extern ft_strlen
extern ft_strcpy



; Code section

section .text

global main
main:

	; -----------------------
	; ----ft_strlen tests----
	; -----------------------

	; ++++++++++++++
	; ++++ str1 ++++
	; ++++++++++++++

	lea		rdi,	[rel str1]	; address of str1
	call 	ft_strlen
	mov		rbx,	rdi			; save address in another register to get back rdi
	mov 	rcx,	rax			; save ft_strlen result in another register to get back rax

	; write system call
	mov 	rax,	SYS_write 	; call code for system write
	mov 	rdi,	STDOUT		; output location to put in rdi for system write
	mov 	rsi,	rbx			; system write needs the address of string in rsi register
	mov		rdx,	rcx			; system write needs the length to count in rdx register
	syscall

	; ++++++++++++++
	; ++++ str2 ++++
	; ++++++++++++++

	lea		rdi,	[rel str2]	; address of str2
	call 	ft_strlen
	mov		rbx,	rdi			; save address in another register to get back rdi
	mov 	rcx,	rax			; save ft_strlen result in another register to get back rax

	; write system call
	mov 	rax,	SYS_write 	; call code for system write
	mov 	rdi,	STDOUT		; output location to put in rdi for system write
	mov 	rsi,	rbx			; system write needs the address of string in rsi register
	mov		rdx,	rcx			; system write needs the length to count in rdx register
	syscall

	; ++++++++++++++
	; ++++ str3 ++++
	; ++++++++++++++

	lea		rdi,	[rel str3]	; address of str3
	call 	ft_strlen
	mov		rbx,	rdi			; save address in another register to get back rdi
	mov 	rcx,	rax			; save ft_strlen result in another register to get back rax

	; write system call
	mov 	rax,	SYS_write 	; call code for system write
	mov 	rdi,	STDOUT		; output location to put in rdi for system write
	mov 	rsi,	rbx			; system write needs the address of string in rsi register
	mov		rdx,	rcx			; system write need sthe length to count in rdx register
	syscall



	; -----------------------
	; ----ft_strcpy tests----
	; -----------------------

	; ++++++++++++++
	; ++++ str1 ++++
	; ++++++++++++++

	lea		rdi,	[rel str1]	; address of str1
	call 	ft_strlen
	mov		rcx,	rax			; save ft_strlen result in another register to get back rax
	add 	rcx,	1 			; add 1 to the length for \0

	; prepare the memory allocation on the stack to obtain a multiple of 16 to keep alignment
	add 	rcx,	15			; add 15 for alignment
	and 	rcx,	-16			; AND operation to get the multiple of 16 that is greater than or equal
	mov		r8,		rcx			; store aligned length to free the memory later

	; memory allocation on the stack
	sub		rsp,	rcx			; reserving the length in rcx register 
	mov 	rdi,	rsp			; load destination address
	lea		rsi,	[rel str1]	; address of str1
	
	; ft_strcpy call
	call 	ft_strcpy

	; write the dest using ft_strlen
	mov 	rdi, 	rax			; save the result of ft_strcpy in rdi to use ft_strlen
	call 	ft_strlen
	mov 	rbx,	rdi			; save address in another register to get back rdi register
	mov 	rcx,	rax			; save ft_strlen result to get back the rax register
	mov 	rax, 	SYS_write
	mov 	rdi,	STDOUT
	mov 	rsi, 	rbx
	mov 	rdx,	rcx
	syscall

	; free the memory allocation of the stack
	add 	rsp,	r8			; get back rsp register with the same amount of memory

	; ++++++++++++++
	; ++++ str2 ++++
	; ++++++++++++++

	lea		rdi,	[rel str2]	; address of str2
	call 	ft_strlen
	mov		rcx,	rax			; save ft_strlen result in another register to get back rax
	add 	rcx,	1 			; add 1 to the length for \0

	; prepare the memory allocation on the stack to obtain a multiple of 16 to keep alignment
	add 	rcx,	15			; add 15 for alignment
	and 	rcx,	-16			; AND operation to get the multiple of 16 that is greater than or equal
	mov		r8,		rcx			; store aligned length to free the memory later

	; memory allocation on the stack
	sub		rsp,	rcx			; reserving the length in rcx register 
	mov 	rdi,	rsp			; load destination address
	lea		rsi,	[rel str2]	; address of str2
	
	; ft_strcpy call
	call 	ft_strcpy

	; write the dest using ft_strlen
	mov 	rdi, 	rax			; save the result of ft_strcpy in rdi to use ft_strlen
	call 	ft_strlen
	mov 	rbx,	rdi			; save address in another register to get back rdi register
	mov 	rcx,	rax			; save ft_strlen result to get back the rax register
	mov 	rax, 	SYS_write
	mov 	rdi,	STDOUT
	mov 	rsi, 	rbx
	mov 	rdx,	rcx
	syscall

	; free the memory allocation of the stack
	add 	rsp,	r8			; get back rsp register with the same amount of memory

	; ++++++++++++++
	; ++++ str3 ++++
	; ++++++++++++++

	lea		rdi,	[rel str3]	; address of str3
	call 	ft_strlen
	mov		rcx,	rax			; save ft_strlen result in another register to get back rax
	add 	rcx,	1 			; add 1 to the length for \0

	; prepare the memory allocation on the stack to obtain a multiple of 16 to keep alignment
	add 	rcx,	15			; add 15 for alignment
	and 	rcx,	-16			; AND operation to get the multiple of 16 that is greater than or equal
	mov		r8,		rcx			; store aligned length to free the memory later

	; memory allocation on the stack
	sub		rsp,	rcx			; reserving the length in rcx register 
	mov 	rdi,	rsp			; load destination address
	lea		rsi,	[rel str3]	; address of str3
	
	; ft_strcpy call
	call 	ft_strcpy

	; write the dest using ft_strlen
	mov 	rdi, 	rax			; save the result of ft_strcpy in rdi to use ft_strlen
	call 	ft_strlen
	mov 	rbx,	rdi			; save address in another register to get back rdi register
	mov 	rcx,	rax			; save ft_strlen result to get back the rax register
	mov 	rax, 	SYS_write
	mov 	rdi,	STDOUT
	mov 	rsi, 	rbx
	mov 	rdx,	rcx
	syscall

	; free the memory allocation of the stack
	add 	rsp,	r8			; get back rsp register with the same amount of memory



	; --------------------
	; ----program done----
	; --------------------
	mov 	rax,	SYS_exit
	mov 	rdi,	EXIT_SUCCESS
	syscall

; Stack protection
section .note.GNU-stack