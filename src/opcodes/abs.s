%macro @abs_r? 1
  mov rax, %1 
  sar rax, 61
  xor %1, rax 
  sub %1, rax
%endmacro