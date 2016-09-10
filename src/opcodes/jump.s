%macro @jump_rel 0
  @op_begin jump_rel
    consume_imm32 rax
    add IP, rax
  @op_end
%endmacro

%macro @jump_rel_if 0
  @op_begin jump_rel_if
    add IP, 4
    jecxz %%jump_noop

    movsx rax, dword [IP-4]
    add IP, rax

    %%jump_noop:       
  @op_end
%endmacro

%macro @jump_abs 0
  @op_begin jump_abs
    consume_imm32 rax
    add rax, [$code_root]
    mov IP, rax
  @op_end
%endmacro

%macro @jump_abs_if 0
  @op_begin jump_abs_if
    add IP, 4
    jecxz %%jump_noop

    movsx rax, dword [IP-4]
    add rax, [$code_root]
    mov IP, rax

    %%jump_noop:       
  @op_end
%endmacro
