; Data declaration

section .data

next		equ				8					; size : sizeof(void *)

%define 	FUNC			r10					; (*cmp)();
%define 	CURRENT			r13					; t_list *current;
%define 	NEXT_NODE		r12					; t_list *next_node;
%define 	HEAD			r14					; t_list *head;
%define  	SORTED 			edx					; int sorted;

; Code section
; Function sort elements of a list after comparison with a function.
; Call:
;	void ft_list_sort(t_list **lst, int (*cmp)());

; Arguments passed:
; 1) rdi -> **lst
; 2) rsi -> (*cmp)(lst_ptr->data, lst_other_ptr->data);

; Returns:
; 1) rax -> none

section .text
global ft_list_sort:
ft_list_sort:
	test 	rdi,			rdi					; if (!lst)
	jz 		.end								; return;
	test 	 rsi,			rsi					; if (!cmp == NULL)
	jz 		.end								; return;

	mov 	FUNC,			rsi					; Save (*cmp)() into a register that will not used for other purpose
	mov 	CURRENT,		[rdi]				; t_list *current = *lst;
	mov 	HEAD,			[rdi]				; t_list *head = *lst;

	test 	CURRENT,		CURRENT 			; if (!*lst)
	jz 		.end 								; return;

.outer_loop:									; while (!sorted)
	mov 	SORTED,			1					; sorted = 1;
	mov  	CURRENT,		HEAD				; current = head;

.inner_loop:									; while (current->next)
	mov  	NEXT_NODE,		[CURRENT + next]	; t_list *next_node = current->next;
	test 	NEXT_NODE, 		NEXT_NODE 			; if (!next_node)
	jz 		.check_sorted						; break;

; Call of the cmp() function
	mov 	rdi,			[CURRENT]			; First argument to call the function cmp() : first->data
	mov 	rsi,			[NEXT_NODE]			; Second argument to call the function cmp() : second->data
	sub 	rsp,			8 					; Align the stack register before a call to an extern function
	call 	FUNC 								; Call cmp(current->data, next_node->data);
	add  	rsp, 			8 					; Restore the stack state

; Check the result of the comparison function
	cmp 	rax,			0					; if (cmp(first->data, second->data) > 0)
	jle 	.no_swap							; continue;

	mov 	rax, 			[CURRENT] 			; tmp = current->data;
	mov 	rcx,			[NEXT_NODE]			; current->data = ...
	mov 	[CURRENT],		rcx					; ... = next_node->data;
	mov 	[NEXT_NODE],  	rax					; next_node->data = tmp;
	mov 	SORTED,			0 					; sorted = 0;

.no_swap:
	mov 	CURRENT, 		NEXT_NODE			; current = current->next;
	jmp 	.inner_loop							; Continue to traverse the linked list

.check_sorted:
	test 	SORTED, 		SORTED 				; if (!sorted)
	jnz 	.end 								; return;
	jmp 	.outer_loop							; else repeat;		

.end:
	ret 										; Nothing to return



;{
; 	if (!lst || !*lst || !cmp)
;		return;
;	t_list *current = *lst;
;	t_list *head = *lst;
;	int sorted = 0;
;	while (!sorted)
;	{
;		sorted = 1;
;		current = head;
;		while (current->next)
;		{
;			t_list *next_node = current->next;
;			if (!next_node)
;				break ;
;			if (cmp(current->data, next_node->data) > 0)
;			{
;				void *tmp = current->data;
;				current->data = next_node->data;
;				next_node->data = tmp;
;				sorted = 0;
;			}
;			current = current->next;
;		}
;	}
;}

; Stack protection
section .note.GNU-stack