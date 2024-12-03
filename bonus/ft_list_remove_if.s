%macro PUSH_REG 0
	push 	rdi
	push  	rsi
	push  	rdx
	push  	rcx
	push  	r8 
	push 	r9
	push  	r10
%endmacro

%macro POP_REG 0
	pop 	r10
	pop  	r9
	pop  	r8
	pop  	rcx
	pop  	rdx 
	pop 	rsi
	pop  	rdi
%endmacro

; Data declaration

section .data

next 		equ 				8 					; size : sizeof(void *)

%define 	BEGIN_LST 			rdi					; t_list **begin_list;
%define		CURRENT				r10					; t_list *current;
%define  	PREV_NODE  			r8					; t_list *previous_node;
%define 	TMP 				r9  				; t_list *tmp;
%define 	REF  				rsi					; void *data_ref;
%define		CMP_FUNC 			rdx					; (*cmp)();
%define 	FREE_FUNC			rcx					; (*free_fct)();

extern 		free

; Code section
; Function to remove an element from a list is the comparison to the data reference is correct
; Call:
;	void ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void *));

; Arguments passed:
; 1) rdi -> **begin_list
; 2) rsi -> *data_ref
; 3) rdx -> (*cmp)(lst_ptr->data, data_ref);
; 4) rcx -> (*free_fct)(lst_ptr->data);

; Returns:
; 1) rax -> none

section .text
global ft_list_remove_if
ft_list_remove_if:
	test 	BEGIN_LST,			BEGIN_LST			; if (!begin_list)
	jz 		.end 									; return;
	test  	REF, 				REF 				; if (!data_ref)
	jz 		.end 									; return;
	test 	CMP_FUNC, 			CMP_FUNC			; if (!cmp)
	jz 		.end 									; return;
	test  	FREE_FUNC,			FREE_FUNC			; if (!free_fct)
	jz 		.end 									; return;

	mov  	CURRENT,			[BEGIN_LST]			; t_list *current = *begin_list;
	xor  	PREV_NODE,			PREV_NODE 			; t_list *previous_node = NULL;
	xor  	TMP, 				TMP					; t_list *tmp = NULL;

.loop:												; while(current)
; Check loop condition
	test  	CURRENT,			CURRENT 			; if (!current)
	jz 		.end 									; return;

; Call of the cmp() function
	PUSH_REG 										; Push all registers onto the stack to preserve them
	mov 	rdi, 				[CURRENT] 			; First argument to call the function cmp() : current->data
	sub  	rsp,				8					; Align the stack register before a call to an extern function
	call 	CMP_FUNC								; Call cmp(current->data, data_ref);
	add  	rsp,				8					; Restore the stack state
	POP_REG 										; Retrieve all registers from the stack

; Check the result of the comparison function
	test 	rax,				rax					; if (cmp(data_ref, current->data) == 0)
	jnz 	.no_remove 								; continue; else goto .no_remove;
	mov  	TMP,				[CURRENT + next]	; tmp = current->next;

; Remove current node
	test 	PREV_NODE,			PREV_NODE 			; if (previous_node)
	jnz 	.new_prev								; goto new_prev; else continue;
	mov  	[BEGIN_LST], 		TMP					; *begin_list = current->next;
	jmp 	.free_node								; goto .free_node;

.new_prev:
	mov 	[PREV_NODE + next],	TMP					; previous_node->next = current->next; 

.free_node:
; Call of the free_fct function
	PUSH_REG										; Push all registers onto the stack to preserve them
	mov  	rdi,				[CURRENT]			; Argument to call the function free_fct() : tmp->data
	sub  	rsp,				8					; Align the stack register before a call to an extern function
	call 	FREE_FUNC								; Call free_fct(tmp);
	add  	rsp,				8					; Restore the stack state
	POP_REG											; Retrieve all registers from the stack

; Call of the C free function to remove the node
	PUSH_REG										; Push all registers onto the stack to preserve them
	mov 	rdi,				CURRENT 			; Argument to call the C function free : tmp
	sub  	rsp,				8 					; Align the stack register before a call to an extern function
	call  	free WRT ..plt
	add 	rsp, 				8 					; Restore the stack state
	POP_REG											; Retrieve all registers from the stack

	mov  	CURRENT, 			TMP					; current = tmp;
	jmp 	.loop									; Loop again

.no_remove:
	test  	CURRENT,			CURRENT 			; if (!current)
	jz 		.end 									; return;
	mov  	PREV_NODE,			CURRENT				; previous_node = current ;
	mov 	CURRENT,			[PREV_NODE + next] 	; current = current->next;
	jmp 	.loop 			 						; Loop again

.end:
	ret 											; Nothing to return

;{
;	if (!begin_list || !*begin_list || !cmp || !fre_fct)
;		return;
;	t_list *current = *begin_list;
;	t_list *previous_node = NULL;
;	t_list *tmp = NULL;
;	while (current)
;	{
;		if (cmp(data_ref, current->data) == 0)
;		{
;			if (previous_node)
;				previous_node->next = current->next;
;			else
;				*begin_list = current->next;
;			tmp = current->next;
;			free_fct(current->data);
;			free(current);
;			current = tmp;
;		}
;		if (!current)
;			return;
;		previous_node = current;
;		current = current->next;
;	}
;}

; Stack protection
section .note.GNU-stack