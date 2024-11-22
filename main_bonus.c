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
	char *var1 = strdup("Hello");
	char *var2 = strdup("world!");
	char *var3 = strdup("");
	char *var4 = strdup("LOL!");
	char *var5 = strdup("HO\0HO");
	char *var6 = strdup("Hi there");

	printf("--------------------------------\nSECTION FT_LIST_PUSH_FRONT\n\n");
	printf("Print the list before adding elements\n");
	print_list(lst);
	printf("Add 6 elements to the list:\narg1 = [%s]\narg2 = [%s]\narg3 = [%s]\narg4 = [%s]\narg5 = [%s]\narg6 = [%s]\n", var1, var2, var3, var4, var5, var6);
	ft_list_push_front(&lst, var1);
	ft_list_push_front(&lst, var2);
	ft_list_push_front(&lst, var3);
	ft_list_push_front(&lst, var4);
	ft_list_push_front(&lst, var5);
	ft_list_push_front(&lst, var6);
	printf("Print the list after elements were added\n");
	print_list(lst);
	printf("--------------------------------\nSECTION FT_LIST_SIZE\n\n");
	printf("The list is %ld size long\n", ft_list_size(lst));

	free(var1);
	free(var2);
	free(var3);
	free(var4);
	free(var5);
	free(var6);
	t_list *tmp;
	while (lst)
	{
		tmp = lst;
		lst = lst->next;
		free(tmp);

	}

	return (0);
}