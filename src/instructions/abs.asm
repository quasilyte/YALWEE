%macro @abs_r? 1
  mov rax, R%1 
  sar rax, 61
  xor R%1, rax 
  sub R%1, rax
%endmacro