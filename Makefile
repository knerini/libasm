NAME 			= libasm.a
DBG_NAME		= libasm_dbg.a
C_EXEC			= c_asm_prog
C_DBG_EXEC		= c_asm_prog_dbg
ASM_EXEC		= asm_prog
ASM_DBG_EXEC	= asm_prog_dbg

DIR_SRC			= srcs
DIR_OBJ			= objs
DIR_LIB			= lib

SFILES 			= srcs/ft_strlen.s srcs/ft_strcpy.s srcs/ft_strcmp.s
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


all: $(DIR_LIB)/$(NAME) $(C_EXEC)

debug: $(DIR_LIB)/$(DBG_NAME) $(C_DBG_EXEC)

asm: $(DIR_LIB)/$(NAME) $(ASM_EXEC)

asm_debug: $(DIR_LIB)/$(DBG_NAME) $(ASM_DBG_EXEC)

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

$(C_EXEC): main.c $(DIR_LIB)/$(NAME)
	$(CC) main.c $(CFLAGS) -o $(C_EXEC)

$(C_DBG_EXEC): main.c $(DIR_LIB)/$(DBG_NAME)
	$(CC) main.c $(DBG_CFLAGS) -g -o $(C_DBG_EXEC)

$(ASM_EXEC): main.s $(DIR_LIB)/$(DBG_NAME)
	$(NASM) $(NASM_FLAGS) main.s -o main.o
	$(CC) main.o $(CFLAGS) -o $(ASM_EXEC)

$(ASM_DBG_EXEC): main.s $(DIR_LIB)/$(DBG_NAME)
	$(NASM) $(NASM_DBG_FLAGS) main.s -o main_debug.o
	$(CC) main_debug.o $(DBG_CFLAGS) -o $(ASM_DBG_EXEC) 


clean:
	$(RM) $(DIR_OBJ)
	$(RM) $(C_EXEC)
	$(RM) $(C_DBG_EXEC)
	$(RM) $(ASM_EXEC)
	$(RM) $(ASM_DBG_EXEC)
	$(RM) main.o
	$(RM) main_debug.o

fclean:	clean 
	$(RM) $(DIR_LIB)

re: fclean all

.PHONY: all debug asm asm_debug clean fclean re
