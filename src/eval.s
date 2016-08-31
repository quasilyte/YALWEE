.global eval
.type eval, @function

.global code_root
.type code_root, @object
.size code_root, 8

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

.section .bss

code_root: .zero 8

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
  # imove byte immediate  
  .quad op_imove_8_to_r0 # 16
  .quad op_imove_8_to_r1 # 17
  .quad op_imove_8_to_r2 # 18
  # jmpz
  .quad op_ijmpz_r0 # 19
  .quad op_ijmpz_r1 # 20
  .quad op_ijmpz_r2 # 21

eval:
  push_regs
  movq %rdi, code_root 
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

  op_imove_8_to_r0:
    movzbq (%rdi), %r8
    inc %rdi
    next_op
  op_imove_8_to_r1:
    movzbq (%rdi), %r9
    inc %rdi
    next_op
  op_imove_8_to_r2:
    movzbq (%rdi), %r10
    inc %rdi
    next_op

  op_ijmpz_r0:
    cmpq $0, %r8
    jz ijmpz_r0_set_pc
    add $8, %rdi
    next_op
    ijmpz_r0_set_pc:
       movq (%rdi), %rax
       movq code_root, %rdi
       add %rax, %rdi
       next_op
  op_ijmpz_r1:
    cmpq $0, %r9
    jz ijmpz_r1_set_pc
    add $8, %rdi
    next_op
    ijmpz_r1_set_pc:
       movq (%rdi), %rax
       movq code_root, %rdi
       add %rax, %rdi
       next_op
  op_ijmpz_r2:
    cmpq $0, %r10
    jz ijmpz_r2_set_pc
    add $8, %rdi
    next_op
    ijmpz_r2_set_pc:
       movq (%rdi), %rax
       movq code_root, %rdi
       add %rax, %rdi
       next_op

  done:
  pop_regs 
  ret
