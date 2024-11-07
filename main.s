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

str1			db		"Hello world", LF, NULL
str2			db		"Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin ut ex nec neque placerat sagittis at at nulla. Etiam in nulla justo. Interdum et malesuada fames ac ante ipsum primis in faucibus. Pellentesque a mi magna. Vestibulum pellentesque nisi id felis faucibus, a consectetur orci molestie. Etiam tempor sed justo nec hendrerit. Integer quis est leo. Integer rutrum, mauris sit amet tempus dignissim, ligula leo dapibus tortor, a bibendum velit nisl a erat. Integer nibh velit, gravida vitae ut.", LF, NULL
str3			db 		"", LF, NULL
str4			db 		"Hello word", LF, NULL
str5 			db 		"Hello world", LF, NULL
buf_end			db 		0
lf_str 			db 		LF, NULL

; ----Call of extern functions----

extern ft_strlen
extern ft_strcpy
extern ft_strcmp



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



	; -----------------------
	; ----ft_strcmp tests----
	; -----------------------

	; +++++++++++++++++++++
	; ++++ str1 - str5 ++++
	; +++++++++++++++++++++

	lea 	rdi,	[rel str1]	; address of str1
	lea 	rsi, 	[rel str5]	; address of str5
	call 	ft_strcmp
	mov		rdi,	rax			; save the result of ft_strcmp in rdi to call another function

	; call a function to convert int to ascii string
	call int_to_string

	; write the string using ft_strlen
	mov		rdi,	rax			; save the result of int_to_string in rdi to use ft_strlen
	call ft_strlen
	mov 	rbx,	rdi			; save address in another register to get back rdi register
	mov 	rcx,	rax			; save ft_strlen result to get back the rax register
	mov 	rax, 	SYS_write
	mov 	rdi,	STDOUT
	mov 	rsi, 	rbx
	mov 	rdx,	rcx
	syscall

	; newline
	lea 	rsi, 	[rel lf_str]	; address of lf_str
	mov 	rax, 	SYS_write
	mov		rdi, 	STDOUT
	mov 	rdx, 	1 				; length of lf_str
	syscall

	; +++++++++++++++++++++
	; ++++ str1 - str4 ++++
	; +++++++++++++++++++++

	lea 	rdi,	[rel str1]	; address of str1
	lea 	rsi, 	[rel str4]	; address of str4
	call 	ft_strcmp
	mov		rdi,	rax			; save the result of ft_strcmp in rdi to call another function

	; call a function to convert int to ascii string
	call int_to_string

	; write the string using ft_strlen
	mov		rdi,	rax			; save the result of int_to_string in rdi to use ft_strlen
	call ft_strlen
	mov 	rbx,	rdi			; save address in another register to get back rdi register
	mov 	rcx,	rax			; save ft_strlen result to get back the rax register
	mov 	rax, 	SYS_write
	mov 	rdi,	STDOUT
	mov 	rsi, 	rbx
	mov 	rdx,	rcx
	syscall

	; newline
	lea 	rsi, 	[rel lf_str]	; address of lf_str
	mov 	rax, 	SYS_write
	mov		rdi, 	STDOUT
	mov 	rdx, 	1 				; length of lf_str
	syscall

	; +++++++++++++++++++++
	; ++++ str4 - str1 ++++
	; +++++++++++++++++++++

	lea 	rdi,	[rel str4]	; address of str4
	lea 	rsi, 	[rel str1]	; address of str1
	call 	ft_strcmp
	mov		rdi,	rax			; save the result of ft_strcmp in rdi to call another function

	; call a function to convert int to ascii string
	call int_to_string

	; write the string using ft_strlen
	mov		rdi,	rax			; save the result of int_to_string in rdi to use ft_strlen
	call ft_strlen
	mov 	rbx,	rdi			; save address in another register to get back rdi register
	mov 	rcx,	rax			; save ft_strlen result to get back the rax register
	mov 	rax, 	SYS_write
	mov 	rdi,	STDOUT
	mov 	rsi, 	rbx
	mov 	rdx,	rcx
	syscall

	; newline
	lea 	rsi, 	[rel lf_str]	; address of lf_str
	mov 	rax, 	SYS_write
	mov		rdi, 	STDOUT
	mov 	rdx, 	1 				; length of lf_str
	syscall

	; +++++++++++++++++++++
	; ++++ str1 - str3 ++++
	; +++++++++++++++++++++

	lea 	rdi,	[rel str1]	; address of str1
	lea 	rsi, 	[rel str3]	; address of str3
	call 	ft_strcmp
	mov		rdi,	rax			; save the result of ft_strcmp in rdi to call another function

	; call a function to convert int to ascii string
	call int_to_string

	; write the string using ft_strlen
	mov		rdi,	rax			; save the result of int_to_string in rdi to use ft_strlen
	call ft_strlen
	mov 	rbx,	rdi			; save address in another register to get back rdi register
	mov 	rcx,	rax			; save ft_strlen result to get back the rax register
	mov 	rax, 	SYS_write
	mov 	rdi,	STDOUT
	mov 	rsi, 	rbx
	mov 	rdx,	rcx
	syscall

	; newline
	lea 	rsi, 	[rel lf_str]	; address of lf_str
	mov 	rax, 	SYS_write
	mov		rdi, 	STDOUT
	mov 	rdx, 	1 				; length of lf_str
	syscall

	; +++++++++++++++++++++
	; ++++ str3 - str1 ++++
	; +++++++++++++++++++++

	lea 	rdi,	[rel str3]	; address of str3
	lea 	rsi, 	[rel str1]	; address of str1
	call 	ft_strcmp
	mov		rdi,	rax			; save the result of ft_strcmp in rdi to call another function

	; call a function to convert int to ascii string
	call int_to_string

	; write the string using ft_strlen
	mov		rdi,	rax			; save the result of int_to_string in rdi to use ft_strlen
	call ft_strlen
	mov 	rbx,	rdi			; save address in another register to get back rdi register
	mov 	rcx,	rax			; save ft_strlen result to get back the rax register
	mov 	rax, 	SYS_write
	mov 	rdi,	STDOUT
	mov 	rsi, 	rbx
	mov 	rdx,	rcx
	syscall

	; newline
	lea 	rsi, 	[rel lf_str]	; address of lf_str
	mov 	rax, 	SYS_write
	mov		rdi, 	STDOUT
	mov 	rdx, 	1 				; length of lf_str
	syscall



	; --------------------
	; ----program done----
	; --------------------
	mov 	rax,	SYS_exit
	mov 	rdi,	EXIT_SUCCESS
	syscall



int_to_string:
	; Arguments passed :
	; 1) rdi - integer to convert to ascii
	; Returns :
	; 1) rax - string representing the integer

	mov 	rsi, 		0				; initialize rsi register to 0
	mov 	rcx,		10				; divide by 10 to obtain digits
	lea 	rbx,		[rel buf_end]	; rbx is pointing to the end of the buffer
	mov		byte [rbx],	0 				; add null terminated '\0'

	; check the sign of the number
	mov		rax, 		rdi 			; put the number in rax register
	test 	rdi,		rdi				; check if the number is negative
	jge 	_convert_loop				; if the number is positive, the condition is true so jump to the convert section and ignore the negative section

	; handle the negative sign
	neg 	rax							; negate (multiply by -1) the number
	mov 	rsi,		1				; use rsi register remember that the number is negative to write the '-' in the string later

	; convert the number in string
_convert_loop:
	xor		rdx,		rdx				; put the rdx register to 0, used for the remainder of the division
	div 	rcx							; rax register, containing the number, divided by rcx register, quotient put in rax and remainder put in rdx
	add 	dl, 		'0'				; put the lowest part of rdx register as containing an only digit from 0 to 9 and add the ascii value of 0 to it
	dec 	rbx							; decrease the index of the buffer to place the digit at the right place
	mov 	byte [rbx],	dl 				; put the ascii digit in the string
	test 	rax, 		rax				; check is the quotient is 0 or if the is still digits to convert
	jnz 	_convert_loop				; process again if there is still digits to convert

	; check if it's needed to write '-' sign
	test 	rsi, 		rsi 			; check if rsi is not 0 to write '-'
	jz 		_done						; if rsi register is 0, jump to the end section
	dec 	rbx							; decrease the index of the buffer to place the '-' at the right place
	mov 	byte [rbx], '-'				; put the '-' at the begining of the string

_done:
	mov 	rax, 		rbx		 		; put the string in rax to be returned
	ret


; Stack protection
section .note.GNU-stack