; Data declaration

section .data

next 		equ 	8 				; size : sizeof(void *)

; Code section
; Function to return the size of a list
; Call:
;	size_t ft_list_size(t_list *lst);

; Arguments passed:
; 1) rdi -> lst

; Returns:
; 1) rax -> i

section .text
global ft_list_size
ft_list_size:
	xor 	rax, 	rax				; i = 0;

.next_elem:							; while (lst != NULL)
	test 	rdi, 	rdi				; if (lst == NULL)...
	jz		.end					; ...goto .end; 
	mov 	rdi, 	[rdi + next]	; lst = lst->next;
	inc 	rax						; i++;
	jmp 	.next_elem				; Loop again

.end:
	ret 							; return i;

; Stack protection
section .note.GNU-stack