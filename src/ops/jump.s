%macro @jump_ops 0
  @op_jump_rel
  @op_jump_rel_if
  @op_jump_abs
  @op_jump_abs_if
%endmacro

%macro @op_jump_rel 0
  @op_begin jump_rel
    consume_imm32 rax
    add IP, rax
  @op_end
%endmacro

%macro @op_jump_rel_if 0
  @op_begin jump_rel_if
    add IP, 4
    jecxz %%no_jump

    movsx rax, dword [IP-4]
    add IP, rax

    %%no_jump:       
  @op_end
%endmacro

%macro @op_jump_abs 0
  @op_begin jump_abs
    consume_imm32 rax
    add rax, [$code_root]
    mov IP, rax
  @op_end
%endmacro

%macro @op_jump_abs_if 0
  @op_begin jump_abs_if
    add IP, 4
    jecxz %%no_jump

    movsx rax, dword [IP-4]
    add rax, [$code_root]
    mov IP, rax

    %%no_jump:       
  @op_end
%endmacro