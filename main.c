#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <fcntl.h>
#include <sys/errno.h>

extern size_t ft_strlen(const char *str);
extern char *ft_strcpy(char *dest, const char *src);
extern int ft_strcmp(const char *s1, const char *s2);
extern ssize_t ft_write(int fd, const void *buf, size_t count);
extern ssize_t ft_read(int fd, void *buf, size_t count);
extern char *ft_strdup(const char *s);

int 	main(int ac, char **av)
{
	char *str1 = "Hello world";
	char *str2 = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin ut ex nec neque placerat sagittis at at nulla. Etiam in nulla justo. Interdum et malesuada fames ac ante ipsum primis in faucibus. Pellentesque a mi magna. Vestibulum pellentesque nisi id felis faucibus, a consectetur orci molestie. Etiam tempor sed justo nec hendrerit. Integer quis est leo. Integer rutrum, mauris sit amet tempus dignissim, ligula leo dapibus tortor, a bibendum velit nisl a erat. Integer nibh velit, gravida vitae ut.";
	char *str3 = "";
	char *destc1 = NULL, *destc2 = NULL, *destc3 = NULL;
	char *destasm1 = NULL, *destasm2 = NULL, *destasm3 = NULL;
	char *s1 = "Hello world";
	char *s2 = "Hella world";
	char *hey = "Hey i'm print on stdout using write !";
	char *buf = NULL;
	char *c_dup = NULL, *asm_dup = NULL;
	ssize_t c_ret, asm_ret;
	int fd_w, fd_r;


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


	printf("\n--------------------------------\nSECTION FT_STRCMP\n\n");
	printf("s1 = %s -- s2 = %s\n", s1, s2);
	printf("Comp result (ft_strcmp in asm) = %d -- Comp result (strcmp in c) = %d\n", ft_strcmp(s1, s2), strcmp(s1, s2));
	printf("s1 = %s -- s2 = %s\n", s2, s1);
	printf("Comp result (ft_strcmp in asm) = %d -- Comp result (strcmp in c) = %d\n", ft_strcmp(s2, s1), strcmp(s2, s1));
	printf("s1 = %s -- s2 = %s\n", s1, str1);
	printf("Comp result (ft_strcmp in asm) = %d -- Comp result (strcmp in c) = %d\n", ft_strcmp(s1, str1), strcmp(s1, str1));
	printf("s1 = %s -- s2 = %s\n", str1, str3);
	printf("Comp result (ft_strcmp in asm) = %d -- Comp result (strcmp in c) = %d\n", ft_strcmp(str1, str3), strcmp(str1, str3));


	printf("\n--------------------------------\nSECTION FT_WRITE\n\n");
	printf("Write a simple sentence using write in c\n");
	c_ret = write(1, hey, strlen(hey));
	printf("\nWrite a simple sentence using write in asm\n");
	asm_ret = ft_write(1, hey, ft_strlen(hey));
	printf("\nReturn of write in c = %ld // return of ft_write in asm = %ld\n", c_ret, asm_ret);
	fd_w = open("unexisting_file", O_RDWR);
	printf("Write in an unexisting file to generate an error using write in c\n");
	c_ret = write(fd_w, hey, strlen(hey));
	printf("\nReturn of write in c = %ld // error msg = %s\n", c_ret, strerror(errno));
	printf("Write in an unexisting file to generate an error using ft_write in asm\n");
	asm_ret = write(fd_w, hey, strlen(hey));
	printf("\nReturn of ft_write in asm = %ld // error msg = %s\n", asm_ret, strerror(errno));


	printf("\n--------------------------------\nSECTION FT_READ\n\n");
	printf("Read the Makefile for 0 bytes using read in c\n\n");
	fd_r = open("Makefile", O_RDONLY);
	buf = calloc(1, sizeof(char));
	c_ret = read(fd_r, buf, 0);
	printf("Read return = %ld, buf = [[%s]]\n\n\n", c_ret, buf);
	free(buf);
	buf = NULL;
	close(fd_r);
	printf("Read the Makefile for 0 bytes using ft_read in asm\n\n");
	fd_r = open("Makefile", O_RDONLY);
	buf = calloc(1, sizeof(char));
	asm_ret = ft_read(fd_r, buf, 0);
	printf("Read return = %ld, buf = [[%s]]\n\n\n", asm_ret, buf);
	free(buf);
	buf = NULL;
	close(fd_r);

	printf("Read the Makefile for 1 bytes using read in c\n\n");
	fd_r = open("Makefile", O_RDONLY);
	buf = calloc((1 + 1), sizeof(char));
	c_ret = read(fd_r, buf, 1);
	printf("Read return = %ld, buf = [[%s]]\n\n\n", c_ret, buf);
	free(buf);
	buf = NULL;
	close(fd_r);
	printf("Read the Makefile for 1 bytes using ft_read in asm\n\n");
	fd_r = open("Makefile", O_RDONLY);
	buf = calloc((1 + 1), sizeof(char));
	asm_ret = ft_read(fd_r, buf, 1);
	printf("Read return = %ld, buf = [[%s]]\n\n\n", asm_ret, buf);
	free(buf);
	buf = NULL;
	close(fd_r);

	printf("Read the Makefile for 100 bytes using read in c\n\n");
	fd_r = open("Makefile", O_RDONLY);
	buf = calloc((100 + 1), sizeof(char));
	c_ret = read(fd_r, buf, 100);
	printf("Read return = %ld, buf = [[%s]]\n\n\n", c_ret, buf);
	free(buf);
	buf = NULL;
	close(fd_r);
	printf("Read the Makefile for 100 bytes using ft_read in asm\n\n");
	fd_r = open("Makefile", O_RDONLY);
	buf = calloc((100 + 1), sizeof(char));
	asm_ret = ft_read(fd_r, buf, 100);
	printf("Read return = %ld, buf = [[%s]]\n\n\n", asm_ret, buf);
	free(buf);
	buf = NULL;
	close(fd_r);

	printf("Read the Makefile for 100000 bytes using read in c\n\n");
	fd_r = open("Makefile", O_RDONLY);
	buf = calloc((100000 + 1), sizeof(char));
	c_ret = read(fd_r, buf, 100000);
	printf("Read return = %ld, buf = [[%s]]\n\n\n", c_ret, buf);
	free(buf);
	buf = NULL;
	close(fd_r);
	printf("Read the Makefile for 100000 bytes using ft_read in asm\n\n");
	fd_r = open("Makefile", O_RDONLY);
	buf = calloc((100000 + 1), sizeof(char));
	asm_ret = ft_read(fd_r, buf, 100000);
	printf("Read return = %ld, buf = [[%s]]\n\n\n", asm_ret, buf);
	free(buf);
	buf = NULL;
	close(fd_r);

	printf("Read an unexisting file to generate an error using read in c\n");
	fd_r = open("unexisting_file", O_RDONLY);
	buf = calloc((100 + 1), sizeof(char));
	c_ret = read(fd_r, buf, 100);
	printf("Read return = %ld, buf = [[%s]] // error msg = %s\n", c_ret, buf, strerror(errno));
	free(buf);
	buf = NULL;
	printf("Read an unexisting file to generate an error using ft_read in asm\n");
	fd_r = open("unexisting_file", O_RDONLY);
	buf = calloc((100 + 1), sizeof(char));
	asm_ret = ft_read(fd_r, buf, 100);
	printf("Read return = %ld, buf = [[%s]] // error msg = %s\n", asm_ret, buf, strerror(errno));
	free(buf);
	buf = NULL;

	
	printf("\n--------------------------------\nSECTION FT_STRDUP\n\n");
	c_dup = strdup(str1);
	asm_dup = ft_strdup(str1);
	printf("String duplicated with strdup in c = %s\nString duplicated with ft_strdup in asm = %s\n", c_dup, asm_dup);
	if (c_dup)
		free(c_dup);
	if (asm_dup)
		free(asm_dup);
	c_dup = strdup(str3);
	asm_dup = ft_strdup(str3);
	printf("Empty string duplicated with strdup in c = %s\nString duplicated with ft_strdup in asm = %s\n", c_dup, asm_dup);
	if (c_dup)
		free(c_dup);
	if (asm_dup)
		free(asm_dup);

	return(0);
}
