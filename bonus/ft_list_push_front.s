; Data declaration

section .data

next 		equ 				8 			; size : sizeof(void *)
lst_size 	equ  				16 			; size : sizeof(t_list)

%define 	LST				 	rdi 		; t_list **lst;
%define 	DATA 				rsi 		; void *data;
%define 	NEW_LST				rax 		; t_list *new_lst;
%define 	HEAD 				rdx 		; t_list *head;

extern 		malloc 							; call the malloc C function

; Code section
; Function to add an element to a list.
; Call:
;	void *ft_list_push_front(t_list **lst, void *data);

; Arguments passed:
; 1) rdi -> *lst
; 2) rsi -> data

; Returns:
; 1) rax -> none

section .text
global ft_list_push_front
ft_list_push_front:
	test 	LST, 				LST 		; if (*lst == NULL)...
	jz 		.end 							; ...goto .end;

	test  	DATA,				DATA 		; if (data == NULL)...
	jz 		.end							; ...goto .end;

	push 	LST  							; var1 = lst (saved on the stack)
	push  	DATA  							; var2 = data (saved on the stack)

	sub 	rsp, 				8 			; Align the stack register before a call to an extern function
	mov  	rdi,  				lst_size  	; Prepare the amount of memory to allocate
	call  	malloc WRT ..plt
	add 	rsp, 				8 			; Restore the stack state

	pop 	DATA 							; data = var2 (retrieve from stack)
	pop  	LST 							; lst = var1 (retrieve from stack)

	test  	NEW_LST, 			NEW_LST 	; if (!new_lst)...
	jz  	.end 							; ...goto .end;

	mov 	[NEW_LST], 			DATA  		; new_lst->data = data;
	mov 	HEAD,  				[LST]  		; head = *lst;
	mov 	[NEW_LST + next],	HEAD  		; new_lst->next = *head;
	mov  	[LST], 				NEW_LST  	; *lst = new_lst;

.end:
	ret 									; Nothing to return

; Stack protection
section .note.GNU-stack