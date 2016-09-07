%macro @eq_ops 0
  @expand_range @op_eq_r0_r?, 1, 7
%endmacro

%macro @op_eq_r0_r? 1
  @op_begin eq_r0_r%1
    cmp R0, R%1
    sete cl
  @op_end
%endmacro