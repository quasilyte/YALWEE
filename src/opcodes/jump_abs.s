%macro @jump_abs 1
  add %1, [$code_root]
  mov IP, %1
%endmacro

@op_imm? jump_abs, {@jump_abs .a}
