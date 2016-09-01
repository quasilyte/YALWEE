%include "/ee_reg_decls.s"

global eval

segment .bss

code_root: resq 1

segment .text

%macro NEXT_OP 0
  movzx rax, word [rdi]
  add rdi, 2
  jmp [$op_table+(rax*8)]
%endmacro 

%macro PUSH_REGS 0
  push rbp
  push rbx
  push rsi 
  push rdi
%endmacro

%macro POP_REGS 0
  pop rdi
  pop rsi 
  pop rbx
  pop rbp
%endmacro

;; %1 -- ident
;; %2 -- low
;; %3 -- high
%macro OP_LABELS 3
  %assign i %2

  %rep %3
    dq %1%+i  
    %assign i i+1 
  %endrep
%endmacro

;; %1 -- ident
;; %2 -- low 
;; %3 -- high
;; %4 -- excluded
%macro OP_EXC_LABELS 4
  %assign i %2

  %rep %3
    %if i <> %4
      dq %1%+i  
    %endif
    %assign i i+1
  %endrep
%endmacro

%macro ACC_LABELS 1
  OP_LABELS %1, 1, R_COUNT-1
%endmacro

%macro R_LABELS 1
  OP_LABELS %1, 0, R_COUNT
%endmacro

%macro R_EXC_LABELS 2
  OP_EXC_LABELS %1, 0, R_COUNT, %2
%endmacro

%macro ACC_ADD_R 1
  op_acc_add_r%1: 
    add ACC, R%1 
%endmacro

%macro ACC_LOAD_R 1
  op_acc_load_r%1:
    mov ACC, R%1
%endmacro

%macro ACC_SAVE_R 1
  op_acc_save_r%1:
    mov R%1, ACC
%endmacro

%macro RESET_R 1
  op_reset_r%1:
    xor R%1, R%1
%endmacro

%macro INC_R 1
  op_inc_r%1:
    inc R%1
%endmacro

%macro DEC_R 1
  op_dec_r%1:
    dec R%1
%endmacro

%macro MOVE_R0_TO_R 1
  op_move_r0_to_r%1:
    mov R%1, R0
%endmacro

%macro MOVE_R1_TO_R 1
  op_move_r1_to_r%1:
    mov R%1, R1
%endmacro

%macro MOVE_R2_TO_R 1
  op_move_r2_to_r%1:
    mov R%1, R2
%endmacro

%macro MOVE_8_TO_R 1
  op_move_8_to_r%1:
    movzx rax, byte [rdi]
    inc rdi
    add R%1, rax 
%endmacro

%macro MOVE_16_TO_R 1
  op_move_16_to_r%1:
    mov ax, word [rdi]
    add rdi, 2
    add R%1x16, ax 
%endmacro

%macro MOVE_32_TO_R 1
  op_move_32_to_r%1:
    mov eax, dword [rdi]
    add rdi, 4
    add R%1x32, eax 
%endmacro

%macro MOVE_64_TO_R 1
  op_move_64_to_r%1:
    mov rax, qword [rdi]
    add rdi, 8
    add R%1, rax 
%endmacro

%macro ACC_OPS 1
  %assign i 1

  %rep R_COUNT-1
    %1 i
    NEXT_OP
    %assign i i+1 
  %endrep
%endmacro

%macro R_OPS 1
  %assign i 0

  %rep R_COUNT
    %1 i
    NEXT_OP
    %assign i i+1 
  %endrep
%endmacro

%macro R_EXC_OPS 2
  %assign i 0

  %rep R_COUNT
    %if i <> %2
      %1 i
      NEXT_OP
    %endif
    %assign i i+1 
  %endrep
%endmacro

$op_table:
  dq op_exit
  ACC_LABELS op_acc_add_r
  ACC_LABELS op_acc_load_r
  ACC_LABELS op_acc_save_r
  R_LABELS op_reset_r
  R_LABELS op_inc_r
  R_LABELS op_dec_r
  R_LABELS op_move_8_to_r
  R_LABELS op_move_16_to_r
  R_LABELS op_move_32_to_r
  R_LABELS op_move_64_to_r
  R_EXC_LABELS op_move_r0_to_r, 0
  R_EXC_LABELS op_move_r1_to_r, 1
  R_EXC_LABELS op_move_r2_to_r, 2

eval:
  PUSH_REGS
  mov [code_root], rdi
  NEXT_OP

  op_exit: jmp done

  ;; acc ops 
  ACC_OPS ACC_ADD_R
  ACC_OPS ACC_LOAD_R
  ACC_OPS ACC_SAVE_R
  ;; r ops
  R_OPS RESET_R
  R_OPS INC_R
  R_OPS DEC_R
  R_OPS MOVE_8_TO_R
  R_OPS MOVE_16_TO_R
  R_OPS MOVE_32_TO_R
  R_OPS MOVE_64_TO_R
  R_EXC_OPS MOVE_R0_TO_R, 0
  R_EXC_OPS MOVE_R1_TO_R, 1
  R_EXC_OPS MOVE_R2_TO_R, 2

  done:
    POP_REGS
    ret