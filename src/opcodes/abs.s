%macro @abs 1
  mov rax, %1 
  sar rax, 61
  xor %1, rax 
  sub %1, rax
%endmacro

@op_r? abs, {@abs .a}
