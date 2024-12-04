NAME 				= libasm.a
DBG_NAME			= libasm_dbg.a
C_EXEC				= libasm
C_DBG_EXEC			= libasm_dbg
C_EXEC_BONUS		= libasm_bonus
C_DBG_EXEC_BONUS	= libasm_dbg_bonus
ASM_EXEC			= libasm_asm
ASM_DBG_EXEC		= libasm_dbg_asm

DIR_SRC				= srcs
DIR_BONUS 			= bonus
DIR_OBJ				= objs
DIR_OBJ_BONUS		= objs_bonus
DIR_LIB				= lib

SFILES 				= srcs/ft_strlen.s srcs/ft_strcpy.s srcs/ft_strcmp.s srcs/ft_write.s srcs/ft_read.s srcs/ft_strdup.s
SBONUS 				= bonus/ft_list_size.s bonus/ft_list_push_front.s bonus/ft_list_sort.s bonus/ft_list_remove_if.s bonus/ft_atoi_base.s


OBJS				= $(patsubst $(DIR_SRC)/%.s, $(DIR_OBJ)/%.o, $(SFILES))
OBJS_BONUS			= $(patsubst $(DIR_BONUS)/%.s, $(DIR_OBJ_BONUS)/%.o, $(SBONUS))
DBG_OBJS			= $(patsubst $(DIR_SRC)/%.s, $(DIR_OBJ)/%.debug.o, $(SFILES))
DBG_OBJS_BONUS		= $(patsubst $(DIR_BONUS)/%.s, $(DIR_OBJ_BONUS)/%.debug.o, $(SBONUS))

NASM				= nasm
NASM_FLAGS			= -f elf64
NASM_DBG_FLAGS		= -f elf64 -g -F dwarf
CC					= gcc
CFLAGS				= -L$(DIR_LIB) -lasm
DBG_CFLAGS			= -L$(DIR_LIB) -lasm_dbg
AR					= ar rcs
RM					= rm -rf


### RULES ###

all: $(DIR_LIB)/$(NAME) $(C_EXEC)

bonus: $(DIR_LIB)/$(NAME)_bonus $(C_EXEC_BONUS)

debug: $(DIR_LIB)/$(DBG_NAME) $(C_DBG_EXEC)

dbg_bonus: $(DIR_LIB)/$(DBG_NAME)_bonus $(C_DBG_EXEC_BONUS)

asm: $(DIR_LIB)/$(NAME) $(ASM_EXEC)

asm_debug: $(DIR_LIB)/$(DBG_NAME) $(ASM_DBG_EXEC)


### LIBRARY CREATION ###

$(DIR_LIB)/$(NAME): $(OBJS)
	@mkdir -p $(DIR_LIB)
	$(AR) $(DIR_LIB)/$(NAME) $^

$(DIR_LIB)/$(NAME)_bonus: $(OBJS) $(OBJS_BONUS)
	@mkdir -p $(DIR_LIB)
	$(AR) $(DIR_LIB)/$(NAME) $^

$(DIR_LIB)/$(DBG_NAME): $(DBG_OBJS)
	@mkdir -p $(DIR_LIB)
	$(AR) $(DIR_LIB)/$(DBG_NAME) $^

$(DIR_LIB)/$(DBG_NAME)_bonus: $(DBG_OBJS) $(DBG_OBJS_BONUS)
	@mkdir -p $(DIR_LIB)
	$(AR) $(DIR_LIB)/$(DBG_NAME) $^


### HANDLING .o FILES ###

$(DIR_OBJ)/%.o: $(DIR_SRC)/%.s
	@mkdir -p $(DIR_OBJ)
	$(NASM) $(NASM_FLAGS) $< -o $@

$(DIR_OBJ_BONUS)/%.o: $(DIR_BONUS)/%.s
	@mkdir -p $(DIR_OBJ_BONUS)
	$(NASM) $(NASM_FLAGS) $< -o $@

$(DIR_OBJ)/%.debug.o: $(DIR_SRC)/%.s
	@mkdir -p $(DIR_OBJ)
	$(NASM) $(NASM_DBG_FLAGS) $< -o $@

$(DIR_OBJ_BONUS)/%.debug.o: $(DIR_BONUS)/%.s
	@mkdir -p $(DIR_OBJ_BONUS)
	$(NASM) $(NASM_DBG_FLAGS) $< -o $@


### COMPILATION ####

$(C_EXEC): main.c $(DIR_LIB)/$(NAME)
	$(CC) main.c $(CFLAGS) -o $(C_EXEC)

$(C_EXEC_BONUS): main_bonus.c $(DIR_LIB)/$(NAME)
	$(CC) main_bonus.c $(CFLAGS) -o $(C_EXEC_BONUS)

$(C_DBG_EXEC): main.c $(DIR_LIB)/$(DBG_NAME)
	$(CC) main.c $(DBG_CFLAGS) -g -o $(C_DBG_EXEC)

$(C_DBG_EXEC_BONUS): main_bonus.c $(DIR_LIB)/$(DBG_NAME)
	$(CC) main_bonus.c $(DBG_CFLAGS) -g -o $(C_DBG_EXEC_BONUS)

$(ASM_EXEC): main.s $(DIR_LIB)/$(DBG_NAME)
	$(NASM) $(NASM_FLAGS) main.s -o main.o
	$(CC) main.o $(CFLAGS) -o $(ASM_EXEC)

$(ASM_DBG_EXEC): main.s $(DIR_LIB)/$(DBG_NAME)
	$(NASM) $(NASM_DBG_FLAGS) main.s -o main_debug.o
	$(CC) main_debug.o $(DBG_CFLAGS) -o $(ASM_DBG_EXEC) 


### CLEANING RULES ####

clean:
	$(RM) $(DIR_OBJ)
	$(RM) $(DIR_OBJ_BONUS)
	$(RM) $(C_EXEC)
	$(RM) $(C_EXEC_BONUS)
	$(RM) $(C_DBG_EXEC)
	$(RM) $(C_DBG_EXEC_BONUS)
	$(RM) $(ASM_EXEC)
	$(RM) $(ASM_DBG_EXEC)
	$(RM) main.o
	$(RM) main_debug.o

fclean:	clean 
	$(RM) $(DIR_LIB)

re: fclean all

.PHONY: all bonus debug dbg_bonus asm asm_debug clean fclean re
