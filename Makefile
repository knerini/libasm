NAME 			= libasm.a
DBG_NAME		= libasm_dbg.a
EXEC			= asm_prog
DBG_EXEC		= asm_prog_dbg

DIR_SRC			= srcs
DIR_OBJ			= objs
DIR_LIB			= lib

SFILES 			= srcs/ft_strlen.s
OBJS			= $(patsubst $(DIR_SRC)/%.s, $(DIR_OBJ)/%.o, $(SFILES))
DBG_OBJS		= $(patsubst $(DIR_SRC)/%.s, $(DIR_OBJ)/%.debug.o, $(SFILES))

NASM			= nasm
NASM_FLAGS		= -f elf64
NASM_DBG_FLAGS	= -f elf64 -g -F dwarf

CC				= gcc
CFLAGS			= -L$(DIR_LIB) -lasm
DBG_CFLAGS		= -L$(DIR_LIB) -lasm_dbg
AR				= ar rcs
RM				= rm -rf


all: $(DIR_LIB)/$(NAME) $(EXEC)

debug: $(DIR_LIB)/$(DBG_NAME) $(DBG_EXEC)

$(DIR_LIB)/$(NAME): $(OBJS)
	@mkdir -p $(DIR_LIB)
	$(AR) $(DIR_LIB)/$(NAME) $^

$(DIR_LIB)/$(DBG_NAME): $(DBG_OBJS)
	@mkdir -p $(DIR_LIB)
	$(AR) $(DIR_LIB)/$(DBG_NAME) $^

$(DIR_OBJ)/%.o: $(DIR_SRC)/%.s
	@mkdir -p $(DIR_OBJ)
	$(NASM) $(NASM_FLAGS) $< -o $@

$(DIR_OBJ)/%.debug.o: $(DIR_SRC)/%.s
	@mkdir -p $(DIR_OBJ)
	$(NASM) $(NASM_DBG_FLAGS) $< -o $@

$(EXEC): main.c $(DIR_LIB)/$(NAME)
	$(CC) main.c $(CFLAGS) -o $(EXEC)

$(DBG_EXEC): main.c $(DIR_LIB)/$(DBG_NAME)
	$(CC) main.c $(DBG_CFLAGS) -g -o $(DBG_EXEC)

clean:
	$(RM) $(DIR_OBJ)
	$(RM) $(EXEC)
	$(RM) $(DBG_EXEC)

fclean:	clean 
	$(RM) $(DIR_LIB)

re: fclean all

.PHONY: all clean fclean re
