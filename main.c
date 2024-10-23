#include <stdio.h>

extern size_t ft_strlen(const char *str);

int 	main(int ac, char *av)
{
	char *str1 = "Hello word";
	char *str2 = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin ut ex nec neque placerat sagittis at at nulla. Etiam in nulla justo. Interdum et malesuada fames ac ante ipsum primis in faucibus. Pellentesque a mi magna. Vestibulum pellentesque nisi id felis faucibus, a consectetur orci molestie. Etiam tempor sed justo nec hendrerit. Integer quis est leo. Integer rutrum, mauris sit amet tempus dignissim, ligula leo dapibus tortor, a bibendum velit nisl a erat. Integer nibh velit, gravida vitae ut.";
	char *str3 = "";

	if (ac > 1)
		printf("%s\n", "No arguments are required!");

	printf("%s\nSECTION FT_STRLEN\n\n", "---------------------------------");
	printf("%s %s\nlength string 1 = %ld\n", "string 1 =", str1, ft_strlen(str1));
	printf("%s %s\nlength string 2 = %ld\n", "string 2 = ", str2, ft_strlen(str2));
	printf("%s %s\nlength string 3 = %ld\n", "string 3 = ", str3, ft_strlen(str3));

	return(0);
}