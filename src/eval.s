%include "/ee_reg_decls.s"

global eval

segment .bss

code_root: resq 1

segment .text

%macro @next_op 0
  movzx rax, word [rdi]
  add rdi, 2
  jmp [$op_table+(rax*8)]
%endmacro 

%macro @push_regs 0
  push rbp
  push rbx
  push rsi 
  push rdi
%endmacro

%macro @pop_regs 0
  pop rdi
  pop rsi 
  pop rbx
  pop rbp
%endmacro

;; %1 -- ident
;; %2 -- low
;; %3 -- high
%macro @op_labels 3
  %assign i %2

  %rep %3
    dq @@%1%+i  
    %assign i i+1 
  %endrep
%endmacro

;; %1 -- ident
;; %2 -- low 
;; %3 -- high
;; %4 -- excluded
%macro @op_exc_labels 4
  %assign i %2

  %rep %3
    %if i <> %4
      dq @@%1%+i  
    %endif
    %assign i i+1
  %endrep
%endmacro

%macro @opcode_handler 2
  @@op_%1%2:
    @%1 %2
    @next_op
%endmacro

%macro @acc_labels 1
  @op_labels %1, 1, R_COUNT-1
%endmacro

%macro @r_labels 1
  @op_labels %1, 0, R_COUNT
%endmacro

%macro @r_exc_labels 2
  @op_exc_labels %1, 0, R_COUNT, %2
%endmacro

%macro @acc_add_r 1
  add ACC, R%1 
%endmacro

%macro @acc_load_r 1
  mov ACC, R%1
%endmacro

%macro @acc_save_r 1
  mov R%1, ACC
%endmacro

%macro @reset_r 1
  xor R%1, R%1
%endmacro

%macro @inc_r 1
  inc R%1
%endmacro

%macro @dec_r 1
  dec R%1
%endmacro

%macro @move_r0_to_r 1
  mov R%1, R0
%endmacro

%macro @move_r1_to_r 1
  mov R%1, R1
%endmacro

%macro @move_r2_to_r 1
  mov R%1, R2
%endmacro

%macro @move_8_to_r 1
  movzx rax, byte [rdi]
  inc rdi
  add R%1, rax 
%endmacro

%macro @move_16_to_r 1
  mov ax, word [rdi]
  add rdi, 2
  add R%1x16, ax 
%endmacro

%macro @move_32_to_r 1
  mov eax, dword [rdi]
  add rdi, 4
  add R%1x32, eax 
%endmacro

%macro @move_64_to_r 1
  mov rax, qword [rdi]
  add rdi, 8
  add R%1, rax 
%endmacro

%macro @acc_ops 1
  %assign i 1

  %rep R_COUNT-1
    @opcode_handler %1, i
    %assign i i+1 
  %endrep
%endmacro

%macro @r_ops 1
  %assign i 0

  %rep R_COUNT
    @opcode_handler %1, i
    %assign i i+1 
  %endrep
%endmacro

%macro @r_exc_ops 2
  %assign i 0

  %rep R_COUNT
    %if i <> %2
      @opcode_handler %1, i
    %endif
    %assign i i+1 
  %endrep
%endmacro

$op_table:
  dq op_exit
  @acc_labels op_acc_add_r
  @acc_labels op_acc_load_r
  @acc_labels op_acc_save_r
  @r_labels op_reset_r
  @r_labels op_inc_r
  @r_labels op_dec_r
  @r_labels op_move_8_to_r
  @r_labels op_move_16_to_r
  @r_labels op_move_32_to_r
  @r_labels op_move_64_to_r
  @r_exc_labels op_move_r0_to_r, 0
  @r_exc_labels op_move_r1_to_r, 1
  @r_exc_labels op_move_r2_to_r, 2

eval:
  @push_regs
  mov [code_root], rdi
  @next_op

  op_exit: jmp done

  ;; acc ops 
  @acc_ops acc_add_r
  @acc_ops acc_load_r
  @acc_ops acc_save_r
  ;; r ops
  @r_ops reset_r
  @r_ops inc_r
  @r_ops dec_r
  @r_ops move_8_to_r
  @r_ops move_16_to_r
  @r_ops move_32_to_r
  @r_ops move_64_to_r
  @r_exc_ops move_r0_to_r, 0
  @r_exc_ops move_r1_to_r, 1
  @r_exc_ops move_r2_to_r, 2

  done:
    @pop_regs
    ret