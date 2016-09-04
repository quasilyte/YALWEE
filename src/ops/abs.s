%macro @abs_ops 0
  @each_r @op_abs_r?
%endmacro

%macro @op_abs_r? 1
  @@op_abs_r%1:
    mov rax, R%1 
    sar rax, 61
    xor R%1, rax 
    sub R%1, rax 
    @next_op
%endmacro
