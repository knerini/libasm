# THE PROJECT : LIBASM
## Guidelines
This 42's School Project aims to start being familiar with Assembly langage x86_64 ASM architecture using the Intel syntax. The compilation is done with NASM.
The purpose of this project is to do a library by recoding few common C functions like :
- strlen
- strcpy
- strdup
- strcmp
- write
- read

The bonus part lets dive more in the Assembly langage with linked-list manipultation and a custom atoi_base:
- ft_list_push_front
- ft_list_size
- ft_list_sort
- ft_list_remove_if
- ft_atoi_base

## NASM
It's an assembler for the x86 CPU Architecture : [NASM](https://www.nasm.us/).
`nasm -f elf64 <filename>` to compile with the x86_64 format on Linux
`nasm -f elf64 -g -F dwarf <filename>` to compile with the x86_64 format on Linux with debugging information and specifying the debugging format

## GDB
Without a debugger it's not possible to identify bugs and resolve them : [GDB](https://sourceware.org/gdb/documentation/)
**Commands used**

| Command | Purpose |
| -------------------- | -------------------- |
| `disassemble main` | Disassembles the main function and provides a detailed view of the machine-level assembly instructions. Output includes : memory addresses of the instructions, assembly mnemonics, corresponding operands or parameters. |
| `layout asm` | Switches GDB into **Assembly Layout Mode** providing a split-screen interface source code / corresponding assembly instructions. This mode is interactive letting use commands like `step`, `next`, `continue`. |
| `info registers` | Displays the current values of the CPU registers. |
| `print $<register>` | Display the value of the register, e.g., `print $rax`. | 
| `print/<format> $<register>` | Display the value of the register in different formats : `print` (decimal), `print/x` (hexadecimal), `print/u` (unsigned decimal). E.g., `print/x $rax`. |
| `x/<format> $<register>` | Examine the memory at specified register. `x/c` (character), `x/s` (string), `x/x` (hexadecimal), `x/i` (Assembly instruction), `x/d` (decimal). E.g., `x/s $rax`. |

# ASSEMBLY
## Data storage size
| Storage | Size (bits) | Size (bytes) | C/C++ mapping
| ---------- | ---------- | ---------- | ---------- |
| bytes | 8-bits | 1 byte | char |
| word | 16-bits | 2 bytes | short |
| double-word | 32-bits | 4 bytes | int, unsigned int, float |
| quadword | 64-bits | 8 bytes | long, long long, char *, int *, double |
| double quadword | 128-bits | 16 bytes | |
## Registers
A CPU register is a temporary storage or working location built into the CPU itself (separate from memory).
### General purpose registers
| 64-bits registers | lowest 32-bits | lowest 16-bits | lowest 8-bits |
| ---------- | ---------- | ---------- | ---------- |
| rax | eax | ax | al |
| rbx | ebx | bx | bl |
| rcx | ecx | cx | cl |
| rdx | edx | dx | dl |
| rsi | esi | si | sil |
| rdi | edi | di | dil |
| rbp | ebp | bp | bpl |
| rsp | esp | sp | spl |
| r8 | r8d | r8w | r8b |
| r9 | r9d | r9w | r9b |
| r10 | r10d | r10w | r10b |
| r11 | r11d | r11w | r11b |
| r12 | r12d | r12w | r12b |
| r13 | r13d | r13w | r13b |
| r14 | r14d | r14w | r14b |
| r15 | r15d | r15w | r15b |
### Stack Pointer Register
rsp : used to point to the current top of the stack (memory). Shouldn't be used for data or other uses.
### Base Pointer Register
rbp : used as a base pointer during function calls. Shouldn't be used for data or other uses.
### Instruction Pointer Register
rip : in addition with general purpose registers used by CPU to point to the next instruction to be executed.
### Flag Registers
Used for status ans CPU control informations. Updated by CPU after each instruction and not directly accessible by programs.
| Name | Symbol | Bit | Usage |
| ---------- | ---------- | ---------- | ---------- |
| Carry | CF | 0 | Used to indicate if the previous operation resulted in a carry. |
| Parity | PF | 2 | Used to indicate if the last byte has an even number of 1's (even parity). |
| Adjust | AF | 4 | Used to support Binary Coded Decimal operations. |
| Zero | ZF | 6 | Used to indicate if the previous operation resulted in a zero result. |
| Sign | SF | 7 | Used to indicate if the result of the previous operation resulted in a 1 in the most significant bit (indicating negative in the context of signed data). |
| Direction | DF | 10 | Used to specify the direction (increment or decrement) for some string operations. |
| Overflow | OF | 11 | Used to indicate if the previous operation resulted in an overflow. |
### XMM Registers
Used to support floating-point operations and Single Instruction Multiple Data instructions (SIMD).
The SIMD instructions allow a single instruction to be applied simultaneously to multiple data items. Used to support the Streaming SIMD Extensions (SSE).
128-bits registers : xmm0, xmm1, xmm2, xmm3, xmm4, xmm5, xmm6, xmm7, xmm8, xmm9, xmm10, xmm11, xmm12. xmm13. xmm14. xmm15.
## Program format
A properly formatted assembly source file consists of several main parts :
- Data section where initialized data is declared and defined
- BSS section where uninitialized data is declared
- Text section where code is placed
### Comments
`:` is used for comments. An Assembly code well commented is easier to read and to understand.
### Numbers
- hexadecimal : preceded with '0x'
- ocalt : followed by a 'q'
- decimal : default radix, no special notation
### Constants
- Define by 'equ' : `<name> equ <value>
- Cannot be changed during a program execution
- Constants are substitued for their defines values during assembly process so not assigned a memory location
### Data section
- `section .data`.
-  All initialized variables and constants are placed in this section.
-  Variable definition : `<variableName> <dataType> <initialValue>`.
- Supported data types : db (8-bits), dw (16-bits), dd (32-bits), dq (64-bits), ddq (128-bits integer), dt (128-bits floats).
- Initialized arrays are defined with coma separated values.
### BSS section
- `section .bss`.
- All uninitialized variables are placed in this section.
- Variable definition : `<variableName> <resType> <count>`.
- Supported data types : resb (8-bits), resw (16-bits), resd (32-bits), resq (64-bits), resdq (128-bits).
- The allocated array is not initialized to any specific value.
### Text section
- `section .text`.
- Instructions: one per line and must be a valid instruction with the appropriate required operands.
- Includes some headers or labels that defined the initial program entry point.
- No special label or directives are required to terminate the program but a system service should be used to inform the operating system that the program should be terminated and the ressources, such as memory, recovered and re-utilized.
## Common instructions
- `src` : source operand
- `dest` : destination operand
- `mem` : memory
- `reg` : register (reg8, reg16, reg32, reg64)
- `op` : operand (op8, op16, op32, op64)
- `imm` : immediate (imm8, imm16, imm32, imm64)

| Instruction | Purpose |
| ---------- | ------------------------------------------------------- |
| `mov <dest>, <src>` | `src` is copied from `src` into `dest`. Value of `src` is unchanged. `src` and `dest` must be of the same size, both cannot be memory. If memory to memory operation is requiredm two instructions must be used. Only way to access memory, use brackets '[]'. E.g., `mov rax, qword [var1]` = value of `var1` in `rax` // `mov rax, var1` = address of `var1` in `rax`. |
| `lea <reg64>, <mem>` | Load Effective Address : place address of `mem` into `reg64`. |
| `movzx <reg16>, <op8>`, `movzx <reg32>, <op8>`, `movzx <reg16>, <op16>`, `movzx <reg64>, <op8>`, `movzx <reg64>, <op16>` | Widening unsigned conversion : converts from a smaller type to a larger type. |
| `cbw` (al into ax), `cwd` (dx:ax), `cwde` (ax into eax), `cdq` (edx:eax), `cdqe` (eax into rax), `cqo` (rdx:rax), `movsx <reg16>, <op8>`, `movsx <reg32>, <op8>`, `movsx <reg32>, <op16>`, `movsx <reg64>, <op8>`, `movsx <reg64>, <op16>`, `movsx <reg64>, <op32>`, `movsxd <reg64>, <op32>` | Widening signed conversion : work only with A register and sometimes use D register for result (rdx:rax). |
| `add <dest>, <src>` | Addition instruction. Value of `src` is unchanged. `src` and `dest` must be of the same size, both cannot be memory. `dest` cannot be an immediate value. If a memory to memory addition operation is required, two instructions must be used. |
| `inc <op>` | Incrementation. |
| `adc <dest>, <src>` | Addition with carry. Same specification as `add` instruction. |
| `sub <dest>, <src>` | Substraction instruction. Value of `src` is unchanged. `src` and `dest` must be of the same size, both cannot be memory. `dest` cannot be an immediate value. If a memory to memory substraction operation is required, two instructions must be used. |
| `dec <op>` | Decrementation. |
| `mul <src>` | Unsigned multiplication. `src` must be a memory location or a register. The A register must be used for one of the operands. Immediate operand is not allowed. Result will be place in the A and possibly D registers, based on the size being mutiplied. |
| `imul <src>`, `imul <dest>, <src/imm32>`, `imul <dest>, <src>, <imm32>` | Signed multiplication. `dest` must be a register. For multiple operands bytes operand are not supported. For two operands `src/imm` operand may be a register, memory location or immediate value, with size of `imm` limited to the size of `src` up to double-word size. For three operands, two operands are multiplicated and the result is placed in `dest`, `src` must be a register or memory location and `imm` an immediate value with size of `imm` limited to the size of `src` up to double-word size. |
| `div <src>` | Unsigned division. Division requires dividend must be a larger size than divisor. Like multiplication, division uses a combination of A register and D register. Divisor can be a register or a memory location but not an immediate. Result will be place in the A register and the remainder in either the `ah`, `dx`, `edx` or `rdx` register. The use of a larger size operand for dividend matches the single operand multiplication. For simple divisions, an appropriate conversion may be required in order to ensure dividend is set correctly. |
| `idiv <src>` | Signed division. Same specifications as unsigned division. |
