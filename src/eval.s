%include "/ee_reg_decls.s"
%include "/op_macros.s"
%include "/op_impl.s"

global eval

segment .bss

code_root: resq 1

segment .text

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