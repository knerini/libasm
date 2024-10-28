#include <stdio.h>
#include <string.h>
#include <stdlib.h>

extern size_t ft_strlen(const char *str);
extern char *ft_strcpy(char *dest, const char *src);

int 	main(int ac, char **av)
{
	char *str1 = "Hello world";
	char *str2 = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin ut ex nec neque placerat sagittis at at nulla. Etiam in nulla justo. Interdum et malesuada fames ac ante ipsum primis in faucibus. Pellentesque a mi magna. Vestibulum pellentesque nisi id felis faucibus, a consectetur orci molestie. Etiam tempor sed justo nec hendrerit. Integer quis est leo. Integer rutrum, mauris sit amet tempus dignissim, ligula leo dapibus tortor, a bibendum velit nisl a erat. Integer nibh velit, gravida vitae ut.";
	char *str3 = "";
	char *destc1 = NULL, *destc2 = NULL, *destc3 = NULL;
	char *destasm1 = NULL, *destasm2 = NULL, *destasm3 = NULL;

	if (ac > 1)
		printf("No arguments are required!\n");

	printf("--------------------------------\nSECTION FT_STRLEN\n\n");
	printf("string 1 = %s\nlength string 1 (ft_strlen in asm) = %ld -- length string 1 (strlen in c) = %ld\n", str1, ft_strlen(str1), strlen(str1));
	printf("string 2 = %s\nlength string 2 (ft_strlen in asm) = %ld -- length string 2 (strlen in c) = %ld\n", str2, ft_strlen(str2), strlen(str2));
	printf("string 3 = %s\nlength string 3 (ft_strlen in asm) = %ld -- length string 3 (strlen in c) = %ld\n", str3, ft_strlen(str3), strlen(str3));

	printf("\n--------------------------------\nSECTION FT_STRCPY\n\n");
	destasm1 = malloc(sizeof(char) * (ft_strlen(str1) + 1));
	destc1 = malloc(sizeof(char) * (ft_strlen(str1) + 1));
	if (destc1 && destasm1)
	{
		printf("ft_strcpy of str1, destasm = %s\n---\nstrcpy of str1, destc = %s\n\n", ft_strcpy(destasm1, str1), strcpy(destc1, str1));
		free(destc1);
		free(destasm1);
		destc1 = destasm1 = NULL;
	}

	destasm2 = malloc(sizeof(char) * (ft_strlen(str2) + 1));
	destc2 = malloc(sizeof(char) * (ft_strlen(str2) + 1));
	if (destc2 && destasm2)
	{
		printf("ft_strcpy of str2, destasm = %s\n---\nstrcpy of str2, destc = %s\n\n", ft_strcpy(destasm2, str2), strcpy(destc2, str2));
		free(destc2);
		free(destasm2);
		destc2 = destasm2 = NULL;
	}

	destasm3 = malloc(sizeof(char) * (ft_strlen(str3) + 1));
	destc3 = malloc(sizeof(char) * (ft_strlen(str3) + 1));
	if (destc3 && destasm3)
	{
		printf("ft_strcpy of str3, destasm = %s\n---\nstrcpy of str3, destc = %s\n\n", ft_strcpy(destasm3, str3), strcpy(destc3, str3));
		free(destc3);
		free(destasm3);
		destc3 = destasm3 = NULL;
	}

	return(0);
}
