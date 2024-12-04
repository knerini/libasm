; Data declaration

section .data

whitespace_inf	equ 			9
whitespace_sup 	equ 			13
space 			equ 			32
plus_sign 		equ 			43
minus_sign 		equ 			45
int_max 		equ 			2147483647
int_min 		equ 			-2147483648

%define			STR 			r14					; char *str;
%define 		BASE 			r15					; char *base;
%define  		BASE_SIZE 		ecx 				; int bsize;
%define 		NB 				edx 				; int nb;
%define 		NEG 			r10d 				; int neg;

; Code section
; Function to converts initial portion of the string to int representation with the specified base.
; Call:
;	int ft_atoi_base(char *str, char *base);

; Arguments passed:
; 1) rdi -> str
; 2) rsi -> base

; Returns:
; 1) rax -> int

section .text
global ft_atoi_base

; Function int ft_digit(char s, char *base)
ft_digit: 											; rdi = char s; // rsi = char *base;
	xor  	rax,				rax					; int n = 0 ;

.digit_loop:										; while (base[n] && base[n] != s)
	cmp 	[rsi + rax],		byte 0 				; if (base[n] == '\0')
	jz 		.end_digit_loop							; goto .end_digit_loop;
	cmp 	byte [rsi + rax],	dil  				; if (base[n] != s)
	je 		.end_digit_loop							; continue; else goto .end_digit_loop
	inc 	rax										; n++;
	jmp 	.digit_loop								; loop again

.end_digit_loop:
	ret 		  									; return (n);


; Function int ft_base_check(char *base)
ft_base_check:										; rdi = char *base;
	xor 	rax,  				rax				 	; int i = 0;
	xor  	rbx,				rbx 				; int j = 0;

.base_loop:											; while (base[i])
	cmp 	[rdi + rax],		byte 0				; if (base[i] == '\0')
	jz 		.end_base_check							; goto .end_base_check
	xor 	rbx,				rbx					; j = 0;
	movzx  	r12, 				byte [rdi + rax] 	; Load the char in the lowest part of rax register to do comparison

.base_len_loop:										; while (j < i)
	cmp 	rbx, 				rax 				; if (j >= i) check the loop condition
	jge 	.iterate								; goto .iterate;
	cmp 	r12b,					byte [rdi + rbx] 	; if (base[i] == base [j])
	je 		.invalid_base							; goto .invalid_base
	cmp 	byte [rdi + rbx],	space 				; if (base[j] == 32)
	je 		.invalid_base							; goto .invalid_base
	cmp  	byte [rdi + rbx], 	plus_sign			; if (base[j] == '+')
	je 		.invalid_base							; goto .invalid_base
	cmp 	byte [rdi + rbx],	minus_sign			; if (base[j] == '-')
	je 		.invalid_base							; goto .invalid_base
	cmp  	byte [rdi + rbx],  whitespace_inf  		; if (base[j] >= 9)
	jge 	.check_whitespace 						; goto .check_whitespace

.valid_base:
	inc 	rbx										; j++;
	jmp 	.base_len_loop							; Loop again the base_len_loop

.iterate:
	inc 	rax										; i++;
	jmp 	.base_loop 								; Loop again the base_loop

.end_base_check:
	cmp 	rax,				1 					; if (i <= 1)
	jle 	.invalid_base							; goto .invalid_ret
	ret

.invalid_base:
	mov  	rax,				0 					; Prepare to return because the base is less than or equal to 1
	ret

.check_whitespace:
	cmp  	byte [rdi + rbx], 	whitespace_sup		; if (base[j] <= 13)
	jle 	.invalid_base							; goto .invalid_base
	jmp 	.valid_base 							; goto .valid_base


; Main function
ft_atoi_base:
	mov 	STR,				rdi					; Put str in another register to keep it safe
	mov  	BASE, 				rsi 				; Put base in another register to keep it safe

; Check the base
	mov  	rdi,  				BASE  				; Prepare the call to base_check
	sub 	rsp,				8  					; Align the stack register before a call to an extern function
	call  	ft_base_check
	add  	rsp,				8  					; Restore the stack state
	mov  	BASE_SIZE,  		eax  				; int bsize = ft_base_check(base);
	cmp  	BASE_SIZE,			1 					; if (bsize <= 1)
	jle 	.zero_ret 								; goto .zero_ret

; Init variables
	xor  	NB, 				NB 					; int nb = 0;
	mov  	NEG, 				1 					; int neg = 1;

; Skip whitespaces
.whitespace_loop: 									; while (*str && ((*str >= 9 || *str <= 13) || *str == 32))
	cmp 	byte [STR], 		byte 0 				; if (*str == '\0')
	jz 		.zero_ret 								; goto .zero_ret
	cmp  	byte [STR],			space 				; if (*str == 32)
	je 		.go_next								; goto .go_next
	cmp 	byte [STR],			whitespace_inf		; if (*str >= 9)
	jge 		.check_whitespace2 					; goto .check_whitespace2
	jmp 	.sign_check								; Break the whitespace loop to go to check sign
.go_next:
	add 	STR, 				1					; str++;
	jmp 	.whitespace_loop
.check_whitespace2:
	cmp 	byte [STR], 		whitespace_sup 		; if (*str <= 13)
	jle 		.go_next							; goto .go_next

; Check for the sign
.sign_check:
	cmp 	byte [STR],			minus_sign			; if (*str == '-')
	je 		.neg_sign								; goto .neg_sign
	cmp 	byte [STR], 		plus_sign			; else if (*str == '+')
	je 		.plus_sign 								; goto .plus_sign
	jmp 	.atoi_loop								; else goto .atoi_loop

.neg_sign:
	imul 	NEG, 				-1 					; neg *= -1; 
.plus_sign:
	add  	STR, 				1 					; str++; 	

.atoi_loop: 										; while (*str, && (ft_digit(*str, base) < bsize))
	cmp 	byte [STR], 		byte 0 				; if (*str == '\0')
	jz 		.ret 									; goto .ret
	mov  	dil, 				byte [STR] 			; Prepare the call to ft_digit function
	mov  	rsi, 				BASE 				; Prepare the call to ft_digit
	;sub  	rsp, 				8 					; Align the stack register before a call to an extern function
	call  	ft_digit
	;add  	rsp, 				8 					; Restore the stack state
	mov  	r11d, 				eax 				; Put the result of ft_digit in r11g register
	cmp 	r11d, 				BASE_SIZE 			; if (result of ft_digit < bsize)
	jge 	.ret 									; continue ; else goto .ret
	imul 	NB, 				BASE_SIZE			; nb = nb * size;
	jo  	.overflow  								; Check for overflow and if it is goto .overflow
	add 	NB, 				r11d 				; nb = nb + result of ft_digit
	add  	STR, 				1 					; str++;
	jmp 	.atoi_loop 								; Loop again

.ret:
	mov  	eax, 				NB 					; Prepare to return nb
	imul  	eax, 				NEG 				; nb *= neg;
	ret 											; return (nb);

.zero_ret:
	mov  	rax, 				0					; rax = 0;
	ret 											; return (0);

.overflow:
	cmp 	NEG, 				-1 					; if (nef == -1)
	je 		.neg_overflow 							; goto .neg_overflow
	mov 	eax, 				int_max				; nb = INT_MAX;
	ret
.neg_overflow:
	mov  	eax,  				int_min 			; nb = INT_MIN;
	ret


; int ft_digit(char s, char *base)
;{
;	int n = 0;
;	while(base[n] && base[n] != s)
;		n++;
;	return (n);
;}
;
;int ft_base_check(char *base)
;{
;	int i, j = 0;
;	while (base[i])
;	{
;		j = 0;
;		while (j < i)
;		{
;			if (base[i] == base[j] || (base[j] >= 9 && base[j] <= 13) || base[j] == 32 || base[j] == '-' || base[j] == '+')
;				return (0);
;			j++;
;		}
;		i++;
;	}
;	if (i <= 1)
;		return (0);
;	return (i);
;}
;
;int ft_atoi_base(char *str, char *base)
;{
;	int bsize = base_check(base);
;	if (bsize <= 1)
;		return (0);
;	int nb = 0;
;	int neg = 1;
;	while (*str && ((*str >= 9 || *str <= 13) || *str == 32))
;		str++;
;	if (*str && (*str == '-' || *str == '+'))
;	{
;		if (*str == '-')
;			neg *= -1;
;		str++;
;	}
;	while (*str && (digit(*str, base) < bsize))
;	{
;		nb = (bsize * nb) + (digit(*str, base));
;		str++;
;	}
;	return (nb * neg);
;}

; Stack protection
section .note.GNU-stack