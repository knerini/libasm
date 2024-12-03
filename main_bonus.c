#include <stdlib.h>
#include <stdio.h>
#include <string.h>

typedef struct 	s_list
{
	void 			*data;
	struct s_list	*next;
}				t_list;

extern size_t ft_list_size(t_list *lst);
extern void *ft_list_push_front(t_list **lst, void *data);
extern void ft_list_sort(t_list **lst, int(*cmp)());
extern int ft_strcmp(const char *s1, const char *s2);
extern void ft_list_remove_if(t_list **begin_list, void *data_ref, int(*cmp)(), void(*free_fct)(void *));

void print_list(t_list *lst)
{
	t_list *tmp;
	tmp = lst;

	if (!tmp)
	{
		printf("List is empty\n");
		return ;
	}

	while (tmp)
	{
		printf("Arg of lst is [%s]\n", (char*)(tmp->data));
		tmp = tmp->next;
	}
	return ;
}

int main(int ac, char **av)
{
	t_list *lst = NULL;
	t_list *empty_lst = NULL;
	char *var1 = strdup("Hello");
	char *var2 = strdup("world!");
	char *var3 = strdup("");
	char *var4 = strdup("LOL!");
	char *var5 = strdup("HO\0HO");
	char *var6 = strdup("Hi there");

	printf("--------------------------------\nSECTION FT_LIST_PUSH_FRONT\n--------------------------------\n\n");
	printf("Print lst before adding elements\n");
	print_list(lst);
	printf("Add 6 elements to lst:\narg1 = [%s]\narg2 = [%s]\narg3 = [%s]\narg4 = [%s]\narg5 = [%s]\narg6 = [%s]\n", var1, var2, var3, var4, var5, var6);
	ft_list_push_front(&lst, var1);
	ft_list_push_front(&lst, var2);
	ft_list_push_front(&lst, var3);
	ft_list_push_front(&lst, var4);
	ft_list_push_front(&lst, var5);
	ft_list_push_front(&lst, var6);
	printf("Print lst after elements were added\n");
	print_list(lst);
	
	printf("\n\n--------------------------------\nSECTION FT_LIST_SIZE\n--------------------------------\n\n");
	printf("lst is %ld size long\n", ft_list_size(lst));
	printf("empty_lst is %ld size long\n", ft_list_size(empty_lst));

	printf("\n\n--------------------------------\nSECTION FT_LIST_SORT\n--------------------------------\n\n");
	printf("Print lst before sorting:\n");
	print_list(lst);
	ft_list_sort(&lst, ft_strcmp);
	printf("Print lst after sorting\n");
	print_list(lst);
	printf("Print empty_lst before sorting:\n");
	ft_list_sort(&empty_lst, ft_strcmp);
	print_list(empty_lst);
	printf("Print empty_lst after sorting:\n");
	print_list(empty_lst);

	printf("\n\n--------------------------------\nSECTION FT_LIST_REMOVE_IF\n--------------------------------\n\n");
	printf("When data_ref is in lst: [%s]\n", "LOL!");
	ft_list_remove_if(&lst, "LOL!", ft_strcmp, free);
	printf("Print lst after ft_list_remove_if fct :\n");
	print_list(lst);
	printf("When data_ref isn't in lst: [%s]\n", "Pouet");
	ft_list_remove_if(&lst, "Pouet", ft_strcmp, free);
	printf("Print lst after ft_list_remove_if fct :\n");
	print_list(lst);
	printf("When data_ref is in the first place of lst: [%s]\n", "");
	ft_list_remove_if(&lst, "", ft_strcmp, free);
	printf("Print lst after ft_list_remove_if fct :\n");
	print_list(lst);
	printf("Remove a data of empty_lst: [%s]\n", "There will be nothing to remove");
	ft_list_remove_if(&empty_lst, "Ther will be nothing to remove", ft_strcmp, free);
	print_list(empty_lst);

	t_list *tmp;
	while (lst)
	{
		tmp = lst;
		lst = lst->next;
		free(tmp->data);
		free(tmp);
	}

	return (0);
}