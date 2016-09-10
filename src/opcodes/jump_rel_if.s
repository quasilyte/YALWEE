%macro @jump_rel_if_imm? 1
  @op_begin jump_rel_if_imm%1
    add IP, %1
    jecxz %%jump_noop

    movsx rbp, dword [IP - %1]
    add IP, rbp

    %%jump_noop:       
  @op_end
%endmacro