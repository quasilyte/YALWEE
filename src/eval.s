.global eval
.type eval, @function

.macro next_op
  movzwq (%rdi), %rax
  add $2, %rdi
  jmp *op_table(, %rax, 8)
.endm

.macro push_regs
  push %rbx
  push %rsi 
  push %rdi
.endm

.macro pop_regs
  pop %rbx
  pop %rsi 
  pop %rdi
.endm

.section .text

op_table:
  .quad op_exit # 0
  # iacc_add
  .quad op_iacc_add_r1 # 1
  .quad op_iacc_add_r2 # 2
  # iacc_load
  .quad op_iacc_load_r1 # 3
  .quad op_iacc_load_r2 # 4
  # iacc_save
  .quad op_iacc_save_r1 # 5
  .quad op_iacc_save_r2 # 6
  # ireset
  .quad op_ireset_r0 # 7
  .quad op_ireset_r1 # 8
  .quad op_ireset_r2 # 9
  # imove
  .quad op_imove_r0_to_r1 # 10
  .quad op_imove_r0_to_r2 # 11
  .quad op_imove_r1_to_r0 # 12
  .quad op_imove_r1_to_r2 # 13
  .quad op_imove_r2_to_r0 # 14
  .quad op_imove_r2_to_r1 # 15

eval:
  push_regs
  next_op 

  op_exit:
    jmp done
  
  op_iacc_add_r1:
    add %r9, %r8
    next_op
  op_iacc_add_r2:
    add %r10, %r8 
    next_op

  op_iacc_load_r1:
    mov %r9, %r8
    next_op
  op_iacc_load_r2:
    mov %r10, %r8
    next_op

  op_iacc_save_r1:
    mov %r8, %r9
    next_op
  op_iacc_save_r2:
    mov %r8, %r10
    next_op

  op_ireset_r0:
    xor %r8, %r8
    next_op
  op_ireset_r1:
    xor %r9, %r9
    next_op
  op_ireset_r2:
    xor %r10, %r10
    next_op

  op_imove_r0_to_r1:
    mov %r8, %r9
    next_op
  op_imove_r0_to_r2:
    mov %r8, %r10
    next_op
  op_imove_r1_to_r0:
    mov %r9, %r8
    next_op
  op_imove_r1_to_r2:
    mov %r9, %r10
    next_op
  op_imove_r2_to_r0:
    mov %r10, %r8
    next_op
  op_imove_r2_to_r1:
    mov %r10, %r9
    next_op

  done:
  pop_regs 
  ret
