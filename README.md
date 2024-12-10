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
`nasm -f elf64 <filename>` to compile with the x86_64 format on Linux.
`nasm -f elf64 -g -F dwarf <filename>` to compile with the x86_64 format on Linux with debugging information and specifying the debugging format.

## GDB
Without a debugger it's not possible to identify bugs and resolve them : [GDB](https://sourceware.org/gdb/documentation/).
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
- octal : followed by a 'q'
- decimal : default radix, no special notation
### Constants
- Define by 'equ' : `<name> equ <value>`
- Cannot be changed during a program execution
- Constants are substitued for their defines values during assembly process so not assigned a memory location
- Example from my code **ft_write.s** :
> ```
> SYS_write equ 1       ; define a constant named SYS_write with a value of 1
> [...]
> mov rax, SYS_write    ; put SYS_write in rax register, same as "mov rax, 1" with more clarity of what is intented
> ```
### Label
A program label is the target, or location to jump to, for control statements. Program labels may be defined only once.
Example from my code **ft_strdup.s** :
> ```
> test NEW_S, NEW_S    ; comparison instruction
> je .error            ; condition jump to a label named .error
> [...]
> .label:              ; start of the label section named .error
> [...]
> ```
### Data section
- `section .data`.
-  All initialized variables and constants are placed in this section.
-  Variable definition : `<variableName> <dataType> <initialValue>`.
- Supported data types : db (8-bits), dw (16-bits), dd (32-bits), dq (64-bits), ddq (128-bits integer), dt (128-bits floats).
- Initialized arrays are defined with coma separated values.
### BSS section
- `section .bss`.saoûl
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
- `RXdest` : floating-point destination operand
- `mem` : memory
- `reg` : register (reg8, reg16, reg32, reg64)
- `op` : operand (op8, op16, op32, op64)
- `imm` : immediate (imm8, imm16, imm32, imm64)

| Instruction | Purpose |
| ---------- | ---------- |
| `mov <dest>, <src>` | Copy `src` to `dest`. `dest` cannot be an immediate. `src` and `dest` must be of the same size, both cannot be memory. |
| `lea <reg64>, <mem>` | Load Effective Address : place address of `mem` into `reg64`. |
| `movzx <dest>, <src>` | Unsigned widening conversion. Both operands cannot be memory. `dest` cannot be an immediate. Immediate values not allowed. |
| `cbw` | Convert byte in `al` into word in `ax`. Only works for A register. |
| `cwd` | Convert word in `ax` into double-word in `dx:ax`. Only works for A register and D register. |
| `cwde` | Convert word in `ax` into double-word in `eax`. Only works for A register. |
| `cdq` | Convert double-word in `eax` into quadword in `edx:eax`. Only works for A register and D register. |
| `cdqe` | Convert double-word in `eax` into quadword in `rax`. Only works for A register. |
| `cqo` | Convert quadword in `rax` into quadword in `rdx:rax`. Only works for A register and D register. |
| `movsx <dest>, <src>` | Signed widening conversion. Both operands cannot be memory. `dest` cannot be an immediate. Immediate values not allowed. |
| `add <dest>, <src>` | Addition instruction (`dest` + `src`), result placed in `dest`. `dest` cannot be an immediate. `src` and `dest` must be of the same size, both cannot be memory. If a memory to memory addition operation is required, two instructions must be used. |
| `inc <op>` | Increment `op` by 1. `op` cannot be an immediate. |
| `adc <dest>, <src>` | Addition instruction (`dest` + `src`), result placed in `dest` and any previous carry is stroored in the `CF` register. `dest` cannot be an immediate. `src` and `dest` must be of the same size, both cannot be memory. If a memory to memory addition operation is required, two instructions must be used. |
| `sub <dest>, <src>` | Substraction instruction (`dest` - `src`), result placed in `dest`. `dest` cannot be an immediate. `src` and `dest` must be of the same size, both cannot be memory. If a memory to memory substraction operation is required, two instructions must be used. |
| `dec <op>` | Decrement `op` by 1. `op` cannot be an immediate. |
| `mul <src>` | Unsigned multiplication. Multiply A register times the `src`. `src` cannot be an immediate. Result will be place in the A and possibly D registers, based on the size being mutiplied. |
| `imul <src>`/ `imul <dest>, <src/imm32>` / `imul <dest>, <src>, <imm32>` | Signed multiplication. `src` cannot be an immediate. Single operand : same as unsigned multiplication. Two operands : result placed in dest (`dest` = `dest` * `src/imm32`). Three operands : result placed in dest (`dest` = `src` * `imm32`). |
| `div <src>` | Unsigned division. Divide A/D register by `src`.  `src` cannot be an immediate. Result will be place in the A register and the remainder in either the `ah`, `dx`, `edx` or `rdx` register. For simple divisions, an appropriate conversion may be required in order to ensure dividend is set correctly. |
| `idiv <src>` | Signed division. Same specifications as unsigned division. |
| `and <dest>, <src>` | AND logical instruction. Result placed in `dest`. Both operands cannot be memory.`dest` cannot be an immediate. |
| `or <dest>, <src>` | OR logical instruction. Result placed in `dest`. Both operands cannot be memory.`dest` cannot be an immediate. |
| `xor <dest>, <src>` | XOR logical instruction. Result placed in `dest`. Both operands cannot be memory.`dest` cannot be an immediate. |
| `not <op>` | NOT logical instruction.`op` cannot be an immediate. |
| `shl <dest>, <imm>` / `shl <dest>, cl` | Perform logical shift left operation on `dest`. Zero fills from right. `imm` or the value in `cl` register must be between 1 and 64. `dest` cannot be an immediate. |
| `shr <dest>, <imm>` / `shr <dest>, cl` | Perform logical shift right operation on `dest`. Zero fills from left. `imm` or the value in `cl` register must be between 1 and 64. `dest` cannot be an immediate. |
| `sal <dest>, <imm>` / `sal <dest>, cl` | Perform arithmetic shift left operation on `dest`. Zero fills from right. `imm` or the value in `cl` register must be between 1 and 64. `dest` cannot be an immediate. |
| `sar <dest>, <imm>` / `sar <dest>, cl` | Perform arithmetic shift right operation on `dest`. Zero fills from left. `imm` or the value in `cl` register must be between 1 and 64. `dest` cannot be an immediate. |
| `rol <dest>, <imm>` / `rol <dest>, cl` | Perform rotate left operation on `dest`. `imm` or the value in `cl` register must be between 1 and 64. `dest` cannot be an immediate. |
| `ror <dest>, <imm>` / `ror <dest>, cl` | Perform rotate right operation on `dest`. `imm` or the value in `cl` register must be between 1 and 64. `dest` cannot be an immediate. |
| `cmp <op1>, <op2>` | Compare `op1` with `op2`. Results are stored in flag registers. Operands are not changed. Both operands cannot be memory. `op1` cannot be an immediate. |
| `je <label>` | Based on preceding comparison instruction, jump to `label` if `op1` == `op2`. Label must be defined exactly once. |
| `jne <label>` | Based on preceding comparison instruction, jump to `label` if `op1` != `op2`. Label must be defined exactly once. |
| `jl <label>` | For signed data, based on preceding comparison instruction, jump to `label` if `op1` < `op2`. Label must be defined exactly once. |
| `jle <label>` | For signed data, based on preceding comparison instruction, jump to `label` if `op1` <= `op2`. Label must be defined exactly once. |
| `jg <label>` | For signed data, based on preceding comparison instruction, jump to `label` if `op1` > `op2`. Label must be defined exactly once. |
| `jge <label>` | For signed data, based on preceding comparison instruction, jump to `label` if `op1` >= `op2`. Label must be defined exactly once. |
| `jb <label>` | For unsigned data, based on preceding comparison instruction, jump to `label` if `op1` < `op2`. Label must be defined exactly once. |
| `jbe <label>` | For unsigned data, based on preceding comparison instruction, jump to `label` if `op1` <= `op2`. Label must be defined exactly once. |
| `ja <label>` | For unsigned data, based on preceding comparison instruction, jump to `label` if `op1` > `op2`. Label must be defined exactly once. |
| `jae <label>` | For unsigned data, based on preceding comparison instruction, jump to `label` if `op1` >= `op2`. Label must be defined exactly once. |
| `loop <label>` | Decrement rcx register and jump to `label` if `rcx` is != 0. Label must be defined exactly once. |
| `push <op64>` | Push `op64` on the stack. Adjusts `rsp` accordingly. Operand is unaltered. |
| `pop <op64>` | Pop `op64` from the stack. Adjusts `rsp` accordingly. The operand may not be an immediate value. Operand is overwritten. |
| `call <funcName>` | Calls a function. Push `rip` register and jump to the `funcName`. |
| `ret` | Return from a function. Pop the stack into `rip` register, effecting a jump to the line after the call. |

| Floating-points' instruction | Purpose |
| ---------- | ---------- |
| `movss <dest>, <src>` | Copy 32-bit `src` to 32-bit `dest`. Both operands cannot be memory. Operands cannot be an immediate. |
| `movsd <dest>, <src>` | Copy 64-bit `src` to 64-bit `dest`. Both operands cannot be memory. Operands cannot be an immediate. |
| `cvtss2sd <RXdest>, <src>` | Convert 32-bit `src` to 64-bit `RXdest`. `RXdest` floating-point register. `src` cannot be an immediate. |
| `cvtss2ss <RXdest>, <src>` | Convert 64-bit `src` to 32-bit `RXdest`. `RXdest` floating-point register. `src` cannot be an immediate. |
| `cvtss2si <reg>, <src>` | Convert 32-bit `src` to the 32-bit integer `dest`. `dest` must be a register. `src` cannot be an immediate. |
| `cvtsd2si <reg>, <src>` | Convert 64-bit `src` to the 32-bit integer `reg`. `dest` must be a register. `reg` cannot be an immediate. |
| `cvtsi2ss <RXdest>, <src>` | Convert 32-bit integer `src` to the 32-bit floating-point `RXdest`. `RXdest` must be a floating-point register. `src` cannot be an immediate. |
| `cvtsi2sd <RXdest>, <src>` | Convert 32-bit integer `src` to the 64-bit floating-point `RXdest`. `RXdest` must be a floating-point register. `src` cannot be an immediate. |
| `addss <RXdest>, <src>` | Addition instruction for two 32-bits operands (`RXdest` + `src`), result placed in `RXdest`. `src` cannot be an immediate. |
| `addsd <RXdest>, <src>` | Addition instruction for two 64-bits operands (`RXdest` + `src`), result placed in `RXdest`. `src` cannot be an immediate. |
| `subss <RXdest>, <src>` | Substraction instruction for two 32-bits operands (`RXdest` - `src`), result placed in `RXdest`. `src` cannot be an immediate. |
| `subsd <RXdest>, <src>` | Substraction instruction for two 64-bits operands (`RXdest` - `src`), result placed in `RXdest`. `src` cannot be an immediate. |
| `mulss <RXdest>, <src>` | Multiplication instruction for two 32-bits operands (`RXdest` * `src`), result placed in `RXdest`. `src` cannot be an immediate. |
| `mulsd <RXdest>, <src>` | Multiplication instruction for two 64-bits operands (`RXdest` * `src`), result placed in `RXdest`. `src` cannot be an immediate. |
| `divss <RXdest>, <src>` | Division instruction for two 32-bits operands (`RXdest` / `src`), result placed in `RXdest`. `src` cannot be an immediate. |
| `divsd <RXdest>, <src>` | Division instruction for two 64-bits operands (`RXdest` / `src`), result placed in `RXdest`. `src` cannot be an immediate. |
| `sqrtss <RXdest>, <src>` | Square root instruction of `src` 32-bits operand, result placed in `RXdest`. `src` cannot be an immediate. |
| `sqrtsd <RXdest>, <src>` | Square root instruction of `src` 64-bits operand, result placed in `RXdest`. `src` cannot be an immediate. |
| `ucomiss <RXdest>, <src>` | Compare two 32-bit operands. Results are placed in the Flag registers. Neither operand is changed. `src` operand may be a floating-point register or memory, but not be an immediate. |
| `ucomisd <RXdest>, <src>` | Compare two 64-bit operands. Results are placed in the Flag registers. Neither operand is changed. `src` operand may be a floating-point register or memory, but not be an immediate. |

## Addressing modes
- Only way to access memory is with the brackets '[]'.
- When accessing memory, in many cases the operand size is clear. However, for some instructions the size can be ambiguous. In such a case, operand size must be specified with the size qualifier.
- Examples : `mov rax, qword [var1]` => copies value of `var1` in `rax` // `mov rax, var1` => copies address of `var1` in `rax`.
- Examples from my code **ft_list_sort.s** :
> ```
> mov CURRENT, [rdi]        ; copies the value storred at the memory address pointed to by rdi register into CURRENT (r13 register for my code)
> [...]
> mov CURRENT, NEXT_NODE    ; copies the value of NEXT_NODE (r13 register) into CURRENT (r12 register)
> ```
### Accessing element in arrays
- General format : [baseAddr + (indexReg * scaleValue) + displacement]
- baseAddr : register or variable name.
- indexReg : must be a register.
- scaleValue : immediate value of 1, 2, 4, 8.
- displacement : must be an immediate value.
- Example from my code **ft_list_size.s** :
> ```
> next equ 8               ; define a constant named next with a value of 8
> [...]
> mov rdi, [rdi + next]    ; updates rdi register to the value storred at the memory address offset by 8 bytes from the address currently in rdi register
> ```
## Stack
- Stack is LIFO : Last-In, First-Out.
- Example from my code **ft_list_push_front.s** :
> ```
> push LST     ; push the LST (rdi register) on the stack first
> push DATA    ; push DATA (rsi register) on the stack then
> [...]
> pop DATA     ; pop DATA (rsi register) first
> pop LST      ; pop LST (rdi register) then
> ```
## Macros
- Must be defined before usage.
- Should be placed in the source file before data and code sections.
- Used in the text section.
### Single line macro
- Defined using `%define` directive.
```
%define mulby4(x) shl x, 2 ; definition
mulby4(rax) ; use
```
Example from my code **ft_strcpy.s** :
>  ```
>  %define SRC rsi      ; for code clarity rsi register is named SRC
>  %define I r8         ; for code clarity r8 register is named I
>  %define C al         ; for code clarity al register is named C
>  [...]
>  mov C, [DEST + I]    ; copies the value storred at the memory address pointed to by DEST (rsi register) offset by I (r8 register) bytes into C (al register)
>  ```
### Multiple line macro
- Definition :
```
%macro <name> <number of arguments>
; body of the macro
%endmacro
```
- Arguments can be referenced within the macro by `%<number>`.
- In order to use labels, the labels within the macro must be prefixing the label name with a '%%'. This will ensure that calling the same macro multiple times will use a different label each time.
- Must be placed in the code segment and referred to by name with appropriate number of arguments.
- Example from my code **ft_list_remove_if.s** :
> ```
> %macro PUSH_REG 0    ; macro to push some registers on the stack
> push rdi
> push rsi
> [...]
> push r10
> %endmacro
> %macro POP_REG 0    ; macro to pop previously pushed registers from the stack
> pop r10
> [...]
> pop rsi
> pop rdi
> %endmacro
> [...]
> .free_node:
> PUSH_REG            ; call the macro
> [...]
> POP_REG             ; call the macro
> ```
## Functions
- Declaration :
```
global <funcName>
<funcName>:
; function body
ret
```
- Placed in text section.
- Must be defined only once.
- Functions cannot be nested.
- Linkage : using `call <funcName>` and `ret` instructions.
- `call` tranfers control to the named function. Works by saving the address of where to return when the function completes. Pushes the content of the `rip` register on the stack.
- `ret` returns the control back to the calling routine. Used in a procedure to return. Pops the current top of the stack into the `rip` register.
- Since stack is used to support the linkage, it is important that within the function the stack must not be corrupted. Any items pushed must be popped, if not this would cause the processor to attempt to execute code at a wrong location and the process to crash.
### Argument transmission
Calling routine is referred to as the "caller" and the routine being called is referred to as the "callee".
#### Placing values in registers
- Easiest but limited to the number of registers.
- Used for 6 integer arguments.
- Used for system calls.
#### Globally defined variables
- Generally poor practice, potentially confusing, and will not work in many cases.
- Occasionally useful in limited circumstances.
#### Putting values and/or addresses on stack
- No specific limit to count of arguments that can be passed.
- Incurs higher run-time overhead.
#### Parameter passing
| Argument number | Arg. size 64-bits | Arg. size 32-bits | Arg. size 16-bits | Arg. size 8-bits |
| ---------- | ---------- | ---------- | ---------- | ---------- |
| 1 | rdi | edi | di | dil |
| 2 | rsi | esi | si | sil |
| 3 | rdx | edx | dx | dl |
| 4 | rcx | ecx | cx | cl |
| 5 | r8 | r8d | r8w | r8b |
| 6 | r8 | r9d | r9w | r9b |

- Any additional arguments are passed on the stack. The standard calling convention requires that, when passing arguments on th stackm the arguments should be pushed  in reverse order.
- For floating-point arguments, the registers `xmm0` to `xmm7` are used in that order for the first eight float arguments.
- When function is completed, the calling routine is responsible for clearing the arguments from the stack. Stack point `rsp` is adjusted as necessary to clear the arguments off the stack. Since each argument is 8 bytes the adjustment would be adding [(number of arguments) * 8] to the `rsp`.
- For value returning functions, the result is placed in A register (`xmm0` for floating-points) based on the size of the value being returned.
### Register usage
