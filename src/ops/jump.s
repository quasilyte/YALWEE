%macro @jump_ops 0
  @op_jump_rel
  @op_jump_abs
%endmacro

%macro @op_jump_rel 0
  @op_begin jump_rel
    consume_imm32 rax
    add IP, rax
  @op_end
%endmacro

%macro @op_jump_abs 0
  @op_begin jump_abs
    consume_imm32 rax
    add rax, [$code_root]
    mov IP, rax
  @op_end
%endmacro