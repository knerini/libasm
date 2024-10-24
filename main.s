; Data declaration

section .data

; ----Define standard constants---

LF				equ		10		; line feed
NULL			equ		0		; end of string

EXIT_SUCCESS	equ		0		; success code

STDOUT 			equ 	1	 	; standard output
SYS_write 		equ 	1		; call code for write
SYS_exit		equ		60		; terminate programe

; ----Define variables---

str1			db		"Hello word", LF, NULL
str2			db		"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin ut ex nec neque placerat sagittis at at nulla. Etiam in nulla justo. Interdum et malesuada fames ac ante ipsum primis in faucibus. Pellentesque a mi magna. Vestibulum pellentesque nisi id felis faucibus, a consectetur orci molestie. Etiam tempor sed justo nec hendrerit. Integer quis est leo. Integer rutrum, mauris sit amet tempus dignissim, ligula leo dapibus tortor, a bibendum velit nisl a erat. Integer nibh velit, gravida vitae ut.", LF, NULL
str3			db 		"", LF, NULL

; ----Call of extern functions----

extern ft_strlen


; Code section

section .text

global main
main:
	lea		rdi,	[rel str1]	; address of str1
	call 	ft_strlen
	mov		rbx,	rdi			; save address in another register to get back rdi
	mov 	rcx,	rax			; save ft_strlen result in another register to get back rax

	; write system call
	mov 	rax,	SYS_write 	; call code for system write
	mov 	rdi,	STDOUT		; output location to put in rdi for system write
	mov 	rsi,	rbx			; system write need the address of string in rsi register
	mov		rdx,	rcx			; system write need the length to count in rdx register
	
	syscall

	lea		rdi,	[rel str2]	; address of str2
	call 	ft_strlen
	mov		rbx,	rdi			; save address in another register to get back rdi
	mov 	rcx,	rax			; save ft_strlen result in another register to get back rax

	; write system call
	mov 	rax,	SYS_write 	; call code for system write
	mov 	rdi,	STDOUT		; output location to put in rdi for system write
	mov 	rsi,	rbx			; system write need the address of string in rsi register
	mov		rdx,	rcx			; system write need the length to count in rdx register
	
	syscall

	lea		rdi,	[rel str3]	; address of str3
	call 	ft_strlen
	mov		rbx,	rdi			; save address in another register to get back rdi
	mov 	rcx,	rax			; save ft_strlen result in another register to get back rax

	; write system call
	mov 	rax,	SYS_write 	; call code for system write
	mov 	rdi,	STDOUT		; output location to put in rdi for system write
	mov 	rsi,	rbx			; system write need the address of string in rsi register
	mov		rdx,	rcx			; system write need the length to count in rdx register

	syscall

	; program done
	mov 	rax,	SYS_exit
	mov 	rdi,	EXIT_SUCCESS
	syscall




